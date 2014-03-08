//
//  PageViewViewController.h
//  PageViewControllerDemo
//
//  Created by Nguyễn Mạnh Huy on 3/7/14.
//  Copyright (c) 2014 Nguyễn Mạnh Huy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageViewController.h"

@interface PageViewViewController : UIViewController <UIPageViewControllerDataSource, UIPageViewControllerDelegate,ImageViewControllerDelegate>

@property (nonatomic, strong) UIPageViewController *pageVC;
@property (nonatomic, strong) UIPageControl *pageControl;

@end
