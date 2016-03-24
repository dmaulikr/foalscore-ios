//
//  UserInfoViewController.m
//  foal score
//
//  Created by Jun on 1/31/16.
//  Copyright © 2016 osu.edu. All rights reserved.
//

#import "UserInfoViewController.h"

@interface UserInfoViewController ()

@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *emailID;

@end

@implementation UserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UserInfoModel* user = [DataManager userInfo];
    self.userName.text = user.userName;
    self.emailID.text = user.email;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pressChangePassword:(id)sender {
    // TODO
}

- (IBAction)pressLogOut:(id)sender {
    UserInfoModel* userInfo = [DataManager userInfo];
    [userInfo clearUserInfo];
    [self.navigationController popViewControllerAnimated:YES];
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
