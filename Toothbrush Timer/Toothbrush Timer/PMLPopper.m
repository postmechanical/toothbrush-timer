//
//  PMLPopper.m
//  Popper
//
//  Created by Aaron London on 10/1/13.
//  Copyright (c) 2013 postmechanical. All rights reserved.
//

#import "PMLPopper.h"
#import <AVFoundation/AVFoundation.h>

@interface PMLPopper ()

@property(nonatomic,strong) AVAudioPlayer *audioPlayer;

@end

@implementation PMLPopper

#pragma mark - Actions

- (void)pop
{
    AVAudioSession* session = [AVAudioSession sharedInstance];
    NSError* error;

    if (![session setCategory:AVAudioSessionCategoryPlayback error:&error])
    {
        NSLog(@"Couldn't set session category: %@", error);
    }

    if (![session setActive:YES error:&error])
    {
        NSLog(@"Couldn't activate session: %@", error);
    }

    NSURL *soundURL = [[NSBundle mainBundle] URLForResource:@"Pop" withExtension:@"caf"];
    self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundURL error:&error];
    if (!self.audioPlayer)
    {
        NSLog(@"Couldn't init audio player with URL %@: %@", soundURL, error);
    }
    [self.audioPlayer play];
}

@end
