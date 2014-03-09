//
//  PageViewViewController.m
//  PageViewControllerDemo
//
//  Created by Nguyễn Mạnh Huy on 3/7/14.
//  Copyright (c) 2014 Nguyễn Mạnh Huy. All rights reserved.
//

#import "PageViewViewController.h"

@interface PageViewViewController ()
{
    NSMutableArray *pageVC_Array;
    ImageViewController *imgVC;
}

@end

@implementation PageViewViewController
@synthesize pageControl = _pageControl;
@synthesize pageVC = _pageVC;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    if (!self.pageVC) {
        self.pageVC = [[UIPageViewController alloc]initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
        [self.pageVC.view setBackgroundColor:[UIColor lightGrayColor]];
        [self.pageVC.view setFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
        self.pageVC.delegate = self;
        self.pageVC.dataSource = self;
    }
    
    [self createPageControl];
    
    if (!imgVC) {
//        imgVC = [[ImageViewController alloc]initWithNibName:@"ImageViewController" bundle:nil];
        imgVC = [self viewControllerAtIndex:0];
    }
    
    if (!pageVC_Array) {
        pageVC_Array = [[NSMutableArray alloc]initWithObjects:imgVC, nil];
    }
    
    [self.pageVC setViewControllers:pageVC_Array direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    [self addChildViewController:self.pageVC];
    [self.view addSubview:self.pageVC.view];
    [self.pageVC didMoveToParentViewController:self];
    
}

- (void)createPageControl
{
    self.pageControl = [[UIPageControl alloc]init];
    [self.pageControl setFrame:CGRectMake(self.pageVC.view.bounds.size.width/2, self.pageVC.view.bounds.size.height - 30, 0, 0)];
    [self.pageControl setNumberOfPages:6];
    [self.pageControl setCurrentPage:0];
    [self.pageControl setCurrentPageIndicatorTintColor:[UIColor redColor]];
    [self.pageControl setPageIndicatorTintColor:[UIColor whiteColor]];
    [self.pageVC.view addSubview:self.pageControl];
}

- (ImageViewController *)viewControllerAtIndex:(NSUInteger)index
{
    ImageViewController *imgVC_Index = [[ImageViewController alloc]initWithNibName:@"ImageViewController" bundle:nil];
    [imgVC_Index.view setFrame:_pageVC.view.frame];
    imgVC_Index.index = index;
    if (index == 0) {
        imgVC_Index.delegate = self;
    }
    
    return imgVC_Index;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dismissImageViewController:(UIButton *)button
{
    [self.pageVC.view removeFromSuperview];
    
    //Zoom out Animation
//    MainViewController *mainVC = [[MainViewController alloc]initWithNibName:@"MainViewController" bundle:nil];
//    [mainVC.view setFrame:CGRectMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2, 0, 0)];
//    [self.view addSubview:mainVC.view];
//    [UIView beginAnimations:@"Zoom" context:nil];
//    [UIView setAnimationDuration:1.0f];
//    [mainVC.view setFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
//    [UIView commitAnimations];
    
    //Fade Animation
    MainViewController *mainVC = [[MainViewController alloc]initWithNibName:@"MainViewController" bundle:nil];
    [mainVC.view setFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    [mainVC.view setAlpha:0.0f];
    [self.view addSubview:mainVC.view];
    [UIView beginAnimations:@"Fade" context:nil];
    [UIView setAnimationDuration:1.5f];
    [mainVC.view setAlpha:1.0f];
    [UIView commitAnimations];
    
//    [UIView animateWithDuration:2.0f
//                          delay:0.5
//                        options: UIViewAnimationOptionCurveLinear
//                     animations:^{
//                         MainViewController *mainVC = [[MainViewController alloc]initWithNibName:@"MainViewController" bundle:nil];
//                         [mainVC.view setFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
//                         [self.view addSubview:mainVC.view];
//                     }
//                     completion:^(BOOL finished){
//                         NSLog(@"Animation Done!");
//                     }];
}

#pragma mark - UIPageViewController Delegate
-(void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed
{
//    NSLog(@"%i",self.pageControl.currentPage);
}

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = [(ImageViewController *)viewController index];
    index++;
    if (index == 6) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = [(ImageViewController *)viewController index];    
    if (index == 0) {
        return nil;
    }
    index--;
    return [self viewControllerAtIndex:index];
}

-(void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray *)pendingViewControllers
{
    if ([pendingViewControllers count] > 0) {
        NSInteger pageIndex = [(ImageViewController *)[pendingViewControllers objectAtIndex:0] index];
        [self.pageControl setCurrentPage:pageIndex];
    }
}

//-(NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
//{
//    return 5;
//}
//
//-(NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
//{
//    return 0;
//}

@end
