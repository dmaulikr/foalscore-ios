//
//  ReferViewController.m
//  foal score
//
//  Created by Jun on 4/10/16.
//  Copyright © 2016 osu.edu. All rights reserved.
//

#import "ReferViewController.h"

@interface ReferViewController ()
@property (weak, nonatomic) IBOutlet UITextField *emailIDTextField;
@property (weak, nonatomic) IBOutlet UIButton *referButton;

@end

@implementation ReferViewController

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];// this will do the trick
}

- (IBAction)pressRefer:(id)sender {
    if([DataManager loginOrNot]){
        NSMutableDictionary* dict =[[NSMutableDictionary alloc]init];
        [dict setObject:[DataManager userInfo].userId forKey:@"userId"];
        [dict setObject:self.emailIDTextField.text forKey:@"referredEmail"];
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [[FoalScoreAFAPIClient sharedClient]referUser:dict withCompletitionBlock:^(NSDictionary *response, NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if(response){
                if([response[@"status"] isEqual:@"success"]){
                    [UiModal showModalWithTitle:@"Note" message:@"Referral email has been sent" buttonTitle:@"OK" viewController:self];
                } else {
                    [UiModal showModalWithTitle:@"Error" message:response[@"error"] buttonTitle:@"OK" viewController:self];
                }
            } else{
                [UiModal showModalWithTitle:@"Error" message:[error localizedDescription] buttonTitle:@"OK" viewController:self];
            }}];
        
    }else{
        [UiModal showModalWithTitle:@"Note" message:@"Login to view synced foals" buttonTitle:@"OK" viewController:self];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.emailIDTextField addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingDidEnd];
    self.referButton.enabled = false;
}

- (void)textFieldDidChange{
    if (![self.emailIDTextField isEqual: @""]){
        self.referButton.enabled = YES;
    }else{
        self.referButton.enabled = NO;
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
