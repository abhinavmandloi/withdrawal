//
//  WithdrawalHistoryDetailsViewController.m
//  SelfWithdrawal
//
//  Created by Abhinav Mandloi on 24/02/17.
//  Copyright © 2017 Abhinav Mandloi. All rights reserved.
//

#import "WithdrawalHistoryDetailsViewController.h"
#import "WithdrawalHistorySuccessViewController.h"
#import "LandingScreenViewViewController.h"
#import "WithdrawalHistoryConfirmViewController.h"
#import "DashBoardActionViewController.h"
#import "APIManager.h"

@interface WithdrawalHistoryDetailsViewController ()

@end

NSDictionary *requestDic;
NSDictionary *responseDic;
NSDictionary *withdrawPaymentDic;
UIColor *redColor;
UIColor *blueColor;
UIColor *greenColor;
UIActivityIndicatorView *spinnerFour;

@implementation WithdrawalHistoryDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@""
                                                                 style:UIBarButtonItemStylePlain
                                                                target:nil
                                                                action:nil];
    [self.navigationItem setBackBarButtonItem:backItem];
    self.title = @"STATUS";
    spinnerFour = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spinnerFour.center = CGPointMake(self.view.center.x, self.view.center.y);
    spinnerFour.hidesWhenStopped = YES;
    [self.view addSubview:spinnerFour];
    self.actionButton.hidden = true;
    self.cancelButton.hidden = true;
}

- (void)viewWillAppear:(BOOL)animated{
    redColor = [UIColor colorWithRed:231/255.0f green:76/255.0f blue:60/255.0f alpha:1.0];
    blueColor = [UIColor colorWithRed:51/255.0f green:153/255.0f blue:204/255.0f alpha:1.0];
    greenColor = [UIColor colorWithRed:111.0/255.0f green:188.0/255.0f blue:26.0/255.0f alpha:1.0];
    [self setRequestDic];
    [self withdrawPaymenJson];
    [self apiCall];
}


- (void)setRequestDic{
    requestDic = @{
                   @"emitterTicket":self.userEmitterTicket,
                   @"accountId":self.accountId,
                   @"channelId":@"01",
                   @"entityId":@"0215",
                   };
}

- (void)apiCall{
    APIManager *aPIManager = [[APIManager alloc]init];
    [spinnerFour startAnimating];
    [aPIManager statusInquiryWithParameter:requestDic Success:^(NSDictionary *response){
        if (response == nil) {
            [self showAlert];
        }else{
        [spinnerFour stopAnimating];
        NSLog(@"%@",response);
        responseDic = response;
            NSLog(@"---%@",[responseDic objectForKey:@"responseString"]);
            if (![responseDic objectForKey:@"responseString"] || [[responseDic objectForKey:@"responseString"] isEqual:[NSNull null]]) {
                [self showAlert];
            } else {
           [self setUpViews];
            }
        }
        
    }failure:^(NSError *error) {
        [spinnerFour stopAnimating];
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

-(void)hideButtons{
    CGRect viewFrame = self.backView.frame;
    viewFrame = CGRectMake(0, self.backView.frame.origin.x, [UIScreen mainScreen].bounds.size.width, self.backView.frame.size.height - 60);
    self.backView.frame = viewFrame;
    self.actionButton.hidden = YES;
    self.cancelButton.hidden = YES;
}

- (void)setUpViews{
    self.firstColorView.layer.cornerRadius = 5;
    self.secondColorView.layer.cornerRadius = 5;
    self.actionButton.layer.borderColor = blueColor.CGColor;
    self.cancelButton.layer.cornerRadius = 5;
    self.cancelButton.layer.borderColor = redColor.CGColor;
    self.actionButton.layer.cornerRadius = 5;
    self.HeaderViewIMTIDTitleLabel.text = NSLocalizedString(@"IMTID_TITLE_LABEL", @"");
    self.userWithdrawalAmountTitleLabel.text = NSLocalizedString(@"AMOUNT_MESSAGE", @"");
    self.bottomMessageLabel.text = NSLocalizedString(@"BOTTOM_MESSAGE", @"");
    self.HeaderViewIMTIDNumber.text = [responseDic objectForKey:@"emitterTicket"];
    int total = [[responseDic objectForKey:@"amount"] intValue];
    total = (total / 100);
    self.totalAmountLabel.text = [NSString stringWithFormat:@"₹%d",total];
    int status = [[responseDic objectForKey:@"status"] intValue];
    NSString *finalDate = (NSString *)[responseDic objectForKey:@"expiryDate"];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyyMMddHHmmss";
    
    NSDate *date = [dateFormatter dateFromString:finalDate];
    [dateFormatter setDateFormat:@"dd MMMM yyyy"];
    self.transTime = [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:date]];
    self.transDateLabel.text = self.transTime;
    
    if (status == 1) {
        self.actionButton.hidden = false;
        self.cancelButton.hidden = false;
        self.imageTwoTitleLabel.text = @"Completed";
        self.secondColorView.backgroundColor = blueColor;
        self.imageOneTitleLabel.textColor = blueColor;
        self.actionButton.tag = 11;
        self.cancelButton.tag = 12;
    }else if (status == 2){
        self.firstColorView.backgroundColor = redColor;
        self.imageTwoTitleLabel.textColor = redColor;
        self.imageTwoTitleLabel.text = @"Cancelled";
        [self hideButtons];
        
    }else if (status == 8){
        self.imageTwoTitleLabel.text = @"Blocked";
        self.imageTwoTitleLabel.textColor = redColor;
        self.firstColorView.backgroundColor = redColor;
        [self hideButtons];
        
    }else if (status == 4){
        self.actionButton.hidden = false;
        self.cancelButton.hidden = false;
        self.imageTwoTitleLabel.text = @"Completed";
        self.imageTwoTitleLabel.textColor = greenColor;
        self.firstColorView.backgroundColor = greenColor;
        self.cancelButton.hidden = YES;
        [self.actionButton setNeedsLayout];
        CGRect frame = self.actionButton.frame;
        frame = CGRectMake(self.actionButton.frame.origin.x, self.actionButton.frame.origin.y, self.actionButton.frame.size.width + 100, self.actionButton.frame.size.height);
        self.actionButton.frame = frame;
        CGPoint centrePoint = self.actionButton.center;
        centrePoint.x = self.view.center.x;
        self.actionButton.center = centrePoint;
        self.actionButton.hidden = false;
        [self.actionButton setTitle:@"Withdraw Again" forState:UIControlStateNormal];
        self.actionButton.tag = 3;
    }else if (status == 3){
        self.imageTwoTitleLabel.text = @"Expired";
        self.imageOneTitleLabel.textColor = redColor;
        self.firstColorView.backgroundColor = redColor;
        [self hideButtons];
    }else if (status == 13){
        self.imageTwoTitleLabel.text = @"Held";//Held
        self.imageTwoTitleLabel.textColor = redColor;
        self.firstColorView.backgroundColor = redColor;
        [self hideButtons];
    }else if (status == 5){
        self.imageTwoTitleLabel.text = @"Validation Failed ";//Failed
        self.imageTwoTitleLabel.textColor = redColor;
        self.firstColorView.backgroundColor = redColor;
        [self hideButtons];
    }
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

- (void)withdrawPaymenJson{
    
    withdrawPaymentDic = @{
                           @"destTele":@"9820175762",
                           @"channelId":@"01",
                           @"terminalID":@"MPQRAPP",
                           @"amount":@"1000",
                           @"senderCode":@"1234",
                           @"otp":@"4420",
                           @"transDatetime":@"201702161109542",
                           @"entityId":@"0215",
                           };
    NSLog(@"withdrawPaymentDic %@",withdrawPaymentDic);
}

- (void)gotoLandingPage{
    
    LandingScreenViewViewController *landingScreenViewViewController = [[LandingScreenViewViewController alloc]init];
    [self.navigationController pushViewController:landingScreenViewViewController animated:YES];
}

- (void)gotoWithdrawalHistoryConfirmViewController{
    WithdrawalHistoryConfirmViewController *withdrawalHistoryConfirmViewController = [[WithdrawalHistoryConfirmViewController alloc]init];
    withdrawalHistoryConfirmViewController.status = [[responseDic objectForKey:@"status"] intValue];
    withdrawalHistoryConfirmViewController.transDate = self.transTime;
    withdrawalHistoryConfirmViewController.userMobNumber = self.mobileNumber;
    withdrawalHistoryConfirmViewController.buttonTag = self.actionButtonTag;
    withdrawalHistoryConfirmViewController.userTransTime = self.transTime;
    withdrawalHistoryConfirmViewController.userAccountId = self.accountId;
    withdrawalHistoryConfirmViewController.emitterTicket = self.userEmitterTicket;
    [self.navigationController pushViewController:withdrawalHistoryConfirmViewController animated:YES];
}

- (IBAction)actionButton:(UIButton*)sender {
    
    if (sender.tag == 11) {
        self.actionButtonTag = 1;
        [self gotoWithdrawalHistoryConfirmViewController];
        
    }else if (sender.tag == 12) {
        self.actionButtonTag = 2;
        [self gotoWithdrawalHistoryConfirmViewController];
        
    }else if (sender.tag == 3) {
        APIManager *apiManager = [[APIManager alloc]init];
        [spinnerFour startAnimating];
        [apiManager withdrawPaymentWithParameter:withdrawPaymentDic Success:^(NSDictionary *response){
            if (response == nil) {
                [self showAlert];
            }else{
            [spinnerFour stopAnimating];
            NSLog(@"%@",response);
            [self gotoLandingPage];
            }
        }failure:^(NSError *error) {
            [spinnerFour stopAnimating];
            NSLog(@"error");
            [self showAlert];
        }];
    }
}
@end
