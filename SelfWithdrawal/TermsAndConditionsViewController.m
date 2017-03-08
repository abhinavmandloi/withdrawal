//
//  TermsAndConditionsViewController.m
//  SelfWithdrawal
//
//  Created by Abhinav Mandloi on 24/02/17.
//  Copyright © 2017 Abhinav Mandloi. All rights reserved.
//

#import "TermsAndConditionsViewController.h"

@interface TermsAndConditionsViewController ()

@end

@implementation TermsAndConditionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@""
                                                                 style:UIBarButtonItemStylePlain
                                                                target:nil
                                                                action:nil];
    
    [self.navigationItem setBackBarButtonItem:backItem];
    self.title = @"TERMS AND CONDITIONS";
    [self setTextToTextView];
}

- (void)setTextToTextView{
    self.textView.text = @"Terms & Conditions\nBy availing the Facility, the User can transfer amounts in the multiples of Rs. 100, subject to a minimum of Rs. 100 and maximum of Rs 10,000.\nFor the purpose of Self-Withdrawals, the User and Beneficiary are the same individual\nOn submission of a request from the User for transfer of funds to the Beneficiary, the same shall be processed by <Member Bank>. The Remitter shall communicate the Sender Code to the Beneficiary in order to enable him/her to receive the funds being transferred to him/her. On receipt of instruction from the Remitter in the manner and through any of the eligible modes as are specified <MEMBER BANK>, for funds transfer by use of the Facility, the Beneficiary shall be sent an SMS containing a four (4) digit numeric code (""SMS Pin"") on such mobile number as may be intimated by the Remitter at the time of placing the request for funds transfer (""Beneficiary Mobile Number""). The User shall have to communicate the Sender Code to the Beneficiary, in order to enable him to receive the funds transferred by use of the Facility. The User will need to provide the Beneficiary's Name, Address and Mobile Number, electronically, as are specified by <Member Bank>. The channels for providing this information are multiple. Currently, the enabled channels for providing this information are through Internet Banking and via SMS. By doing this, the User certifies that he knows the Beneficiary and if requested by the <MEMBER BANK> or RBI, he would need to provide more details about the beneficiary and the transactions. If the Beneficiary details are not received from the sender within a window of 24 hours, the transaction is cancelled, and the amount is credited back to the User’s account./nConsideration:- As towards consideration for providing the IMT facility <MEMBER BANK> is entitled to charge a non-refundable fee per transaction to the Remitter and the Beneficiary for using this facility. This fee can be a flat amount or variable sum as per the transaction amount / mode. This fee will be charged to the sender upfront at the time of initiation of the transaction. In case of cancellation / expiry / blocking of an IMT transaction, this fee will not be reversed to the Remitter or the beneficiary. Presently the fee per each transaction would be Rs.25.00 which will be directly debited from the account of the USER at the time of initiation of the transaction. <MEMBER BANK> reserves the rights to charge any fee from the beneficiary as and when the same is notified in its Website and upon notifications of such charges. Even In the event of the amount transferred by use of the Facility is not withdrawn by the Beneficiary within the period as prescribed by <MEMBER BANK> and such monies are consequently credited back into the Account or the user himself/herself cancelling the IMT the fees charged to the user will not be reversed back./n<MEMBER BANK> shall have the discretion to charge such fees as it may deem fit from time to time and may at its sole discretion, revise the fees for use of any or all of the Facility, by notifying the User of such revision through <MEMBER BANK>s website or in any manner as may be specified by <MEMBER BANK> from time to time. The User shall be required to refer to the schedule of fees put up on <MEMBER BANK>s website from time to time./nThe amount of Rs 25.00 stated in para II(c)  shall not be reversed at any circumstances despite the transaction was not completed and <MEMBER BANK>  reserves the right to obtain further details of the beneficiary if <MEMBER BANK> considers that the same are required  for the  compliance of any Law/Rules/Regulations in force from time to time  and/or for  internal compliances/nThe Beneficiary shall be entitled to receive the funds transferred by the Remitter by using the Facility only on submission of the Beneficiary Mobile Number, Sender Code, SMS Pin and the amount transferred and following of such steps/ processes as may be prescribed by <MEMBER BANK>  to such of the ATMs of <MEMBER BANK> as may be specified in this respect. <MEMBER BANK> shall be entitled not to provide the funds to the Beneficiary in the event the details submitted by the Beneficiary are wrong/ erroneous or the Beneficiary is unable to ascertain his/her true identity for any other reason and in such event <MEMBER BANK> shall not be liable in any manner to the Beneficiary or the Remitter. The Beneficiary shall approach any of the specified <MEMBER BANK> ATM to withdraw the cash transferred within the time frame of the transfer being made by the User or such other time as may be prescribed by <MEMBER BANK> from time to time, failing which the transaction will be deemed to be cancelled and the amount will be credited back into the user Account. The entire amount transferred to the Beneficiary shall be withdrawn by the Beneficiary at once and no part withdrawals shall be permitted./nThe User shall be entitled to transfer fund by use of the Facility to each Beneficiary upto such limit in such period, as may be prescribed by <MEMBER BANK> , from time to time./nThere will be no other charges for withdrawal or cancellation or status enquiry of IMT in any of the channels enabled by the <MEMBER BANK>./nIII	Cancellation of Request for Facility/nThe User may submit instruction to cancel any request for IMT placed with <MEMBER BANK> Such instruction can be submitted through Internet Banking or <MEMBER BANK> ATMs in such form and manner as may be specified by <MEMBER BANK>. However any instruction cancelling a request made for IMT received by <MEMBER BANK> after the funds / money has been received by the Beneficiary shall be ineffective and <MEMBER BANK> shall not be held liable for execution of such instruction.";
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
