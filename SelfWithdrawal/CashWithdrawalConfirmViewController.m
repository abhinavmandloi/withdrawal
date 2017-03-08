//
//  CashWithdrawalConfirmViewController.m
//  SelfWithdrawal
//
//  Created by Abhinav Mandloi on 23/02/17.
//  Copyright © 2017 Abhinav Mandloi. All rights reserved.
//

#import "CashWithdrawalConfirmViewController.h"
#import "CashWithdrawalSuccessViewController.h"
#import "TermsAndConditionsViewController.h"
#import "LandingScreenViewViewController.h"
#import "DashBoardActionViewController.h"
#import "APIManager.h"

@interface CashWithdrawalConfirmViewController ()

@end
NSDictionary *json;
UIActivityIndicatorView *spinnerOne;


@implementation CashWithdrawalConfirmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        self.reponseObject = [[NSDictionary alloc]init];
    // Do any additional setup after loading the view from its nib.
    [self setHeaderViewCardDetails];
    [self setTotalAmountEnteredByUser];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@""
                                                                 style:UIBarButtonItemStylePlain
                                                                target:nil
                                                                action:nil];
    
    [self.navigationItem setBackBarButtonItem:backItem];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = @"CONFIRM";
    spinnerOne = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spinnerOne.center = CGPointMake(self.view.center.x, self.view.center.y);
    spinnerOne.hidesWhenStopped = YES;
    [self.view addSubview:spinnerOne];
}

- (void)setJsonForParameter{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
    // or @"yyyy-MM-dd hh:mm:ss a" if you prefer the time with AM/PM
    NSLog(@"%@",[dateFormatter stringFromDate:[NSDate date]]);
    
    NSArray* nameArray = [self.userDetails valueForKey:@"name"];
    NSArray* mobileNumberArray = [self.userDetails valueForKey:@"mobilenumber"];
    NSArray* emailIdArray = [self.userDetails valueForKey:@"emailId"];
    
    NSString* userName = [nameArray objectAtIndex:0];
    NSString* userMobileNumber = [mobileNumberArray objectAtIndex:0];
    NSString* userEmailId = [emailIdArray objectAtIndex:0];
    NSString *withdrawalAmount = [self.totalAmountEnteredByUser substringFromIndex:1];
   NSUInteger totalAmount = [withdrawalAmount integerValue];
    totalAmount = totalAmount * 100;
    withdrawalAmount = [NSString stringWithFormat:@"%lu",(unsigned long)totalAmount];
    
    json = @{
             @"senderMobile":userMobileNumber,
             @"destTele":userMobileNumber,
             @"channelId":@"01",
             @"terminalId":@"MPQRAPP",
             @"accountId":@"123457",
             @"customerName":userName,
             @"amount":withdrawalAmount,
             @"senderCode":self.userPasscode,
             @"transDatetime":[dateFormatter stringFromDate:[NSDate date]],
             @"entityId":@"0215",
             @"senderName":userName,
             @"addField1":userEmailId,
             @"fee":@"10"
             };
}

- (void)succsesResponse{
    CashWithdrawalSuccessViewController* cashWithdrawalSuccessViewController = [[CashWithdrawalSuccessViewController alloc] init];
    cashWithdrawalSuccessViewController.IMTID = self.reponseObject;
    NSLog(@"Response Object %@",self.reponseObject);
    [self.navigationController presentViewController:cashWithdrawalSuccessViewController animated:YES completion:nil];
}

- (void)setTotalAmountEnteredByUser{
    self.withdrawalAmount.text = [NSString stringWithFormat:@"%@.00",self.totalAmountEnteredByUser];
    self.factorageAmount.text = [NSString stringWithFormat:@"₹%@.00",self.totalCharges];
    NSString *withdrawalAmount = [self.totalAmountEnteredByUser substringFromIndex:1];
    NSString *factorageAmount = [self.factorageAmount.text substringFromIndex:1];
    
    self.totalChargeAmount.text =  [NSString stringWithFormat:@"₹%@.00",[NSString stringWithFormat:@"%d", ([withdrawalAmount intValue]) + ([factorageAmount intValue])]];
}

- (void)setHeaderViewCardDetails{
    self.cardNumberLabel.text = self.userCardNumber;
    self.bankNameLabel.text = self.userBankName;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)termsAndConditionsAction:(id)sender {
    TermsAndConditionsViewController *termsAndConditionsViewController = [[TermsAndConditionsViewController alloc]init];
    [self.navigationController pushViewController:termsAndConditionsViewController animated:YES];
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

- (IBAction)finishButtonAction:(id)sender {
    [self setJsonForParameter];
    if (self.checkbutton.tag == 11) {
    APIManager *a = [[APIManager alloc]init];
        [spinnerOne startAnimating];
    [a loadInitiatePaymentWithParameter:json Success:^(NSDictionary *response){
        [spinnerOne stopAnimating];
        if (response == nil) {
            [self showAlert];
        }else{
        self.reponseObject = response;
        NSLog(@"Success");
        [self succsesResponse];
        }
        
    }failure:^(NSError *error) {
        [spinnerOne stopAnimating];
        [self showAlert];
        NSLog(@"error");
    }];
    }else{
         [self showTermsAndConditionsAlert];
        NSLog(@"Select Terms and Conditions");
    }
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
- (IBAction)checkTermsAndConditionsButtonAction:(id)sender {
    if (self.checkbutton.tag == 12) {
        self.checkbutton.tag = 11;
        [self.checkbutton setImage:[UIImage imageNamed:@"Check_icon"] forState:UIControlStateNormal];
    }else{
    self.checkbutton.tag = 12;
        [self showTermsAndConditionsAlert];
        [self.checkbutton setImage:[UIImage imageNamed:@"Uncheck_icon"] forState:UIControlStateNormal];
    }
}

- (void)showTermsAndConditionsAlert{
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@"Error"
                                 message:@"Please accpet terms and conditions to continue"
                                 preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* okayBtn = [UIAlertAction
                              actionWithTitle:@"Okay"
                              style:UIAlertActionStyleDefault
                              handler:^(UIAlertAction * action) {
    //
                              }];
    [alert addAction:okayBtn];
    [self presentViewController:alert animated:YES completion:nil];
}
@end
