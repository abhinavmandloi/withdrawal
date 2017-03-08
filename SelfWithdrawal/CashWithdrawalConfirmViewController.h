//
//  CashWithdrawalConfirmViewController.h
//  SelfWithdrawal
//
//  Created by Abhinav Mandloi on 23/02/17.
//  Copyright © 2017 Abhinav Mandloi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CashWithdrawalConfirmViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *bankNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *bankCardImageView;
@property (weak, nonatomic) IBOutlet UILabel *cardNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *withdrawalAmountLabel;
@property (weak, nonatomic) IBOutlet UILabel *withdrawalAmount;
@property (weak, nonatomic) IBOutlet UILabel *factorageLabel;
@property (weak, nonatomic) IBOutlet UILabel *factorageAmount;
@property (weak, nonatomic) IBOutlet UILabel *totalChargeLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalChargeAmount;
@property (weak, nonatomic) IBOutlet UIButton *checkbutton;
- (IBAction)checkTermsAndConditionsButtonAction:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *termsAndConditionsLabel;
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UIButton *termsAndConditionsButton;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (strong, nonatomic) NSArray *userDetails;
@property (strong, nonatomic) NSString *userPasscode;
@property (strong, nonatomic) NSString *totalCharges;
@property (strong, nonatomic) NSDictionary *reponseObject;
- (IBAction)termsAndConditionsAction:(id)sender;
- (IBAction)cancelButtonAction:(id)sender;
- (IBAction)finishButtonAction:(id)sender;

@property (strong, nonatomic) NSString *userBankName;
@property (strong, nonatomic) NSString *userCardNumber;
@property (strong, nonatomic) NSString *totalAmountEnteredByUser;

@end
