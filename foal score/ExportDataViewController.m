//
//  ExportDataViewController.m
//  foal score
//
//  Created by Jun on 4/10/16.
//  Copyright © 2016 osu.edu. All rights reserved.
//

#import "ExportDataViewController.h"

@interface ExportDataViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic)NSMutableArray* foals;
@property (assign, nonatomic)BOOL hasSelected;
@end

@implementation ExportDataViewController
- (IBAction)pressSelectAll:(id)sender {
    if(!self.hasSelected){
        for (int i = 0; i < [self.foals count]; i++) {
            NSIndexPath* idp = [NSIndexPath indexPathForRow:i inSection:0];
            [self.tableView selectRowAtIndexPath:idp animated:false scrollPosition:UITableViewScrollPositionNone];
        }
        self.hasSelected = true;
    }else{
        for (int i = 0; i < [self.foals count]; i++) {
            NSIndexPath* idp = [NSIndexPath indexPathForRow:i inSection:0];
            [self.tableView deselectRowAtIndexPath:idp animated:false];
        }
        self.hasSelected = false;
    }
    
}

- (NSMutableArray*)foals{
    if(_foals == nil){
        _foals = [[NSMutableArray alloc]init];
    }
    return _foals;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.hasSelected = false;
    // Do any additional setup after loading the view from its nib.
    [self.navigationItem setTitle:@"Export Data"];
    //
    if([DataManager loginOrNot]){
        NSMutableDictionary* dict =[[NSMutableDictionary alloc]init];
        [dict setObject:[DataManager userInfo].userId forKey:@"userId"];
        [[FoalScoreAFAPIClient sharedClient]allFoals:dict withCompletitionBlock:^(NSDictionary *response, NSError *error) {
            if(response){
                if([response[@"status"] isEqual:@"success"]){
                    [self parseFoalsFromServer: response];
                } else {
                    [UiModal showModalWithTitle:@"Error" message:response[@"error"] buttonTitle:@"OK" viewController:self];
                }
            } else{
                [UiModal showModalWithTitle:@"Error" message:[error localizedDescription] buttonTitle:@"OK" viewController:self];
            }}];
        
    }else{
        [UiModal showModalWithTitle:@"Note" message:@"Login to view synced foals" buttonTitle:@"OK" viewController:self];
    }
    //
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.tableView reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // Configure the cell...
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    FoalInfoModel* foal = [self.foals objectAtIndex:indexPath.row];
    NSString* title = foal.name;
    [cell.textLabel setText:title];
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"MM-dd yyyy"];
    NSString *date_string = [formatter stringFromDate:foal.addDate];
    cell.detailTextLabel.text = date_string;
    UIView* bv = [[UIView alloc]init];
    bv.backgroundColor = [UIColor colorWithRed:(132/255.0) green:(207/255.0) blue:(250/255.0) alpha:1];
    cell.selectedBackgroundView = bv;
    return cell;
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.foals count];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) parseFoalsFromServer:(NSDictionary*)response {
    NSMutableArray* foals =response[@"foals"];
    for (NSDictionary* d in foals) {
        BOOL dystocia = false;
        if ([d[@"dystocia"]isEqual:@"Yes"]) {
            dystocia = true;
        }
        BOOL survivalUntilDischarge = false;
        if([d[@"survivedUntilHospitalDischarge"] isEqual: @"Yes"]){
            survivalUntilDischarge = true;
        }
        NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyy'-'MM'-'dd' 'HH':'mm':'ss"];
        NSDate* date = [formatter dateFromString:d[@"addedDate"]];
        NSInteger age = -1;
        NSInteger heartRate = -1;
        NSInteger respiratoryRate = -1;
        NSInteger temperature = -1;
        if(d[@"ageMonths"]!=(id)[NSNull null]){
            age =[d[@"ageMonths"] integerValue];
        }
        if(d[@"temperature"]!=(id)[NSNull null]){
            temperature = [d[@"temperature"]integerValue];
        }
        if(d[@"respiratoryRate"]!=(id)[NSNull null]){
            respiratoryRate = [d[@"respiratoryRate"]integerValue];
        }
        if(d[@"heartRate"]!=(id)[NSNull null]){
            heartRate = [d[@"heartRate"]integerValue];
        }
        
        
        FoalInfoModel* foal = [[FoalInfoModel alloc]initWithName:d[@"name"] Age:age Breed:d[@"breed"] Temperature:temperature RespiratoryRate:respiratoryRate HeartRate:heartRate Sex:d[@"gender"] Dystocia:dystocia SurvivalUntilDischarge:survivalUntilDischarge Date:date];
        
        [foal setFoalId:d[@"id"]];
        [self.foals addObject:foal];
    }
    [self.tableView reloadData];
}
- (IBAction)pressExport:(id)sender {
    NSMutableDictionary* dict = [[NSMutableDictionary alloc]init];
    [dict setObject:[self foalsNeedToExport] forKey:@"foalids"];
    [dict setObject:[DataManager userInfo].email forKey:@"userEmail"];
    [[FoalScoreAFAPIClient sharedClient]exportFoals:dict withCompletitionBlock:^(NSDictionary *response, NSError *error) {
        if(response){
            if([response[@"status"] isEqual:@"success"]){
                [UiModal showModalWithTitle:@"Note" message:@"Email has been sent" buttonTitle:@"Yes" viewController:self];
            } else {
                [UiModal showModalWithTitle:@"Error" message:response[@"error"] buttonTitle:@"OK" viewController:self];
            }
        } else{
            [UiModal showModalWithTitle:@"Error" message:[error localizedDescription] buttonTitle:@"OK" viewController:self];
        }}];

    
}
- (NSString*)foalsNeedToExport{
    NSString* foalIDsString = @"";
    NSArray* selects = [self.tableView indexPathsForSelectedRows];
    for(NSIndexPath* select in selects){
        FoalInfoModel* foal = self.foals[select.row];
        [foalIDsString stringByAppendingString:foal.foalId];
        [foalIDsString stringByAppendingString:@","];
    }
    if ([foalIDsString length] > 0) {
        foalIDsString = [foalIDsString substringWithRange:NSMakeRange(0,[foalIDsString length] - 1)];
    }
    return foalIDsString;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
