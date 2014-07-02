//
//  XYZMainScreenViewController.h
//  KeepIt
//
//  Created by Medialab_student on 5/28/14.
//  Copyright (c) 2014 Games4Therapy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYZBuildStoryViewController.h"
#import "XYZStoryOverviewTableViewController.h"

@interface XYZMainScreenViewController : UIViewController

- (IBAction)unwindToListFromStoryPart:(UIStoryboardSegue *)segue;
- (IBAction)unwindToListFromOverview:(UIStoryboardSegue *)segue;
- (IBAction)unwindToListFromSettings:(UIStoryboardSegue *)segue;
- (IBAction)unwindToMainMenuDoingNothing:(UIStoryboardSegue *)segue;
@property (strong, nonatomic) NSMutableArray* listOfStories;
@property (weak, nonatomic) IBOutlet UIImageView *howItWorks;
@property (weak, nonatomic) IBOutlet UIButton *closeHowItWorks;
@property (strong, nonatomic) NSMutableArray* categoryHolder;
@property (strong,nonatomic) NSMutableString* storyTitle;
@property (nonatomic, assign) id currentResponder;

@end
