//
//  FoalSurvivalScore.m
//  foal score
//
//  Created by Jun on 2/13/16.
//  Copyright © 2016 osu.edu. All rights reserved.
//

#import "FoalSurvivalScore.h"

@implementation FoalSurvivalScore

-(instancetype) initWithColdExtremities:(NSInteger)coldExtremities Prematurity:(NSInteger)prematurity Infection:(NSInteger)infection IgG:(NSInteger)igG Glucose:(NSInteger)glucose WBC:(NSInteger)wbc{
    if(self = [super init]){
        self.coldExtremities = coldExtremities;
        self.prematurity = prematurity;
        self.infection = infection;
        self.igG = igG;
        self.glucose = glucose;
        self.WBC = wbc;
    }
    return self;
}

-(void) modifyColdExtremities:(NSInteger)coldExtremities Prematurity:(NSInteger)prematurity Infection:(NSInteger)infection IgG:(NSInteger)igG Glucose:(NSInteger)glucose WBC:(NSInteger)wbc{
    
    self.coldExtremities = coldExtremities;
    self.prematurity = prematurity;
    self.infection = infection;
    self.igG = igG;
    self.glucose = glucose;
    self.WBC = wbc;
}

-(NSInteger) calculateSurvivalPercentage{
    
    NSInteger sum = self.coldExtremities + self.prematurity + self.infection + self.igG + self.glucose + self.WBC;
    NSInteger percent = 0;
    switch (sum) {
        case 0:
            percent = 3;
            break;
        case 1:
            percent = 8;
            break;
        case 2:
            percent = 18;
            break;
        case 3:
            percent = 38;
            break;
        case 4:
            percent = 62;
            break;
        case 5:
            percent = 82;
            break;
        case 6:
            percent = 92;
            break;
        case 7:
            percent = 97;
            break;
        default:
            break;
    }
    return percent;
}
@end
