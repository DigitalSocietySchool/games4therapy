//
//  XYZOverviewViewController.h
//  KeepIt
//
//  Created by Medialab_student on 6/11/14.
//  Copyright (c) 2014 Games4Therapy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYZOverviewViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIButton *closeButton;
@property (strong, nonatomic) IBOutlet UIScrollView *childScroller;
@property (strong, nonatomic) IBOutlet UIView *viewHolder;

- (void)setUpConnectionWithParent:(UIViewController *)parent;


@end
