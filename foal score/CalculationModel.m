//
//  CalculationModel.m
//  foal score
//
//  Created by Jun on 4/5/16.
//  Copyright © 2016 osu.edu. All rights reserved.
//

#import "CalculationModel.h"

@implementation CalculationModel

-(instancetype)initWithScore:(NSString*)score Message:(NSString*)message IsSurvivalScore:(BOOL)isSurvivalScore Date:(NSString*)date CalculationID:(NSString*)calculationID{
    if(self = [super init]){
        self.score = score;
        self.message = message;
        self.isSurvivalScore = isSurvivalScore;
        self.date = date;
        self.calculationID = calculationID;
    }
    return self;
}
@end
