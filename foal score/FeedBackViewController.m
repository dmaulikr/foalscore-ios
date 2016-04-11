//
//  FeedBackViewController.m
//  foal score
//
//  Created by Jun on 4/10/16.
//  Copyright © 2016 osu.edu. All rights reserved.
//

#import "FeedBackViewController.h"

@interface FeedBackViewController ()
@property (weak, nonatomic) IBOutlet UITextField *feedBackTextField;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;

@end

@implementation FeedBackViewController

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];// this will do the trick
}

- (IBAction)pressSubmit:(id)sender {
    if([DataManager loginOrNot]){
        NSMutableDictionary* dict =[[NSMutableDictionary alloc]init];
        [dict setObject:[DataManager userInfo].userId forKey:@"userId"];
        [dict setObject:self.feedBackTextField.text forKey:@"feedback"];
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [[FoalScoreAFAPIClient sharedClient]userFeedback:dict withCompletitionBlock:^(NSDictionary *response, NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if(response){
                if([response[@"status"] isEqual:@"success"]){
                    [UiModal showModalWithTitle:@"Note" message:@"Feedback has been sent" buttonTitle:@"OK" viewController:self];
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
    [self.feedBackTextField addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingDidEnd];
    self.submitButton.enabled= false;
}

- (void)textFieldDidChange{
    if (![self.feedBackTextField isEqual: @""]){
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
