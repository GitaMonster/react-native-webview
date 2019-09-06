//
//  Cookies.m
//  CapybaraMobile
//
//  Created by Colin Smith on 2018-12-03.
//  Copyright © 2018 Facebook. All rights reserved.
//

#import "Cookies.h"
#import <WebKit/WebKit.h>

static NSString * const NOT_AVAILABLE_ERROR_MESSAGE = @"WebKit/WebKit-Components are only available with iOS11 and higher!";

@implementation Cookies

RCT_EXPORT_MODULE();

RCT_EXPORT_METHOD(clearAll:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject)
{
  if (@available(iOS 11.0, *)) {
    dispatch_async(dispatch_get_main_queue(), ^(){
      WKHTTPCookieStore *cookieStore = [[WKWebsiteDataStore defaultDataStore] httpCookieStore];
      [cookieStore getAllCookies:^(NSArray<NSHTTPCookie *> *allCookies) {
        for(NSHTTPCookie *currentCookie in allCookies) {
          // Uses the NSHTTPCookie directly has no effect, nor deleted the cookie nor thrown an error.
          // Create a new cookie with the given values and delete this one do the work.
          NSMutableDictionary<NSHTTPCookiePropertyKey, id> *cookieData =  [NSMutableDictionary dictionary];
          [cookieData setValue:currentCookie.name forKey:NSHTTPCookieName];
          [cookieData setValue:currentCookie.value forKey:NSHTTPCookieValue];
          [cookieData setValue:currentCookie.domain forKey:NSHTTPCookieDomain];
          [cookieData setValue:currentCookie.path forKey:NSHTTPCookiePath];
          
          NSHTTPCookie *newCookie = [NSHTTPCookie cookieWithProperties:cookieData];
          [cookieStore deleteCookie:newCookie completionHandler:^{}];
        }
        resolve(nil);
      }];
    });
  } else {
    reject(@"", NOT_AVAILABLE_ERROR_MESSAGE, nil);
  }
}

RCT_EXPORT_METHOD(getAll:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject)
{
  if (@available(iOS 11.0, *)) {
    dispatch_async(dispatch_get_main_queue(), ^(){
      WKHTTPCookieStore *cookieStore = [[WKWebsiteDataStore defaultDataStore] httpCookieStore];
      [cookieStore getAllCookies:^(NSArray<NSHTTPCookie *> *allCookies) {
        resolve([self createCookieList: allCookies]);
      }];
    });
  } else {
    reject(@"", NOT_AVAILABLE_ERROR_MESSAGE, nil);
  }
}

RCT_EXPORT_METHOD(get:(NSURL *) url
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
  if (@available(iOS 11.0, *)) {
    dispatch_async(dispatch_get_main_queue(), ^(){
      NSString *topLevelDomain = [self getDomainName:url];
      
      WKHTTPCookieStore *cookieStore = [[WKWebsiteDataStore defaultDataStore] httpCookieStore];
      [cookieStore getAllCookies:^(NSArray<NSHTTPCookie *> *allCookies) {
        NSMutableDictionary *cookies = [NSMutableDictionary dictionary];
        for(NSHTTPCookie *currentCookie in allCookies) {
          if([currentCookie.domain containsString:topLevelDomain]) {
            [cookies setObject:currentCookie.value forKey:currentCookie.name];
          }
        }
        resolve(cookies);
      }];
    });
  } else {
    reject(@"", NOT_AVAILABLE_ERROR_MESSAGE, nil);
  }
}


-(NSString *)getDomainName:(NSURL *) url
{
  NSString *separator = @".";
  NSInteger maxLength = 2;
  
  NSURLComponents *components = [[NSURLComponents alloc]initWithURL:url resolvingAgainstBaseURL:FALSE];
  NSArray<NSString *> *separatedHost = [components.host componentsSeparatedByString:separator];
  NSInteger count = [separatedHost count];
  NSInteger endPosition = count;
  NSInteger startPosition = count - maxLength;
  
  NSMutableString *result = [[NSMutableString alloc]init];
  for (NSUInteger i = startPosition; i != endPosition; i++) {
    [result appendString:separator];
    [result appendString:[separatedHost objectAtIndex:i]];
  }
  return result;
}

-(NSDictionary *)createCookieList:(NSArray<NSHTTPCookie *>*)cookies
{
  NSMutableDictionary *cookieList = [NSMutableDictionary dictionary];
  for (NSHTTPCookie *cookie in cookies) {
    // NSLog(@"COOKIE: %@", cookie);
    [cookieList setObject:[self createCookieData:cookie] forKey:cookie.name];
  }
  return cookieList;
}

-(NSDictionary *)createCookieData:(NSHTTPCookie *)cookie
{
  NSMutableDictionary *cookieData = [NSMutableDictionary dictionary];
  [cookieData setObject:cookie.value forKey:@"value"];
  [cookieData setObject:cookie.name forKey:@"name"];
  [cookieData setObject:cookie.domain forKey:@"domain"];
  [cookieData setObject:cookie.path forKey:@"path"];
  return cookieData;
}


@end
