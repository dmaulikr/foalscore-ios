//
//  FoalScoreAFAPIClient.h
//  foal score
//
//  Created by wi800 on 3/2/16.
//  Copyright © 2016 osu.edu. All rights reserved.
//

#import "AFHTTPSessionManager.h"

typedef void(^AFAPIClientErrorCompletionBlock)(NSError *error);
typedef void(^SuccessOrFailureCompletionBlock)(NSDictionary *response, NSError *error);
@interface FoalScoreAFAPIClient : AFHTTPSessionManager
+ (instancetype)sharedClient;
- (void)registerNewUser:(NSDictionary *)params
        withCompletitionBlock:(SuccessOrFailureCompletionBlock)block;

- (void)loginUser:(NSDictionary *)params
  withCompletitionBlock:(SuccessOrFailureCompletionBlock)block;

- (void)calculateSurvivalScore:(NSDictionary *)params
        withCompletitionBlock:(SuccessOrFailureCompletionBlock)block;
@end
