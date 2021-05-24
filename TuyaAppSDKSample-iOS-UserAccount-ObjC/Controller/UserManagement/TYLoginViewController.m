//
//  TYLoginViewController.m
//  TuyaAppSDKSample-iOS-UserAccount-ObjC
//
//  Copyright (c) 2014-2021 Tuya Inc. (https://developer.tuya.com/)
//

#import "TYLoginViewController.h"
#import "TYResetPasswordViewController.h"
#import "TYRegisterViewController.h"
#import "TYMainViewController.h"
#import "TYUserInfoViewController.h"

@interface TYLoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *accountTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *countryCodeTextField;
 
@end

@implementation TYLoginViewController

- (void)viewDidLoad {
    
    
    [super viewDidLoad];
    
    // if user had login , navigate to main page directly
    if ([TuyaSmartUser sharedInstance].isLogin) {
                
        UIStoryboard *Storyboard = [UIStoryboard storyboardWithName:@"TYUserInfo" bundle:nil];

        TYUserInfoViewController *vc = [Storyboard instantiateViewControllerWithIdentifier:@"userInfo"];

        [UIApplication sharedApplication].windows[0].rootViewController = [[UINavigationController alloc] initWithRootViewController:vc];
        
    }
    // Do any additional setup after loading the view.
}


#pragma mark - Target functions


//navigate to Forget Password Controller
- (IBAction)forgetPassword:(UIButton *)sender {
    
    UIStoryboard *Storyboard = [UIStoryboard storyboardWithName:@"TYResetPassword" bundle:nil];
    
    TYResetPasswordViewController *vc = [Storyboard instantiateViewControllerWithIdentifier:@"resetPassword"];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}


- (IBAction)login:(UIButton *)sender {
    
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
        
        [self loginByEmail:self.accountTextField.text countryCode:self.countryCodeTextField.text password:self.passwordTextField.text];
        
    } else {
        
        [self loginByPhone:self.accountTextField.text countryCode:self.countryCodeTextField.text password:self.passwordTextField.text];
        
    }
    
}


#pragma mark - Request functions


-(void)loginByEmail:(NSString *)email countryCode:(NSString *)countryCode password:(NSString *)password {
    
    [[TuyaSmartUser sharedInstance] loginByEmail:countryCode                                                                  email:email                                                                               password:password
                                    success:^{
       
                                        [TYAlert showBasicAlertOnVC:self withTitle:@"Login Successfully" message:@"Will navigate to MainPage." handler:^(UIAlertAction * _Nonnull action) {

                                            // login success , will navigate to Main Controller

                                            UIStoryboard *Storyboard = [UIStoryboard storyboardWithName:@"TYUserInfo" bundle:nil];

                                            TYUserInfoViewController *vc = [Storyboard instantiateViewControllerWithIdentifier:@"userInfo"];

                                            [UIApplication sharedApplication].windows[0].rootViewController = [[UINavigationController alloc] initWithRootViewController:vc];

                                        }];
        
                                    } failure:^(NSError *error) {
        
                                        [TYAlert showBasicAlertOnVC:self withTitle:@"Failed to Login" message:error.localizedDescription handler:nil];
        
                                    }];
    
}

-(void)loginByPhone:(NSString *)phone countryCode:(NSString *)countryCode password:(NSString *)password {
    
    [[TuyaSmartUser sharedInstance] loginByPhone:countryCode                                                                  phoneNumber:phone                                                                         password:password
                                    success:^{
                                        
                                        // login successfully
                                        [TYAlert showBasicAlertOnVC:self withTitle:@"Login Successfully" message:@"Will navigate to MainPage." handler:^(UIAlertAction * _Nonnull action) {

                                            // login success , will navigate to Main Controller
                
                                            UIStoryboard *Storyboard = [UIStoryboard storyboardWithName:@"TYUserInfo" bundle:nil];
            
                                            TYUserInfoViewController *vc = [Storyboard instantiateViewControllerWithIdentifier:@"userInfo"];
            
                                            [UIApplication sharedApplication].windows[0].rootViewController = [[UINavigationController alloc] initWithRootViewController:vc];

                                       }];
        
                                        
        
                                    } failure:^(NSError *error) {
        
                                        [TYAlert showBasicAlertOnVC:self withTitle:@"Failed to Login" message:error.localizedDescription handler:nil];
        
                                    }];
    
}

@end
