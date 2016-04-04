//
//  OverviewPage.m
//  foal score
//
//  Created by Jun on 4/3/16.
//  Copyright © 2016 osu.edu. All rights reserved.
//

#import "OverviewPage.h"


@interface OverviewPage ()

@property (strong, nonatomic) IBOutlet UIView *v;

@property (weak, nonatomic) IBOutlet UIWebView *webview;

@end

@implementation OverviewPage

- (void)viewDidLoad {
    self.v.backgroundColor = [UIColor whiteColor];
    CGSize size = [UIScreen mainScreen].bounds.size;
    CGRect fullsize =CGRectMake(0, 0, size.width, size.height);
    self.v.frame = fullsize;
    [self.navigationItem setTitle:self.NVtitle];
    [super viewDidLoad];
    [self.webview loadHTMLString:self.text baseURL:nil];
    self.webview.opaque = NO;
    self.webview.backgroundColor = [UIColor clearColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
