//
//  APIManager.h
//  SelfWithdrawal
//
//  Created by Abhinav Mandloi on 27/02/17.
//  Copyright © 2017 Abhinav Mandloi. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "InitiatePayment.h"
@class ConfigurationBundle;

@interface APIManager : NSObject

typedef void (^SuccessAPICallBlock)();
typedef void (^FailedAPICallBlock)(NSError *error);

typedef void (^InitiatePaymentAPICallBlock)(ConfigurationBundle *configuration);

- (void)loadInitiatePaymentWithParameter:(NSDictionary *)json Success:(SuccessAPICallBlock)success failure:(FailedAPICallBlock)failure;
- (void)loadgetConfigurationInfoWithParameter:(NSDictionary *)json Success:(SuccessAPICallBlock)success failure:(FailedAPICallBlock)failure;
- (void)loadTransactionListWithParameter:(NSDictionary *)json Success:(SuccessAPICallBlock)success failure:(FailedAPICallBlock)failure;
- (void)statusInquiryWithParameter:(NSDictionary *)json Success:(SuccessAPICallBlock)success failure:(FailedAPICallBlock)failure;
- (void)regenerateOtpWithParameter:(NSDictionary *)json Success:(SuccessAPICallBlock)success failure:(FailedAPICallBlock)failure;
- (void)cancelPaymentWithParameter:(NSDictionary *)json Success:(SuccessAPICallBlock)success failure:(FailedAPICallBlock)failure;
- (void)withdrawPaymentWithParameter:(NSDictionary *)json Success:(SuccessAPICallBlock)success failure:(FailedAPICallBlock)failure;

@end
