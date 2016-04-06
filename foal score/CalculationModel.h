//
//  CalculationModel.h
//  foal score
//
//  Created by Jun on 4/5/16.
//  Copyright © 2016 osu.edu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculationModel : NSObject
@property (copy, nonatomic)NSString* score;
@property (copy, nonatomic)NSString* message;
@property (assign, nonatomic)BOOL isSurvivalScore;
@property (copy, nonatomic)NSString* date;
@property (copy,nonatomic)NSString* calculationID;

-(instancetype)initWithScore:(NSString*)score Message:(NSString*)message IsSurvivalScore:(BOOL)isSurvivalScore Date:(NSString*)date CalculationID:(NSString*)calculationID;
@end
