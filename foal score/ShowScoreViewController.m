//
//  ShowScoreViewController.m
//  foal score
//
//  Created by Jun on 2/13/16.
//  Copyright © 2016 osu.edu. All rights reserved.
//

#import "ShowScoreViewController.h"

@interface ShowScoreViewController ()
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@end

@implementation ShowScoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.scoreLabel.text = [[@(self.survivalScore) stringValue] stringByAppendingString:@"%"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)pressAddToAFoalButton:(id)sender {
    if(self.scoreID != nil){
        ListOfFoalsChoosingToAttachedViewController* foalsToAttachedVC = [[ListOfFoalsChoosingToAttachedViewController alloc]init];
        foalsToAttachedVC.survivalScore = self.survivalScore;
        [self.navigationController pushViewController:foalsToAttachedVC animated:YES];

    }else{
        if(self.networkError){
            [UiModal showModalWithTitle:@"Error" message:@"Network error, cannot add a foal." buttonTitle:@"OK" viewController:self];
        }else{
            // TODO:maybe link to login page.
            [UiModal showModalWithTitle:@"Sorry" message:@"Please log in to add a foal." buttonTitle:@"OK" viewController:self];
        }
        
    }
}
- (IBAction)pressCancelButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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
