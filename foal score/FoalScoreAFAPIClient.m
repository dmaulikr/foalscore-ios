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
    static FoalScoreAFAPIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // Code to be run only once
        static NSString * const BaseURLString = @"foalscore.org.ohio-state.edu/foalscore/server/";
        NSURL *baseURL = [NSURL URLWithString:BaseURLString];
        _sharedClient = [[FoalScoreAFAPIClient alloc] initWithBaseURL:baseURL];
        
    });
    
    return _sharedClient;
}

-(void)calculateSurvivalScore:(NSDictionary *)params withCompletitionBlock:(SurvivalScoreCompletionBlock)block
{
    // Mock Success
    NSDictionary *response = @{@"score" : @"7", @"calculationId": @"25", @"scoreResultResponse" : @"The foal has 0% chance of survival"};
    block(response, nil);
}
@end
