//
//  Alert.m
//  TuyaAppSDKSample-iOS-UserAccount-ObjC
//
//  Copyright (c) 2014-2021 Tuya Inc. (https://developer.tuya.com/)

#import "TYAlert.h"


@implementation TYAlert

+(void)showBasicAlertOnVC:(UIViewController *)currentViewController withTitle:(NSString *)title message:(NSString *)message handler:(void (^)(UIAlertAction * _Nonnull))handler {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:handler];
    
    [alertController addAction:action];
    

    dispatch_async(dispatch_get_main_queue(), ^{
        [currentViewController presentViewController:alertController animated:true completion:nil];
    });
    
}



+(void)showInputAlertOnVC:(UIViewController *)currentViewController withTitle:(NSString *)title message:(NSString *)message confirmHandler:(void (^)(NSString *))handler {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];

        

        [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

               

        }]];

     

        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {


            UITextField *userNameTextField = alertController.textFields.firstObject;

            handler(userNameTextField.text);

        }]];

        

        [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {

            textField.placeholder = @"please input..";

           

        }];

        

        [currentViewController presentViewController:alertController animated:true completion:nil];
    
}

@end
