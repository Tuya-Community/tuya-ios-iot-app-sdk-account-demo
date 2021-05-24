//
//  TYBindingAccountViewController.m
//  TuyaAppSDKSample-iOS-UserAccount-ObjC
//
//  Copyright (c) 2014-2021 Tuya Inc. (https://developer.tuya.com/)
//

#import "TYBindingAccountViewController.h"

@interface TYBindingAccountViewController ()

@property (weak, nonatomic) IBOutlet UITextField *countryCodeTextField;
@property (weak, nonatomic) IBOutlet UITextField *accountTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *verificationCodeTextField;

@end

@implementation TYBindingAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - Target functions

- (IBAction)sendVerificationTapped:(UIButton *)sender {
    
    if ([NSPredicate checkEmail:self.accountTextField.text]||[NSPredicate checkPhoneNumber:self.accountTextField.text]) {
        
        [self requestVerification:self.accountTextField.text countryCode:self.countryCodeTextField.text];
        
    } else {
        
        [TYAlert showBasicAlertOnVC:self withTitle:@"Error" message:@"Unvalidated Input" handler:nil];
        
        
    }
}

- (IBAction)bindTapped:(UIButton *)sender {
    
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
    
    
    if ([NSPredicate checkEmail:self.accountTextField.text]||[NSPredicate checkPhoneNumber:self.accountTextField.text]) {
        
        [self bindingAccount:self.accountTextField.text countryCode:self.countryCodeTextField.text password:self.passwordTextField.text code:self.verificationCodeTextField.text];
        
    } else {
        
        [TYAlert showBasicAlertOnVC:self withTitle:@"Error" message:@"Unvalidated Input" handler:nil];
        
    }

}


#pragma mark - Request functions

-(void)requestVerification:(NSString *)userName countryCode:(NSString *)countryCode {
    
    [[TuyaSmartUser sharedInstance] sendBindingVerificationCodeWithEmail:userName
                                    countryCode:countryCode
                                    success:^{
         
                                        [TYAlert showBasicAlertOnVC:self withTitle:@"Verification Code Sent Successfully" message:@"Please check your message for the code." handler:nil];
           
                                        [self.verificationCodeTextField becomeFirstResponder];
                                           
                                    } failure:^(NSError *error) {
        
                                        [TYAlert showBasicAlertOnVC:self withTitle:@"Failed to Sent Verification Code" message:error.localizedDescription handler:nil];
                                           
                                    }];
    
}


-(void)bindingAccount:(NSString *)account countryCode:(NSString *)countryCode password:(NSString *)password code:(NSString *)code {
    
    [[TuyaSmartUser sharedInstance] bindEmail:account
                                    withCountryCode:countryCode
                                    code:code
                                    sId:[TuyaSmartUser sharedInstance].sid
                                    success:^{
        
                                        [TYAlert showBasicAlertOnVC:self withTitle:@"Bind Successfully" message:@"Now you also could login with your email ! " handler:^(UIAlertAction * _Nonnull action) {

                                            //navigate back to user info page
                                        [self.navigationController popViewControllerAnimated:YES];

                                        }];
            
                                    } failure:^(NSError *error) {
            
                                        [TYAlert showBasicAlertOnVC:self withTitle:@"Failed to Binding" message:error.localizedDescription handler:nil];
                                        
                                    }];
    
    
}



@end
