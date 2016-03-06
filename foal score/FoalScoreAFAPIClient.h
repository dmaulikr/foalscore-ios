//
//  FoalScoreAFAPIClient.h
//  foal score
//
//  Created by wi800 on 3/2/16.
//  Copyright © 2016 osu.edu. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

typedef void(^AFAPIClientErrorCompletionBlock)(NSError *error);
typedef void(^SurvivalScoreCompletionBlock)(NSDictionary *params, NSError *error);

@interface FoalScoreAFAPIClient : AFHTTPSessionManager
+ (instancetype)sharedClient;
- (void)calculateSurvivalScore:(NSDictionary *)params
        withCompletitionBlock:(SurvivalScoreCompletionBlock)block;
@end
