//
//  FoalInfoModel.m
//  foal score
//
//  Created by Jun on 2/3/16.
//  Copyright © 2016 osu.edu. All rights reserved.
//

#import "FoalInfoModel.h"

@implementation FoalInfoModel

- (instancetype) initWithName:(NSString *)name Age:(NSInteger)age Breed:(NSString *)breed Temperature:(NSInteger)temperature RespiratoryRate:(NSInteger)respiratoryRate HeartRate:(NSInteger)heartRate Sex:(NSString *)sex Dystocia:(BOOL)dystocia SurvivalUntilDischarge:(BOOL)survival Date:(NSDate *)date{
    
    if(self = [super init]){
        self.name = name;
        self.age = age;
        self.breed = breed;
        self.temperature = temperature;
        self.respiratoryRate = respiratoryRate;
        self.heartRate = heartRate;
        self.sex = sex;
        self.dystocia = dystocia;
        self.survivalUntilDischarge = survival;
        self.addDate = date;
        self.survivalScore = -1;
    }
    return self;
}

- (void)modifyWithName:(NSString *)name Age:(NSInteger)age Breed:(NSString *)breed Temperature:(NSInteger)temperature RespiratoryRate:(NSInteger)respiratoryRate HeartRate:(NSInteger)heartRate Sex:(NSString *)sex Dystocia:(BOOL)dystocia SurvivalUntilDischarge:(BOOL)survival Date:(NSDate *)date{
    self.name = name;
    self.age = age;
    self.breed = breed;
    self.temperature = temperature;
    self.respiratoryRate = respiratoryRate;
    self.heartRate = heartRate;
    self.sex = sex;
    self.dystocia = dystocia;
    self.survivalUntilDischarge = survival;
    self.addDate = date;
    self.survivalScore = -1;
}

- (void)attachSurvivalScore:(NSInteger)survivalScore{
    self.survivalScore = survivalScore;
}
@end
