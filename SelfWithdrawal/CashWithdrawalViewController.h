//
//  CashWithdrawalViewController.h
//  SelfWithdrawal
//
//  Created by Abhinav Mandloi on 22/02/17.
//  Copyright © 2017 Abhinav Mandloi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CashWithdrawalViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *bankNameHeaderLabel;
@property (weak, nonatomic) IBOutlet UIImageView *cardHeaderImage;
@property (weak, nonatomic) IBOutlet UILabel *cardNumberHeaderLabel;
@property (weak, nonatomic) IBOutlet UILabel *rupeeSymbolLabel;
//tag = 1
@property (weak, nonatomic) IBOutlet UITextField *amountTextField;
@property (weak, nonatomic) IBOutlet UILabel *totalAmountValidation;

@property (weak, nonatomic) IBOutlet UILabel *yourWithdrawalAmountLabel;
@property (weak, nonatomic) IBOutlet UILabel *withdrawTodayLabel;
@property (weak, nonatomic) IBOutlet UILabel *passcodeToWithdrawLabel;
//tag = 2
@property (weak, nonatomic) IBOutlet UITextField *PasscodeToWithdrawTextField;

@property (weak, nonatomic) IBOutlet UILabel *reEnterPasscodeLabel;
//tag = 3
@property (weak, nonatomic) IBOutlet UITextField *reEnterPasscodeTextField;

@property (weak, nonatomic) IBOutlet UIView *lineViewOne;
@property (weak, nonatomic) IBOutlet UIView *lineViewTwo;
@property (weak, nonatomic) IBOutlet UIView *backViewWithOutHeader;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UILabel *validationMessageLabel;

@property (weak, nonatomic) IBOutlet UILabel *buttomDetailLabel;
@property (strong, nonatomic) NSString *userCardNumber;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (strong, nonatomic) NSString *userBankName;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (strong, nonatomic) NSString *totalAmountEnteredByUser;
@property (strong, nonatomic) NSString *passCodeEnteredByUserFieldOne;
@property (strong, nonatomic) NSString *passCodeEnteredByUserFieldTwo;
@property (strong, nonatomic) NSArray *userDetails;
@property (strong, nonatomic) NSDictionary *responseForValidation;

- (IBAction)nextButtonAction:(id)sender;
- (IBAction)cancelButtonAction:(id)sender;

@end
