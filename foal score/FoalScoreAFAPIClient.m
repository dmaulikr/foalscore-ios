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
        static NSString * const BaseURLString = @"http://foalscore.org.ohio-state.edu/foalscore/server/";
        NSURL *baseURL = [NSURL URLWithString:BaseURLString];
        _sharedClient = [[FoalScoreAFAPIClient alloc] initWithBaseURL:baseURL];
    });
    
    return _sharedClient;
}

-(void)registerNewUser:(NSMutableDictionary *)params withCompletitionBlock:(SuccessOrFailureCompletionBlock)block
{
    params[@"token"] = @"TODO";
    [self POST:@"users/add.json"
        parameters:params
        progress:nil
        success:^(NSURLSessionDataTask *task, id responseObject) {
            block(responseObject, nil);
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            block(nil, error);
        }];
}

-(void)loginUser:(NSMutableDictionary *)params withCompletitionBlock:(SuccessOrFailureCompletionBlock)block
{
    params[@"token"] = @"TODO";
    [self POST:@"users/login.json"
        parameters:params
        progress:nil
        success:^(NSURLSessionDataTask *task, id responseObject) {
           block(responseObject, nil);
       } failure:^(NSURLSessionDataTask *task, NSError *error) {
           block(nil, error);
       }];
}


-(void)forgotPassword:(NSMutableDictionary *)params withCompletitionBlock:(SuccessOrFailureCompletionBlock)block
{
    params[@"token"] = @"TODO";
    [self POST:@"users/forgotpassword.json"
    parameters:params
      progress:nil
       success:^(NSURLSessionDataTask *task, id responseObject) {
           block(responseObject, nil);
       } failure:^(NSURLSessionDataTask *task, NSError *error) {
           block(nil, error);
       }];
}

-(void)changePassword:(NSMutableDictionary *)params withCompletitionBlock:(SuccessOrFailureCompletionBlock)block
{
    params[@"token"] = @"TODO";
    [self POST:@"users/changepassword.json"
    parameters:params
      progress:nil
       success:^(NSURLSessionDataTask *task, id responseObject) {
           block(responseObject, nil);
       } failure:^(NSURLSessionDataTask *task, NSError *error) {
           block(nil, error);
       }];
}

-(void)referUser:(NSMutableDictionary *)params withCompletitionBlock:(SuccessOrFailureCompletionBlock)block
{
    params[@"token"] = @"TODO";
    [self POST:@"users/referuser.json"
    parameters:params
      progress:nil
       success:^(NSURLSessionDataTask *task, id responseObject) {
           block(responseObject, nil);
       } failure:^(NSURLSessionDataTask *task, NSError *error) {
           block(nil, error);
       }];
}


-(void)userFeedback:(NSMutableDictionary *)params withCompletitionBlock:(SuccessOrFailureCompletionBlock)block
{
    params[@"token"] = @"TODO";
    [self POST:@"users/feedback.json"
    parameters:params
      progress:nil
       success:^(NSURLSessionDataTask *task, id responseObject) {
           block(responseObject, nil);
       } failure:^(NSURLSessionDataTask *task, NSError *error) {
           block(nil, error);
       }];
}

-(void)addFoal:(NSMutableDictionary *)params withCompletitionBlock:(SuccessOrFailureCompletionBlock)block
{
    params[@"token"] = @"TODO";
    [self POST:@"foals/add.json"
    parameters:params
      progress:nil
       success:^(NSURLSessionDataTask *task, id responseObject) {
           block(responseObject, nil);
       } failure:^(NSURLSessionDataTask *task, NSError *error) {
           block(nil, error);
       }];
}

-(void)editFoal:(NSMutableDictionary *)params withCompletitionBlock:(SuccessOrFailureCompletionBlock)block
{
    params[@"token"] = @"TODO";
    [self POST:@"foals/edit.json"
    parameters:params
      progress:nil
       success:^(NSURLSessionDataTask *task, id responseObject) {
           block(responseObject, nil);
       } failure:^(NSURLSessionDataTask *task, NSError *error) {
           block(nil, error);
       }];
}

-(void)allFoals:(NSMutableDictionary *)params withCompletitionBlock:(SuccessOrFailureCompletionBlock)block
{
    params[@"token"] = @"TODO";
    [self POST:@"foals/all.json"
    parameters:params
      progress:nil
       success:^(NSURLSessionDataTask *task, id responseObject) {
           block(responseObject, nil);
       } failure:^(NSURLSessionDataTask *task, NSError *error) {
           block(nil, error);
       }];
}

-(void)exportFoals:(NSMutableDictionary *)params withCompletitionBlock:(SuccessOrFailureCompletionBlock)block
{
    params[@"token"] = @"TODO";
    [self POST:@"foals/export.json"
    parameters:params
      progress:nil
       success:^(NSURLSessionDataTask *task, id responseObject) {
           block(responseObject, nil);
       } failure:^(NSURLSessionDataTask *task, NSError *error) {
           block(nil, error);
       }];
}

-(void)foalScores:(NSMutableDictionary *)params withCompletitionBlock:(SuccessOrFailureCompletionBlock)block
{
    params[@"token"] = @"TODO";
    [self POST:@"foals/foalcalculations.json"
    parameters:params
      progress:nil
       success:^(NSURLSessionDataTask *task, id responseObject) {
           block(responseObject, nil);
       } failure:^(NSURLSessionDataTask *task, NSError *error) {
           block(nil, error);
       }];
}

-(void)calculateSurvivalScore:(NSMutableDictionary *)params withCompletitionBlock:(SuccessOrFailureCompletionBlock)block
{
    params[@"token"] = @"TODO";
    [self POST:@"survivalscores/add.json"
        parameters:params
        progress:nil
        success:^(NSURLSessionDataTask *task, id responseObject) {
        block(responseObject, nil);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        block(nil, error);
        
    }];
    
}

-(void)calculateSepsisScore:(NSMutableDictionary *)params withCompletitionBlock:(SuccessOrFailureCompletionBlock)block
{
    params[@"token"] = @"TODO";
    [self POST:@"sepsisscores/add.json"
    parameters:params
      progress:nil
       success:^(NSURLSessionDataTask *task, id responseObject) {
           block(responseObject, nil);
           
       } failure:^(NSURLSessionDataTask *task, NSError *error) {
           block(nil, error);
           
       }];
}

-(void)foalSurvivalScoreLink:(NSMutableDictionary *)params withCompletitionBlock:(SuccessOrFailureCompletionBlock)block
{
    params[@"token"] = @"TODO";
    [self POST:@"survivalscores/foalsurvivalcalculatorlink.json"
    parameters:params
      progress:nil
       success:^(NSURLSessionDataTask *task, id responseObject) {
           block(responseObject, nil);
           
       } failure:^(NSURLSessionDataTask *task, NSError *error) {
           block(nil, error);
           
       }];
}

-(void)foalSepsisScoreLink:(NSMutableDictionary *)params withCompletitionBlock:(SuccessOrFailureCompletionBlock)block
{
    params[@"token"] = @"TODO";
    [self POST:@"sepsisscores/foalsepsiscalculatorlink.json"
    parameters:params
      progress:nil
       success:^(NSURLSessionDataTask *task, id responseObject) {
           block(responseObject, nil);
           
       } failure:^(NSURLSessionDataTask *task, NSError *error) {
           block(nil, error);
           
       }];
}

-(void)getOverview: (SuccessOrFailureCompletionBlock)block
//Important Information button in app
{

    [self GET:@"contents/overview.json"
        parameters:nil
        progress:nil
      success:^(NSURLSessionDataTask *task, id responseObject) {
           block(responseObject, nil);
           
       }failure:^(NSURLSessionDataTask *task, NSError *error) {
           block(nil, error);
           
       }];
}
-(void)getSepsisInfo: (SuccessOrFailureCompletionBlock)block
{
    
    [self GET:@"contents/sepsisscore.json"
   parameters:nil
     progress:nil
      success:^(NSURLSessionDataTask *task, id responseObject) {
          block(responseObject, nil);
          
      }failure:^(NSURLSessionDataTask *task, NSError *error) {
          block(nil, error);
          
      }];
}
-(void)getSurvivalInfo: (SuccessOrFailureCompletionBlock)block
{
    
    [self GET:@"contents/survivalscore.json"
   parameters:nil
     progress:nil
      success:^(NSURLSessionDataTask *task, id responseObject) {
          block(responseObject, nil);
          
      }failure:^(NSURLSessionDataTask *task, NSError *error) {
          block(nil, error);
          
      }];
}
-(void)getTerminology: (SuccessOrFailureCompletionBlock)block {
    
    [self GET:@"contents/terminology.json"
   parameters:nil
     progress:nil
      success:^(NSURLSessionDataTask *task, id responseObject) {
          block(responseObject, nil);
          
      }failure:^(NSURLSessionDataTask *task, NSError *error) {
          block(nil, error);
          
      }];
}
-(void)getReferences: (SuccessOrFailureCompletionBlock)block {
    
    [self GET:@"contents/references.json"
   parameters:nil
     progress:nil
      success:^(NSURLSessionDataTask *task, id responseObject) {
          block(responseObject, nil);
          
      }failure:^(NSURLSessionDataTask *task, NSError *error) {
          block(nil, error);
          
      }];
}
@end
