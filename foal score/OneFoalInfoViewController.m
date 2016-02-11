//
//  OneFoalInfoViewController.m
//  foal score
//
//  Created by Jun on 2/10/16.
//  Copyright © 2016 osu.edu. All rights reserved.
//

#import "OneFoalInfoViewController.h"

@interface OneFoalInfoViewController ()

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


@end

@implementation OneFoalInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    // add scroll View
    self.scrollView.contentSize = self.scrollView.frame.size;
    self.scrollView.frame = self.view.frame;
    [self.view addSubview:self.scrollView];
    FoalInfoModel* foalNeedToShow = [[DataManager foals] objectAtIndex:self.indexOfFoal];
    self.nameLable.text = foalNeedToShow.name;
    self.ageLable.text = [@(foalNeedToShow.age) stringValue];
    self.breedLable.text = foalNeedToShow.breed;
    self.tempLable.text = [@(foalNeedToShow.temperature) stringValue];
    self.rRateLable.text = [@(foalNeedToShow.respiratoryRate) stringValue];
    self.hRateLable.text = [@(foalNeedToShow.heartRate) stringValue];
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

    
}
- (IBAction)pressOKButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
