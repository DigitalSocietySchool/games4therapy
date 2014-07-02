//
//  XYZsettingsScreenViewController.h
//  KeepIt
//
//  Created by Medialab_student on 6/11/14.
//  Copyright (c) 2014 Games4Therapy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYZsettingsScreenViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSMutableArray* categoryHolder;
- (IBAction)unwindToSettings:(UIStoryboardSegue *)segue;
- (void)setUpConnectionWithParent:(UIViewController*)parent;

@end
