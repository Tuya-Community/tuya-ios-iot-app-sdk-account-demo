//
//  NSPredicate+TYFormatCheck.h
//  TuyaAppSDKSample-iOS-UserAccount-ObjC
//
//  Copyright (c) 2014-2021 Tuya Inc. (https://developer.tuya.com/)


#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSPredicate (TYFormatCheck)

/**
  Check Email address
*/
+ (BOOL)checkEmail:(NSString *)email;
 
/**
  Check phone number
*/
+ (BOOL)checkPhoneNumber:(NSString *)PhoneNumber;

@end

NS_ASSUME_NONNULL_END
