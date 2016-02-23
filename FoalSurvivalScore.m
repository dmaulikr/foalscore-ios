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

-(NSInteger) calculateTotalScore{
    
    return self.coldExtremities + self.prematurity + self.infection + self.igG + self.glucose + self.WBC;
    
}

@end
