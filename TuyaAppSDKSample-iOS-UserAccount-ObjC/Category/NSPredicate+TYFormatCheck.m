//
//  NSPredicate+TYFormatCheck.m
//  TuyaAppSDKSample-iOS-UserAccount-ObjC
//
//  Copyright (c) 2014-2021 Tuya Inc. (https://developer.tuya.com/)


#import "NSPredicate+TYFormatCheck.h"

@implementation NSPredicate (TYFormatCheck)

+ (BOOL)checkEmail:(NSString *)email {
    
    NSString *regex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *predicate = [self predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [predicate evaluateWithObject:email];
    
}


+ (BOOL)checkPhoneNumber:(NSString *)PhoneNumber {
    
    NSString *regex =  @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|70)\\d{8}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    
    return [predicate evaluateWithObject:PhoneNumber];
    
}





@end
