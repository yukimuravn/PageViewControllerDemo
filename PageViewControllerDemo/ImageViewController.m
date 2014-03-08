//
//  ImageViewController.m
//  PageViewControllerDemo
//
//  Created by Nguyễn Mạnh Huy on 3/7/14.
//  Copyright (c) 2014 Nguyễn Mạnh Huy. All rights reserved.
//

#import "ImageViewController.h"

@interface ImageViewController ()
{
    UIButton *clickToStartButton;
}

@end

@implementation ImageViewController
@synthesize imgView = _imgView;
@synthesize index = _index;
@synthesize delegate = _delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.imgView setFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    NSString *imgName = [NSString stringWithFormat:@"img%li",(long)_index];
    [self.imgView setImage:[UIImage imageNamed:imgName]];
    if (_index == 0) {
        [self.imgView setUserInteractionEnabled:YES];
        clickToStartButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [clickToStartButton setFrame:CGRectMake(20, self.imgView.bounds.size.height - 100, 280, 44)];
        [clickToStartButton setBackgroundColor:[UIColor blueColor]];
        [self.imgView addSubview:clickToStartButton];
        [clickToStartButton setTitle:@"Click To Start" forState:UIControlStateNormal];
        [clickToStartButton addTarget:self action:@selector(clickToStartButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    }
    [self.view addSubview:_imgView];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if (!self.imgView) {
        self.imgView = [[UIImageView alloc]init];
    }
    
}

- (void)clickToStartButtonTapped:(UIButton *)clickButton
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(dismissImageViewController:)]) {
        [self.delegate dismissImageViewController:clickButton];
    }
//    if ([clickToStartButton.titleLabel.text isEqualToString:@"Click To Start"]) {
//        [clickToStartButton setTitle:@"Started" forState:UIControlStateNormal];
//    }
//    else {
//        [clickToStartButton setTitle:@"Click To Start" forState:UIControlStateNormal];
//    }
}
         
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
