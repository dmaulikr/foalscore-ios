//
//  OneFoalInfoViewController.m
//  foal score
//
//  Created by Jun on 2/10/16.
//  Copyright © 2016 osu.edu. All rights reserved.
//

#import "OneFoalInfoViewController.h"

@interface OneFoalInfoViewController ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *nameLable;
@property (weak, nonatomic) IBOutlet UILabel *ageLable;
@property (weak, nonatomic) IBOutlet UILabel *breedLable;
@property (weak, nonatomic) IBOutlet UILabel *tempLable;
@property (weak, nonatomic) IBOutlet UILabel *rRateLable;
@property (weak, nonatomic) IBOutlet UILabel *hRateLable;
@property (weak, nonatomic) IBOutlet UISegmentedControl *sexSeg;
@property (weak, nonatomic) IBOutlet UISwitch *dystociaSwich;
@property (weak, nonatomic) IBOutlet UISwitch *survivedSwich;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (strong, nonatomic) IBOutlet UIView *scrollContent;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic)NSMutableArray* calculations;


@end

@implementation OneFoalInfoViewController
- (NSMutableArray*)calculations{
    if (_calculations == nil) {
        _calculations = [[NSMutableArray alloc]init];
    }
    return _calculations;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self tableView];
    // Do any additional setup after loading the view from its nib.
    // add scroll View
    CGRect newFrame = self.scrollContent.frame;
    newFrame.size.width = [UIScreen mainScreen].bounds.size.width;
    [self.scrollContent setFrame:newFrame];
    self.scrollView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.scrollContent];
    self.scrollView.contentSize = self.scrollContent.frame.size;
    
    FoalInfoModel* foalNeedToShow = [[DataManager foals] objectAtIndex:self.indexOfFoal];
    self.nameLable.text = foalNeedToShow.name;
    self.ageLable.text = [@(foalNeedToShow.age) stringValue];
    self.breedLable.text = foalNeedToShow.breed;
    self.tempLable.text = [@(foalNeedToShow.temperature) stringValue];
    self.rRateLable.text = [@(foalNeedToShow.respiratoryRate) stringValue];
    self.hRateLable.text = [@(foalNeedToShow.heartRate) stringValue];
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"MM-dd yyyy"];
    self.date.text = [formatter stringFromDate: foalNeedToShow.addDate];
    if([foalNeedToShow.sex isEqual: @"Colt"]){
        self.sexSeg.selectedSegmentIndex = 0;
        [self.sexSeg sendActionsForControlEvents:UIControlEventValueChanged];
    }else{
        self.sexSeg.selectedSegmentIndex = 1;
        [self.sexSeg sendActionsForControlEvents:UIControlEventValueChanged];
    }
    if(foalNeedToShow.dystocia == true){
        [self.dystociaSwich setOn:YES animated:YES];
    }else{
        [self.dystociaSwich setOn:NO animated:YES];
    }
    if(foalNeedToShow.survivalUntilDischarge == true){
        [self.survivedSwich setOn:YES animated:YES];
    }else{
        [self.survivedSwich setOn:NO animated:YES];
    }
    
    self.sexSeg.enabled = NO;
    self.survivedSwich.enabled = NO;
    self.dystociaSwich.enabled = NO;
    
    //request
    NSMutableDictionary* dict = [[NSMutableDictionary alloc]init];
    [dict setObject:foalNeedToShow.foalId forKey:@"foalid"];
    [[FoalScoreAFAPIClient sharedClient]foalScores:dict withCompletitionBlock:^(NSDictionary *response, NSError *error) {
        if(response){
            if([response[@"status"] isEqual:@"success"]) {
                NSMutableArray* calcs = response[@"results"];
                for(NSMutableDictionary* d in calcs){
                    NSString* score = d[@"Score"];
                    NSString* date = d[@"Date"];
                    NSString* message = d[@"ResultString"];
                    BOOL flag = false;
                    if([d[@"ScoreType"] isEqual:@"Survival Score"]){
                        flag = true;
                    }
                    CalculationModel* calc = [[CalculationModel alloc]initWithScore:score Message:message IsSurvivalScore:flag Date:date CalculationID:nil];
                    // test
                    if(flag){
                        [self.calculations addObject:calc];
                    }
                }
                NSLog(@"%@",@"RELOADING");
                
                [self.tableView reloadData];
            }else{
                [UiModal showModalWithTitle:@"Error" message:response[@"error"] buttonTitle:@"OK" viewController:self];
            }
        } else {
            [UiModal showModalWithTitle:@"Error" message:error.localizedDescription buttonTitle:@"OK" viewController:self];
        }
    }];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    [self.tableView reloadData];
}
- (IBAction)pressOKButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // Configure the cell...
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    CalculationModel* cal  = self.calculations[indexPath.row];
    if(cal.isSurvivalScore){
        cell.textLabel.text = [[[@"Survival Score: " stringByAppendingString:cal.score]stringByAppendingString:@"    "]stringByAppendingString:cal.date];
    }else{
        cell.textLabel.text = [[[@"Sepsis   Score: " stringByAppendingString:cal.score]stringByAppendingString:@"    "]stringByAppendingString:cal.date];
    }
    cell.detailTextLabel.text = cal.message;
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //dsds
    return [self.calculations count];
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
