//
//  XYZnoteOverviewViewController.m
//  KeepIt
//
//  Created by Medialab_student on 6/5/14.
//  Copyright (c) 2014 Games4Therapy. All rights reserved.
//

#import "XYZnoteOverviewViewController.h"

@interface XYZnoteOverviewViewController ()

//@property (strong, nonatomic) NSMutableArray* listQuestions;
@property (strong, nonatomic) XYZBuildStoryViewController* parentController;

@end

@implementation XYZnoteOverviewViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    _scrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(0,40,320,270)];
    _scrollview.showsVerticalScrollIndicator=YES;
    _scrollview.scrollEnabled=YES;
    _scrollview.userInteractionEnabled=YES;
    _scrollview.contentSize = CGSizeMake(240,900);
    _scrollview.layer.zPosition = MAXFLOAT;
    [_noteViewHolder addSubview:_scrollview];
    _listQuestions = [[NSMutableArray alloc]init];
    
}

- (void)fillNoteList:(NSMutableArray*)listOfQuestions
{
    int combinedHeight = 0;
    
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
        [_scrollview addSubview:myLabel];
        
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
            [_scrollview addSubview:myButton];
        }

        combinedHeight += 30;
        
        _scrollview.contentSize = CGSizeMake(240,combinedHeight + 200);
        [_scrollview addSubview:myLabel2];
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
