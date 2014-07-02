//
//  XYZnoteOverviewViewController.h
//  KeepIt
//
//  Created by Medialab_student on 6/5/14.
//  Copyright (c) 2014 Games4Therapy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYZStoryPart.h"
#import "MSLabel.h"
#import "XYZBuildStoryViewController.h"

@interface XYZnoteOverviewViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIView *noteViewHolder;
@property (strong, nonatomic) IBOutlet UIScrollView* scrollview;
@property (strong, nonatomic) NSMutableArray* listQuestions;

- (void)fillNoteList:(NSMutableArray*)listOfQuestions;
- (void)testMethod;

@end
