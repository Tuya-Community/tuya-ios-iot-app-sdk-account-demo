//
//  TYUserInfoTableViewCell.h
//  TuyaAppSDKSample-iOS-UserAccount-ObjC
//
//  Created by 萧玄 on 2021/5/13.
//  Copyright © 2021 Tuya. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


typedef NS_ENUM(NSInteger, UserInfoStyle) {
    UserInfoStyleHeader = 0,
    UserInfoStyleCustom,
    //UserInfoStyleOther,
};


@interface TYUserInfoTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (assign, nonatomic) UserInfoStyle style;

@end

NS_ASSUME_NONNULL_END
