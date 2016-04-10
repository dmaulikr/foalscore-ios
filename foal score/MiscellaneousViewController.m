//
//  MiscellaneousViewController.m
//  foal score
//
//  Created by Jun on 4/7/16.
//  Copyright © 2016 osu.edu. All rights reserved.
//

#import "MiscellaneousViewController.h"

@interface MiscellaneousViewController ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong)UITableView* tableView;
@property(nonatomic, strong)NSMutableArray* choices;
@end

@implementation MiscellaneousViewController

- (NSMutableArray *)choices{
    if(_choices == nil){
        _choices = [[NSMutableArray alloc]init];
        [_choices addObject:@"Export Data"];
        [_choices addObject:@"Refer a Friend"];
        [_choices addObject:@"Give Feedback"];
    }
    return _choices;
}

- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame: self.view.bounds style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGRect screenRect =[[UIScreen mainScreen]bounds];
    CGFloat screenHeight = screenRect.size.height;
    //CGFloat tabBarHeight = self.tabBarController.tabBar.frame.size.height;
    CGFloat navigationBarHeight = self.navigationController.navigationBar.frame.size.height;
    CGFloat statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    return (screenHeight - navigationBarHeight - statusBarHeight)/3.0;
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

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        ExportDataViewController* edc = [[ExportDataViewController alloc]init];
        [self.navigationController pushViewController:edc animated:YES];
    }else if (indexPath.row == 1){
        ReferViewController* rvc = [[ReferViewController alloc]init];
        [self.navigationController pushViewController:rvc animated:YES];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self tableView];
    [self.navigationItem setTitle:@"Miscellaneous"];
    self.tableView.separatorColor = [UIColor clearColor];
    [self.tableView setScrollEnabled:NO];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
