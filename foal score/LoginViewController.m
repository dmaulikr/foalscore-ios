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
@property (weak, nonatomic) IBOutlet UITextField *emailIDTextField;
@property (nonatomic, copy) UserInfoModel* userInfo;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.doneButton.enabled = NO;
    [self.userNameTextField addTarget:self action:@selector(textFieldDidChange_UserName) forControlEvents:UIControlEventEditingDidEnd];
    [self.passwordTextField addTarget:self action:@selector(textFieldDidChange_Password) forControlEvents:UIControlEventEditingDidEnd];
    [self.emailIDTextField addTarget:self action:@selector(textFieldDidChange_emailID) forControlEvents:UIControlEventEditingDidEnd];
    // Listen for keyboard appearances and disappearances
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidHide:)
                                                 name:UIKeyboardDidHideNotification
                                               object:nil];
    
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
    NSString *email = self.emailIDTextField.text;
    
    
    // Send login info to server
    NSMutableDictionary *requestObj =  [[NSMutableDictionary alloc]init];
    requestObj[@"email"] = email;
    requestObj[@"password"] = password;
    [[FoalScoreAFAPIClient sharedClient] loginUser: requestObj
                             withCompletitionBlock:^(NSDictionary *response, NSError *error) {
                                 if(response) {
                                     if([response[@"status"] isEqual: @"success"]) {
                                         
                                         NSLog(@"%@ %@", @"ID:", response[@"userObj"][@"User"][@"id"]);
                                         
                                         //Save user login status
                                         UserInfoModel* userInfo = [DataManager userInfo];
                                         [userInfo modifyUserName:userName AndPassword:password AndEmailID:email];
                                         userInfo.userId = response[@"userObj"][@"User"][@"id"];
                                         [self dismissViewControllerAnimated:YES completion:nil];
                                     } else {
                                         //TODO - pop modal with error message from server
                                         NSLog(@"%@ %@", @"Error", response[@"error"]);
                                         [UiModal showModalWithTitle:@"ERROR" message:response[@"error"] buttonTitle:@"OK" viewController:self];
                                         
                                     }
                                 } else {
                                     //TODO - pop modal with error, probably no internet or something along those lines
                                     NSLog(@"%@", error);
                                 }
                            }];
    
}

- (void)textFieldDidChange_UserName{
    if (![self.passwordTextField.text  isEqual: @""] && ![self.userNameTextField.text  isEqual: @""] && ![self.emailIDTextField.text isEqual:@""]) {
        self.doneButton.enabled = YES;
    }else{
        self.doneButton.enabled = NO;
    }
}

- (void)textFieldDidChange_Password{
    if (![self.passwordTextField.text  isEqual: @""] && ![self.userNameTextField.text  isEqual: @""] && ![self.emailIDTextField.text isEqual:@""]) {
        self.doneButton.enabled = YES;
    }else{
        self.doneButton.enabled = NO;
    }

}

- (void)textFieldDidChange_emailID{
    if (![self.passwordTextField.text  isEqual: @""] && ![self.userNameTextField.text  isEqual: @""] && ![self.emailIDTextField.text isEqual:@""]) {
        self.doneButton.enabled = YES;
    }else{
        self.doneButton.enabled = NO;
    }
    
}



-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];// this will do the trick
}

- (void)keyboardDidShow: (NSNotification *) notif{
    CGFloat screenHeight =[[UIScreen mainScreen]bounds].size.height;
    CGFloat height = 0 - 0.25 * screenHeight;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationBeginsFromCurrentState:YES];
    self.view.frame = CGRectMake(self.view.frame.origin.x, height, self.view.frame.size.width, self.view.frame.size.height);
    [UIView commitAnimations];
}

- (void)keyboardDidHide: (NSNotification *) notif{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationBeginsFromCurrentState:YES];
    self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [UIView commitAnimations];

}
- (IBAction)pressNewUserButton:(id)sender {
    NSLog(@"mama");
    RegisterViewController* rg = [[RegisterViewController alloc]init];
    [self presentViewController:rg animated:YES completion:nil];
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
