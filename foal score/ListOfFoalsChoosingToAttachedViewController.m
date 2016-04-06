//
//  ListOf FoalsChoosingToAttachedViewController.m
//  foal score
//
//  Created by Jun on 2/17/16.
//  Copyright © 2016 osu.edu. All rights reserved.
//

#import "ListOfFoalsChoosingToAttachedViewController.h"

@interface ListOfFoalsChoosingToAttachedViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) NSMutableArray* foals;

@end

@implementation ListOfFoalsChoosingToAttachedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationItem setTitle:@"Choosing A Foal"];
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
    [self tableView];
}
-(NSMutableArray*)foals{
    if(_foals == nil){
        _foals = [[NSMutableArray alloc]init];
    }
    return _foals;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
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

    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UITableView*)tableView{
    if(_tableView == nil){
        _tableView = [[UITableView alloc]initWithFrame: self.view.bounds style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [self.view addSubview:_tableView];
        
    }
    return  _tableView;
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.foals count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // Configure the cell...
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    FoalInfoModel* foal = [self.foals objectAtIndex:indexPath.row];
    cell.textLabel.text = foal.name;
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"MM-dd yyyy"];
    NSString *date_string = [formatter stringFromDate:foal.addDate];
    cell.detailTextLabel.text = date_string;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FoalInfoModel* foal = self.foals[indexPath.row];
    if (self.isSurvivalScore) {
        NSMutableDictionary* dict = [[NSMutableDictionary alloc]init];
        [dict setObject:self.scoreID forKey:@"calculationId"];
        NSLog(@"%@", foal.foalId);
        [dict setObject:foal.foalId forKey:@"foalId"];
        [[FoalScoreAFAPIClient sharedClient]foalSurvivalScoreLink:dict withCompletitionBlock:^(NSDictionary *response, NSError *error) {
            if (response) {
                if (![response[@"status"]isEqual:@"success"]) {
                    [UiModal showModalWithTitle:@"Error" message:response[error] buttonTitle:@"OK" viewController:self];
                    [self.navigationController popToRootViewControllerAnimated:YES];
                }

            } else {
                [UiModal showModalWithTitle:@"Error" message:error.localizedDescription buttonTitle:@"OK" viewController:self];
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
        }];
    }
    [self.navigationController popToRootViewControllerAnimated:YES];
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



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
