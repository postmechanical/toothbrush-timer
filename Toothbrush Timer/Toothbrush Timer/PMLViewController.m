//
//  PMLViewController.m
//  Toothbrush Timer
//
//  Created by Aaron London on 10/4/13.
//  Copyright (c) 2013 postmechanical. All rights reserved.
//

#import "PMLViewController.h"

@interface PMLViewController ()

@end

@implementation PMLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"embedPageViewController"])
    {
        self.brushViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"BrushViewController"];
        self.brushViewController.endSeconds = 120;
        self.brushViewController.intervalSeconds = 30;
        self.brushViewController.delegate = self;

        self.rinseViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"RinseViewController"];
        self.rinseViewController.endSeconds = 60;
        self.rinseViewController.intervalSeconds = 0;
        self.rinseViewController.delegate = self;

        self.pageViewController = (UIPageViewController*)segue.destinationViewController;
        self.pageViewController.dataSource = self;
        self.pageViewController.delegate = self;
        self.pageViewController.view.backgroundColor = [UIColor whiteColor];
        [self.pageViewController setViewControllers:@[self.brushViewController] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];

    }
}

#pragma mark - UIPageViewControllerDataSource

- (UIViewController*)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    if (viewController == self.brushViewController)
    {
        return self.rinseViewController;
    }
    else
    {
        return nil;
    }
}

- (UIViewController*)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    if (viewController == self.brushViewController)
    {
        return nil;
    }
    else
    {
        return self.brushViewController;
    }
}

#pragma mark - UIPageViewControllerDelegate

#pragma mark - PMLTimerViewControllerDelegate

- (void)timerViewControllerDidFinish:(PMLTimerViewController *)timerViewController
{
    if (timerViewController == self.rinseViewController)
    {
        [self.pageViewController setViewControllers:@[self.brushViewController] direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:nil];
    }
    else
    {
        [self.pageViewController setViewControllers:@[self.rinseViewController] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    }
}

@end
