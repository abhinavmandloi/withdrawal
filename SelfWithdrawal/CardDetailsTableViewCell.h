//
//  CardDetailsTableViewCell.h
//  SelfWithdrawal
//
//  Created by Abhinav Mandloi on 20/02/17.
//  Copyright © 2017 Abhinav Mandloi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CardDetailsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailIDLabel;
@property (weak, nonatomic) IBOutlet UILabel *mobileNumber;
@property (weak, nonatomic) IBOutlet UILabel *emailId;

@end
