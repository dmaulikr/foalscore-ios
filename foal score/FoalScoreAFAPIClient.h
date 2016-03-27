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
- (void)registerNewUser:(NSMutableDictionary *)params
        withCompletitionBlock:(SuccessOrFailureCompletionBlock)block;

- (void)loginUser:(NSMutableDictionary *)params
  withCompletitionBlock:(SuccessOrFailureCompletionBlock)block;

- (void)changePassword:(NSMutableDictionary *)params
withCompletitionBlock:(SuccessOrFailureCompletionBlock)block;

- (void)forgotPassword:(NSMutableDictionary *)params
withCompletitionBlock:(SuccessOrFailureCompletionBlock)block;

- (void)referUser:(NSMutableDictionary *)params
withCompletitionBlock:(SuccessOrFailureCompletionBlock)block;

- (void)userFeedback:(NSMutableDictionary *)params
withCompletitionBlock:(SuccessOrFailureCompletionBlock)block;

- (void)addFoal:(NSMutableDictionary *)params
withCompletitionBlock:(SuccessOrFailureCompletionBlock)block;

- (void)editFoal:(NSMutableDictionary *)params
withCompletitionBlock:(SuccessOrFailureCompletionBlock)block;

- (void)allFoals:(NSMutableDictionary *)params
withCompletitionBlock:(SuccessOrFailureCompletionBlock)block;

- (void)exportFoals:(NSMutableDictionary *)params
withCompletitionBlock:(SuccessOrFailureCompletionBlock)block;

- (void)foalScores:(NSMutableDictionary *)params
withCompletitionBlock:(SuccessOrFailureCompletionBlock)block;

- (void)calculateSurvivalScore:(NSMutableDictionary *)params
         withCompletitionBlock:(SuccessOrFailureCompletionBlock)block;

- (void)calculateSepsisScore:(NSMutableDictionary *)params
         withCompletitionBlock:(SuccessOrFailureCompletionBlock)block;

- (void)foalSurvivalScoreLink:(NSMutableDictionary *)params
         withCompletitionBlock:(SuccessOrFailureCompletionBlock)block;

- (void)foalSepsisScoreLink:(NSMutableDictionary *)params
         withCompletitionBlock:(SuccessOrFailureCompletionBlock)block;

- (void)getOverview: (SuccessOrFailureCompletionBlock)block;

- (void)getSepsisInfo: (SuccessOrFailureCompletionBlock)block;

- (void)getSurvivalInfo: (SuccessOrFailureCompletionBlock)block;

- (void)getTerminology: (SuccessOrFailureCompletionBlock)block;

- (void)getReferences: (SuccessOrFailureCompletionBlock)block;

@end
