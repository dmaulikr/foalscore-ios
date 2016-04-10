//
//  ForgotPasswordViewController.m
//  foal score
//
//  Created by Jun on 4/10/16.
//  Copyright © 2016 osu.edu. All rights reserved.
//

#import "ForgotPasswordViewController.h"

@interface ForgotPasswordViewController ()
@property (weak, nonatomic) IBOutlet UITextField *emailIDTextField;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;

@end

@implementation ForgotPasswordViewController

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];// this will do the trick
}
- (IBAction)pressCancelButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)pressSubmit:(id)sender {
        NSMutableDictionary* dict =[[NSMutableDictionary alloc]init];
        [dict setObject:self.emailIDTextField.text forKey:@"email"];
        [[FoalScoreAFAPIClient sharedClient]forgotPassword:dict withCompletitionBlock:^(NSDictionary *response, NSError *error) {
            if(response){
                if([response[@"status"] isEqual:@"success"]){
                    [UiModal showModalWithTitle:@"Note" message:@"Check your email for new password" buttonTitle:@"OK" viewController:self];
                } else {
                    [UiModal showModalWithTitle:@"Error" message:response[@"error"] buttonTitle:@"OK" viewController:self];
                }
            } else{
                [UiModal showModalWithTitle:@"Error" message:[error localizedDescription] buttonTitle:@"OK" viewController:self];
            }}];
        
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.emailIDTextField addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingDidEnd];
    self.submitButton.enabled= false;
}

- (void)textFieldDidChange{
    if (![self.emailIDTextField isEqual: @""]){
        self.submitButton.enabled = YES;
    }else{
        self.submitButton.enabled = NO;
    }
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
