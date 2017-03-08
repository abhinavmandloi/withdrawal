//
//  WithdrawalHistoryViewController.h
//  SelfWithdrawal
//
//  Created by Abhinav Mandloi on 24/02/17.
//  Copyright © 2017 Abhinav Mandloi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WithdrawalHistoryViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *withdrawalHistoryTableView;
@property (weak, nonatomic) IBOutlet UITableView *headerCardDetialsTableView;
@property (strong, nonatomic) NSArray *userDetails;
@property (weak, nonatomic) IBOutlet UIView *historyDurationSelectionView;
//Tag = 12
@property (weak, nonatomic) IBOutlet UIView *firstLineView;
//Tag = 13
@property (weak, nonatomic) IBOutlet UIView *SecondLineView;
//Tag = 14
@property (weak, nonatomic) IBOutlet UIView *thirdLineView;
//Tag = 15
@property (weak, nonatomic) IBOutlet UIView *fourthLineView;
//Tag = 1
@property (weak, nonatomic) IBOutlet UIButton *one_monthButton;
//Tag = 2
@property (weak, nonatomic) IBOutlet UIButton *three_monthButton;
//Tag = 3
@property (weak, nonatomic) IBOutlet UIButton *six_monthButton;
//Tag = 4
@property (weak, nonatomic) IBOutlet UIButton *one_yearButton;
//Tag = 5
@property (weak, nonatomic) IBOutlet UIButton *moreThenOneYear_button;
@property (weak, nonatomic) IBOutlet UILabel *one_monthlabel;
@property (weak, nonatomic) IBOutlet UILabel *three_monthlabel;
@property (weak, nonatomic) IBOutlet UILabel *oneYearLabel;
@property (weak, nonatomic) IBOutlet UILabel *moreThenOneYearLabel;
@property (weak, nonatomic) IBOutlet UILabel *six_monthLabel;
- (IBAction)buttonAction:(UIButton *)sender;



@end
