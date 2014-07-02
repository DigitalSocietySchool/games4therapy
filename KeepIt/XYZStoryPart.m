//
//  XYZStoryPart.m
//  KeepIt
//
//  Created by Medialab_student on 6/2/14.
//  Copyright (c) 2014 Games4Therapy. All rights reserved.
//

#import "XYZStoryPart.h"

@implementation XYZStoryPart

-(id)init {
    if (self = [super init])  {
        self.isDone = false;
        self.type = 0;
        self.question = @"Error! No question found!";
        self.answer = @"Enter Answer Here";
        self.positivityMeter = 50;
        self.listPickerQuestions = [[NSMutableArray alloc] init];
        self.isMoodQuestion = false;
        self.title = @"No Title";
    }
    return self;
}

@end
