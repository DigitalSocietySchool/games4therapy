//
//  XYZBuildStoryViewController.h
//  KeepIt
//
//  Created by Medialab_student on 6/2/14.
//  Copyright (c) 2014 Games4Therapy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoryPartButton.h"
#import "XYZStoryPart.h"
#import "XYZnoteOverviewViewController.h"
#import "XYZStoryPartListViewController.h"

@interface XYZBuildStoryViewController : UIViewController<UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UIScrollViewDelegate>{
    IBOutlet UIScrollView *scroller;
    IBOutlet UIScrollView *noteScroller;
    
}
@property bool storyFinished;
@property (strong, nonatomic) IBOutlet UIView *viewItem;
@property (weak, nonatomic) IBOutlet UIScrollView *childScroller;

@property (weak, nonatomic) IBOutlet UIButton *createButton;
@property (weak, nonatomic) IBOutlet UILabel *createLabel;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (weak, nonatomic) IBOutlet UIButton *editButton;
@property (weak, nonatomic) IBOutlet UIImageView *topGreen;

@property (strong, nonatomic) UIImageView *currentImage;
@property (strong, nonatomic) UISlider *currentSlider;

@property (weak, nonatomic) IBOutlet UITextField *storyNameTextField;
@property (nonatomic, assign) id currentResponder;
@property (weak, nonatomic) IBOutlet UIView *containerView;
- (void)toggleBlack;
@property (strong, nonatomic) NSArray *pickerViewArray;

@property (weak, nonatomic) IBOutlet UIButton *noteButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *acceptButton;

@property (weak, nonatomic) IBOutlet UIView *allNoteView;
@property (weak, nonatomic) IBOutlet UIView *storyPartView;

@property (weak, nonatomic) IBOutlet UIImageView *content_OverviewImage;
@property (weak, nonatomic) IBOutlet UIScrollView *content_scrollview;

@property (weak, nonatomic) IBOutlet UIScrollView *basicScrollerView;

@property (strong, nonatomic) XYZStoryPart *currentPart;
@property (weak, nonatomic) IBOutlet UIButton *acceptEditButton;

@property (weak, nonatomic) IBOutlet UIView *noteContainerView;
@property int currentHeight;
@property (weak, nonatomic) IBOutlet UITextField *storyTitle;

@property (strong,nonatomic) NSMutableString* storyTitleHolder;
@property bool shouldBeSaved;

- (void)showSaveScreen;

@property NSMutableArray* listQuestions;
- (void)createNewStoryPartButton:(XYZStoryPart *)storyPart;
- (void)closeNoteOverview; 
- (void)yelpMethod;
- (void)noteButtonClicked;
- (void)setBackgroundColor:(int) value;

@property NSMutableArray* categoryHolder;

@end
