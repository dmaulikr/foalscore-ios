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
    [self tableView];
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

-(NSMutableArray*)foals{
    if(_foals == nil){
        _foals = [DataManager foals];
    }
    return _foals;
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
    NSMutableArray* foals = [DataManager foals];
    FoalInfoModel* foal = [foals objectAtIndex:indexPath.row];
    [foal attachSurvivalScore:self.survivalScore];
    [self.navigationController popToRootViewControllerAnimated:YES];
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
