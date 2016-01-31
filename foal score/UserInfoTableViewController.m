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
    [self.navigationItem setTitle:@"User Infomation"];
    self.tableView.separatorColor = [UIColor clearColor];}

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
            NSLog(@"User info/Login");
            UserInfoModel* userInfo1 = [DataManager userInfo];
            if ([userInfo1.userName isEqual: @""] || [userInfo1.password isEqual: @""] || userInfo1.userName == nil || userInfo1.password == nil){
                LoginViewController *log = [[LoginViewController alloc]init];
                [self presentViewController:log animated:YES completion:nil];
            }else{
                //test
                UserInfoModel* userInfo = [DataManager userInfo];
                NSLog(userInfo.userName);
                NSLog(userInfo.password);
                
            }
            break;
        }
        // my foals
        case 1:{
            NSLog(@"ok");
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
            NSLog(@"ok");
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
