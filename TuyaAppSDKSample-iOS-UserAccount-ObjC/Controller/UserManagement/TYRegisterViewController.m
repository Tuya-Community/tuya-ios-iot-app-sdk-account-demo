//
//  TYRegisterViewController.m
//  TuyaAppSDKSample-iOS-UserAccount-ObjC
//
//  Copyright (c) 2014-2021 Tuya Inc. (https://developer.tuya.com/)  
//

#import "TYRegisterViewController.h"

@interface TYRegisterViewController ()

@property (weak, nonatomic) IBOutlet UITextField *countryCodeTextField;
@property (weak, nonatomic) IBOutlet UITextField *accountTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *verificationCodeTextField;

@end

@implementation TYRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}



#pragma mark - Target functions

- (IBAction)sendVerificationTapped:(UIButton *)sender {
    
    if ([NSPredicate checkEmail:self.accountTextField.text]||[NSPredicate checkPhoneNumber:self.accountTextField.text]) {
        
        [self requestVerification:self.accountTextField.text countryCode:self.countryCodeTextField.text];
        
    } else {
        
        [TYAlert showBasicAlertOnVC:self withTitle:@"Error" message:@"Unvalidated Input" handler:nil];
        
    }
}

- (IBAction)registerTapped:(UIButton *)sender {
    
    /*
     
    check input if necessary
     
    if(self.accountTextField.text.length<1) {
        
        [TYAlert showBasicAlertOnVC:self withTitle:@"Error" message:@"please input user name"];
        return;
        
    }
    if (self.passwordTextField.text.length<1) {
        
        [TYAlert showBasicAlertOnVC:self withTitle:@"Error" message:@"please input password"];
        return;
        
    }
    **/
    
    if ([NSPredicate checkEmail:self.accountTextField.text]) {
        
        //register by Email
        [self registerByEmail:self.accountTextField.text countryCode:self.countryCodeTextField.text password:self.passwordTextField.text code:self.verificationCodeTextField.text];
        
    } else if ([NSPredicate checkPhoneNumber:self.accountTextField.text]) {
        
        //register by phone
        [self registerByPhone:self.accountTextField.text countryCode:self.countryCodeTextField.text password:self.passwordTextField.text code:self.verificationCodeTextField.text];
        
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
                                    type:1
                                    success:^{
        
                                        [TYAlert showBasicAlertOnVC:self withTitle:@"Verification Code Sent Successfully" message:@"Please check your message for the code." handler:nil];
        
                                        [self.verificationCodeTextField becomeFirstResponder];
    
                                    } failure:^(NSError *error) {
                                        
                                        [TYAlert showBasicAlertOnVC:self withTitle:@"Failed to Sent Verification Code" message:error.localizedDescription handler:nil];
                
                                    }];
    
}


-(void)registerByEmail:(NSString *)email countryCode:(NSString *)countryCode password:(NSString *)password code:(NSString *)code {
    
    [[TuyaSmartUser sharedInstance] registerByEmail:countryCode
                                    email:email
                                    password:password
                                    code:code
                                    success:^{
                                        
                                        [TYAlert showBasicAlertOnVC:self withTitle:@"Registered Successfully" message:@"Please navigate back to login your account." handler:^(UIAlertAction * _Nonnull action) {
                                            
                                            //navigate back to login page
                                            [self.navigationController popViewControllerAnimated:YES];
                                            
                                        }];
        
                                    } failure:^(NSError *error) {
        
                                        [TYAlert showBasicAlertOnVC:self withTitle:@"Failed to Register" message:error.localizedDescription handler:nil];
        
                                    }];
    
}

-(void)registerByPhone:(NSString *)phone countryCode:(NSString *)countryCode password:(NSString *)password code:(NSString *)code {
    
    [[TuyaSmartUser sharedInstance] registerByPhone:countryCode
                                    phoneNumber:phone
                                    password:password
                                    code:code
                                    success:^{
        
                                        [TYAlert showBasicAlertOnVC:self withTitle:@"Registered Successfully" message:@"Please navigate back to login your account." handler:^(UIAlertAction * _Nonnull action) {
            
                                            //navigate back to login page
                                            [self.navigationController popViewControllerAnimated:YES];
            
                                        }];
        
                                    } failure:^(NSError *error) {
        
                                        [TYAlert showBasicAlertOnVC:self withTitle:@"Failed to Register" message:error.localizedDescription handler:nil];
        
                                    }];
    
}



@end
