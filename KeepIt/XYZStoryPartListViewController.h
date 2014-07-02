//
//  XYZStoryPartListViewController.h
//  KeepIt
//
//  Created by Medialab_student on 6/10/14.
//  Copyright (c) 2014 Games4Therapy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYZStoryPart.h"
#import "XYZBuildStoryViewController.h"

@interface XYZStoryPartListViewController : UIViewController<UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, assign) id currentResponder;
@property (strong, nonatomic) NSMutableArray* listOfParts;
@property int currentTrack;
@property int trackCount;

@property BOOL currentStoryFinished;
@property bool firstTimeOne;
@property bool firstTimeTwelve;
@property bool firstTimeFourteen;
@property bool firstTimeSeventeen;
@property bool firstTimeNineteen;
@property bool firstTimeTwentyOne;
@property bool firstTimeTwentyTwo;
@property bool firstTimeTwentyThree;
@property bool quickRouteToFinish;

@property (strong, nonatomic) NSMutableArray* categoryHolder;

- (void)generateNextQuestionAnswer:(int)type;
- (void)generateNextQuestionAnswer:(int)type :(NSString*)type;
-(void)setUpConnectionWithParent:(UIViewController *) parent;
- (void)generateMessage;
- (void)generateMessage:(NSString*)message;
- (void)showOverview:(NSString*)message;
- (void)showOverview;

@end
