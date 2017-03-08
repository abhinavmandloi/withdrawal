//
//  CashWithdrawalSuccessViewController.h
//  SelfWithdrawal
//
//  Created by Abhinav Mandloi on 23/02/17.
//  Copyright © 2017 Abhinav Mandloi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CashWithdrawalSuccessViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *imdIDLabel;
@property (weak, nonatomic) IBOutlet UIImageView *successImageView;
@property (weak, nonatomic) IBOutlet UIImageView *mapImageView;
@property (weak, nonatomic) IBOutlet UILabel *successMessageLabel;
@property (weak, nonatomic) IBOutlet UIButton *howToWithdrawCashButton;
@property (weak, nonatomic) NSArray *userDetails;
@property (weak, nonatomic) NSDictionary *IMTID;

- (IBAction)howToWithdrawCashButtonAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *backToHomeButton;
- (IBAction)backToHomeButtonAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIScrollView *backScrollView;

@end
