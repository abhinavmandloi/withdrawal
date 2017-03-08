//
//  WithdrawalHistoryTableViewCell.m
//  SelfWithdrawal
//
//  Created by Abhinav Mandloi on 24/02/17.
//  Copyright © 2017 Abhinav Mandloi. All rights reserved.
//

#import "WithdrawalHistoryTableViewCell.h"

@implementation WithdrawalHistoryTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.upperViewWithBorder.layer.borderWidth = 0.3f;
    self.upperViewWithBorder.layer.borderColor = [UIColor colorWithRed:221.0/255.0f green:221.0/255.0f  blue:221.0/255.0f  alpha:1.0].CGColor;
    self.upperViewWithBorder.clipsToBounds = YES;
    self.smallRoundView.layer.cornerRadius = 5;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
