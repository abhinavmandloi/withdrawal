//
//  DashBoardActionViewController.m
//  SelfWithdrawal
//
//  Created by Abhinav Mandloi on 02/03/17.
//  Copyright © 2017 Abhinav Mandloi. All rights reserved.
//

#import "DashBoardActionViewController.h"
#import "LandingScreenViewViewController.h"
#import "APIManager.h"

@interface DashBoardActionViewController ()

@property(nonatomic, weak) NSString *userName;
@property(nonatomic, weak) NSString *userEmail;
@property(nonatomic, weak) NSString *userNumber;
@property (strong, nonatomic) NSDictionary *responseForValidation;
@property (strong, nonatomic) NSArray *detailsArray;
@property (nonatomic) BOOL isApiWorking;

@end
UIActivityIndicatorView *spinnerSix;

@implementation DashBoardActionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.isApiWorking = false;
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@""
                                                                 style:UIBarButtonItemStylePlain
                                                                target:nil
                                                                action:nil];
    
    [self.navigationItem setBackBarButtonItem:backItem];
    self.title = @"HOME";
    spinnerSix = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spinnerSix.center = CGPointMake(self.view.center.x, self.view.center.y);
    spinnerSix.hidesWhenStopped = YES;
    [self.view addSubview:spinnerSix];
//    [self setStatusBarBackgroundColor:[UIColor redColor]];
//    [self setNeedsStatusBarAppearanceUpdate];
//    [[UIApplication sharedApplication]
//     setStatusBarStyle:UIStatusBarStyleLightContent];
}

-(void)viewWillAppear:(BOOL)animated{
    [self callConfigurationAPI];
}

//- (UIStatusBarStyle)preferredStatusBarStyle
//{
//    return UIStatusBarStyleLightContent;
//}

- (void)setStatusBarBackgroundColor:(UIColor *)color {
    
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = color;
    }
    
    if ([statusBar respondsToSelector:@selector(setTintColor:)]) {
        statusBar.tintColor = color;
    }
}

- (void)setValidationResponse{
    NSArray *arr = self.responseForValidation[@"configurationInfoList"];
    for (NSDictionary *dict in arr) {
        if ([[dict valueForKey:@"configurationName"] isEqualToString:@"SENDER_NAME"]) {
            self.userName = [dict valueForKey:@"configurationValue"];
        }else if ([[dict valueForKey:@"configurationName"] isEqualToString:@"SENDER_EMAIL"]){
            self.userEmail = [dict valueForKey:@"configurationValue"];
        }else if ([[dict valueForKey:@"configurationName"] isEqualToString:@"SENDER_MOBILE_NO"]){
            self.userNumber = [dict valueForKey:@"configurationValue"];
        }
    }
    self.detailsArray = [[NSArray alloc]initWithObjects:[NSDictionary dictionaryWithObjectsAndKeys:
                                                         self.userName, @"name",
                                                         self.userEmail, @"emailId",
                                                         self.userNumber, @"mobilenumber",
                                                         @"7878",@"cardNumber",
                                                         @"123457",@"accountId",
                                                         @"TRANSACTION FOR",@"bankName",
                                                         nil], nil];
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
    [spinnerSix startAnimating];
    [aPIManager loadgetConfigurationInfoWithParameter:json Success:^(NSDictionary *response){
        if (response == nil) {
            [self showAlert];
        }else{
            self.isApiWorking = true;
            self.responseForValidation = response;
            [spinnerSix stopAnimating];
            NSLog(@"Success %@",response);
            [self setValidationResponse];
        }
        
    }failure:^(NSError *error) {
        [spinnerSix stopAnimating];
        self.isApiWorking = false;
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

- (IBAction)IMT_buttonAction:(id)sender {
    if (!self.isApiWorking) {
        [self callConfigurationAPI];
        [self showAlert];
    }else{
        LandingScreenViewViewController *landingScreenViewViewController = [[LandingScreenViewViewController alloc]init];
        landingScreenViewViewController.names = self.detailsArray;
        [self.navigationController pushViewController:landingScreenViewViewController animated:YES];
    }
}
@end
