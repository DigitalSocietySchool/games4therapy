//
//  XYZnewQuestionViewController.m
//  KeepIt
//
//  Created by Medialab_student on 6/11/14.
//  Copyright (c) 2014 Games4Therapy. All rights reserved.
//

#import "XYZnewQuestionViewController.h"

@interface XYZnewQuestionViewController ()

@end

@implementation XYZnewQuestionViewController

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
    
    self.answerHolder = [[NSMutableString alloc]init];
    // Do any additional setup after loading the view.
    
    self.AddNewQuestionLabel.font = [UIFont fontWithName:@"Moon Flower Bold" size:23];
    self.AddNewQuestionLabel.text = _questionHolder;
    self.saveLabel.text = @"Save";
    self.saveLabel.font = [UIFont fontWithName:@"Moon Flower Bold" size:18];
    self.textViewHolder.font = [UIFont fontWithName:@"Gujarati Sangam MN" size:14];
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resignOnTap:)];
    [singleTap setNumberOfTapsRequired:1];
    [singleTap setNumberOfTouchesRequired:1];
    [self.view addGestureRecognizer:singleTap];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)saveButtonClicked:(id)sender {
    [self.answerHolder appendString:self.textViewHolder.text];
    [self performSegueWithIdentifier:@"goToSettingsSegue" sender:sender];
}

- (void)resignOnTap:(id)iSender {
    [self.view endEditing:YES];
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
