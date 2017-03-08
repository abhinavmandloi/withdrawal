//
//  ABHTTPRequestOperationManger.m
//  NetworkLayer
//
//  Created by Abhinav Mandloi on 17/02/17.
//  Copyright © 2017 Abhinav Mandloi. All rights reserved.
//

#import "ABHTTPRequestOperationManger.h"

@implementation ABHTTPRequestOperationManger

+ (instancetype)manager {
    ABHTTPRequestOperationManger *manager = [[ABHTTPRequestOperationManger alloc] initWithBaseURL:nil];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializer];
    responseSerializer.removesKeysWithNullValues = YES;
    manager.responseSerializer = responseSerializer;
    
    return manager;
}

- (AFHTTPRequestOperation *)GET:(NSString *)URLString
                    parameters:(NSDictionary *)parameters
                       success:(SNSuccess)success
                       failure:(SNFailure)failure {
    return [self method:@"GET" URLString:URLString parameters:parameters success:success failure:failure ];
}

- (AFHTTPRequestOperation *)POST:(NSString *)URLString
                     parameters:(NSDictionary *)parameters
                        success:(SNSuccess)success
                        failure:(SNFailure)failure {
    return [self method:@"POST" URLString:URLString parameters:parameters success:success failure:failure ];
}

- (AFHTTPRequestOperation *)PATCH:(NSString *)URLString
                     parameters:(NSDictionary *)parameters
                        success:(SNSuccess)success
                        failure:(SNFailure)failure {
    return [self method:@"PATCH" URLString:URLString parameters:parameters success:success failure:failure ];
}
- (AFHTTPRequestOperation *)DELETE:(NSString *)URLString
                     parameters:(NSDictionary *)parameters
                        success:(SNSuccess)success
                        failure:(SNFailure)failure {
    return [self method:@"DELETE" URLString:URLString parameters:parameters success:success failure:failure ];
}

- (AFHTTPRequestOperation *)UPDATE:(NSString *)URLString
                       parameters:(NSDictionary *)parameters
                          success:(SNSuccess)success
                          failure:(SNFailure)failure {
    return [self method:@"UPDATE" URLString:URLString parameters:parameters success:success failure:failure ];
}
- (AFHTTPRequestOperation *)PUT:(NSString *)URLString
                        parameters:(NSDictionary *)parameters
                           success:(SNSuccess)success
                           failure:(SNFailure)failure {
    return [self method:@"PUT" URLString:URLString parameters:parameters success:success failure:failure ];
}

- (AFHTTPRequestOperation * )method:(NSString *)method
                        URLString:(NSString *)URLString
                       parameters:(NSDictionary *)parameters
                          success:(SNSuccess)success
                          failure:(SNFailure)failure{
    NSURL *url = [NSURL URLWithString:URLString relativeToURL:self.baseURL];
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithDictionary:parameters];
    NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:method URLString:[url absoluteString] parameters:dict error:nil];
    
    AFHTTPRequestOperation *operation = [self HTTPRequestOperationWithRequest:request success:success
                                                                      failure:^(AFHTTPRequestOperation * operation, NSError *error) {
                                                                              failure(operation, error);
                                                                      }];
    [self.operationQueue addOperation:operation];
    
    return operation;
}

@end
