//
//  RegisterViewController.m
//  foal score
//
//  Created by Jun on 3/24/16.
//  Copyright © 2016 osu.edu. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;
@property (weak, nonatomic) IBOutlet UITextField *emailIDTextField;
@property (nonatomic, copy) UserInfoModel* userInfo;


@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.doneButton.enabled = NO;
    [self.nameTextField addTarget:self action:@selector(textFieldDidChange_Name) forControlEvents:UIControlEventEditingDidEnd];
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
    NSString *name = self.nameTextField.text;
    NSString *password = self.passwordTextField.text;
    NSString *email = self.emailIDTextField.text;
    
    NSMutableDictionary *registrationInfo = [[NSMutableDictionary alloc] init];
    registrationInfo[@"email"] = email;
    registrationInfo[@"name"] = name;
    registrationInfo[@"password"] = password;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[FoalScoreAFAPIClient sharedClient] registerNewUser:registrationInfo withCompletitionBlock:^(NSDictionary *response, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (response) {
            if ([response[@"status"] isEqual: @"success"]) {
                //Save user login status
                UserInfoModel* userInfo = [DataManager userInfo];
                [userInfo modifyUserName:name AndPassword:password AndEmailID:email];
                userInfo.userId = response[@"userObj"][@"User"][@"id"];
                

                [self dismissViewControllerAnimated:YES completion:^{
                    [self.parent dismissViewControllerAnimated:NO completion:nil];
                }];
                
            } else {
                [UiModal showModalWithTitle:@"Unsuccessful Request" message:response[@"error"] buttonTitle:@"OK" viewController:self];
            }
        } else {
            [UiModal showModalWithTitle:@"Network Error" message:[error localizedDescription] buttonTitle:@"OK" viewController:self];        }
    }];
}

- (void)textFieldDidChange_Name{
    if (![self.passwordTextField.text  isEqual: @""] && ![self.nameTextField.text  isEqual: @""] && ![self.emailIDTextField.text isEqual:@""]) {
        self.doneButton.enabled = YES;
    }else{
        self.doneButton.enabled = NO;
    }
}

- (void)textFieldDidChange_Password{
    if (![self.passwordTextField.text  isEqual: @""] && ![self.nameTextField.text  isEqual: @""] && ![self.emailIDTextField.text isEqual:@""]) {
        self.doneButton.enabled = YES;
    }else{
        self.doneButton.enabled = NO;
    }
    
}

- (void)textFieldDidChange_emailID{
    if (![self.passwordTextField.text  isEqual: @""] && ![self.nameTextField.text  isEqual: @""] && ![self.emailIDTextField.text isEqual:@""]) {
        self.doneButton.enabled = YES;
    }else{
        self.doneButton.enabled = NO;
    }
    
}



-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];// this will do the trick
}

- (void)keyboardDidShow: (NSNotification *) notif{
    // TODO
}

- (void)keyboardDidHide: (NSNotification *) notif{
    // TODO
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
