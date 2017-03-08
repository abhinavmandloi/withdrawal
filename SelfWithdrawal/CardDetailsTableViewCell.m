//
//  CardDetailsTableViewCell.m
//  SelfWithdrawal
//
//  Created by Abhinav Mandloi on 20/02/17.
//  Copyright © 2017 Abhinav Mandloi. All rights reserved.
//

#import "CardDetailsTableViewCell.h"

@implementation CardDetailsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.titleLabel.text = NSLocalizedString(@"USER_NAME", @"User Name");
    self.mobileNumber.text = NSLocalizedString(@"MOBILE_NUMBER", @"Mobile Number");
    self.emailId.text = NSLocalizedString(@"EMAIL_ID", @"Email ID");
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
