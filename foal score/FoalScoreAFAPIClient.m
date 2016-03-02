//
//  FoalScoreAFAPIClient.m
//  foal score
//
//  Created by wi800 on 3/2/16.
//  Copyright © 2016 osu.edu. All rights reserved.
//

#import "FoalScoreAFAPIClient.h"

@implementation FoalScoreAFAPIClient

+(instancetype)sharedClient
{
    static FoalScoreAPIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // Code to be run only once
        static NSString * const BaseURLString = @"foalscore.org.ohio-state.edu/foalscore/server/";
        NSURL *baseURL = [NSURL URLWithString:BaseURLString]
        _sharedClient = [[FoalScoreAPIClient alloc] initWithBaseURL:baseURL];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
    });
    
    return _sharedClient;
}
@end
