//
//  FoalInfoModel.m
//  foal score
//
//  Created by Jun on 2/3/16.
//  Copyright © 2016 osu.edu. All rights reserved.
//

#import "FoalInfoModel.h"

@implementation FoalInfoModel

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeInteger:self.age forKey:@"age"];
    [aCoder encodeObject:self.breed forKey:@"breed"];
    [aCoder encodeInteger:self.temperature forKey:@"temperature"];
    [aCoder encodeInteger:self.respiratoryRate forKey:@"respiratoryRate"];
    [aCoder encodeInteger:self.heartRate forKey:@"heartRate"];
    [aCoder encodeBool:self.dystocia forKey:@"dystocia"];
    [aCoder encodeObject:self.sex forKey:@"sex"];
    [aCoder encodeBool:self.survivalUntilDischarge forKey:@"survivalUntilDischarge"];
    [aCoder encodeInteger:self.survivalScore forKey:@"survivalScore"];
    [aCoder encodeObject:self.addDate forKey:@"addDate"];
    [aCoder encodeObject:self.foalId forKey:@"foalId"];
    
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        [self setName:[aDecoder decodeObjectForKey:@"name"]];
        [self setAge:[aDecoder decodeIntegerForKey:@"age"]];
        [self setBreed:[aDecoder decodeObjectForKey:@"breed"]];
        [self setTemperature:[aDecoder decodeIntegerForKey:@"temperature"]];
        [self setRespiratoryRate:[aDecoder decodeIntegerForKey:@"respiratoryRate"]];
        [self setHeartRate:[aDecoder decodeIntegerForKey:@"heartRate"]];
        [self setDystocia:[aDecoder decodeBoolForKey:@"dystocia"]];
        [self setSex:[aDecoder decodeObjectForKey:@"sex"]];
        [self setSurvivalUntilDischarge:[aDecoder decodeBoolForKey:@"survivalUntilDischarge"]];
        [self setSurvivalScore:[aDecoder decodeIntegerForKey:@"survivalScore"]];
        [self setAddDate:[aDecoder decodeObjectForKey:@"addDate"]];
        [self setFoalId:[aDecoder decodeObjectForKey:@"foalId"]];
    }
    return self;
}

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
        self.foalId = nil;
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

@end
