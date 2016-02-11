//
//  MyFoalViewController.m
//  foal score
//
//  Created by Jun on 2/3/16.
//  Copyright © 2016 osu.edu. All rights reserved.
//

#import "MyFoalViewController.h"

@interface MyFoalViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) NSMutableArray* foals;

@end

@implementation MyFoalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self tableView];
    [self.navigationItem setTitle:@"My Foals"];
    self.tableView.separatorColor = [UIColor clearColor];
    UIBarButtonItem *newBackButton = [[UIBarButtonItem alloc]initWithTitle:@"Info" style:UIBarButtonItemStylePlain target:self action:@selector(backButtonAction)];
    self.navigationItem.leftBarButtonItem = newBackButton;
    // add new foal button
    UIBarButtonItem *newAddingButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addingButtonAction)];
    self.navigationItem.rightBarButtonItem = newAddingButton;
}

- (void)viewWillAppear:(BOOL)animated{
    NSLog(@"HIHI");	
    [super viewWillAppear:YES];
    [self.tableView reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)backButtonAction{
    self.tabBarController.tabBar.hidden = NO;
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)addingButtonAction{
    // create (load) addFoalViewController
    // at this time index can be any number since it will not use parameter of index when modifyOrNot is NO
    AddNewFoalViewController* addNewFoalVC = [[AddNewFoalViewController alloc]initWithAnIndexOfFoalThatNeedToModify:-1 ModifyOrNot:NO];
    [self.navigationController pushViewController:addNewFoalVC animated:YES];
}


- (UITableView *)tableView{
    if(_tableView == nil){
        _tableView = [[UITableView alloc]initWithFrame: self.view.bounds style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [self.view addSubview:_tableView];
        
    }
    return  _tableView;
}

- (NSMutableArray *)foals{
    if(_foals == nil){
        _foals = [DataManager foals];
        
    }
    return _foals;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.foals count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // Configure the cell...
    
    static NSString *CellIdentifier = @"Cell";
    MGSwipeTableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil){
        cell = [[MGSwipeTableCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    // modify cell content
    FoalInfoModel *foal = [self.foals objectAtIndex:indexPath.row];
    cell.textLabel.text = foal.name;
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"MM-dd yyyy"];
    NSString *date_string = [formatter stringFromDate:foal.addDate];
    cell.detailTextLabel.text = date_string;
    //configure right buttons
    cell.rightButtons = @[[MGSwipeButton buttonWithTitle:@"Delete" backgroundColor:[UIColor redColor] callback:^BOOL(MGSwipeTableCell *sender) {
        NSLog(@"Convenience callback for delete buttons!");
        NSMutableArray* foals = [DataManager foals];
        [foals removeObjectAtIndex:indexPath.row];
        [tableView reloadData];
        return YES;
    }], [MGSwipeButton buttonWithTitle:@"Edit" backgroundColor:[UIColor blueColor] callback:^BOOL(MGSwipeTableCell *sender) {
        NSLog(@"Convenience callback for edit buttons!");
        AddNewFoalViewController* addNewFoalVC = [[AddNewFoalViewController alloc]initWithAnIndexOfFoalThatNeedToModify:indexPath.row ModifyOrNot:YES];
        [self.navigationController pushViewController:addNewFoalVC animated:YES];
        return YES;
    }]];
    cell.rightSwipeSettings.transition = MGSwipeTransition3D;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    AddNewFoalViewController* addNewFoalVC = [[AddNewFoalViewController alloc]initWithAnIndexOfFoalThatNeedToModify:indexPath.row ModifyOrNot:YES];
//    [self.navigationController pushViewController:addNewFoalVC animated:YES];
    OneFoalInfoViewController* ofvc = [[OneFoalInfoViewController alloc]init];
    ofvc.indexOfFoal =indexPath.row;
    [self.navigationController pushViewController:ofvc animated:YES];			
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
