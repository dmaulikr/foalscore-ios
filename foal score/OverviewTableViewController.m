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
//@property (nonatomic, strong) NSString *content;

@end

@implementation OverviewTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tabBarController.tabBar.hidden = YES;
    [self.navigationItem setTitle:@"Overview"];
    // modify navigation bar
    UIBarButtonItem *newBackButton = [[UIBarButtonItem alloc]initWithTitle:@"Hub" style:UIBarButtonItemStylePlain target:self action:@selector(backButtonAction)];
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
    [[[FoalScoreAFAPIClient sharedClient] operationQueue] cancelAllOperations];
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
        [_choices addObject:@"Foal Survival Score"];
        [_choices addObject:@"References"];
        [_choices addObject:@"Terminology"];
        [_choices addObject:@"Important Info"];
    }
    return _choices;
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
    if(indexPath.row == 0){
        FoalScoreAFAPIClient* api = [FoalScoreAFAPIClient sharedClient];
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [api getSepsisInfo:^(NSDictionary *response, NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if (response) {
                NSString* text_html = [response valueForKey:@"text"];
                NSString* text = [HtmlStriper stringByStrippingHTML:text_html];
                [UiModal showModalWithTitle:self.choices[0] message:text buttonTitle:@"Yes" viewController:self];
            } else {
                [UiModal showModalWithTitle:@"ERROR" message:[error localizedDescription] buttonTitle:@"OK" viewController:self];
            }

        }];
    }else if (indexPath.row ==1){
        FoalScoreAFAPIClient* api = [FoalScoreAFAPIClient sharedClient];
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [api getSurvivalInfo:^(NSDictionary *response, NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if (response) {
                NSString* text_html = [response valueForKey:@"text"];
                NSString* text = [HtmlStriper stringByStrippingHTML:text_html];
                [UiModal showModalWithTitle:self.choices[1] message:text buttonTitle:@"Yes" viewController:self];
            } else {
                [UiModal showModalWithTitle:@"ERROR" message:[error localizedDescription] buttonTitle:@"OK" viewController:self];
            }
            
        }];

    }else if (indexPath.row ==4){
        FoalScoreAFAPIClient* api = [FoalScoreAFAPIClient sharedClient];
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [api getOverview:^(NSDictionary *response, NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if (response) {
                NSString* text_html = [response valueForKey:@"text"];
                NSString* text = [HtmlStriper stringByStrippingHTML:text_html];
                text = [text stringByAppendingString:@"\nIcon Credits:\nSepsis Icon made by Freepik from flaticon.com"];
                [UiModal showModalWithTitle:self.choices[4] message:text buttonTitle:@"Yes" viewController:self];
            } else {
                [UiModal showModalWithTitle:@"ERROR" message:[error localizedDescription] buttonTitle:@"OK" viewController:self];
            }
            
        }];
        
    }else if (indexPath.row == 2){
        FoalScoreAFAPIClient* api = [FoalScoreAFAPIClient sharedClient];
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [api getReferences:^(NSDictionary *response, NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if (response) {
                NSString* text_html = [response valueForKey:@"text"];
                OverviewPage* op = [[OverviewPage alloc]init];
                op.text = text_html;
                op.NVtitle = @"References";
                [self.navigationController pushViewController:op animated:YES];
                
            } else {
                [UiModal showModalWithTitle:@"ERROR" message:[error localizedDescription] buttonTitle:@"OK" viewController:self];
            }
            
        }];

    }else{
        FoalScoreAFAPIClient* api = [FoalScoreAFAPIClient sharedClient];
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [api getTerminology:^(NSDictionary *response, NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if (response) {
                NSString* text_html = [response valueForKey:@"text"];
                OverviewPage* op = [[OverviewPage alloc]init];
                op.text = text_html;
                op.NVtitle = @"Terminology";
                [self.navigationController pushViewController:op animated:YES];
                
            } else {
                [UiModal showModalWithTitle:@"ERROR" message:[error localizedDescription] buttonTitle:@"OK" viewController:self];
            }
            
        }];

    }

    
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
}

@end
