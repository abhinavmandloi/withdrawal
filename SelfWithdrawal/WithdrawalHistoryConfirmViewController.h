//
//  WithdrawalHistoryConfirmViewController.h
//  SelfWithdrawal
//
//  Created by Abhinav Mandloi on 02/03/17.
//  Copyright © 2017 Abhinav Mandloi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WithdrawalHistoryConfirmViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UILabel *confrimMessage;
@property (weak, nonatomic) IBOutlet UILabel *totalAmount;
@property (weak, nonatomic) IBOutlet UILabel *firstLebel;
@property (weak, nonatomic) IBOutlet UILabel *secondLabel;
@property (weak, nonatomic) IBOutlet UILabel *paymentMessage;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIView *firstRoundView;
@property (weak, nonatomic) IBOutlet UIView *secondRoundView;
@property (weak, nonatomic) IBOutlet UIView *horizontalView;
@property (weak, nonatomic) IBOutlet UIButton *actionButton;
@property (weak, nonatomic) IBOutlet UILabel *susscesMessage;
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UILabel *IMTID;
@property (weak, nonatomic) IBOutlet UILabel *IMTIDStaticLabel;

@property (strong, nonatomic) UIColor *firstViewColor;
@property (strong, nonatomic) UIColor *secondViewColor;
@property (strong, nonatomic) NSString *APIsuccessMessage;
@property (strong, nonatomic) NSString *APIsuccessCheckText;
@property int status;
@property (strong, nonatomic) NSString *emitterTicket;
@property (strong, nonatomic) NSString *userAccountId;
@property (strong, nonatomic) NSString *userTransTime;
@property (strong, nonatomic) NSString *mobileNumber;
@property (strong, nonatomic) NSString *transDate;
@property (strong, nonatomic) NSString *userMobNumber;
@property NSInteger buttonTag;


- (IBAction)buttonAction:(id)sender;

@end
