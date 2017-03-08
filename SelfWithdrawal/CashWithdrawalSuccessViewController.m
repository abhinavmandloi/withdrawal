//
//  CashWithdrawalSuccessViewController.m
//  SelfWithdrawal
//
//  Created by Abhinav Mandloi on 23/02/17.
//  Copyright © 2017 Abhinav Mandloi. All rights reserved.
//

#import "CashWithdrawalSuccessViewController.h"
#import "WithdrawalHelpViewController.h"
#import "LandingScreenViewViewController.h"
#import "DashBoardActionViewController.h"

@interface CashWithdrawalSuccessViewController ()

@end

@implementation CashWithdrawalSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@""
                                                                 style:UIBarButtonItemStylePlain
                                                                target:nil
                                                                action:nil];
    
    [self.navigationItem setBackBarButtonItem:backItem];
    self.title = @"SUCCESSFUL";
    CGRect frame = [UIScreen mainScreen].bounds;
    self.backScrollView.contentSize = CGSizeMake(frame.size.width, frame.size.height);
    [self viewSetUp];
}

-(void)viewSetUp{
    NSString *IMTIDNumber = [self.IMTID objectForKey:@"emitterTicket"];
    NSString *isSuccess = [self.IMTID objectForKey:@"responseCode"];
    if ([isSuccess isEqualToString:@"E0000"]) {
        self.successImageView.image = [UIImage imageNamed:@"success_icon"];
    }else{
        self.successImageView.image = [UIImage imageNamed:@"error_icon"];
    }
    IMTIDNumber = [self.IMTID objectForKey:@"responseString"];
    self.imdIDLabel.text = IMTIDNumber;
    self.howToWithdrawCashButton.layer.borderColor = [UIColor colorWithRed:51.0/255.0f green:153.0/255.0f blue:204.0/255.0f alpha:1.0].CGColor;
    self.howToWithdrawCashButton.layer.cornerRadius = 5;
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

- (IBAction)howToWithdrawCashButtonAction:(id)sender {
    WithdrawalHelpViewController *withdrawalHelpViewController = [[WithdrawalHelpViewController alloc]init];
    UINavigationController *navcontroller = [[UINavigationController alloc] initWithRootViewController:withdrawalHelpViewController ];
    
    dispatch_async(dispatch_get_main_queue(), ^ {
        [self presentViewController:navcontroller animated:YES completion:nil];
    });
}
- (IBAction)backToHomeButtonAction:(id)sender {
    UINavigationController *navController = (UINavigationController *)self.view.window.rootViewController;
    [self dismissViewControllerAnimated:YES completion:^ {
        [navController popToRootViewControllerAnimated:YES];
    }];
}
@end
