//
//  UserInfoTableViewController.m
//  foal score
//
//  Created by Jun on 1/25/16.
//  Copyright © 2016 osu.edu. All rights reserved.
//

#import "UserInfoTableViewController.h"

@interface UserInfoTableViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *choices;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) DataManager *dataManager;

@end

@implementation UserInfoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self tableView];
    [self.navigationItem setTitle:@"User Hub"];
    self.tableView.separatorColor = [UIColor clearColor];
    [self.tableView setScrollEnabled:NO];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (NSMutableArray *)choices {
    if (_choices == nil){
        NSMutableArray *array = [[NSMutableArray alloc]initWithCapacity:4];
        [array addObject:@"Login/User Profile"];
        [array addObject:@"My Foals"];
        [array addObject:@"Overview"];
        [array addObject:@"Miscellaneous"];
        
        _choices = array;
    }
    return _choices;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // Configure the cell...
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    [cell.textLabel setText:[self.choices objectAtIndex:indexPath.row]];
    cell.imageView.image = [UIImage imageNamed:
                            [NSString stringWithFormat:@"icon%ld.png",(long)indexPath.row]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGRect screenRect =[[UIScreen mainScreen]bounds];
    CGFloat screenHeight = screenRect.size.height;
    CGFloat tabBarHeight = self.tabBarController.tabBar.frame.size.height;
    CGFloat navigationBarHeight = self.navigationController.navigationBar.frame.size.height;
    CGFloat statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    return (screenHeight - tabBarHeight-navigationBarHeight - statusBarHeight)/4.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
    switch (indexPath.row) {
        // login/user profile
        case 0:{
            if (![DataManager loginOrNot]){
                LoginViewController *log = [[LoginViewController alloc]init];
                [self presentViewController:log animated:YES completion:nil];
            }else{
                UserInfoViewController* userViewController = [[UserInfoViewController alloc]init];
                [self.navigationController pushViewController:userViewController animated:YES];
            }
            break;
        }
        // my foals
        case 1:{
            MyFoalViewController* myFoalVc = [[MyFoalViewController alloc]init];
            [[self navigationController]pushViewController:myFoalVc animated:YES];
            break;
        }
        // overview
        case 2:{
            OverviewTableViewController *overViewPage = [[OverviewTableViewController alloc]init];
            [[self navigationController] pushViewController:overViewPage animated:YES];
            break;
        }
        // miscellaneous
        case 3:{
            MiscellaneousViewController* mvc = [[MiscellaneousViewController alloc]init];
            [[self navigationController] pushViewController:mvc animated:YES];
            break;
        }
            
        default:
            break;
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
}



@end
