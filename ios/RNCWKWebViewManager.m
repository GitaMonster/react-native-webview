/**
 * Copyright (c) 2015-present, Facebook, Inc.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

#import "RNCWKWebViewManager.h"

#import <React/RCTUIManager.h>
#import <React/RCTDefines.h>
#import "RNCWKWebView.h"

static NSString * const NOT_AVAILABLE_ERROR_MESSAGE = @"WebKit/WebKit-Components are only available with iOS11 and higher!";

@interface RNCWKWebViewManager () <RNCWKWebViewDelegate>
@end

@implementation RCTConvert (UIScrollView)

#if defined(__IPHONE_OS_VERSION_MAX_ALLOWED) && __IPHONE_OS_VERSION_MAX_ALLOWED >= 110000 /* __IPHONE_11_0 */
RCT_ENUM_CONVERTER(UIScrollViewContentInsetAdjustmentBehavior, (@{
                                                                  @"automatic": @(UIScrollViewContentInsetAdjustmentAutomatic),
                                                                  @"scrollableAxes": @(UIScrollViewContentInsetAdjustmentScrollableAxes),
                                                                  @"never": @(UIScrollViewContentInsetAdjustmentNever),
                                                                  @"always": @(UIScrollViewContentInsetAdjustmentAlways),
                                                                  }), UIScrollViewContentInsetAdjustmentNever, integerValue)
#endif

@end

@implementation RNCWKWebViewManager
{
  NSConditionLock *_shouldStartLoadLock;
  BOOL _shouldStartLoad;
}

RCT_EXPORT_MODULE()

- (UIView *)view
{
  RNCWKWebView *webView = [RNCWKWebView new];
  webView.delegate = self;
  return webView;
}

RCT_EXPORT_VIEW_PROPERTY(source, NSDictionary)
RCT_EXPORT_VIEW_PROPERTY(onLoadingStart, RCTDirectEventBlock)
RCT_EXPORT_VIEW_PROPERTY(onLoadingFinish, RCTDirectEventBlock)
RCT_EXPORT_VIEW_PROPERTY(onLoadingError, RCTDirectEventBlock)
RCT_EXPORT_VIEW_PROPERTY(onLoadingProgress, RCTDirectEventBlock)
RCT_EXPORT_VIEW_PROPERTY(onShouldStartLoadWithRequest, RCTDirectEventBlock)
RCT_EXPORT_VIEW_PROPERTY(injectedJavaScript, NSString)
RCT_EXPORT_VIEW_PROPERTY(defaultUsername, NSString)
RCT_EXPORT_VIEW_PROPERTY(defaultPassword, NSString)
RCT_EXPORT_VIEW_PROPERTY(allowsInlineMediaPlayback, BOOL)
RCT_EXPORT_VIEW_PROPERTY(mediaPlaybackRequiresUserAction, BOOL)
#if WEBKIT_IOS_10_APIS_AVAILABLE
RCT_EXPORT_VIEW_PROPERTY(dataDetectorTypes, WKDataDetectorTypes)
#endif
RCT_EXPORT_VIEW_PROPERTY(contentInset, UIEdgeInsets)
RCT_EXPORT_VIEW_PROPERTY(automaticallyAdjustContentInsets, BOOL)
RCT_EXPORT_VIEW_PROPERTY(hideKeyboardAccessoryView, BOOL)
RCT_EXPORT_VIEW_PROPERTY(allowsBackForwardNavigationGestures, BOOL)
RCT_EXPORT_VIEW_PROPERTY(incognito, BOOL)
RCT_EXPORT_VIEW_PROPERTY(pagingEnabled, BOOL)
RCT_EXPORT_VIEW_PROPERTY(userAgent, NSString)
RCT_EXPORT_VIEW_PROPERTY(applicationNameForUserAgent, NSString)
RCT_EXPORT_VIEW_PROPERTY(cacheEnabled, BOOL)
RCT_EXPORT_VIEW_PROPERTY(allowsLinkPreview, BOOL)

#if defined(__IPHONE_OS_VERSION_MAX_ALLOWED) && __IPHONE_OS_VERSION_MAX_ALLOWED >= 110000 /* __IPHONE_11_0 */
RCT_EXPORT_VIEW_PROPERTY(contentInsetAdjustmentBehavior, UIScrollViewContentInsetAdjustmentBehavior)
#endif

/**
 * Expose methods to enable messaging the webview.
 */
RCT_EXPORT_VIEW_PROPERTY(messagingEnabled, BOOL)
RCT_EXPORT_VIEW_PROPERTY(onMessage, RCTDirectEventBlock)
RCT_EXPORT_VIEW_PROPERTY(onScroll, RCTDirectEventBlock)

RCT_EXPORT_METHOD(postMessage:(nonnull NSNumber *)reactTag message:(NSString *)message)
{
  [self.bridge.uiManager addUIBlock:^(__unused RCTUIManager *uiManager, NSDictionary<NSNumber *, RNCWKWebView *> *viewRegistry) {
    RNCWKWebView *view = viewRegistry[reactTag];
    if (![view isKindOfClass:[RNCWKWebView class]]) {
      RCTLogError(@"Invalid view returned from registry, expecting RNCWKWebView, got: %@", view);
    } else {
      [view postMessage:message];
    }
  }];
}

RCT_EXPORT_METHOD(clearCredentials:(nonnull NSNumber *)reactTag)
{
  [self.bridge.uiManager addUIBlock:^(__unused RCTUIManager *uiManager, NSDictionary<NSNumber *, RNCWKWebView *> *viewRegistry) {
    RNCWKWebView *view = viewRegistry[reactTag];
    if (![view isKindOfClass:[RNCWKWebView class]]) {
      RCTLogError(@"Invalid view returned from registry, expecting RCTWebView, got: %@", view);
    } else {
      [view clearCredentials];
    }
  }];
}

RCT_CUSTOM_VIEW_PROPERTY(bounces, BOOL, RNCWKWebView) {
  view.bounces = json == nil ? true : [RCTConvert BOOL: json];
}

RCT_CUSTOM_VIEW_PROPERTY(useSharedProcessPool, BOOL, RNCWKWebView) {
  view.useSharedProcessPool = json == nil ? true : [RCTConvert BOOL: json];
}

RCT_CUSTOM_VIEW_PROPERTY(scrollEnabled, BOOL, RNCWKWebView) {
  view.scrollEnabled = json == nil ? true : [RCTConvert BOOL: json];
}

RCT_CUSTOM_VIEW_PROPERTY(sharedCookiesEnabled, BOOL, RNCWKWebView) {
    view.sharedCookiesEnabled = json == nil ? false : [RCTConvert BOOL: json];
}

RCT_CUSTOM_VIEW_PROPERTY(decelerationRate, CGFloat, RNCWKWebView) {
  view.decelerationRate = json == nil ? UIScrollViewDecelerationRateNormal : [RCTConvert CGFloat: json];
}

RCT_CUSTOM_VIEW_PROPERTY(directionalLockEnabled, BOOL, RNCWKWebView) {
    view.directionalLockEnabled = json == nil ? true : [RCTConvert BOOL: json];
}

RCT_CUSTOM_VIEW_PROPERTY(showsHorizontalScrollIndicator, BOOL, RNCWKWebView) {
  view.showsHorizontalScrollIndicator = json == nil ? true : [RCTConvert BOOL: json];
}

RCT_CUSTOM_VIEW_PROPERTY(showsVerticalScrollIndicator, BOOL, RNCWKWebView) {
  view.showsVerticalScrollIndicator = json == nil ? true : [RCTConvert BOOL: json];
}

RCT_CUSTOM_VIEW_PROPERTY(keyboardDisplayRequiresUserAction, BOOL, RNCWKWebView) {
  view.keyboardDisplayRequiresUserAction = json == nil ? true : [RCTConvert BOOL: json];
}

RCT_EXPORT_METHOD(injectJavaScript:(nonnull NSNumber *)reactTag script:(NSString *)script)
{
  [self.bridge.uiManager addUIBlock:^(__unused RCTUIManager *uiManager, NSDictionary<NSNumber *, RNCWKWebView *> *viewRegistry) {
    RNCWKWebView *view = viewRegistry[reactTag];
    if (![view isKindOfClass:[RNCWKWebView class]]) {
      RCTLogError(@"Invalid view returned from registry, expecting RNCWKWebView, got: %@", view);
    } else {
      [view injectJavaScript:script];
    }
  }];
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

RCT_EXPORT_METHOD(goBack:(nonnull NSNumber *)reactTag)
{
  [self.bridge.uiManager addUIBlock:^(__unused RCTUIManager *uiManager, NSDictionary<NSNumber *, RNCWKWebView *> *viewRegistry) {
    RNCWKWebView *view = viewRegistry[reactTag];
    if (![view isKindOfClass:[RNCWKWebView class]]) {
      RCTLogError(@"Invalid view returned from registry, expecting RNCWKWebView, got: %@", view);
    } else {
      [view goBack];
    }
  }];
}

RCT_EXPORT_METHOD(goForward:(nonnull NSNumber *)reactTag)
{
  [self.bridge.uiManager addUIBlock:^(__unused RCTUIManager *uiManager, NSDictionary<NSNumber *, RNCWKWebView *> *viewRegistry) {
    RNCWKWebView *view = viewRegistry[reactTag];
    if (![view isKindOfClass:[RNCWKWebView class]]) {
      RCTLogError(@"Invalid view returned from registry, expecting RNCWKWebView, got: %@", view);
    } else {
      [view goForward];
    }
  }];
}

RCT_EXPORT_METHOD(reload:(nonnull NSNumber *)reactTag)
{
  [self.bridge.uiManager addUIBlock:^(__unused RCTUIManager *uiManager, NSDictionary<NSNumber *, RNCWKWebView *> *viewRegistry) {
    RNCWKWebView *view = viewRegistry[reactTag];
    if (![view isKindOfClass:[RNCWKWebView class]]) {
      RCTLogError(@"Invalid view returned from registry, expecting RNCWKWebView, got: %@", view);
    } else {
      [view reload];
    }
  }];
}

RCT_EXPORT_METHOD(stopLoading:(nonnull NSNumber *)reactTag)
{
  [self.bridge.uiManager addUIBlock:^(__unused RCTUIManager *uiManager, NSDictionary<NSNumber *, RNCWKWebView *> *viewRegistry) {
    RNCWKWebView *view = viewRegistry[reactTag];
    if (![view isKindOfClass:[RNCWKWebView class]]) {
      RCTLogError(@"Invalid view returned from registry, expecting RNCWKWebView, got: %@", view);
    } else {
      [view stopLoading];
    }
  }];
}

#pragma mark - Exported synchronous methods

- (BOOL)          webView:(RNCWKWebView *)webView
shouldStartLoadForRequest:(NSMutableDictionary<NSString *, id> *)request
             withCallback:(RCTDirectEventBlock)callback
{
  _shouldStartLoadLock = [[NSConditionLock alloc] initWithCondition:arc4random()];
  _shouldStartLoad = YES;
  request[@"lockIdentifier"] = @(_shouldStartLoadLock.condition);
  callback(request);

  // Block the main thread for a maximum of 250ms until the JS thread returns
  if ([_shouldStartLoadLock lockWhenCondition:0 beforeDate:[NSDate dateWithTimeIntervalSinceNow:.25]]) {
    BOOL returnValue = _shouldStartLoad;
    [_shouldStartLoadLock unlock];
    _shouldStartLoadLock = nil;
    return returnValue;
  } else {
    RCTLogWarn(@"Did not receive response to shouldStartLoad in time, defaulting to YES");
    return YES;
  }
}

RCT_EXPORT_METHOD(startLoadWithResult:(BOOL)result lockIdentifier:(NSInteger)lockIdentifier)
{
  if ([_shouldStartLoadLock tryLockWhenCondition:lockIdentifier]) {
    _shouldStartLoad = result;
    [_shouldStartLoadLock unlockWithCondition:0];
  } else {
    RCTLogWarn(@"startLoadWithResult invoked with invalid lockIdentifier: "
               "got %lld, expected %lld", (long long)lockIdentifier, (long long)_shouldStartLoadLock.condition);
  }
}

@end
