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
@property (nonatomic, strong) NSMutableArray* Qs;
@property (nonatomic, strong) NSMutableArray* As;

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
    
    // pr select
    NSIndexPath *p1 = [NSIndexPath indexPathForItem:0 inSection:0];
    NSIndexPath *p2 = [NSIndexPath indexPathForItem:0 inSection:1];
    NSIndexPath *p3 = [NSIndexPath indexPathForItem:0 inSection:2];
    NSIndexPath *p4 = [NSIndexPath indexPathForItem:0 inSection:3];
    NSIndexPath *p5 = [NSIndexPath indexPathForItem:0 inSection:4];
    NSIndexPath *p6 = [NSIndexPath indexPathForItem:0 inSection:5];
    NSIndexPath *p7 = [NSIndexPath indexPathForItem:0 inSection:6];
    NSIndexPath *p8 = [NSIndexPath indexPathForItem:0 inSection:7];
    NSIndexPath *p9 = [NSIndexPath indexPathForItem:0 inSection:8];
    NSIndexPath *p10 = [NSIndexPath indexPathForItem:0 inSection:9];
    NSIndexPath *p11 = [NSIndexPath indexPathForItem:0 inSection:10];
    NSIndexPath *p12 = [NSIndexPath indexPathForItem:0 inSection:11];
    NSIndexPath *p13 = [NSIndexPath indexPathForItem:0 inSection:12];
    NSIndexPath *p14 = [NSIndexPath indexPathForItem:0 inSection:13];
 
    
    
    
    [self.tableView selectRowAtIndexPath:p2 animated:YES scrollPosition:UITableViewScrollPositionNone];
    [self.tableView selectRowAtIndexPath:p3 animated:YES scrollPosition:UITableViewScrollPositionNone];
    [self.tableView selectRowAtIndexPath:p4 animated:YES scrollPosition:UITableViewScrollPositionNone];
    [self.tableView selectRowAtIndexPath:p5 animated:YES scrollPosition:UITableViewScrollPositionNone];
    [self.tableView selectRowAtIndexPath:p1 animated:YES scrollPosition:UITableViewScrollPositionNone];
    [self.tableView selectRowAtIndexPath:p6 animated:YES scrollPosition:UITableViewScrollPositionNone];
    [self.tableView selectRowAtIndexPath:p7 animated:YES scrollPosition:UITableViewScrollPositionNone];
    [self.tableView selectRowAtIndexPath:p8 animated:YES scrollPosition:UITableViewScrollPositionNone];
    [self.tableView selectRowAtIndexPath:p9 animated:YES scrollPosition:UITableViewScrollPositionNone];
    [self.tableView selectRowAtIndexPath:p10 animated:YES scrollPosition:UITableViewScrollPositionNone];
    [self.tableView selectRowAtIndexPath:p11 animated:YES scrollPosition:UITableViewScrollPositionNone];
    [self.tableView selectRowAtIndexPath:p12 animated:YES scrollPosition:UITableViewScrollPositionNone];
    [self.tableView selectRowAtIndexPath:p13 animated:YES scrollPosition:UITableViewScrollPositionNone];
    [self.tableView selectRowAtIndexPath:p14 animated:YES scrollPosition:UITableViewScrollPositionNone];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
   
}

- (NSMutableArray *)As{
    if(_As == nil){
        NSMutableArray* choices1 = [[NSMutableArray alloc]init];
        NSMutableArray* choices2 = [[NSMutableArray alloc]init];
        NSMutableArray* choices3 = [[NSMutableArray alloc]init];
        NSMutableArray* choices4 = [[NSMutableArray alloc]init];
        NSMutableArray* choices5 = [[NSMutableArray alloc]init];
        NSMutableArray* choices6 = [[NSMutableArray alloc]init];
        NSMutableArray* choices7 = [[NSMutableArray alloc]init];
        NSMutableArray* choices8 = [[NSMutableArray alloc]init];
        NSMutableArray* choices9 = [[NSMutableArray alloc]init];
        NSMutableArray* choices10 = [[NSMutableArray alloc]init];
        NSMutableArray* choices11 = [[NSMutableArray alloc]init];
        NSMutableArray* choices12 = [[NSMutableArray alloc]init];
        NSMutableArray* choices13 = [[NSMutableArray alloc]init];
        NSMutableArray* choices14 = [[NSMutableArray alloc]init];

        [choices1 addObject:@"1"];
        [choices1 addObject:@"2"];
        [choices1 addObject:@"3"];
        [choices1 addObject:@"4"];
        [choices1 addObject:@"5"];
        [choices1 addObject:@"6"];
        
        [choices2 addObject:@"1"];
        [choices2 addObject:@"2"];
        [choices2 addObject:@"3"];
        [choices2 addObject:@"4"];
        
        [choices3 addObject:@"1"];
        [choices3 addObject:@"2"];
        [choices3 addObject:@"3"];
        [choices3 addObject:@"4"];
        
        
        [choices4 addObject:@"1"];
        [choices4 addObject:@"2"];
        [choices4 addObject:@"3"];
        [choices4 addObject:@"4"];

        [choices5 addObject:@"1"];
        [choices5 addObject:@"2"];
        [choices5 addObject:@"3"];
        [choices5 addObject:@"4"];
        
        [choices6 addObject:@"1"];
        [choices6 addObject:@"2"];
        [choices6 addObject:@"3"];
        [choices6 addObject:@"4"];
        [choices6 addObject:@"5"];
        
        [choices7 addObject:@"1"];
        [choices7 addObject:@"2"];
        [choices7 addObject:@"3"];
        [choices7 addObject:@"4"];
        [choices7 addObject:@"5"];
        
        [choices8 addObject:@"1"];
        [choices8 addObject:@"2"];
        [choices8 addObject:@"3"];
        
        [choices9 addObject:@"1"];
        [choices9 addObject:@"2"];
        [choices9 addObject:@"3"];
        [choices9 addObject:@"4"];
        
        [choices10 addObject:@"1"];
        [choices10 addObject:@"2"];
        [choices10 addObject:@"3"];
        
        [choices11 addObject:@"1"];
        [choices11 addObject:@"2"];
        [choices11 addObject:@"3"];
        [choices11 addObject:@"4"];
        
        [choices12 addObject:@"1"];
        [choices12 addObject:@"2"];
        [choices12 addObject:@"3"];
        
        [choices13 addObject:@"1"];
        [choices13 addObject:@"2"];
        [choices13 addObject:@"3"];
        
        [choices14 addObject:@"1"];
        [choices14 addObject:@"2"];
        [choices14 addObject:@"3"];
        [choices14 addObject:@"4"];
        [choices14 addObject:@"5"];

        _As = [[NSMutableArray alloc]init];
        [_As addObject:choices1];
        [_As addObject:choices2];
        [_As addObject:choices3];
        [_As addObject:choices4];
        [_As addObject:choices5];
        [_As addObject:choices6];
        [_As addObject:choices7];
        [_As addObject:choices8];
        [_As addObject:choices9];
        [_As addObject:choices10];
        [_As addObject:choices11];
        [_As addObject:choices12];
        [_As addObject:choices13];
        [_As addObject:choices14];
    }
    return _As;
}

- (NSMutableArray*)Qs{
    if (_Qs == nil) {
        _Qs = [[NSMutableArray alloc]init];
        [_Qs addObject:@"1"];
        [_Qs addObject:@"2"];
        [_Qs addObject:@"3"];
        [_Qs addObject:@"4"];
        [_Qs addObject:@"5"];
        [_Qs addObject:@"6"];
        [_Qs addObject:@"7"];
        [_Qs addObject:@"8"];
        [_Qs addObject:@"9"];
        [_Qs addObject:@"10"];
        [_Qs addObject:@"11"];
        [_Qs addObject:@"12"];
        [_Qs addObject:@"13"];
        [_Qs addObject:@"14"];
        
    }
    return _Qs;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // Configure the cell...
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    NSString* title = [[self.As objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
    [cell.textLabel setText:title];
    UIView* bv = [[UIView alloc]init];
    bv.backgroundColor = [UIColor blueColor];
    cell.selectedBackgroundView = bv;
    return cell;
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return (int)[self.Qs count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return (int)[[self.As objectAtIndex:section] count];
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
    return [self.Qs objectAtIndex:section];
}



- (IBAction)pressCalculateButton:(id)sender {
    NSArray* selects = [self.tableView indexPathsForSelectedRows];
    for (NSIndexPath* select in selects) {
        NSInteger section = select.section;
        NSInteger row = select.row;
        NSString* choice = [[self.As objectAtIndex:section]objectAtIndex:row];
        NSString* question = [[self.Qs objectAtIndex:section]objectAtIndex:row];
        // TO DO
    }
}

//- (void)viewDidAppear:(BOOL)animated{
//    [super viewDidAppear:animated];
//    NSIndexPath *p1 = [NSIndexPath indexPathForItem:0 inSection:0];
//    NSIndexPath *p2 = [NSIndexPath indexPathForItem:0 inSection:1];
//    NSIndexPath *p3 = [NSIndexPath indexPathForItem:0 inSection:2];
//    NSIndexPath *p4 = [NSIndexPath indexPathForItem:0 inSection:3];
//    NSIndexPath *p5 = [NSIndexPath indexPathForItem:0 inSection:4];
//    [self.tableView selectRowAtIndexPath:p2 animated:YES scrollPosition:UITableViewScrollPositionTop];
//    [self.tableView selectRowAtIndexPath:p3 animated:YES scrollPosition:UITableViewScrollPositionTop];
//    [self.tableView selectRowAtIndexPath:p4 animated:YES scrollPosition:UITableViewScrollPositionTop];
//    [self.tableView selectRowAtIndexPath:p5 animated:YES scrollPosition:UITableViewScrollPositionTop];
//    [self.tableView selectRowAtIndexPath:p1 animated:YES scrollPosition:UITableViewScrollPositionTop];
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
