//
//  WithdrawalHistoryDetailsViewController.h
//  SelfWithdrawal
//
//  Created by Abhinav Mandloi on 24/02/17.
//  Copyright © 2017 Abhinav Mandloi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WithdrawalHistoryDetailsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UILabel *bottomMessageLabel;
@property (weak, nonatomic) IBOutlet UIView *secondColorView;
@property (weak, nonatomic) IBOutlet UILabel *HeaderViewIMTIDNumber;
@property (weak, nonatomic) IBOutlet UILabel *HeaderViewIMTIDTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalAmountLabel;
@property (weak, nonatomic) IBOutlet UILabel *userWithdrawalAmountTitleLabel;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UIButton *actionButton;
@property (weak, nonatomic) IBOutlet UIView *firstColorView;
@property (weak, nonatomic) IBOutlet UILabel *imageOneTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *imageTwoTitleLabel;
@property (strong, nonatomic) NSString *userEmitterTicket;
@property (strong, nonatomic) NSString *accountId;
@property (strong, nonatomic) NSString *mobileNumber;
@property (strong, nonatomic) NSString *transTime;
@property (strong, nonatomic) NSString *successMessagetext;
@property (weak, nonatomic) IBOutlet UILabel *transDateLabel;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property NSInteger actionButtonTag;
- (IBAction)actionButton:(id)sender;

@end
