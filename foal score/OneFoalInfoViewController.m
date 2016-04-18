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
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[FoalScoreAFAPIClient sharedClient]foalScores:dict withCompletitionBlock:^(NSDictionary *response, NSError *error) {
        if(response){
            [MBProgressHUD hideHUDForView:self.view animated:YES];
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

                    [self.calculations addObject:calc];
        
                }
                
                [self.tableView reloadData];
            }else{
                [UiModal showModalWithTitle:@"Error" message:response[@"error"] buttonTitle:@"OK" viewController:self];
            }
        } else {
            [UiModal showModalWithTitle:@"Error" message:error.localizedDescription buttonTitle:@"OK" viewController:self];
        }
    }];
    
    UIBarButtonItem *newEditingButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(EditingButtonAction)];
    self.navigationItem.rightBarButtonItem = newEditingButton;
}

- (void)EditingButtonAction{
    AddNewFoalViewController* addNewFoalVC = [[AddNewFoalViewController alloc]initWithAnIndexOfFoalThatNeedToModify:self.indexOfFoal ModifyOrNot:YES];
    addNewFoalVC.fromBarButton = true;
    [self.navigationController pushViewController:addNewFoalVC animated:YES];
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

    if([self.calculations count]!=0){
        CalculationModel* cal  = self.calculations[indexPath.row];
        if(cal.isSurvivalScore){
            cell.textLabel.textColor = [UIColor colorWithRed:(252/255.0) green:(81/255.0) blue:(87/255.0) alpha:1.0];
            cell.textLabel.text = [[[@"Survival Score: " stringByAppendingString:cal.score]stringByAppendingString:@"    "]stringByAppendingString:[self RightDateString:cal.date]];
        }else{
            cell.textLabel.textColor = [UIColor colorWithRed:(82/255.0) green:(104/255.0) blue:(153/255.0) alpha:1.0];
            cell.textLabel.text = [[[@"Sepsis   Score: " stringByAppendingString:cal.score]stringByAppendingString:@"    "]stringByAppendingString:[self RightDateString:cal.date]];
        }
        cell.detailTextLabel.text = cal.message;
    }else{
        [cell.textLabel setText:@"No calculation history"];
        [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    }
    cell.detailTextLabel.numberOfLines = 0;
    cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //dsds
    if([self.calculations count] == 0){
        return 1;
    }
    return [self.calculations count];
}

-(NSString*)RightDateString:(NSString*)data{
    NSString *returnString=@"";
    NSArray *arr = [data componentsSeparatedByCharactersInSet:
                    [NSCharacterSet characterSetWithCharactersInString:@"^~ -:"]];
    NSString *month ;
    if([arr[1]isEqualToString:@"01"])
    {
        month = @"Jan ";
    }
    else if([arr[1]isEqualToString:@"02"])
    {
        month =@"Feb ";
    }
    else if([arr[1]isEqualToString:@"03"])
    {
        month = @"Mar ";
    }else if([arr[1]isEqualToString:@"04"])
    {
        month= @"Apr ";
    }
    else if([arr[1]isEqualToString:@"05"])
    {
        month =@"May ";
    }
    else if([arr[1]isEqualToString:@"06"])
    {
        month=@"June ";
    }
    else if([arr[1]isEqualToString:@"07"])
    {
        month =@"July ";
    }
    else if([arr[1]isEqualToString:@"08"])
    {
        month = @"Aug ";
    }
    else if( [arr[1]isEqualToString:@"09"])
    {
        month = @"Sept ";
        
    }else if([arr[1]isEqualToString:@"10"])
    {
        month = @"Oct ";
    }else if([arr[1]isEqualToString:@"11"])
    {
        month = @"Nov ";
    }
    else if([arr[1]isEqualToString:@"12"])
        
    {
        month =@"Dec ";
    }
    else {
        month = @" ";
    }
    
    NSString *day = arr[2];
    NSString *year = arr[0];
    NSString *space =@" ";
    returnString = [returnString stringByAppendingString:month];
    
    returnString = [returnString stringByAppendingString:day];
    returnString = [returnString stringByAppendingString:space];
    
    returnString = [returnString stringByAppendingString:year];
 

    
    
    return returnString;
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
