//
//  XYZstoryOverviewTableViewCell.m
//  KeepIt
//
//  Created by Medialab_student on 6/16/14.
//  Copyright (c) 2014 Games4Therapy. All rights reserved.
//

#import "XYZstoryOverviewTableViewCell.h"

@implementation XYZstoryOverviewTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)willTransitionToState:(UITableViewCellStateMask)state
{
    [super willTransitionToState:state];
 
    //TODO CREATE CUSTOM BUTTON ON SWIPE
    /*   if ((state & UITableViewCellStateShowingDeleteConfirmationMask) == UITableViewCellStateShowingDeleteConfirmationMask)
    {
        for (UIView *subview in self.subviews) {
            for (UIView *subview2 in subview.subviews) {
               if ([NSStringFromClass([subview2 class]) rangeOfString:@"DELETE"].location != NSNotFound) {
                    UIImageView *deleteBtn = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 64, 33)];
                    [deleteBtn setImage:[UIImage imageNamed:@"icon_close.png"]];
                    [[subview.subviews objectAtIndex:0] addSubview:deleteBtn];
                }
            }
        }
    }
  */
}

@end