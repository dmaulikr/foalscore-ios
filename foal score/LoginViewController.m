//
//  LoginViewController.m
//  foal score
//
//  Created by Jun on 1/26/16.
//  Copyright © 2016 osu.edu. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.doneButton.enabled = NO;
    [self.userNameTextField addTarget:self action:@selector(textFieldDidChange_UserName) forControlEvents:UIControlEventEditingDidEnd];
    [self.passwordTextField addTarget:self action:@selector(textFieldDidChange_Password) forControlEvents:UIControlEventEditingDidEnd];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancelButtonPress:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)doneButtonPress:(id)sender {
    NSString *userName = self.userNameTextField.text;
    NSString *password = self.passwordTextField.text;
    NSLog(userName);
    NSLog(password);
}

- (void)textFieldDidChange_UserName{
    NSLog(@"a");
}

- (void)textFieldDidChange_Password{
    NSLog(@"b");
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
