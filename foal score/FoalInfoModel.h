//
//  FoalInfoModel.h
//  foal score
//
//  Created by Jun on 2/3/16.
//  Copyright © 2016 osu.edu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FoalInfoModel : NSObject

@property (nonatomic, copy) NSString* name;
@property (nonatomic, assign) NSInteger age;
@property (nonatomic, copy) NSString* breed;
@property (nonatomic, assign) NSInteger temperature;
@property (nonatomic, assign) NSInteger respiratoryRate;
@property (nonatomic, assign) NSInteger heartRate;
@property (nonatomic, copy) NSString* sex;
@property (nonatomic, assign) BOOL dystocia;
@property (nonatomic, assign) BOOL survivalUntilDischarge;
@property (nonatomic, retain) NSDate* addDate;

- (instancetype) initWithName:(NSString *)name Age:(NSInteger)age Breed:(NSString *)breed Temperature:(NSInteger)temperature RespiratoryRate:(NSInteger)respiratoryRate HeartRate:(NSInteger)heartRate Sex:(NSString *)sex Dystocia:(BOOL)dystocia SurvivalUntilDischarge:(BOOL)survival Date:(NSDate *)date;

- (void) modifyWithName:(NSString *)name Age:(NSInteger)age Breed:(NSString *)breed Temperature:(NSInteger)temperature RespiratoryRate:(NSInteger)respiratoryRate HeartRate:(NSInteger)heartRate Sex:(NSString *)sex Dystocia:(BOOL)dystocia SurvivalUntilDischarge:(BOOL)survival Date:(NSDate *)date;

@end
