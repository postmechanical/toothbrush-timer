//
//  PMLViewController.h
//  Toothbrush Timer
//
//  Created by Aaron London on 10/4/13.
//  Copyright (c) 2013 postmechanical. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PMLTimerViewController.h"

@interface PMLViewController : UIViewController <UIPageViewControllerDataSource, UIPageViewControllerDelegate>

@property(nonatomic,strong) IBOutlet UIPageViewController *pageViewController;

@property(nonatomic,strong) IBOutlet PMLTimerViewController *brushViewController;
@property(nonatomic,strong) IBOutlet PMLTimerViewController *rinseViewController;

@end
