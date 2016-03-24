//
//  AddNewFoalViewController.m
//  foal score
//
//  Created by Jun on 2/4/16.
//  Copyright © 2016 osu.edu. All rights reserved.
//

#import "AddNewFoalViewController.h"

@interface AddNewFoalViewController ()<UIScrollViewDelegate, UIGestureRecognizerDelegate>

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
@property (weak, nonatomic) IBOutlet UISwitch *dystocia;
@property (weak, nonatomic) IBOutlet UISwitch *survived;
@property (weak, nonatomic) IBOutlet UISwitch *share;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;

@end

@implementation AddNewFoalViewController

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
    
    self.navigationItem.title = @"Add New Foal";
    
    
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
            [self.dystocia setOn:YES animated:YES];
        }else{
            [self.dystocia setOn:NO animated:YES];
        }
        if(foalNeedToModify.survivalUntilDischarge == true){
            [self.survived setOn:YES animated:YES];
        }else{
            [self.survived setOn:NO animated:YES];
        }
    }
    
}

- (IBAction)pressSaveButton:(id)sender {
    
    FoalInfoModel* newFoal = [[FoalInfoModel alloc]initWithName:self.name.text Age:[self.age.text integerValue] Breed:self.breed.text Temperature:[self.temp.text integerValue] RespiratoryRate:[self.rRate.text integerValue] HeartRate:[self.hRate.text integerValue] Sex:@"Colt" Dystocia:self.dystocia.isOn SurvivalUntilDischarge:self.survived.isOn Date:[NSDate date]];
    if(self.sex.selectedSegmentIndex == 0){
        newFoal.sex = @"Colt";
    }else{
        newFoal.sex = @"Filly";
    }
    NSMutableArray* foals = [DataManager foals];
    [foals addObject:newFoal];
    if (self.modify) {
        [foals removeObjectAtIndex:self.indexOfFoalThatNeedToModify];
    }
    [self.navigationController popViewControllerAnimated:YES];
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
