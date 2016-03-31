//
//  OverviewTableViewController.m
//  foal score
//
//  Created by Jun on 1/26/16.
//  Copyright © 2016 osu.edu. All rights reserved.
//

#import "OverviewTableViewController.h"

@interface OverviewTableViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *choices;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *contents;

@end

@implementation OverviewTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tabBarController.tabBar.hidden = YES;
    [self.navigationItem setTitle:@"Overview"];
    // modify navigation bar
    UIBarButtonItem *newBackButton = [[UIBarButtonItem alloc]initWithTitle:@"Info" style:UIBarButtonItemStylePlain target:self action:@selector(backButtonAction)];
    self.navigationItem.leftBarButtonItem = newBackButton;
    [self tableView];
    self.tableView.separatorColor = [UIColor clearColor];
    [self.tableView setScrollEnabled:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)backButtonAction{
    self.tabBarController.tabBar.hidden = NO;
    [self.navigationController popViewControllerAnimated:YES];
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

- (NSMutableArray *)choices{
    if(_choices == nil){
        _choices = [[NSMutableArray alloc]initWithCapacity:5];
        [_choices addObject:@"Sepsis Score"];
        [_choices addObject:@"Foul Survival Score"];
        [_choices addObject:@"References"];
        [_choices addObject:@"Terminology"];
        [_choices addObject:@"Important Info"];
    }
    return _choices;
}

- (NSMutableArray *)contents{
    if(_contents == nil){
        _contents = [[NSMutableArray alloc]initWithCapacity:5];
        [_contents addObject:@"111111111111111"];
        [_contents addObject:@"222222222222222"];
        [_contents addObject:@"333333333333333"];
        [_contents addObject:@"444444444444444"];
        [_contents addObject:@"Cities Recover After Winter Storm Jonas Posted: Jan 26 2016 10:45 AM ES Updated: Jan 26 2016 05:00 PM EST Meteorologist Domenica Davis gives an overview of the impacts and travel conditions followi...read more Cities Recover After Winter Storm Jonas weather.com Posted: Jan 26 2016 10:45 AM EST Updated: Jan 26 2016 05:00 PM ESTMeteorologist Domenica Davis gives an overview of the impacts and travel conditions following Winter Storm Jonas."];
    }
    return _contents;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
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
    //CGFloat tabBarHeight = self.tabBarController.tabBar.frame.size.height;
    CGFloat navigationBarHeight = self.navigationController.navigationBar.frame.size.height;
    CGFloat statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    return (screenHeight - navigationBarHeight - statusBarHeight)/5.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    // change message
    [UiModal showModalWithTitle:[self.choices objectAtIndex:indexPath.row] message:[self.contents objectAtIndex:indexPath.row]buttonTitle:@"OK" viewController:self];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
}


@end
