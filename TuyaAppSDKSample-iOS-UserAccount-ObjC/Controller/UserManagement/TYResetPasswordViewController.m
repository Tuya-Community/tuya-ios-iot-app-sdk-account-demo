//
//  TYResetPasswordViewController.m
//  TuyaAppSDKSample-iOS-UserAccount-ObjC
//
//  Copyright (c) 2014-2021 Tuya Inc. (https://developer.tuya.com/)
//

#import "TYResetPasswordViewController.h"

@interface TYResetPasswordViewController ()

@property (weak, nonatomic) IBOutlet UITextField *countryCodeTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailAddressTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *verificationCodeTextField;

@end

@implementation TYResetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}



#pragma mark - Target functions

- (IBAction)sendVerificationTapped:(UIButton *)sender {
    
    if ([NSPredicate checkEmail:self.emailAddressTextField.text]||[NSPredicate checkPhoneNumber:self.emailAddressTextField.text]) {
        
        // send Verification code
        [self requestVerification:self.emailAddressTextField.text countryCode:self.countryCodeTextField.text];
        
    } else {
        
        [TYAlert showBasicAlertOnVC:self withTitle:@"Error" message:@"Unvalidated Input" handler:nil];
        
    }
}

- (IBAction)resetPassword:(UIButton *)sender {
    
    /*
     
    check input if necessary
     
    if(self.emailAddressTextField.text.length<1) {
        
        [TYAlert showBasicAlertOnVC:self withTitle:@"Error" message:@"please input user name"];
        return;
        
    }
    if (self.passwordTextField.text.length<1) {
        
        [TYAlert showBasicAlertOnVC:self withTitle:@"Error" message:@"please input password"];
        return;
        
    }
    **/
    
    if ([NSPredicate checkEmail:self.emailAddressTextField.text]) {
        
        //reset by Email
        [self resetPasswordByEmail:self.emailAddressTextField.text countryCode:self.countryCodeTextField.text password:self.passwordTextField.text code:self.verificationCodeTextField.text];
        
    } else if ([NSPredicate checkPhoneNumber:self.emailAddressTextField.text]) {
        
        //reset by phone
        [self resetPasswordByPhone:self.emailAddressTextField.text countryCode:self.countryCodeTextField.text password:self.passwordTextField.text code:self.verificationCodeTextField.text];
        
    } else {
        
        [TYAlert showBasicAlertOnVC:self withTitle:@"Error" message:@"Unvalidated Input" handler:nil];
        
    }
}


#pragma mark - Request functions

-(void)requestVerification:(NSString *)userName countryCode:(NSString *)countryCode {
    
    NSString * region = [[TuyaSmartUser sharedInstance] getDefaultRegionWithCountryCode:countryCode];
    
    [[TuyaSmartUser sharedInstance] sendVerifyCodeWithUserName:userName
                                    region:region
                                    countryCode:countryCode
                                    type:3
                                    success:^{
        
                                        [TYAlert showBasicAlertOnVC:self withTitle:@"Verification Code Sent Successfully" message:@"Please check your message for the code." handler:nil];
        
                                        [self.verificationCodeTextField becomeFirstResponder];
    
                                    } failure:^(NSError *error) {
                                        
                                        [TYAlert showBasicAlertOnVC:self withTitle:@"Failed to Sent Verification Code" message:error.localizedDescription handler:nil];
                
                                    }];
}


-(void)resetPasswordByEmail:(NSString *)email countryCode:(NSString *)countryCode password:(NSString *)password code:(NSString *)code {
    
   
    
    [[TuyaSmartUser sharedInstance] resetPasswordByEmail:countryCode
                                    email:email
                                    newPassword:password
                                    code:code
                                    success:^{
                                        // reset successfully
                                        [TYAlert showBasicAlertOnVC:self withTitle:@"Registered Successfully" message:@"Please navigate back to login your account." handler:^(UIAlertAction * _Nonnull action) {
            
                                            //navigate back to login page
                                            [self.navigationController popViewControllerAnimated:YES];
            
                                        }];
        
                                    } failure:^(NSError *error) {
        
                                        [TYAlert showBasicAlertOnVC:self withTitle:@"Failed to Reset" message:error.localizedDescription handler:nil];
        
                                    }];
    
}

-(void)resetPasswordByPhone:(NSString *)phone countryCode:(NSString *)countryCode password:(NSString *)password code:(NSString *)code{
    
    [[TuyaSmartUser sharedInstance] resetPasswordByPhone:countryCode
                                    phoneNumber:phone
                                    newPassword:password
                                    code:code
                                    success:^{
                                        
                                        [TYAlert showBasicAlertOnVC:self withTitle:@"Reset Successfully" message:@"Please navigate back to login your account." handler:^(UIAlertAction * _Nonnull action) {
            
                                            //navigate back to login page
                                            [self.navigationController popViewControllerAnimated:YES];
            
                                        }];
        
                                    } failure:^(NSError *error) {
        
                                        [TYAlert showBasicAlertOnVC:self withTitle:@"Failed to Reset" message:error.localizedDescription handler:nil];
        
                                    }];
    
}

@end
