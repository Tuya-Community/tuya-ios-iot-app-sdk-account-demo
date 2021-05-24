//
//  TYUserInfoTableViewCell.m
//  TuyaAppSDKSample-iOS-UserAccount-ObjC
//
//  Created by 萧玄 on 2021/5/13.
//  Copyright © 2021 Tuya. All rights reserved.
//

#import "TYUserInfoTableViewCell.h"

@interface TYUserInfoTableViewCell()


@end

@implementation TYUserInfoTableViewCell


- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.iconImageView.bounds = CGRectMake(0, 0 ,self.iconImageView.bounds.size.height, self.iconImageView.bounds.size.height);
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
