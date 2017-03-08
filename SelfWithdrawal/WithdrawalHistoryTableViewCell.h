//
//  WithdrawalHistoryTableViewCell.h
//  SelfWithdrawal
//
//  Created by Abhinav Mandloi on 24/02/17.
//  Copyright © 2017 Abhinav Mandloi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WithdrawalHistoryTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *imtIDTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *userIMTID;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIView *upperViewWithBorder;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *monthAndYearLabel;
@property (weak, nonatomic) IBOutlet UIView *horizontalView;
@property (weak, nonatomic) IBOutlet UIView *smallRoundView;
@property (weak, nonatomic) IBOutlet UIView *horizontalViewTwo;

@end
