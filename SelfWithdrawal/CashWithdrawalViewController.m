//
//  CashWithdrawalViewController.m
//  SelfWithdrawal
//
//  Created by Abhinav Mandloi on 22/02/17.
//  Copyright © 2017 Abhinav Mandloi. All rights reserved.
//

#import "CashWithdrawalViewController.h"
#import "CashWithdrawalConfirmViewController.h"
#import "LandingScreenViewViewController.h"
#import "DashBoardActionViewController.h"
#import "APIManager.h"

@interface CashWithdrawalViewController ()<UITextFieldDelegate>

@end

int MIN_AMOUNT;
int MAX_AMOUNT;
int CHARGE_AMOUNT;// CHARGE_AMOUNT / 100
int PASSCODE_LENGTH;// CHARGE_AMOUNT / 100
int CHARGE_PERCENTAGE;
UIActivityIndicatorView *spinnerTwo;

@implementation CashWithdrawalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@""
                                                                 style:UIBarButtonItemStylePlain
                                                                target:nil
                                                                action:nil];
    
    [self.navigationItem setBackBarButtonItem:backItem];
    self.title = @"ENTER AMOUNT";
    self.amountTextField.delegate = self;
    self.PasscodeToWithdrawTextField.delegate = self;
    self.reEnterPasscodeTextField.delegate = self;
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 40)];
    numberToolbar.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar.items = [NSArray arrayWithObjects:
                           [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                           [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)],
                           nil];
    [numberToolbar sizeToFit];
    self.amountTextField.inputAccessoryView = numberToolbar;
    self.PasscodeToWithdrawTextField.inputAccessoryView = numberToolbar;
    self.reEnterPasscodeTextField.inputAccessoryView = numberToolbar;
    spinnerTwo = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spinnerTwo.center = CGPointMake(self.view.center.x, self.view.center.y);
    spinnerTwo.hidesWhenStopped = YES;
    [self.view addSubview:spinnerTwo];
    [self setViewDetails];
}

- (void)viewWillAppear:(BOOL)animated{
    [self setHeaderViewCardDetails];
    [self callConfigurationAPI];
    self.validationMessageLabel.text = @"";
    self.totalAmountValidation.text = @"";
    [self.amountTextField becomeFirstResponder];
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

-(void)doneWithNumberPad{
    self.backView.frame = CGRectMake(0 ,0 ,320 ,480 );
    [self.amountTextField resignFirstResponder];
    [self.PasscodeToWithdrawTextField resignFirstResponder];
    [self.reEnterPasscodeTextField resignFirstResponder];
}

- (void)setValidationResponse{
    NSArray *arr = self.responseForValidation[@"configurationInfoList"];
    for (NSDictionary *dict in arr) {
        if ([[dict valueForKey:@"configurationName"] isEqualToString:@"MIN_AMOUNT"]) {
            MIN_AMOUNT = [[dict valueForKey:@"configurationValue"] intValue];
        }else if ([[dict valueForKey:@"configurationName"] isEqualToString:@"MAX_AMOUNT"]){
            MAX_AMOUNT = [[dict valueForKey:@"configurationValue"] intValue];
        }else if ([[dict valueForKey:@"configurationName"] isEqualToString:@"PASSCODE_LENGTH"]){
            PASSCODE_LENGTH = [[dict valueForKey:@"configurationValue"] intValue];
        }else if ([[dict valueForKey:@"configurationName"] isEqualToString:@"CHARGE_AMOUNT"]){
            CHARGE_AMOUNT = [[dict valueForKey:@"configurationValue"] intValue];
        }else if ([[dict valueForKey:@"configurationName"] isEqualToString:@"CHARGE_PERCENTAGE"]){
            //CHARGE_PERCENTAGE = [[dict valueForKey:@"configurationValue"] intValue];
        }
    }
}

- (void)callConfigurationAPI{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
    NSLog(@"%@",[dateFormatter stringFromDate:[NSDate date]]);
    NSDictionary *json = [[NSDictionary alloc]init];
    json = @{
             @"channelId":@"01",
             @"transDatetime":[dateFormatter stringFromDate:[NSDate date]],
             @"entityId":@"0215",
             };
    APIManager *aPIManager = [[APIManager alloc]init];
    [spinnerTwo startAnimating];
    [aPIManager loadgetConfigurationInfoWithParameter:json Success:^(NSDictionary *response){
        if (response == nil) {
            [self showAlert];
        }else{
            self.responseForValidation = response;
            [spinnerTwo stopAnimating];
            NSLog(@"Success %@",response);
            [self setValidationResponse];
        }
        
    }failure:^(NSError *error) {
        [spinnerTwo stopAnimating];
        NSLog(@"error");
        [self showAlert];
    }];
}

- (void)showAlert{
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@"Error"
                                 message:@"Something Went Wrong"
                                 preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* okayBtn = [UIAlertAction
                              actionWithTitle:@"Okay"
                              style:UIAlertActionStyleDefault
                              handler:^(UIAlertAction * action) {
                                  [self gotoRootView];
                              }];
    [alert addAction:okayBtn];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)gotoRootView{
    UINavigationController *navController = (UINavigationController *)self.view.window.rootViewController;
    for (int i = (int)navController.childViewControllers.count - 1; i >= 0 ; i--){
        if ([navController.childViewControllers[i] isKindOfClass:[DashBoardActionViewController class]]) {
            DashBoardActionViewController *VC = (DashBoardActionViewController *)navController.childViewControllers[i];
            [navController popToViewController:VC animated:YES];
        }
    }
}

- (void) setHeaderViewCardDetails{
    self.cardNumberHeaderLabel.text = self.userCardNumber;
    self.bankNameHeaderLabel.text = @"WITHDRAW FROM";
}

- (void) setViewDetails{
    self.yourWithdrawalAmountLabel.text = NSLocalizedString(@"WITHDRAWAL_AMOUNT_LABEL", @"");
    self.withdrawTodayLabel.text = NSLocalizedString(@"WITHDRAWAL_TODAY_AMOUNT_LABEL", @"");
    self.validationMessageLabel.text = NSLocalizedString(@"VALIDATION_MESSAGE_PASSCODE", @"");
    self.totalAmountValidation.text = NSLocalizedString(@"VALIDATION_MESSAGE_AMOUNT", @"");
    self.passcodeToWithdrawLabel.text = NSLocalizedString(@"PASSCODE", @"");
    self.reEnterPasscodeLabel.text = NSLocalizedString(@"REENTER_PASSCODE", @"");
    self.buttomDetailLabel.text = NSLocalizedString(@"GUIDE_MESSAGE", @"");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (range.location >= 6) {
        return false;
    }
    if (textField.tag == 1) {
        if (range.location == 0) {
            return false;
        }
        NSString *totalAmount = [textField.text stringByReplacingCharactersInRange:range withString:string];
        [self updateTotalAmountEnteredByUser:totalAmount];
    }
    else if (textField.tag == 2) {
        self.passCodeEnteredByUserFieldOne = [textField.text stringByReplacingCharactersInRange:range withString:string];
        if ([self.passCodeEnteredByUserFieldOne isEqualToString:@""]) {
            self.validationMessageLabel.text = @"";
        }
    }
    else if (textField.tag == 3) {
        self.passCodeEnteredByUserFieldTwo = [textField.text stringByReplacingCharactersInRange:range withString:string];
    }
    return YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark - keyboard movements
- (void)keyboardWillShow:(NSNotification *)notification
{
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    if ([self.reEnterPasscodeTextField isFirstResponder]) {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect f = self.backView.frame;
            f.origin.y = -keyboardSize.height;
            self.backView.frame = f;
        }];
    }
}

-(void)keyboardWillHide:(NSNotification *)notification
{
    if (self.backView.frame.origin.y != 0) {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect f = self.backView.frame;
            f.origin.y = 0.0f;
            self.backView.frame = f;
        }];
    }
}

- (void)updateTotalAmountEnteredByUser:(NSString *)totalAmount{
    if ([totalAmount isEqualToString:@"₹"]){
        
        NSLog(@"Enter Amount");
    }else{
        self.totalAmountEnteredByUser = totalAmount;
    }
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)nextButtonAction:(id)sender {
    NSString *withdrawalAmount = [self.totalAmountEnteredByUser substringFromIndex:1];
    int check = [withdrawalAmount intValue];
    
    if (check <= 99){
        self.totalAmountValidation.text = @"Minimun amount is 100";
        return;
    }else{
        self.totalAmountValidation.text = @"";
    }
    
    if (!((check % 100) == 0 )){
        self.totalAmountValidation.text = @"Amount should be divisible by 100";
        return;
    }else{
        self.totalAmountValidation.text = @"";
    }
    
    if ([self.passCodeEnteredByUserFieldOne isEqualToString:self.passCodeEnteredByUserFieldTwo]) {
        if (!(self.passCodeEnteredByUserFieldOne.length == 0)) {
            self.validationMessageLabel.text = @"Enter Passcode";
            return;
        }else{
            self.validationMessageLabel.text = @"";
        }
    }
    
    if ([self.passCodeEnteredByUserFieldOne isEqualToString:self.passCodeEnteredByUserFieldTwo]) {
        if (!(self.passCodeEnteredByUserFieldOne.length == PASSCODE_LENGTH)) {
            self.validationMessageLabel.text = [NSString stringWithFormat:@"Passcode lenth should be %d",PASSCODE_LENGTH];
            return;
        }else{
            self.validationMessageLabel.text = @"";
        }
    }
    if (![self.passCodeEnteredByUserFieldOne isEqualToString:self.passCodeEnteredByUserFieldTwo]) {
        self.validationMessageLabel.text = @"Passcode doesn’t match";
        self.lineViewOne.backgroundColor = [UIColor redColor];
        self.lineViewTwo.backgroundColor = [UIColor redColor];
        return;
    }else{
    }
    
    if ([withdrawalAmount integerValue] > (MAX_AMOUNT / 100)){
        NSLog(@"Enter Amount");
        self.totalAmountValidation.text = [NSString stringWithFormat:@"Withdrawal amount is more than %d",(MAX_AMOUNT / 100)];
        return;
    }
    
    if (!(withdrawalAmount && [withdrawalAmount floatValue]  > 0)) {
        self.totalAmountValidation.text = @"Enter Amount";
        return;
    }
    
    if ([withdrawalAmount integerValue] > (MAX_AMOUNT / 100)){
        NSLog(@"Enter Amount");
        self.totalAmountValidation.text = [NSString stringWithFormat:@"Withdrawal amount is more than %d",(MAX_AMOUNT / 100)];
        return;
    }else{
        CashWithdrawalConfirmViewController *cashWithdrawalConfirmViewController = [[CashWithdrawalConfirmViewController alloc]init];
        cashWithdrawalConfirmViewController.userPasscode = self.passCodeEnteredByUserFieldOne;
        CHARGE_AMOUNT = CHARGE_AMOUNT / 100;
        cashWithdrawalConfirmViewController.totalCharges = [NSString stringWithFormat:@"%d",CHARGE_AMOUNT];
        cashWithdrawalConfirmViewController.userDetails = self.userDetails;
        cashWithdrawalConfirmViewController.userBankName = self.userBankName;
        cashWithdrawalConfirmViewController.userCardNumber = self.userCardNumber;
        cashWithdrawalConfirmViewController.totalAmountEnteredByUser = self.totalAmountEnteredByUser;
        [self.navigationController pushViewController:cashWithdrawalConfirmViewController animated:YES];
    }
}

- (IBAction)cancelButtonAction:(id)sender {
    UINavigationController *navController = (UINavigationController *)self.view.window.rootViewController;
    for (int i = (int)navController.childViewControllers.count - 1; i >= 0 ; i--){
        if ([navController.childViewControllers[i] isKindOfClass:[LandingScreenViewViewController class]]) {
            LandingScreenViewViewController *VC = (LandingScreenViewViewController *)navController.childViewControllers[i];
            [navController popToViewController:VC animated:YES];
        }
    }
}
@end
