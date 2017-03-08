//
//  LandingScreenViewViewController.h
//  SelfWithdrawal
//
//  Created by Abhinav Mandloi on 20/02/17.
//  Copyright © 2017 Abhinav Mandloi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LandingScreenViewViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *landingScreenTableView;

@property (weak, nonatomic) IBOutlet UITableView *cardDetailsView;
@property(strong, nonatomic) NSArray *names;

@end
