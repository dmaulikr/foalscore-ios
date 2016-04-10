//
//  ChangePasswordViewController.m
//  foal score
//
//  Created by Jun on 4/10/16.
//  Copyright © 2016 osu.edu. All rights reserved.
//

#import "ChangePasswordViewController.h"

@interface ChangePasswordViewController ()
@property (weak, nonatomic) IBOutlet UITextField *currentPTextField;
@property (weak, nonatomic) IBOutlet UITextField *PTextField;
@property (weak, nonatomic) IBOutlet UITextField *confirmPTextField;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;

@end

@implementation ChangePasswordViewController
- (IBAction)pressCancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)pressSubmit:(id)sender {
    BOOL isCurrentNotEmpty = NO;
    BOOL isNewNotEmpty = NO;
    BOOL isNotDifferent = NO;
    if(![self.currentPTextField.text isEqual:@""]){
        isCurrentNotEmpty = YES;
    }
    if(![self.PTextField.text isEqual:@""]){
        isNewNotEmpty = YES;
    }
    if([self.PTextField.text isEqual:self.confirmPTextField.text]){
        isNotDifferent = YES;
    }
    if(isNotDifferent && isCurrentNotEmpty && isNewNotEmpty){
        if([DataManager loginOrNot]){
            NSMutableDictionary* dict =[[NSMutableDictionary alloc]init];
            [dict setObject:[DataManager userInfo].email forKey:@"email"];
            [dict setObject:self.currentPTextField.text forKey:@"oldPassword"];
            [dict setObject:self.PTextField.text forKey:@"newPassword"];
            [[FoalScoreAFAPIClient sharedClient]changePassword:dict withCompletitionBlock:^(NSDictionary *response, NSError *error) {
                if(response){
                    if([response[@"status"] isEqual:@"success"]){
                        [UiModal showModalWithTitle:@"Note" message:@"Password changed successfully" buttonTitle:@"OK" viewController:self];
                    } else {
                        [UiModal showModalWithTitle:@"Error" message:response[@"error"] buttonTitle:@"OK" viewController:self];
                    }
                } else{
                    [UiModal showModalWithTitle:@"Error" message:[error localizedDescription] buttonTitle:@"OK" viewController:self];
                }}];
            
        }else{
            [UiModal showModalWithTitle:@"Note" message:@"Login to view synced foals" buttonTitle:@"OK" viewController:self];
        }

    }else if(!isCurrentNotEmpty){
        [UiModal showModalWithTitle:@"Error" message:@"Current password should not be empty" buttonTitle:@"OK" viewController:self];
    }else if(!isNewNotEmpty){
        [UiModal showModalWithTitle:@"Error" message:@"New password should not be empty" buttonTitle:@"OK" viewController:self];
    }else{
        [UiModal showModalWithTitle:@"Error" message:@"Confirmation password doesn't match " buttonTitle:@"OK" viewController:self];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];// this will do the trick
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
