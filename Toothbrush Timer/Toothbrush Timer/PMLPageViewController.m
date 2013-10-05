//
//  PMLPageViewController.m
//  Toothbrush Timer
//
//  Created by Aaron London on 10/4/13.
//  Copyright (c) 2013 postmechanical. All rights reserved.
//

#import "PMLPageViewController.h"

@implementation PMLPageViewController

- (void)awakeFromNib
{
    [super awakeFromNib];

    self.dataSource = self;
    self.delegate = self;
}

@end
