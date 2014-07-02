//
//  XYZnewQuestionViewController.h
//  KeepIt
//
//  Created by Medialab_student on 6/11/14.
//  Copyright (c) 2014 Games4Therapy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYZnewQuestionViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *textViewHolder;
@property (weak, nonatomic) IBOutlet UILabel *AddNewQuestionLabel;
@property (weak, nonatomic) IBOutlet UILabel *saveLabel;
@property (strong, nonatomic) NSMutableString* answerHolder;
@property (strong, nonatomic) NSString* questionHolder;



@end
