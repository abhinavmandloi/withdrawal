//
//  APIURLPaths.m
//  SelfWithdrawal
//
//  Created by Abhinav Mandloi on 27/02/17.
//  Copyright © 2017 Abhinav Mandloi. All rights reserved.
//

#import "APIURLPaths.h"

@implementation APIURLPaths

NSString *const INITIATEPAYMENT = @"EmpaysMaster/initiatePayment";
NSString *const REGENERATEOTP = @"EmpaysMaster/regenerateOtp";
NSString *const GETTRANSACTIONLIST = @"EmpaysMaster/getTransactionList";
NSString *const STATUSINQUIRY = @"EmpaysMaster/statusInquiry";
NSString *const CANCELPAYMENT = @"EmpaysMaster/cancelPayment";
NSString *const WITHDRAWPAYMENT = @"EmpaysMaster/withdrawPayment";
NSString *const GETCONFIGURATIONINFO = @"EmpaysMaster/getConfigurationInfo";

@end
