//
//  WithdrawalHistorySuccessViewController.h
//  SelfWithdrawal
//
//  Created by Abhinav Mandloi on 24/02/17.
//  Copyright © 2017 Abhinav Mandloi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WithdrawalHistorySuccessViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *successImageView;
@property (weak, nonatomic) IBOutlet UIButton *backToHomeButton;
@property (weak, nonatomic) IBOutlet UILabel *successMessageLabel;
@property (strong, nonatomic) NSString *successMessagetext;
@property (strong, nonatomic) NSString *successChecktext;
@property (weak, nonatomic) IBOutlet UIButton *withdrawHistoryButton;
- (IBAction)withdrawHistoryButtonAction:(id)sender;
- (IBAction)backToHomeButtonAction:(id)sender;


@end
