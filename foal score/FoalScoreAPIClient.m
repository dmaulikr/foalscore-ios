//
//  FoalScoreAPIClient.m
//  foal score
//
//  Created by Danny Schlitt on 27/02/2016.
//  Copyright © 2016 osu.edu. All rights reserved.
//

#import "FoalScoreAPIClient.h"

@implementation FoalScoreAPIClient

+(instancetype)sharedClient
{
    static FoalScoreAPIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // Code to be run only once
        _sharedClient = [[FoalScoreAPIClient alloc] init];
    });
    
    return _sharedClient;
}

@end