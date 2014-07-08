//
//  StoryPartButton.m
//  KeepIt
//
//  Created by Medialab_student on 6/3/14.
//  Copyright (c) 2014 Games4Therapy. All rights reserved.
//

#import "StoryPartButton.h"

@implementation StoryPartButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.opaque = NO;
        self.backgroundColor = [UIColor clearColor];
        [self setAlpha:0];
        [self setHidden:true];
    }
    return self;
}




@end
