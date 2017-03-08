//
//  WithdrawalHelpViewController.m
//  SelfWithdrawal
//
//  Created by Abhinav Mandloi on 24/02/17.
//  Copyright © 2017 Abhinav Mandloi. All rights reserved.
//

#import "WithdrawalHelpViewController.h"
#import "APIManager.h"
#import "LandingScreenViewViewController.h"

@interface WithdrawalHelpViewController ()<UIScrollViewDelegate>

@end

@implementation WithdrawalHelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [super viewDidLoad];
    [self prefersStatusBarHidden];
    [[self navigationController] setNavigationBarHidden:YES animated:NO];
    self.scrollView.tag = 1;
    [self setupScrollView];
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width / 2) - 50 , [UIScreen mainScreen].bounds.size.height - 150, 100, 36)];
    [btn setTitle:@"Close" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor clearColor];
    [btn addTarget:self
            action:@selector(closeButtonAction:)
  forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIPageControl *pgCtr = [[UIPageControl alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width / 2) - 50 , [UIScreen mainScreen].bounds.size.height - 200, 100, 36)];
    [pgCtr setTag:12];
    pgCtr.numberOfPages=6;
    [self.view addSubview:pgCtr];
    self.scrollView.delegate = self;
}

- (void)closeButtonAction:(UIButton *)btn{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)setupScrollView {
    // we have 10 images here.
    // we will add all images into a scrollView &amp; set the appropriate size.
    
    for (int i=1; i <= 7; i++) {
        // create image
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"Help Step %d",i]];
        // create imageView
        UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake((i-1)*self.scrollView.frame.size.width, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height)];
        // set scale to fill
        imgV.contentMode=UIViewContentModeScaleToFill;
        // set image
        [imgV setImage:image];
        // apply tag to access in future
        imgV.tag=i+1;
        // add to scrollView
        [self.scrollView addSubview:imgV];
    }
    // set the content size to 10 image width
    [self.scrollView setContentSize:CGSizeMake(self.scrollView.frame.size.width * 6, self.scrollView.frame.size.height)];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    // access the scroll view with the tag
    UIScrollView *scrMain = (UIScrollView*) [self.view viewWithTag:1];
    // same way, access pagecontroll access
    UIPageControl *pgCtr = (UIPageControl*) [self.view viewWithTag:12];
    // get the current offset ( which page is being displayed )
    CGFloat contentOffset = scrMain.contentOffset.x;
    // calculate next page to display
    [scrollView setContentSize:CGSizeMake([UIScreen mainScreen].bounds.size.width * 6,(contentOffset/scrMain.frame.size.height))];
    int nextPage = (int)(contentOffset/scrMain.frame.size.width) + 1 ;
    // if page is not 10, display it
    if( nextPage!= 7 )  {
//        [scrMain scrollRectToVisible:CGRectMake(nextPage*scrMain.frame.size.width, 0, scrMain.frame.size.width, scrMain.frame.size.height) animated:YES];
        pgCtr.currentPage=nextPage - 1;
//        // else start sliding form 1 :)
    } else {
//        [scrMain scrollRectToVisible:CGRectMake(0, 0, scrMain.frame.size.width, scrMain.frame.size.height) animated:YES];
        pgCtr.currentPage=0;
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

@end
