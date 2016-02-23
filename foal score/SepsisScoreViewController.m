//
//  SepsisScoreViewController.m
//  foal score
//
//  Created by Jun on 2/22/16.
//  Copyright © 2016 osu.edu. All rights reserved.
//

#import "SepsisScoreViewController.h"

@interface SepsisScoreViewController ()<UITableViewDataSource, UITableViewDelegate>


@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSDictionary* choicesForEachQ;

@end

@implementation SepsisScoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tableView.delegate =self;
    self.tableView.dataSource = self;
    [self tableView];
    [self.tableView reloadData];
    NSLog(@"sss");
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
   
}

- (NSDictionary *)choicesForEachQ{
    if(_choicesForEachQ == nil){
        NSMutableArray* choices1 = [[NSMutableArray alloc]init];
        NSMutableArray* choices2 = [[NSMutableArray alloc]init];
        NSMutableArray* choices3 = [[NSMutableArray alloc]init];
        NSMutableArray* choices4 = [[NSMutableArray alloc]init];
        NSMutableArray* choices5 = [[NSMutableArray alloc]init];
        
        [choices1 addObject:@"1"];
        [choices1 addObject:@"2"];
        [choices1 addObject:@"3"];
        [choices1 addObject:@"4"];
        [choices1 addObject:@"5"];
        
        [choices2 addObject:@"1"];
        [choices2 addObject:@"2"];
        [choices2 addObject:@"3"];
        [choices2 addObject:@"4"];
        [choices2 addObject:@"5"];
        
        [choices3 addObject:@"1"];
        [choices3 addObject:@"2"];
        [choices3 addObject:@"3"];
        [choices3 addObject:@"4"];
        [choices3 addObject:@"5"];
        
        [choices4 addObject:@"1"];
        [choices4 addObject:@"2"];
        [choices4 addObject:@"3"];
        [choices4 addObject:@"4"];
        [choices4 addObject:@"5"];
        
        [choices5 addObject:@"1"];
        [choices5 addObject:@"2"];
        [choices5 addObject:@"3"];
        [choices5 addObject:@"4"];
        [choices5 addObject:@"5"];
        
        
        _choicesForEachQ = @{
                             @"jdhksjf df sd f ds fnlvnl" : choices1,
                             @"2" : choices2,
                             @"3" : choices3,
                             @"4" : choices4,
                             @"5" : choices5,
                             
                             };
    }
    return _choicesForEachQ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // Configure the cell...
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    NSString* title = [[[self.choicesForEachQ allValues]objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
    [cell.textLabel setText:title];
    
    return cell;
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return (int)[self.choicesForEachQ count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return (int)[[[self.choicesForEachQ allValues]objectAtIndex:section]count];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
}
- (NSIndexPath*)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath*)indexPath {
    for ( NSIndexPath* selectedIndexPath in tableView.indexPathsForSelectedRows ) {
        if ( selectedIndexPath.section == indexPath.section )
            [tableView deselectRowAtIndexPath:selectedIndexPath animated:NO] ;
    }
    return indexPath ;
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [[self.choicesForEachQ allKeys]objectAtIndex:section];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSIndexPath *p1 = [NSIndexPath indexPathForItem:0 inSection:0];
    NSIndexPath *p2 = [NSIndexPath indexPathForItem:0 inSection:1];
    NSIndexPath *p3 = [NSIndexPath indexPathForItem:0 inSection:2];
    NSIndexPath *p4 = [NSIndexPath indexPathForItem:0 inSection:3];
    NSIndexPath *p5 = [NSIndexPath indexPathForItem:0 inSection:4];
    [self.tableView selectRowAtIndexPath:p2 animated:YES scrollPosition:UITableViewScrollPositionTop];
    [self.tableView selectRowAtIndexPath:p3 animated:YES scrollPosition:UITableViewScrollPositionTop];
    [self.tableView selectRowAtIndexPath:p4 animated:YES scrollPosition:UITableViewScrollPositionTop];
    [self.tableView selectRowAtIndexPath:p5 animated:YES scrollPosition:UITableViewScrollPositionTop];
    [self.tableView selectRowAtIndexPath:p1 animated:YES scrollPosition:UITableViewScrollPositionTop];
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
