//
//  PMLViewController.m
//  Toothbrush Timer
//
//  Created by Aaron London on 10/1/13.
//  Copyright (c) 2013 postmechanical. All rights reserved.
//

#import "PMLTimerViewController.h"
#import "PMLPopper.h"

@interface PMLTimerViewController ()

@property(nonatomic,strong) NSTimer *timer;
@property(nonatomic,assign) NSUInteger seconds;
@property(nonatomic,strong) PMLPopper *popper;

@end

@implementation PMLTimerViewController

#pragma mark - View life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.progressView.progressTintColor = self.view.tintColor;
    self.progressView.thicknessRatio = 0.01f;
    self.progressView.progressTintColor = self.view.tintColor;
    [self.singleTapRecognizer requireGestureRecognizerToFail:self.doubleTapRecognizer];
    self.popper = [[PMLPopper alloc] init];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self reset:animated];
}

#pragma mark - Actions

- (IBAction)tap:(UITapGestureRecognizer*)recognizer
{
    [self.timer invalidate];
    self.seconds = 0;
    [UIView animateWithDuration:0.2 animations:^{
        self.activityLabel.alpha = 0.0f;
    }];
    [self.progressView setProgress:0.0f animated:YES];
    [self.popper pop];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(update:) userInfo:nil repeats:YES];
}

- (IBAction)doubleTap:(UITapGestureRecognizer*)recognizer
{
    [self reset:YES];
}

- (void)reset:(BOOL)animated
{
    [self.timer invalidate];
    self.seconds = 0;
    [UIView animateWithDuration:0.2 animations:^{
        self.timeLabel.text = nil;
        self.activityLabel.alpha = 1.0f;
    }];
    [self.progressView setProgress:1.0f animated:animated];
}

- (void)update:(NSTimer*)aTimer
{
    self.seconds += 1;
    self.timeLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)self.seconds];
    [self.progressView setProgress:((CGFloat)self.seconds / (CGFloat)self.endSeconds) animated:NO];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        if (self.intervalSeconds > 0 && self.seconds % self.intervalSeconds == 0)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.popper pop];
                [UIView animateWithDuration:0.2
                                 animations:^{
                                     self.progressView.transform = CGAffineTransformScale(self.progressView.transform, 1.2f, 1.2f);
                                     self.timeLabel.transform = CGAffineTransformScale(self.timeLabel.transform, 1.2f, 1.2f);
                                 }
                                 completion:^(BOOL finished) {
                                     self.progressView.transform = CGAffineTransformIdentity;
                                     self.timeLabel.transform = CGAffineTransformIdentity;
                                 }];
            });
        }
        if (self.seconds == self.endSeconds)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self reset:YES];
                double delayInSeconds = 0.5;
                dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
                dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                    [self.popper pop];
                    if (self.delegate && [self.delegate respondsToSelector:@selector(timerViewControllerDidFinish:)])
                    {
                        [self.delegate timerViewControllerDidFinish:self];
                    }
                });
            });
        }
    });
}

@end
