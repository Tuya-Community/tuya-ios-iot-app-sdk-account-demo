//
//  Alert.h
//  TuyaAppSDKSample-iOS-UserAccount-ObjC
//
//  Copyright (c) 2014-2021 Tuya Inc. (https://developer.tuya.com/)

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface TYAlert : NSObject


/**
  Display Alert message
  
  @param currentViewController  The Current ViewController . If want to invoke it in a view or cell , you could use `[UIApplication sharedApplication].windows[0].rootViewController`
  @param title  Alert Title
  @param message Alert Details
  @param handler Alert Action
*/
+ (void)showBasicAlertOnVC:(UIViewController *)currentViewController withTitle:(NSString *)title message:(NSString *)message handler:(void (^ __nullable)(UIAlertAction *action))handler;

/**
  Display Alert message
  
  @param currentViewController  The Current ViewController . If want to invoke it in a view or cell , you could use `[UIApplication sharedApplication].windows[0].rootViewController`
  @param title  Alert Title
  @param message Alert Details
  @param handler Alert Action , you could get the input content from the parameter
*/
+(void)showInputAlertOnVC:(UIViewController *)currentViewController withTitle:(NSString *)title message:(NSString *)message confirmHandler:(void (^)(NSString *))handler;

@end

NS_ASSUME_NONNULL_END
