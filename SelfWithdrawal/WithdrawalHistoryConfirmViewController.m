//
//  WithdrawalHistoryConfirmViewController.m
//  SelfWithdrawal
//
//  Created by Abhinav Mandloi on 02/03/17.
//  Copyright © 2017 Abhinav Mandloi. All rights reserved.
//

#import "WithdrawalHistoryConfirmViewController.h"
#import "APIManager.h"
#import "WithdrawalHistorySuccessViewController.h"
#import "LandingScreenViewViewController.h"
#import "DashBoardActionViewController.h"

@interface WithdrawalHistoryConfirmViewController ()

@end
NSDictionary *cancelPaymentDic;
NSDictionary *regenerateOtpDic;
UIColor *vcRedColor;
UIColor *vcBlueColor;
UIColor *vcGreenColor;
UIActivityIndicatorView *spinnerThree;


@implementation WithdrawalHistoryConfirmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@""
                                                                 style:UIBarButtonItemStylePlain
                                                                target:nil
                                                                action:nil];
    [self.navigationItem setBackBarButtonItem:backItem];
    
    vcRedColor = [UIColor colorWithRed:231/255.0f green:76/255.0f blue:60/255.0f alpha:1.0];
    vcBlueColor = [UIColor colorWithRed:51/255.0f green:153/255.0f blue:204/255.0f alpha:1.0];
    vcGreenColor = [UIColor colorWithRed:111.0/255.0f green:188.0/255.0f blue:26.0/255.0f alpha:1.0];
    self.firstRoundView.layer.cornerRadius = 5;
    self.secondRoundView.layer.cornerRadius = 5;
    self.actionButton.layer.borderColor = vcBlueColor.CGColor;
    self.actionButton.layer.cornerRadius = 5;
    self.IMTID.text = self.emitterTicket;
    spinnerThree = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spinnerThree.center = CGPointMake(self.view.center.x, self.view.center.y);
    spinnerThree.hidesWhenStopped = YES;
    [self.view addSubview:spinnerThree];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    self.actionButton.tag = self.buttonTag;
    self.dateLabel.text = self.transDate;
    if (self.buttonTag == 1) {
        self.title = @"RESEND OTP";
        self.susscesMessage.text = [NSString stringWithFormat:@"The OTP will be sent to your mobile number %@",self.userMobNumber];
        [self.actionButton setTintColor:vcBlueColor];
        [self.actionButton setTitle:@"RESEND OTP" forState:UIControlStateNormal];
    }
    
    if (self.buttonTag == 2) {
        self.title = @"CANCEL";
        self.susscesMessage.text = @"Are you sure, you want to cancel this withdrawal?";
        self.susscesMessage.textColor = vcRedColor;
        [self.actionButton setTitleColor:vcRedColor forState:UIControlStateNormal];
        self.actionButton.layer.borderColor = vcRedColor.CGColor;
        [self.actionButton setTitle:@"CANCEL" forState:UIControlStateNormal];
    }
    
    if (self.status == 1) {
        self.secondLabel.text = @"Completed";
        self.firstRoundView.backgroundColor = vcBlueColor;
        self.firstLebel.textColor = vcBlueColor;
    }else if (self.status == 4){
        self.secondLabel.text = @"Completed";
        self.secondLabel.textColor = vcGreenColor;
        self.secondRoundView.backgroundColor = vcGreenColor;
    }
    [self cancelPaymentJson];
    [self regenerateOtpJson];
}

- (void)regenerateOtpJson{
    regenerateOtpDic = @{
                         @"accountId":self.userAccountId,
                         @"channelId":@"01",
                         @"emitterTicket":self.emitterTicket,
                         @"transDatetime":self.userTransTime,
                         @"entityId":@"0215",
                         };
    NSLog(@"regenerateOtpDic %@",regenerateOtpDic);
}

- (void)cancelPaymentJson{
    
    cancelPaymentDic = @{
                         @"emitterTicket":self.emitterTicket,
                         @"accountId":self.userAccountId,
                         @"channelId":@"01",
                         @"terminalID":@"MPQRAPP",
                         @"transDatetime":self.userTransTime,
                         @"entityId":@"0215",
                         };
    NSLog(@"cancelPaymentDic %@",cancelPaymentDic);
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)buttonAction:(UIButton*)sender {
    
    if (sender.tag == 1) {
        APIManager *apiManager = [[APIManager alloc]init];
        [spinnerThree startAnimating];
        [apiManager regenerateOtpWithParameter:regenerateOtpDic Success:^(NSDictionary *response){
            [spinnerThree stopAnimating];
            NSLog(@"%@",response);
            if (response == nil) {
                [self showAlert];
            }else{
                self.APIsuccessCheckText = [response objectForKey:@"responseCode"];
                self.APIsuccessMessage = [response objectForKey:@"responseString"];
                [self gotoNextView];
            }
        }failure:^(NSError *error) {
            [spinnerThree stopAnimating];
            NSLog(@"error");
            [self showAlert];
        }];
        
    }else if (sender.tag == 2) {
        APIManager *apiManager = [[APIManager alloc]init];
        [spinnerThree startAnimating];
        [apiManager cancelPaymentWithParameter:cancelPaymentDic Success:^(NSDictionary *response){
            [spinnerThree stopAnimating];
            if (response == nil) {
                [self showAlert];
            }else{
                self.APIsuccessMessage = [response objectForKey:@"responseString"];
                [self gotoNextView];
            }
        }failure:^(NSError *error) {
            [spinnerThree stopAnimating];
            NSLog(@"error");
            [self showAlert];
        }];
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

- (void)gotoNextView{
    WithdrawalHistorySuccessViewController *withdrawalHistorySuccessViewController = [[WithdrawalHistorySuccessViewController alloc]init];
    withdrawalHistorySuccessViewController.successMessagetext = self.APIsuccessMessage;
    withdrawalHistorySuccessViewController.successChecktext = self.APIsuccessCheckText;
    [self.navigationController presentViewController:withdrawalHistorySuccessViewController animated:YES completion:nil];
}
@end
