//
//  XYZStoryPart.h
//  KeepIt
//
//  Created by Medialab_student on 6/2/14.
//  Copyright (c) 2014 Games4Therapy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XYZStoryPart : NSObject
@property NSString *question;
@property NSString *answer;
@property int positivityMeter;
@property BOOL isDone;
@property BOOL isMoodQuestion;

//0 is open answer, 1 is yes/no, 2 is slider.
@property int type;

@property NSString* title; 

@property NSMutableArray *listPickerQuestions;
@end
