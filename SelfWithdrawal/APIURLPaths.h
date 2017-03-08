//
//  APIURLPaths.h
//  SelfWithdrawal
//
//  Created by Abhinav Mandloi on 27/02/17.
//  Copyright © 2017 Abhinav Mandloi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APIURLPaths : NSObject

#define API_BASE_URL @ "http://103.13.96.250:8101/"

extern NSString *const INITIATEPAYMENT;
extern NSString *const REGENERATEOTP;
extern NSString *const GETTRANSACTIONLIST;
extern NSString *const STATUSINQUIRY;
extern NSString *const CANCELPAYMENT;
extern NSString *const WITHDRAWPAYMENT;
extern NSString *const GETCONFIGURATIONINFO;

@end
