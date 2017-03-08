//
//  APIManager.m
//  SelfWithdrawal
//
//  Created by Abhinav Mandloi on 27/02/17.
//  Copyright © 2017 Abhinav Mandloi. All rights reserved.
//

#import "APIManager.h"
#import "AFNetworking.h"
#import "ConfigurationBundle.h"
#import "APIURLPaths.h"
#import "ABHTTPRequestOperationManger.h"
#import "CashWithdrawalConfirmViewController.h"
#import "APIURLPaths.h"


@interface APIManager()
@property (nonatomic, strong) ABHTTPRequestOperationManger * sessionManager;
@end

@implementation APIManager

- (id)init
{
    self = [super init];
    if (self) {
        NSURL * baseURL = [NSURL URLWithString:API_BASE_URL];
        self.sessionManager = [[ABHTTPRequestOperationManger alloc] initWithBaseURL:baseURL];
        
        self.sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
        
        self.sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
    }
    return self;
}

- (void)loadInitiatePaymentWithParameter:(NSDictionary *)json Success:(SuccessAPICallBlock)success failure:(FailedAPICallBlock)failure{
    
   //apiPath = @"http://103.13.96.250:8101/EmpaysMaster/initiatePayment";
    [self.sessionManager POST:INITIATEPAYMENT
                   parameters:json success:^(AFHTTPRequestOperation *operation, id responseObject) {
                       if (success) {
                           success(responseObject);
                       }
                   } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                       if (failure) {
                           failure(error);
                       }
                   }];

}

- (void)regenerateOtpWithParameter:(NSDictionary *)json Success:(SuccessAPICallBlock)success failure:(FailedAPICallBlock)failure{
    
   //apiPath = @"http://103.13.96.250:8101/EmpaysMaster/regenerateOtp";
    [self.sessionManager POST:REGENERATEOTP
                   parameters:json success:^(AFHTTPRequestOperation *operation, id responseObject) {
                       if (success) {
                           success(responseObject);
                       }
                   } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                       if (failure) {
                           failure(error);
                       }
                   }];
    
}

- (void)loadTransactionListWithParameter:(NSDictionary *)json Success:(SuccessAPICallBlock)success failure:(FailedAPICallBlock)failure{
    
   //apiPath = @"http://103.13.96.250:8101/EmpaysMaster/getTransactionList";
    [self.sessionManager POST:GETTRANSACTIONLIST
                   parameters:json success:^(AFHTTPRequestOperation *operation, id responseObject) {
                       if (success) {
                           success(responseObject);
                       }
                   } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                       if (failure) {
                           failure(error);
                       }
                   }];
    
}

- (void)statusInquiryWithParameter:(NSDictionary *)json Success:(SuccessAPICallBlock)success failure:(FailedAPICallBlock)failure{
    
    //apiPath = @"http://103.13.96.250:8101/EmpaysMaster/statusInquiry";
    [self.sessionManager POST:STATUSINQUIRY
                   parameters:json success:^(AFHTTPRequestOperation *operation, id responseObject) {
                       if (success) {
                           success(responseObject);
                       }
                   } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                       if (failure) {
                           failure(error);
                       }
                   }];
    
}

- (void)cancelPaymentWithParameter:(NSDictionary *)json Success:(SuccessAPICallBlock)success failure:(FailedAPICallBlock)failure{
    
    //apiPath = @"http://103.13.96.250:8101/EmpaysMaster/cancelPayment";
    [self.sessionManager POST:CANCELPAYMENT
                   parameters:json success:^(AFHTTPRequestOperation *operation, id responseObject) {
                       if (success) {
                           success(responseObject);
                       }
                   } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                       if (failure) {
                           failure(error);
                       }
                   }];
    
}

- (void)withdrawPaymentWithParameter:(NSDictionary *)json Success:(SuccessAPICallBlock)success failure:(FailedAPICallBlock)failure{
    
   //apiPath = @"http://103.13.96.250:8101/EmpaysMaster/withdrawPayment";
    [self.sessionManager POST:WITHDRAWPAYMENT
                   parameters:json success:^(AFHTTPRequestOperation *operation, id responseObject) {
                       if (success) {
                           success(responseObject);
                       }
                   } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                       if (failure) {
                           failure(error);
                       }
                   }];
    
}


- (void)loadgetConfigurationInfoWithParameter:(NSDictionary *)json Success:(SuccessAPICallBlock)success failure:(FailedAPICallBlock)failure{
    
   //apiPath = @"http://103.13.96.250:8101/EmpaysMaster/getConfigurationInfo";
    [self.sessionManager POST:GETCONFIGURATIONINFO
                   parameters:json success:^(AFHTTPRequestOperation *operation, id responseObject) {
                       if (success) {
                           success(responseObject);
                       }
                   } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                       if (failure) {
                           failure(error);
                       }
                   }];
    
}


@end
