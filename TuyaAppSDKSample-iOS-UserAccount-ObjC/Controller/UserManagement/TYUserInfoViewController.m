//
//  TYUserInfoViewController.m
//  TuyaAppSDKSample-iOS-UserAccount-ObjC
//
//  Copyright (c) 2014-2021 Tuya Inc. (https://developer.tuya.com/)
//

#import "TYUserInfoViewController.h"
#import "TYLoginViewController.h"
#import "TYBindingAccountViewController.h"
@interface TYUserInfoViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

/**
    icon list
*/
@property (nonatomic ,copy) NSArray<NSArray<UIImage *> *>  *iconArr;

/**
 TuyaSmartUser property list
*/
@property (nonatomic ,copy) NSArray<NSArray<NSString *> *> *contentArr;

@end

@implementation TYUserInfoViewController

#pragma mark lifecycle event
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    
    // If you have not login for a long time or  reset the password in the login state, it will  returns the Session expired error when requesting the data from service . In this case you need to monitor TuyaSmartUserNotificationUserSessionInvalid , back to the login page to login again.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sessionInvalid) name:TuyaSmartUserNotificationUserSessionInvalid object:nil];
}


-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self loadData];
    
}

-(void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}


-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {

  [viewController viewWillAppear:animated];
}



#pragma mark  Private Function


-(void)loadData {
    
    //after user login , we can get the user data from the singleton
    TuyaSmartUser *user = [TuyaSmartUser sharedInstance];
        
    // two groups , the first one diaplay the header icon and nickname
    // the second one display other property information
    NSString *nick = [NSString stringWithFormat:@"%@",user.nickname];
    // If user didn't set the nick name before , remind them to set
    NSString *nickName = [nick isEqualToString:@""] ? @"Click to set the nick name" : nick ;
        
    NSString *email = [NSString stringWithFormat:@"%@",user.email];
    // If user didn't bind the email address before , remind them to bind
    NSString *emailAddress = [email isEqualToString:@""] ? @"Click to bind the email" : email ;
        
    NSString *phone = [NSString stringWithFormat:@"%@",user.phoneNumber];
    NSString *country = [NSString stringWithFormat:@"%@",user.countryCode];
    NSString *userName = [NSString stringWithFormat:@"%@",user.userName];
        
    self.contentArr = nil;
    
    self.contentArr = @[@[nickName],
                        @[userName,phone,emailAddress,country]];
        
    self.iconArr = @[@[[UIImage imageNamed:@"header"]],
                     @[[UIImage imageNamed:@"nickname"],
                       [UIImage imageNamed:@"phone"],
                       [UIImage imageNamed:@"email"],
                       [UIImage imageNamed:@"country"]]];
        
    [self.tableView reloadData];
 
}

#pragma mark Request Data

-(void)sessionInvalid {
       
    //return to login page
    UIStoryboard *Storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    TYLoginViewController *vc = [Storyboard instantiateViewControllerWithIdentifier:@"login"];
    
    [UIApplication sharedApplication].windows[0].rootViewController = [[UINavigationController alloc] initWithRootViewController:vc];
        
}

-(void)logOut {
    // pop up the alert
    UIAlertController *alertViewController = [UIAlertController alertControllerWithTitle:nil message:NSLocalizedString(@"You're going to log out this account.", @"User tapped the logout button.") preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *logoutAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Logout", nil) style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        [[TuyaSmartUser sharedInstance] loginOut:^{
            
            //logout
            [self sessionInvalid];
            
        } failure:^(NSError *error) {
            [TYAlert showBasicAlertOnVC:self withTitle:@"Failed to Logout." message:error.localizedDescription handler:nil];
        }];
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel", @"Cancel") style:UIAlertActionStyleCancel handler:nil];
    
    [alertViewController addAction:logoutAction];
    [alertViewController addAction:cancelAction];
    [self.navigationController presentViewController:alertViewController animated:YES completion:nil];
    
}

-(void)resetNickName:(NSString * _Nonnull)nickName {
    
    [[TuyaSmartUser sharedInstance] updateNickname:nickName
                                    success:^{
            
                                         [TYAlert showBasicAlertOnVC:self withTitle:@"Title" message:@"Set Successfully" handler:^(UIAlertAction * _Nonnull action){
             
                                        
                                             dispatch_async(dispatch_get_main_queue(), ^{
                                                 
                                                 [self loadData];
                                                 
                                             });
                                             
                                            }];
        
                                    }failure:^(NSError *error) {
            
                                           [TYAlert showBasicAlertOnVC:self withTitle:@"Failed to Sent Verification Code" message:error.localizedDescription handler:nil];
                                           
                                       }];
    
    
    
    
}

#pragma mark - DataSource

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
   
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"userInfoCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (cell == nil){
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"userInfoCell"];
        
     };
    
    //content
    cell.textLabel.text = self.contentArr[indexPath.section][indexPath.row];
    
    //icon
    cell.imageView.image = self.iconArr[indexPath.section][indexPath.row];
    
    if (indexPath.section == 0) {
        // the first section , show the head icon
        cell.textLabel.font = [UIFont systemFontOfSize:22 ];
        
    } else {
        
        cell.textLabel.font = [UIFont systemFontOfSize:16];
    }
    
    return cell;
  
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return  [self.contentArr[section] count];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return [self.contentArr count];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section==0) {
        return 100;
    }
    else {
        return 60;
    }
    
}

// set the logout button
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {

    if (section==0) {
        return nil;
    }
    else {
    
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300,100)];
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(40,30,SCREEN_WIDTH-80, 40)];
        
        [button setBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:126.0/225.0 blue:0 alpha:1]];
        [button setTitle:@"Log out" forState:UIControlStateNormal];
        button.layer.cornerRadius = 8;
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(logOut) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:button];
        
        return view;
        
    }

}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
 
    if (section==0) {
        return 0.1;
    }
    else {
        return 100;
    }
    
}
    

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (section==0) {
        return 0.1;
    }
    else {
        return 10;
    }
    
}

#pragma mark - Delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section==0) {
        
        [TYAlert showInputAlertOnVC:self withTitle:@"" message:@"Please input new nick name" confirmHandler:^(NSString * content) {
            
            [self resetNickName:content];
            
        }];
        
        return;
    }
    
    
    if (indexPath.section == 1) {
        
        //binding email
        if(indexPath.row == 2 && [[NSString stringWithFormat:@"%@",[TuyaSmartUser sharedInstance].email] isEqualToString:@""]) {
            
            UIStoryboard *Storyboard = [UIStoryboard storyboardWithName:@"TYUserInfo" bundle:nil];
            
            TYBindingAccountViewController *vc = [Storyboard instantiateViewControllerWithIdentifier:@"bindEmail"];
            
            [self.navigationController pushViewController:vc animated:YES];
            
        }
        
        return;
        
    }
    
}


#pragma mark lazy loading



@end
