//
//  PMLViewController.h
//  Toothbrush Timer
//
//  Created by Aaron London on 10/1/13.
//  Copyright (c) 2013 postmechanical. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DACircularProgressView.h"

@class PMLTimerViewController;

@protocol PMLTimerViewControllerDelegate <NSObject>

- (void)timerViewControllerDidFinish:(PMLTimerViewController*)timerViewController;

@end

@interface PMLTimerViewController : UIViewController

@property (weak, nonatomic) id<PMLTimerViewControllerDelegate> delegate;
@property (assign, nonatomic) NSInteger endSeconds;
@property (assign, nonatomic) NSInteger intervalSeconds;
@property (weak, nonatomic) IBOutlet UILabel *activityLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet DACircularProgressView *progressView;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *singleTapRecognizer;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *doubleTapRecognizer;

- (IBAction)tap:(UITapGestureRecognizer*)recognizer;
- (IBAction)doubleTap:(UITapGestureRecognizer*)recognizer;

@end
