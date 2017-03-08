//
//  ABHTTPRequestOperationManger.h
//  NetworkLayer
//
//  Created by Abhinav Mandloi on 17/02/17.
//  Copyright © 2017 Abhinav Mandloi. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

#import "AFHTTPRequestOperationManager.h"

typedef void (^SNSuccess) (AFHTTPRequestOperation *operation, id response);

typedef void (^SNFailure) (AFHTTPRequestOperation* operation, NSError* error);


@interface ABHTTPRequestOperationManger : AFHTTPRequestOperationManager

- (AFHTTPRequestOperation *)method:(NSString* )method
                        URLString:(NSString *)URLString
                       parameters:(NSDictionary *)parameters
                          success:(SNSuccess)success
                          failure:(SNFailure)failure;




@end
