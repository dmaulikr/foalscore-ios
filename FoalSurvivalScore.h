//
//  FoalSurvivalScore.h
//  foal score
//
//  Created by Jun on 2/13/16.
//  Copyright © 2016 osu.edu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FoalSurvivalScore : NSObject

@property (nonatomic, assign)NSInteger coldExtremities;
@property (nonatomic, assign)NSInteger prematurity;
@property (nonatomic, assign)NSInteger infection;
@property (nonatomic, assign)NSInteger igG;
@property (nonatomic, assign)NSInteger glucose;
@property (nonatomic, assign)NSInteger WBC;

-(instancetype) initWithColdExtremities:(NSInteger)coldExtremities Prematurity:(NSInteger)prematurity Infection:(NSInteger)infection IgG:(NSInteger)igG Glucose:(NSInteger)glucose WBC:(NSInteger)wbc;

-(void) modifyColdExtremities:(NSInteger)coldExtremities Prematurity:(NSInteger)prematurity Infection:(NSInteger)infection IgG:(NSInteger)igG Glucose:(NSInteger)glucose WBC:(NSInteger)wbc;

-(NSInteger) calculateTotalScore;

@end
