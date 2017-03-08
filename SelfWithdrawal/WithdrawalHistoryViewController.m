//
//  WithdrawalHistoryViewController.m
//  SelfWithdrawal
//
//  Created by Abhinav Mandloi on 24/02/17.
//  Copyright © 2017 Abhinav Mandloi. All rights reserved.
//

#import "WithdrawalHistoryViewController.h"
#import "WithdrawalHistoryTableViewCell.h"
#import "WithdrawalHistoryDetailsViewController.h"
#import "DashBoardActionViewController.h"
#import "APIManager.h"

@interface WithdrawalHistoryViewController ()<UITableViewDelegate, UITableViewDataSource>

@end
NSDictionary *requestJson;
NSArray *responseArr;
NSArray *mobileNumber;
NSString *user_MobileNumber;


@implementation WithdrawalHistoryViewController

BOOL isDetailsViewOpen = false;
NSString *user_bankName;
NSString *user_cardNumber;
NSString *userAccountId;
NSString *userEmitterTicket;
NSMutableArray *transAmount;
NSMutableArray *transIMTID;
NSMutableArray *transExpiryDate;
NSMutableArray *bankTransactionIds;
NSMutableArray *transTime;
UIColor *viewBlueColor;
UIColor *viewGreyColor;
UIActivityIndicatorView *spinnerFive;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.withdrawalHistoryTableView registerNib:[UINib nibWithNibName:@"WithdrawalHistoryTableViewCell" bundle:nil] forCellReuseIdentifier:@"WithdrawalHistoryCell"];
    viewBlueColor = [UIColor colorWithRed:92.0/255.0f green:173.0/255.0f  blue:214.0/255.0f  alpha:1.0];
    viewGreyColor = [UIColor colorWithRed:221.0/255.0f green:221.0/255.0f  blue:221.0/255.0f  alpha:1.0];
    self.withdrawalHistoryTableView.delegate = self;
    self.withdrawalHistoryTableView.dataSource = self;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@""
                                                                 style:UIBarButtonItemStylePlain
                                                                target:nil
                                                                action:nil];
    
    [self.navigationItem setBackBarButtonItem:backItem];
    spinnerFive = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spinnerFive.center = CGPointMake(self.view.center.x, self.view.center.y);
    spinnerFive.hidesWhenStopped = YES;
    [self.view addSubview:spinnerFive];
    self.title = @"HISTORY";
}

- (void)viewWillAppear:(BOOL)animated{
    [self updateCardData];
    [self setUpCardDetailsView];
    [self historyDurationSelectionViewSetUp];
    [self setRequestJsonForParameterDayComponent: -30];
    [self makeApiCall];
    [self.withdrawalHistoryTableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)historyDurationSelectionViewSetUp{
    self.one_monthButton.layer.cornerRadius = 5;
    self.one_monthButton.clipsToBounds = YES;
    self.three_monthButton.layer.cornerRadius = 5;
    self.three_monthButton.clipsToBounds = YES;
    self.six_monthButton.layer.cornerRadius = 5;
    self.six_monthButton.clipsToBounds = YES;
    self.one_yearButton.layer.cornerRadius = 5;
    self.one_yearButton.clipsToBounds = YES;
    self.moreThenOneYear_button.layer.cornerRadius = 5;
    self.moreThenOneYear_button.clipsToBounds = YES;
}

-(void)updateCardData{
    NSArray *bankName = [self.userDetails valueForKey:@"bankName"];
    NSArray *cardNumber = [self.userDetails valueForKey:@"cardNumber"];
    NSArray *accountNumber = [self.userDetails valueForKey:@"accountId"];
    mobileNumber = [self.userDetails valueForKey:@"mobilenumber"];
    user_MobileNumber = [mobileNumber objectAtIndex:0];
    user_bankName = [[bankName objectAtIndex:0] uppercaseString];
    user_cardNumber = [cardNumber objectAtIndex:0];
    userAccountId = [accountNumber objectAtIndex:0];
}


- (void)setUpCardDetailsView{
    CGRect frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 55);
    self.headerCardDetialsTableView.frame = frame;
    [self.view addSubview:self.headerCardDetialsTableView];
    [self.view bringSubviewToFront:self.headerCardDetialsTableView];
    self.headerCardDetialsTableView.backgroundColor = [UIColor colorWithDisplayP3Red:238.0f/255.0f green:238.0f/255.0f blue:238.0f/255.0f alpha:1.0];
    
    CGRect historySelectionFrame = CGRectMake(0, 55, [UIScreen mainScreen].bounds.size.width, 40);
    self.historyDurationSelectionView.frame = historySelectionFrame;
    [self.view addSubview:self.historyDurationSelectionView];
    [self.view bringSubviewToFront:self.historyDurationSelectionView];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 53)];
    btn.backgroundColor = [UIColor colorWithDisplayP3Red:238.0f/255.0f green:238.0f/255.0f blue:238.0f/255.0f alpha:1.0];
    [btn addTarget:self
            action:@selector(cardDetailsButtonAction:)
  forControlEvents:UIControlEventTouchUpInside];
    UILabel *bankName = [[UILabel alloc]initWithFrame:CGRectMake(40, 15, 155, 30)];
    [UIFont fontWithName:@"MuseoSans-500" size:18];
    [bankName setFont:[UIFont systemFontOfSize:18]];
    bankName.textAlignment = NSTextAlignmentLeft;
    bankName.text = user_bankName;
    [btn addSubview:bankName];
    
    UILabel *cardNumber = [[UILabel alloc]initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width - 90), 18, 45, 21)];
    [UIFont fontWithName:@"MuseoSans-500" size:18];
    [cardNumber setFont:[UIFont systemFontOfSize:18]];
    cardNumber.textAlignment = NSTextAlignmentLeft;
    cardNumber.text = user_cardNumber;
    [btn addSubview:cardNumber];
    
    UIImageView *cardImage = [[UIImageView alloc]initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width - 135), 17, 35, 25)];
    cardImage.image = [UIImage imageNamed:@"CardImage_icon"];
    [btn addSubview:cardImage];
    
    UIImageView *dropDownImage = [[UIImageView alloc]initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width - 36), 27, 12, 6)];
    dropDownImage.image = [UIImage imageNamed:@"CradDropDron_icon"];
    [btn addSubview:dropDownImage];
    
    [self.headerCardDetialsTableView addSubview:btn];
}

- (void)showUserCardDetails{
    int y = 0;
    NSArray* bankNameArray = [self.userDetails valueForKey:@"bankName"];
    NSArray* cardNumberArray = [self.userDetails valueForKey:@"cardNumber"];
    if (isDetailsViewOpen && self.userDetails.count > 0) {
        for (int i = 0 ; i < self.userDetails.count; i++){
            CGRect frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, ((i + 1) * 55) > 275 ? 275 : ((i + 1) * 55));
            self.headerCardDetialsTableView.contentSize = CGSizeMake(0, 55 * self.userDetails.count);
            self.headerCardDetialsTableView.frame = frame;
            [self.view addSubview:self.headerCardDetialsTableView];
            [self.view bringSubviewToFront:self.headerCardDetialsTableView];
            self.headerCardDetialsTableView.backgroundColor = [UIColor colorWithDisplayP3Red:238.0f/255.0f green:238.0f/255.0f blue:238.0f/255.0f alpha:1.0];
            
            UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, y, [UIScreen mainScreen].bounds.size.width, 53)];
            y += 53;
            btn.backgroundColor = [UIColor colorWithDisplayP3Red:238.0f/255.0f green:238.0f/255.0f blue:238.0f/255.0f alpha:1.0];
            btn.tag = i;
            [btn addTarget:self
                    action:@selector(cardDetailsButtonAction:)
          forControlEvents:UIControlEventTouchUpInside];
            
            UILabel *bankName = [[UILabel alloc]initWithFrame:CGRectMake(40, 15, 155, 30)];
            [UIFont fontWithName:@"MuseoSans-500" size:18];
            [bankName setFont:[UIFont systemFontOfSize:18]];
            bankName.textAlignment = NSTextAlignmentLeft;
            bankName.text = [[bankNameArray objectAtIndex:i]uppercaseString];
            [btn addSubview:bankName];
            
            if (self.userDetails.count > 1) {
                UIView *divideLineView = [[UIView alloc]initWithFrame:CGRectMake(0, 52, [UIScreen mainScreen].bounds.size.width, 2)];
                divideLineView.backgroundColor = [UIColor colorWithRed:221.0/255.0f green:221.0/255.0f  blue:221.0/255.0f  alpha:1.0];
                [btn addSubview:divideLineView];
            }
            
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
                [self.headerCardDetialsTableView addSubview:btn];
            }];
        }
    }else{
        //[self.view layoutIfNeeded];
        [self.view bringSubviewToFront:self.headerCardDetialsTableView];
        [UIView animateWithDuration:2.5 animations:^{
            [[self.headerCardDetialsTableView subviews]
             makeObjectsPerformSelector:@selector(removeFromSuperview)];
        }];
    }
}

- (void)cardDetailsButtonAction:(UIButton *)btn{
    isDetailsViewOpen = !isDetailsViewOpen;
    NSArray* bankNameArray = [self.userDetails valueForKey:@"bankName"];
    NSArray* cardNumberArray = [self.userDetails valueForKey:@"cardNumber"];
    NSArray* accountId = [self.userDetails valueForKey:@"accountId"];
    
    if (isDetailsViewOpen) {
        [self showUserCardDetails];
    }
    else {
        user_bankName = [[bankNameArray objectAtIndex:btn.tag]uppercaseString];
        user_cardNumber = [cardNumberArray objectAtIndex:btn.tag];
        userAccountId = [accountId objectAtIndex:btn.tag];
        
        [self setRequestJsonForParameterDayComponent: -30];
        self.one_monthButton.backgroundColor = viewBlueColor;
        self.three_monthButton.backgroundColor = viewGreyColor;
        self.six_monthButton.backgroundColor = viewGreyColor;
        self.one_yearButton.backgroundColor = viewGreyColor;
        self.moreThenOneYear_button.backgroundColor = viewGreyColor;
        self.firstLineView.backgroundColor = viewGreyColor;
        self.SecondLineView.backgroundColor = viewGreyColor;
        self.thirdLineView.backgroundColor = viewGreyColor;
        self.fourthLineView.backgroundColor = viewGreyColor;
        
        if (self.userDetails.count > 1) {
            [self makeApiCall];
            [self showUserCardDetails];
            [self setUpCardDetailsView];
        }
    }
    [self.view layoutIfNeeded];
}

#pragma mark - TableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return responseArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WithdrawalHistoryTableViewCell *withdrawalHistoryTableViewCell = [self.withdrawalHistoryTableView dequeueReusableCellWithIdentifier:@"WithdrawalHistoryCell" forIndexPath:indexPath];
    if (indexPath.section == 0 && indexPath.row == 0) {
        withdrawalHistoryTableViewCell.horizontalViewTwo.hidden = YES;
    }else{
        withdrawalHistoryTableViewCell.horizontalViewTwo.hidden = NO;
    }
    userEmitterTicket = [transIMTID objectAtIndex:indexPath.row];
    withdrawalHistoryTableViewCell.userIMTID.text = userEmitterTicket;
    int totalAmount = [[transAmount objectAtIndex:indexPath.row] intValue];
    totalAmount = totalAmount / 100;
    withdrawalHistoryTableViewCell.amountLabel.text = [NSString stringWithFormat:@"₹%d",totalAmount];
    
    NSString *finalDate = [transTime objectAtIndex:indexPath.row];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
    NSDate *date = [dateFormatter dateFromString:finalDate];
    [dateFormatter setDateFormat:@"MMM yy"];
    withdrawalHistoryTableViewCell.monthAndYearLabel.text = [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:date]];
    [dateFormatter setDateFormat:@"dd"];
    withdrawalHistoryTableViewCell.dateLabel.text = [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:date]];
    [dateFormatter setDateFormat:@"h:mm a"];
    withdrawalHistoryTableViewCell.timeLabel.text = [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:date]];
    NSLog(@"%@", [dateFormatter stringFromDate:date]);
    return withdrawalHistoryTableViewCell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WithdrawalHistoryDetailsViewController *withdrawalHistoryDetailsViewController = [[WithdrawalHistoryDetailsViewController alloc]init];
    withdrawalHistoryDetailsViewController.accountId = userAccountId;
    withdrawalHistoryDetailsViewController.mobileNumber = user_MobileNumber;
    withdrawalHistoryDetailsViewController.transTime = [transTime objectAtIndex:indexPath.row];
    withdrawalHistoryDetailsViewController.userEmitterTicket = [transIMTID objectAtIndex:indexPath.row];
    withdrawalHistoryDetailsViewController.transTime = [transTime objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:withdrawalHistoryDetailsViewController animated:YES];
}

- (void)setRequestJsonForParameterDayComponent:(int)day{
    
    NSDateComponents *dayComponent = [[NSDateComponents alloc] init];
    dayComponent.day = day;
    
    NSCalendar *theCalendar = [NSCalendar currentCalendar];
    NSDate *nextDate = [theCalendar dateByAddingComponents:dayComponent toDate:[NSDate date] options:0];
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    
    NSString *startDate = [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:nextDate]];
    NSString *endDate = [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:[NSDate date]]];
    [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
    requestJson = @{
                    @"accountId":userAccountId,
                    @"maxNoTrans":@"100",
                    @"transDatetime":[dateFormatter stringFromDate:[NSDate date]],
                    @"channelId":@"01",
                    @"startDate":startDate,
                    @"endDate":endDate,
                    @"entityId":@"0215",
                    };
    NSLog(@"requestJson%@",requestJson);
}

- (void)makeApiCall{
    APIManager *a = [[APIManager alloc]init];
    [spinnerFive startAnimating];
    [a loadTransactionListWithParameter:requestJson Success:^(NSDictionary *response){
        [spinnerFive stopAnimating];
        if (response == nil) {
            [self showAlert];
        }else{
            NSLog(@"%@",response);
            responseArr = response[@"transactionDetailsList"];
            transIMTID = [[NSMutableArray alloc]init];
            transAmount = [[NSMutableArray alloc]init];
            transTime = [[NSMutableArray alloc]init];
            //transExpiryDate = [[NSMutableArray alloc]init];
            bankTransactionIds = [[NSMutableArray alloc]init];
            
            for (NSDictionary *dict in responseArr) {
                [transIMTID addObject:[dict objectForKey:@"emitterTicket"]];
                [transAmount addObject:[dict objectForKey:@"amount"]];
                [transTime addObject:[dict objectForKey:@"transDatetime"]];
                //[transExpiryDate addObject:[dict objectForKey:@"expiryDate"]];
                [bankTransactionIds addObject:[dict objectForKey:@"bankTransactionId"]];
            }
            if (transIMTID == nil) {
                [self showAlert];
            }
            
            [self.withdrawalHistoryTableView reloadData];
        }
        
    }failure:^(NSError *error) {
        [spinnerFive stopAnimating];
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

- (IBAction)buttonAction:(UIButton *)sender {
    
    if (sender.tag == 1) {
        [self setRequestJsonForParameterDayComponent: -30];
        self.one_monthButton.backgroundColor = viewBlueColor;
        self.three_monthButton.backgroundColor = viewGreyColor;
        self.six_monthButton.backgroundColor = viewGreyColor;
        self.one_yearButton.backgroundColor = viewGreyColor;
        self.moreThenOneYear_button.backgroundColor = viewGreyColor;
        self.firstLineView.backgroundColor = viewGreyColor;
        self.SecondLineView.backgroundColor = viewGreyColor;
        self.thirdLineView.backgroundColor = viewGreyColor;
        self.fourthLineView.backgroundColor = viewGreyColor;
        self.three_monthButton.layer.borderColor = viewGreyColor.CGColor;
        self.six_monthButton.layer.borderColor = viewGreyColor.CGColor;
        self.one_yearButton.layer.borderColor = viewGreyColor.CGColor;
    }
    if (sender.tag == 2) {
        [self setRequestJsonForParameterDayComponent:-90];
        self.three_monthButton.backgroundColor = viewBlueColor;
        self.one_monthButton.backgroundColor = viewBlueColor;
        
        self.six_monthButton.backgroundColor = viewGreyColor;
        self.one_yearButton.backgroundColor = viewGreyColor;
        self.moreThenOneYear_button.backgroundColor = viewGreyColor;
        self.firstLineView.backgroundColor = viewBlueColor;
        self.SecondLineView.backgroundColor = viewGreyColor;
        self.thirdLineView.backgroundColor = viewGreyColor;
        self.fourthLineView.backgroundColor = viewGreyColor;
        self.six_monthButton.layer.borderColor = viewGreyColor.CGColor;
        self.one_yearButton.layer.borderColor = viewGreyColor.CGColor;
    }
    if (sender.tag == 3) {
        [self setRequestJsonForParameterDayComponent:-180];
        self.six_monthButton.backgroundColor = viewBlueColor;
        self.firstLineView.backgroundColor = viewBlueColor;
        self.SecondLineView.backgroundColor = viewBlueColor;
        self.one_yearButton.backgroundColor = viewGreyColor;
        self.moreThenOneYear_button.backgroundColor = viewGreyColor;
        self.thirdLineView.backgroundColor = viewGreyColor;
        self.fourthLineView.backgroundColor = viewGreyColor;
        self.one_yearButton.layer.borderColor = viewGreyColor.CGColor;
    }
    if (sender.tag == 4) {
        [self setRequestJsonForParameterDayComponent:-365];
        self.three_monthButton.backgroundColor = viewBlueColor;
        self.six_monthButton.backgroundColor = viewBlueColor;
        self.one_yearButton.backgroundColor = viewBlueColor;
        self.moreThenOneYear_button.backgroundColor = viewGreyColor;
        self.firstLineView.backgroundColor = viewBlueColor;
        self.SecondLineView.backgroundColor = viewBlueColor;
        self.thirdLineView.backgroundColor = viewBlueColor;
        self.fourthLineView.backgroundColor = viewGreyColor;
    }
    if (sender.tag == 5) {
        [self setRequestJsonForParameterDayComponent:-600];
        self.three_monthButton.backgroundColor = viewBlueColor;
        self.six_monthButton.backgroundColor = viewBlueColor;
        self.one_yearButton.backgroundColor = viewBlueColor;
        self.moreThenOneYear_button.backgroundColor = viewBlueColor;
        self.firstLineView.backgroundColor = viewBlueColor;
        self.SecondLineView.backgroundColor = viewBlueColor;
        self.thirdLineView.backgroundColor = viewBlueColor;
        self.fourthLineView.backgroundColor = viewBlueColor;
    }
    [self makeApiCall];
}
@end
