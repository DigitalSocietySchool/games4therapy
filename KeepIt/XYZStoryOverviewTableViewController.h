//
//  XYZStoryOverviewTableViewController.h
//  KeepIt
//
//  Created by Medialab_student on 6/10/14.
//  Copyright (c) 2014 Games4Therapy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYZStoryOverviewTableViewController : UITableViewController

@property (strong, nonatomic) NSMutableArray* listOfStories;
@property (strong, nonatomic) NSMutableArray* currentStory;

-(void)setUpConnectionWithParent:(UIViewController *) parent;
- (void)loadInitialData;
- (IBAction)unwindToList:(UIStoryboardSegue *)segue;

@end