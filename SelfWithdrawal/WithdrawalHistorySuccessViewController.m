//
//  WithdrawalHistorySuccessViewController.m
//  SelfWithdrawal
//
//  Created by Abhinav Mandloi on 24/02/17.
//  Copyright © 2017 Abhinav Mandloi. All rights reserved.
//

#import "WithdrawalHistorySuccessViewController.h"
#import "WithdrawalHistoryViewController.h"
#import "LandingScreenViewViewController.h"
#import "DashBoardActionViewController.h"

@interface WithdrawalHistorySuccessViewController ()

@end

@implementation WithdrawalHistorySuccessViewController

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
}

- (void)setUpViews{
    
    if (![self.successChecktext isEqualToString:@"E0000"]) {
        self.successImageView.image = [UIImage imageNamed:@"error_icon"];
    }else{
        self.successImageView.image = [UIImage imageNamed:@"success_icon"];
    }
    
    self.withdrawHistoryButton.layer.borderColor = [UIColor colorWithRed:51.0/255.0f green:153.0/255.0f blue:204.0/255.0f alpha:1.0].CGColor;
    self.withdrawHistoryButton.layer.cornerRadius = 5;
    self.successMessageLabel.text = NSLocalizedString(@"SUCCESS_MESSAGE", @"");
    self.successMessageLabel.text = self.successMessagetext;
    self.backToHomeButton.titleLabel.text = NSLocalizedString(@"BACK_BUTTON_TITLE", @"");
    self.withdrawHistoryButton.titleLabel.text = NSLocalizedString(@"WITHDRAWAL_BUTTON_TITLE", @"");
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

- (IBAction)withdrawHistoryButtonAction:(id)sender {
    UINavigationController *navController = (UINavigationController *)self.view.window.rootViewController;
    [self dismissViewControllerAnimated:YES completion:^ {
    for (int i = (int)navController.childViewControllers.count - 1; i >= 0 ; i--){
        if ([navController.childViewControllers[i] isKindOfClass:[WithdrawalHistoryViewController class]]) {
            WithdrawalHistoryViewController *VC = (WithdrawalHistoryViewController *)navController.childViewControllers[i];
        [navController popToViewController:VC animated:YES];
        }
    }
    }];
}

- (IBAction)backToHomeButtonAction:(id)sender {
    UINavigationController *navController = (UINavigationController *)self.view.window.rootViewController;
    [self dismissViewControllerAnimated:YES completion:^ {
        [navController popToRootViewControllerAnimated:YES];
    }];
}

@end
