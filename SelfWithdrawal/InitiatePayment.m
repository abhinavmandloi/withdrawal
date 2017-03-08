//
//  InitiatePayment.m
//  SelfWithdrawal
//
//  Created by Abhinav Mandloi on 27/02/17.
//  Copyright © 2017 Abhinav Mandloi. All rights reserved.
//

#import "InitiatePayment.h"

@implementation InitiatePayment

- (NSDictionary *)toJSON
{
    NSDictionary *json = @{@"senderMobile": @"766166330",
                           @"destTele": @"766166330",
                           @"fee": @"fees",
                           @"channelId": @"01",
                           @"terminalId": @"MPQRAPP",
                           @"accountId": @"123457",
                           @"customerName": @"Saurabh",
                           @"amount": @"7832",
                           @"senderCode": @"1236",
                           @"transDatetime": @"20170223010000",
                           @"entityId": @"0215",
                           @"ddField1": @"abc@xyz.com"
                           };
    
    return json;
}

@end
