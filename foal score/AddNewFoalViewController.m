//
//  AddNewFoalViewController.m
//  foal score
//
//  Created by Jun on 2/4/16.
//  Copyright © 2016 osu.edu. All rights reserved.
//

#import "AddNewFoalViewController.h"

@interface AddNewFoalViewController ()<UIScrollViewDelegate, UIGestureRecognizerDelegate, UIAlertViewDelegate>

@property (nonatomic, assign) NSInteger indexOfFoalThatNeedToModify;
@property (nonatomic, assign) BOOL modify;

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
// some inclass variables
@property (strong, nonatomic) IBOutlet UIView *scrollContent;

@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *age;
@property (weak, nonatomic) IBOutlet UITextField *breed;
@property (weak, nonatomic) IBOutlet UITextField *temp;
@property (weak, nonatomic) IBOutlet UITextField *rRate;
@property (weak, nonatomic) IBOutlet UITextField *hRate;
@property (weak, nonatomic) IBOutlet UISegmentedControl *sex;
@property (weak, nonatomic) IBOutlet UISegmentedControl *dystocia;
@property (weak, nonatomic) IBOutlet UISegmentedControl *survived;
@property (weak, nonatomic) IBOutlet UISwitch *share;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;

@end

@implementation AddNewFoalViewController
- (instancetype)init{
    self = [super init];
    if(self){
        self.fromBarButton = false;
    }
    return self;
}
- (void)viewDidLoad {
    // Do any additional setup after loading the view from its nib.
    // load UiSrollViewController
    
    self.scrollView.delegate = self;
    
    CGRect newFrame = self.scrollContent.frame;
    newFrame.size.width = [UIScreen mainScreen].bounds.size.width;
    [self.scrollContent setFrame:newFrame];
    
    self.scrollView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.scrollContent];
    self.scrollView.contentSize = self.scrollContent.frame.size;
    if(self.modify){
        self.navigationItem.title = @"Edit Foal";
    }else{
        self.navigationItem.title = @"Add New Foal";
    }
    
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideTheKeyBoard:)];
    gestureRecognizer.delegate = self;
    [self.scrollView addGestureRecognizer:gestureRecognizer];
    
    
    [self.name addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingDidEnd];
    [self.age addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingDidEnd];
    [self.breed addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingDidEnd];
    [self.temp addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingDidEnd];
    [self.rRate addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingDidEnd];
    [self.hRate addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingDidEnd];
    
    // Take info
    self.saveButton.enabled = NO;
    if (self.modify) {
        self.saveButton.enabled = YES;
        NSMutableArray* foals = [DataManager foals];
        //First read that foal info
        FoalInfoModel* foalNeedToModify = [foals objectAtIndex:self.indexOfFoalThatNeedToModify];
        //[foals removeObjectAtIndex:self.indexOfFoalThatNeedToModify];
        //put info into text fields
        self.name.text = foalNeedToModify.name;
        self.age.text = [@(foalNeedToModify.age) stringValue];
        self.breed.text = foalNeedToModify.breed;
        self.temp.text = [@(foalNeedToModify.temperature) stringValue];
        self.rRate.text = [@(foalNeedToModify.respiratoryRate) stringValue];
        self.hRate.text = [@(foalNeedToModify.heartRate) stringValue];
        if([foalNeedToModify.sex isEqual: @"Colt"]){
            self.sex.selectedSegmentIndex = 0;
            [self.sex sendActionsForControlEvents:UIControlEventValueChanged];
        }else{
            self.sex.selectedSegmentIndex = 1;
            [self.sex sendActionsForControlEvents:UIControlEventValueChanged];
        }
        if(foalNeedToModify.dystocia == true){
            self.dystocia.selectedSegmentIndex = 0;
            [self.dystocia sendActionsForControlEvents:UIControlEventValueChanged];
        }else{
            self.dystocia.selectedSegmentIndex = 1;
            [self.dystocia sendActionsForControlEvents:UIControlEventValueChanged];
        }
        if(foalNeedToModify.survivalUntilDischarge == true){
            self.survived.selectedSegmentIndex = 0;
            [self.survived sendActionsForControlEvents:UIControlEventValueChanged];
        }else{
            self.survived.selectedSegmentIndex = 1;
            [self.survived sendActionsForControlEvents:UIControlEventValueChanged];        }
    }
    
}

- (IBAction)pressSaveButton:(id)sender {
    
    FoalInfoModel* newFoal = [[FoalInfoModel alloc]initWithName:self.name.text Age:[self.age.text integerValue] Breed:self.breed.text Temperature:[self.temp.text integerValue] RespiratoryRate:[self.rRate.text integerValue] HeartRate:[self.hRate.text integerValue] Sex:@"Colt" Dystocia:YES SurvivalUntilDischarge:YES Date:[NSDate date]];
    if(self.sex.selectedSegmentIndex == 0){
        newFoal.sex = @"Colt";
    }else{
        newFoal.sex = @"Filly";
    }
    if(self.dystocia.selectedSegmentIndex ==1){
        newFoal.dystocia = NO;
    }
    if(self.survived.selectedSegmentIndex ==1){
        newFoal.survivalUntilDischarge = NO;
    }
    NSMutableArray* foals = [DataManager foals];
    if (self.modify) {
            FoalInfoModel* foal = [DataManager foals][self.indexOfFoalThatNeedToModify];
            if([foal foalId]){
                if([DataManager loginOrNot]){
                    NSMutableDictionary* dict = [[NSMutableDictionary alloc]init];
                    [dict setObject:self.name.text forKey:@"name"];
                    [dict setObject:self.age.text forKey:@"ageMonths"];
                    if (self.sex.selectedSegmentIndex == 0) {
                        [dict setObject:@"Colt" forKey:@"gender"];
                    }else{
                        [dict setObject:@"Filly" forKey:@"gender"];
                    }
                    
                    [dict setObject:self.breed.text forKey:@"breed"];
                    [dict setObject:self.temp.text forKey:@"temperature"];
                    [dict setObject:self.rRate.text forKey:@"respiratoryRate"];
                    [dict setObject:self.hRate.text forKey:@"heartRate"];
                    
                    if (self.dystocia.selectedSegmentIndex == 0) {
                        [dict setObject:@"Yes" forKey:@"dystocia"];
                    }else{
                        [dict setObject:@"No" forKey:@"dystocia"];
                    }
                    if(self.survived.selectedSegmentIndex == 0){
                        [dict setObject:@"Yes" forKey:@"survivedUntilHospitalDischarge"];
                    }else{
                        [dict setObject:@"No" forKey:@"survivedUntilHospitalDischarge"];
                    }
                    [dict setObject:[DataManager userInfo].userId forKey:@"userId"];
                    if (self.share.isOn==YES) {
                        [dict setObject:@(1) forKey:@"allowShare"];
                    } else {
                        [dict setObject:@(0) forKey:@"allowShare"];
                    }
                    [dict setObject:[foal foalId] forKey:@"foalid"];
                    // send request
                    FoalScoreAFAPIClient* client = [FoalScoreAFAPIClient sharedClient];
                    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                    [client editFoal:dict withCompletitionBlock:^(NSDictionary *response, NSError *error) {
                        [MBProgressHUD hideHUDForView:self.view animated:YES];
                        if(response) {
                            if([response[@"status"] isEqual: @"success"]) {
                                NSString* foalId = response[@"foalid"];
                                [newFoal setFoalId:foalId];
                                [[DataManager foals] addObject:newFoal];
                                [foals removeObjectAtIndex:self.indexOfFoalThatNeedToModify];
                                if (self.fromBarButton) {
                                    [self.navigationController popToRootViewControllerAnimated:YES];
                                }else{
                                    [self.navigationController popViewControllerAnimated:YES];
                                }
                            } else {
                                [UiModal showModalWithTitle:@"Unsuccessful Request" message:response[@"error"] buttonTitle:@"OK" viewController:self];
                            }
                        } else {
                            [UiModal showModalWithTitle:@"Network Error" message:[error localizedDescription] buttonTitle:@"OK" viewController:self];
                        }
                    }];
                    
                }else{
                    [UiModal showModalWithTitle:@"ERROR" message:@"Please log in first!" buttonTitle:@"OK" viewController:self];
                }

        }
    }
    
    // build dictionary
    if(!self.modify){
        if([DataManager loginOrNot]){
            NSMutableDictionary* dict = [[NSMutableDictionary alloc]init];
            [dict setObject:self.name.text forKey:@"name"];
            [dict setObject:self.age.text forKey:@"ageMonths"];
            [dict setObject:newFoal.sex forKey:@"gender"];
            [dict setObject:self.breed.text forKey:@"breed"];
            [dict setObject:self.temp.text forKey:@"temperature"];
            [dict setObject:self.rRate.text forKey:@"respiratoryRate"];
            [dict setObject:self.hRate.text forKey:@"heartRate"];
            
            if (self.dystocia.selectedSegmentIndex == 0) {
                [dict setObject:@"Yes" forKey:@"dystocia"];
            }else{
                [dict setObject:@"No" forKey:@"dystocia"];
            }
            if(self.survived.selectedSegmentIndex == 0){
                [dict setObject:@"Yes" forKey:@"survivedUntilHospitalDischarge"];
            }else{
                [dict setObject:@"No" forKey:@"survivedUntilHospitalDischarge"];
            }
            [dict setObject:[DataManager userInfo].userId forKey:@"userId"];
            if (self.share.isOn==YES) {
                [dict setObject:@(1) forKey:@"allowShare"];
            } else {
                [dict setObject:@(0) forKey:@"allowShare"];
            }
            // send request
            FoalScoreAFAPIClient* client = [FoalScoreAFAPIClient sharedClient];
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            [client addFoal:dict withCompletitionBlock:^(NSDictionary *response, NSError *error) {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                if(response) {
                    if([response[@"status"] isEqual: @"success"]) {
                        NSString* foalId = response[@"foalid"];
                        [newFoal setFoalId:foalId];
                        [foals addObject:newFoal];
                        
                        [self.navigationController popViewControllerAnimated:YES];
                    } else {
                        [UiModal showModalWithTitle:@"Unsuccessful Request" message:response[@"error"] buttonTitle:@"OK" viewController:self];
                    }
                } else {
                    [UiModal showModalWithTitle:@"Network Error" message:[error localizedDescription] buttonTitle:@"OK" viewController:self];
                }
            }];
            
        }else{
            [UiModal showModalWithTitle:@"ERROR" message:@"Please log in first!" buttonTitle:@"OK" viewController:self];
        }
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (instancetype)initWithAnIndexOfFoalThatNeedToModify:(NSInteger)index ModifyOrNot:(BOOL)modify{
    if (self = [super init]) {
        _indexOfFoalThatNeedToModify = index;
        _modify = modify;
    }
    return self;
}

- (void)textFieldDidChange{
    if (![self.name.text  isEqual: @""] && ![self.age.text  isEqual: @""] && ![self.breed.text isEqual:@""]&& ![self.temp.text isEqual:@""]&& ![self.rRate.text isEqual:@""]&& ![self.hRate.text isEqual:@""]) {
        self.saveButton.enabled = YES;
    }else{
        self.saveButton.enabled = NO;
    }
}

-(void) hideTheKeyBoard:(UIGestureRecognizer *)sender
{
    [self.view endEditing:YES];
}

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if(buttonIndex == 0) {
        //[self.navigationController popViewControllerAnimated:YES];
    }
}
- (IBAction)pressShareInfo:(id)sender {
    [UiModal showModalWithTitle:@"Note" message:@"The FoalScore App offers an option to share data with The Ohio State University that will be used for future studies. If shared, data from this App will ONLY be used for research purposes and it will not reveal personal information from its users. User information is not required to use this App." buttonTitle:@"OK" viewController:self];
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
