//
//  XYZOverviewViewController.m
//  KeepIt
//
//  Created by Medialab_student on 6/11/14.
//  Copyright (c) 2014 Games4Therapy. All rights reserved.
//

#import "XYZOverviewViewController.h"
#import "XYZStoryPart.h"
#import "XYZStoryOverviewTableViewController.h"

@interface XYZOverviewViewController ()
@property (strong, nonatomic) NSMutableArray* listQuestions;
@property (strong, nonatomic) XYZStoryOverviewTableViewController* parentController;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@end

@implementation XYZOverviewViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (IBAction)closeButtonClicked:(id)sender {
//    [self performSegueWithIdentifier:@"goBackToStoryListSegue" sender:sender];
}

- (void)setUpConnectionWithParent:(XYZStoryOverviewTableViewController *)parent{
    _parentController = parent;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _childScroller=[[UIScrollView alloc]initWithFrame:CGRectMake(0,77,320,364)];
    _childScroller.showsVerticalScrollIndicator=YES;
    _childScroller.scrollEnabled=YES;
    _childScroller.userInteractionEnabled=YES;
    _childScroller.contentSize = CGSizeMake(240,900);
    _childScroller.layer.zPosition = MAXFLOAT;
    [_viewHolder addSubview:_childScroller];
    _listQuestions = [[NSMutableArray alloc]init];
    _listQuestions = _parentController.currentStory;
    
    [self fillNoteList:_listQuestions];
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)fillNoteList:(NSMutableArray*)listOfQuestions
{
    int combinedHeight = 0;
    XYZStoryPart *titlePart = [listOfQuestions objectAtIndex:0];
    
    if(![titlePart.title isEqualToString:@""]){
        _titleLabel.text = titlePart.title;
    }else{
        _titleLabel.text = @"No Title!";
    }
    _titleLabel.font = [UIFont fontWithName:@"Moon Flower Bold" size:23];
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    
    for (int i = 0; i < listOfQuestions.count; i++){
        XYZStoryPart *part = [listOfQuestions objectAtIndex:i];
        UILabel *myLabel = [[UILabel alloc]initWithFrame:CGRectMake(25, 0+(combinedHeight), 270, 100)];
        [myLabel setText:part.question];
        myLabel.font = [UIFont fontWithName:@"Moon Flower Bold" size:23];
        myLabel.textAlignment = NSTextAlignmentLeft;
        myLabel.numberOfLines = 10;
        CGSize maximumLabelSize = CGSizeMake(296, FLT_MAX);
        
        CGSize expectedLabelSize = [myLabel.text sizeWithFont:myLabel.font constrainedToSize:maximumLabelSize lineBreakMode:myLabel.lineBreakMode];
        
        
        //adjust the label the the new height.
        CGRect newFrame = myLabel.frame;
        newFrame.size.height = expectedLabelSize.height;
        combinedHeight += expectedLabelSize.height;
        combinedHeight += 5;
        myLabel.frame = newFrame;
        myLabel.layer.zPosition = MAXFLOAT;
        [_childScroller addSubview:myLabel];
        
        UILabel *myLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(25, 0 + (combinedHeight), 270, 100)];
        [myLabel2 setText:part.answer];
        myLabel2.font = [UIFont fontWithName:@"Gujarati Sangam MN" size:14];
        myLabel2.textAlignment = NSTextAlignmentLeft;
        myLabel2.numberOfLines = 10;
        CGSize maximumLabelSize2 = CGSizeMake(296, FLT_MAX);
        
        CGSize expectedLabelSize2 = [myLabel2.text sizeWithFont:myLabel2.font constrainedToSize:maximumLabelSize2 lineBreakMode:myLabel2.lineBreakMode];
        
        //adjust the label the the new height.
        CGRect newFrame2 = myLabel2.frame;
        newFrame2.size.height = expectedLabelSize2.height;
        combinedHeight += expectedLabelSize2.height;
        
        myLabel2.frame = newFrame2;
        
        for (int b = 0; b < expectedLabelSize2.height/16.625; ++b){
            UIButton *myButton = [UIButton alloc];
            myButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [myButton addTarget:self action:@selector(myCustomFunction:) forControlEvents:UIControlEventTouchUpInside];
            [myButton setBackgroundImage:[UIImage imageNamed:@"dotted_lines.jpg"] forState:UIControlStateNormal];
            myButton.frame = CGRectMake(25, (-b*16.625) + combinedHeight, 270, 1);
            myButton.userInteractionEnabled = false;
            [_childScroller addSubview:myButton];
        }
        
        combinedHeight += 30;
        
        _childScroller.contentSize = CGSizeMake(240,combinedHeight + 200);
        [_childScroller addSubview:myLabel2];
        
    }
}





@end
