//
//  WithdrawFeaturesTableViewCell.m
//  SelfWithdrawal
//
//  Created by Abhinav Mandloi on 20/02/17.
//  Copyright © 2017 Abhinav Mandloi. All rights reserved.
//

#import "WithdrawFeaturesTableViewCell.h"

@implementation WithdrawFeaturesTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
     // Initialization code
    self.backView.layer.cornerRadius = 5;
    self.backView.clipsToBounds = YES;
    self.backView.layer.masksToBounds = NO;
    self.backView.layer.shadowOffset = CGSizeMake(1, 1);
    self.backView.layer.shadowRadius = 2.5;
    self.backView.layer.shadowOpacity = 0.25;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
