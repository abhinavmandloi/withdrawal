//
//  LandingScreenViewViewController.m
//  SelfWithdrawal
//
//  Created by Abhinav Mandloi on 20/02/17.
//  Copyright © 2017 Abhinav Mandloi. All rights reserved.
//

#import "LandingScreenViewViewController.h"
#import "CardDetailsTableViewCell.h"
#import "WithdrawFeaturesTableViewCell.h"
#import "CashWithdrawalViewController.h"
#import "WithdrawalHistoryViewController.h"
#import "WithdrawalHelpViewController.h"

@interface LandingScreenViewViewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation LandingScreenViewViewController

BOOL isCardDetailsViewOpen = false;
NSString *userName;
NSString *userMobileNumber;
NSString *userEmailId;
NSString *userbankName;
NSString *usercardNumber;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   // self.names
    self.edgesForExtendedLayout = UIRectEdgeNone;
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@""
                                                                 style:UIBarButtonItemStylePlain
                                                                target:nil
                                                                action:nil];
    
    [self.navigationItem setBackBarButtonItem:backItem];
    self.title = @"CASH WITHDRAWAL";
    [self registerNibs];
    [self setUserDetails];
    [self setUpCardView];
    
    self.landingScreenTableView.dataSource = self;
    self.landingScreenTableView.delegate = self;
}

#pragma mark - Custom Method
-(void)registerNibs {
    [self.landingScreenTableView registerNib:[UINib nibWithNibName:@"CardDetailsTableViewCell" bundle:nil] forCellReuseIdentifier:@"CardDetailsCell"];
    [self.landingScreenTableView registerNib:[UINib nibWithNibName:@"WithdrawFeaturesTableViewCell" bundle:nil] forCellReuseIdentifier:@"WithdrawFeaturesCell"];
}

- (void) setUserDetails{
    NSArray* bankNameArray = [self.names valueForKey:@"bankName"];
    NSArray* cardNumberArray = [self.names valueForKey:@"cardNumber"];
    NSArray* nameArray = [self.names valueForKey:@"name"];
    NSArray* mobileNumberArray = [self.names valueForKey:@"mobilenumber"];
    NSArray* emailIdArray = [self.names valueForKey:@"emailId"];
    
    userName = [nameArray objectAtIndex:0];
    userMobileNumber = [mobileNumberArray objectAtIndex:0];
    userEmailId = [emailIdArray objectAtIndex:0];
    userbankName = [[bankNameArray objectAtIndex:0] uppercaseString];
    usercardNumber = [cardNumberArray objectAtIndex:0];
}

- (void)setUpCardView{
    CGRect frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 55);
    self.cardDetailsView.frame = frame;
    [self.view addSubview:self.cardDetailsView];
    [self.view bringSubviewToFront:self.cardDetailsView];
    self.cardDetailsView.backgroundColor = [UIColor colorWithDisplayP3Red:238.0f/255.0f green:238.0f/255.0f blue:238.0f/255.0f alpha:1.0];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 53)];
    btn.backgroundColor = [UIColor colorWithDisplayP3Red:238.0f/255.0f green:238.0f/255.0f blue:238.0f/255.0f alpha:1.0];
    [btn addTarget:self
            action:@selector(cardDetailsButtonClicked:)
  forControlEvents:UIControlEventTouchUpInside];
    UILabel *bankName = [[UILabel alloc]initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width - 320), 15, 180, 30)];
    [UIFont fontWithName:@"MuseoSans-500" size:18];
    [bankName setFont:[UIFont systemFontOfSize:18]];
    bankName.textAlignment = NSTextAlignmentRight;
    bankName.text = @"WITHDRAW FROM";
    [btn addSubview:bankName];
    
    UILabel *cardNumber = [[UILabel alloc]initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width - 90), 18, 45, 21)];
    [UIFont fontWithName:@"MuseoSans-500" size:18];
    [cardNumber setFont:[UIFont systemFontOfSize:18]];
    cardNumber.textAlignment = NSTextAlignmentLeft;
    cardNumber.text = usercardNumber;
    [btn addSubview:cardNumber];
    
    UIImageView *cardImage = [[UIImageView alloc]initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width - 135), 17, 35, 25)];
    cardImage.image = [UIImage imageNamed:@"CardImage_icon"];
    [btn addSubview:cardImage];
    
//    UIImageView *dropDownImage = [[UIImageView alloc]initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width - 36), 27, 12, 6)];
//    dropDownImage.image = [UIImage imageNamed:@"CradDropDron_icon"];
//    [btn addSubview:dropDownImage];
    
    [self.cardDetailsView addSubview:btn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showUserCards{
    int y = 0;
    NSArray* bankNameArray = [self.names valueForKey:@"bankName"];
    NSArray* cardNumberArray = [self.names valueForKey:@"cardNumber"];
    if (isCardDetailsViewOpen) {
        for (int i = 0 ; i < self.names.count; i++){
            CGRect frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, ((i + 1) * 55) > 275 ? 275 : ((i + 1) * 55));
            self.cardDetailsView.contentSize = CGSizeMake(0, 55 * self.names.count);
            self.cardDetailsView.frame = frame;
            [self.view addSubview:self.cardDetailsView];
            [self.view bringSubviewToFront:self.cardDetailsView];
            self.cardDetailsView.backgroundColor = [UIColor colorWithDisplayP3Red:238.0f/255.0f green:238.0f/255.0f blue:238.0f/255.0f alpha:1.0];
            
            UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, y, [UIScreen mainScreen].bounds.size.width, 53)];
            y += 53;
            btn.backgroundColor = [UIColor colorWithDisplayP3Red:238.0f/255.0f green:238.0f/255.0f blue:238.0f/255.0f alpha:1.0];
            btn.tag = i;
            [btn addTarget:self
                    action:@selector(cardDetailsButtonClicked:)
          forControlEvents:UIControlEventTouchUpInside];
            
            UILabel *bankName = [[UILabel alloc]initWithFrame:CGRectMake(40, 15, 155, 30)];
            [UIFont fontWithName:@"MuseoSans-500" size:18];
            [bankName setFont:[UIFont systemFontOfSize:18]];
            bankName.textAlignment = NSTextAlignmentLeft;
            bankName.text = [[bankNameArray objectAtIndex:i]uppercaseString];
            [btn addSubview:bankName];
            
            UILabel *cardNumber = [[UILabel alloc]initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width - 90), 18, 45, 21)];
            [UIFont fontWithName:@"MuseoSans-500" size:18];
            [cardNumber setFont:[UIFont systemFontOfSize:18]];
            cardNumber.text = [cardNumberArray objectAtIndex:i];
            [btn addSubview:cardNumber];
            
            UIImageView *cardImage = [[UIImageView alloc]initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width - 135), 17, 35, 25)];
            cardImage.image = [UIImage imageNamed:@"CardImage_icon"];
            [btn addSubview:cardImage];
            
            if (i == 0) {
                UIImageView *dropDownImage = [[UIImageView alloc]initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width - 36), 27, 12, 6)];
                dropDownImage.image = [UIImage imageNamed:@"CradDropDron_icon"];
                [btn addSubview:dropDownImage];
            }
            
            [self.view layoutIfNeeded];
            [UIView animateWithDuration:2.5 animations:^{
                [self.cardDetailsView addSubview:btn];
            }];
        }
    }else{
        [self.view layoutIfNeeded];
        [UIView animateWithDuration:2.5 animations:^{
            [[self.cardDetailsView subviews]
             makeObjectsPerformSelector:@selector(removeFromSuperview)];
        }];
    }
}

- (void)cardDetailsButtonClicked:(UIButton *)btn{
    NSLog(@"No Nothing");
    /*
    isCardDetailsViewOpen = !isCardDetailsViewOpen;
    NSArray* nameArray = [names valueForKey:@"name"];
    NSArray* mobileNumberArray = [names valueForKey:@"mobilenumber"];
    NSArray* emailIdArray = [names valueForKey:@"emailId"];
    NSArray* bankNameArray = [names valueForKey:@"bankName"];
    NSArray* cardNumberArray = [names valueForKey:@"cardNumber"];
    
    if (isCardDetailsViewOpen) {
        [self showUserCards];
    }
    else {
        userName = [nameArray objectAtIndex:btn.tag];
        userMobileNumber = [mobileNumberArray objectAtIndex:btn.tag];
        userEmailId = [emailIdArray objectAtIndex:btn.tag];
        userbankName = [[bankNameArray objectAtIndex:btn.tag]uppercaseString];
        usercardNumber = [cardNumberArray objectAtIndex:btn.tag];
        
        [self.landingScreenTableView reloadData];
        [self showUserCards];
        [self setUpCardView];
    }
    [self.view layoutIfNeeded];
     */
}

#pragma mark - TableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        CardDetailsTableViewCell *cardDetailsTableViewCell = [self.landingScreenTableView dequeueReusableCellWithIdentifier:@"CardDetailsCell" forIndexPath:indexPath];
        
        cardDetailsTableViewCell.selectionStyle = UITableViewCellSelectionStyleNone;
        cardDetailsTableViewCell.userInteractionEnabled = false;
        cardDetailsTableViewCell.detailLabel.text = userName;
        cardDetailsTableViewCell.phoneNumberLabel.text = userMobileNumber;
        cardDetailsTableViewCell.emailIDLabel.text = userEmailId;
        
        if(cardDetailsTableViewCell == nil) {
            cardDetailsTableViewCell = (CardDetailsTableViewCell *)[self.landingScreenTableView dequeueReusableCellWithIdentifier:@"CardDetailsCell" forIndexPath:indexPath];
        }
        
        return cardDetailsTableViewCell;
    }else{
        
        WithdrawFeaturesTableViewCell *withdrawFeaturesTableViewCell = [self.landingScreenTableView dequeueReusableCellWithIdentifier:@"WithdrawFeaturesCell" forIndexPath:indexPath];
        
        withdrawFeaturesTableViewCell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.section == 1) {
            if (indexPath.row == 0) {
                withdrawFeaturesTableViewCell.backView.backgroundColor = [UIColor colorWithDisplayP3Red:51.0f/255.0f green:153.0f/255.0f blue:204.0f/255.0f alpha:1.0];
                withdrawFeaturesTableViewCell.titleLabel.textColor = [UIColor colorWithDisplayP3Red:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0];
                withdrawFeaturesTableViewCell.detailLabel.textColor = [UIColor colorWithDisplayP3Red:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0];
                
                withdrawFeaturesTableViewCell.iconImage.image = [UIImage imageNamed:@"Dollar_icon"];
                withdrawFeaturesTableViewCell.titleLabel.text = NSLocalizedString(@"CASH_WITHDRAWAL", @"");
                withdrawFeaturesTableViewCell.detailLabel.text = NSLocalizedString(@"SELF_WITHDRAWAL", @"");
            }
        }
        if (indexPath.section == 2) {
            if (indexPath.row == 0) {
                withdrawFeaturesTableViewCell.iconImage.image = [UIImage imageNamed:@"Time_icon"];
                withdrawFeaturesTableViewCell.titleLabel.text = NSLocalizedString(@"WITHDRAWAL_HISTORY", @"User Name");
                withdrawFeaturesTableViewCell.detailLabel.text = NSLocalizedString(@"SEE_WITHDRAWAL", @"");
            }
        }
        if (indexPath.section == 3) {
            if (indexPath.row == 0) {
                withdrawFeaturesTableViewCell.iconImage.image = [UIImage imageNamed:@"Help_icon"];
                withdrawFeaturesTableViewCell.titleLabel.text = NSLocalizedString(@"WITHDRAWAL_HELP", @"");
                withdrawFeaturesTableViewCell.detailLabel.text = NSLocalizedString(@"ATM_WITHDRAWAL", @"");
            }
        }
        if (withdrawFeaturesTableViewCell == nil) {
            withdrawFeaturesTableViewCell = [self.landingScreenTableView dequeueReusableCellWithIdentifier:@"WithdrawFeaturesCell" forIndexPath:indexPath];
        }
        
        return withdrawFeaturesTableViewCell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //do to
    //validation
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"username"]){
        
    }
   /// [[NSUserDefaults standardUserDefaults] objectForKey:@"defaultsCardIndex"];
    
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            CashWithdrawalViewController *cashWithdrawalViewController = [[CashWithdrawalViewController alloc]init];
            cashWithdrawalViewController.userDetails = self.names;
            cashWithdrawalViewController.userCardNumber = usercardNumber;
            cashWithdrawalViewController.userBankName = userbankName;
            [self.navigationController pushViewController:cashWithdrawalViewController animated:YES];
        }
    }
    if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            WithdrawalHistoryViewController *withdrawalHistoryViewController = [[WithdrawalHistoryViewController alloc]init];
            withdrawalHistoryViewController.userDetails = self.names;
            [self.navigationController pushViewController:withdrawalHistoryViewController animated:YES];
        }
    }
    if (indexPath.section == 3) {
        if (indexPath.row == 0) {
            WithdrawalHelpViewController *withdrawalHelpViewController = [[WithdrawalHelpViewController alloc]init];
            UINavigationController *navcontroller = [[UINavigationController alloc] initWithRootViewController:withdrawalHelpViewController ];
            [self.navigationController presentViewController:navcontroller animated:YES completion:nil];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section >= 1) {
        return 10.0;
    }
    return 0.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section >= 1) {
        return 10.0;
    }
    return 25.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 225;
    }
    return 80;
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
