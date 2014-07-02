//
//  XYZMainScreenViewController.m
//  KeepIt
//
//  Created by Medialab_student on 5/28/14.
//  Copyright (c) 2014 Games4Therapy. All rights reserved.
//

#import "XYZMainScreenViewController.h"
#import "XYZStoryOverviewTableViewController.h"
#import "XYZsettingsScreenViewController.h"
#import "XYZBuildStoryViewController.h"

@interface XYZMainScreenViewController ()
@property (weak, nonatomic) IBOutlet UIButton *createButton;
@property (weak, nonatomic) IBOutlet UILabel *KeepItTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *BuildYourMindmapLabel;
@property (weak, nonatomic) IBOutlet UILabel *howItWorksLabel;
@property (weak, nonatomic) IBOutlet UILabel *settingsLabel;
@property (weak, nonatomic) IBOutlet UILabel *createLabel;
@property (weak, nonatomic) IBOutlet UILabel *myStoriesLabel;
@property (weak, nonatomic) IBOutlet UILabel *otherStoriesLabel;

@property (weak, nonatomic) IBOutlet UIButton *howItWorksButton;
@property (weak, nonatomic) IBOutlet UIButton *settingsButton;
@property (weak, nonatomic) IBOutlet UIButton *myStoriesButton;
@property (weak, nonatomic) IBOutlet UIImageView *underConstructionImage;
@property (weak, nonatomic) IBOutlet UILabel *underConstructionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *underConstructionBackground;
@property (strong, nonatomic) XYZsettingsScreenViewController* settingsController;
@property (weak, nonatomic) IBOutlet UIImageView *storyNameScreen;
@property (weak, nonatomic) IBOutlet UILabel *nameYourStoryExplanationLabel;
@property (weak, nonatomic) IBOutlet UIImageView *blackBackground;

@property (weak, nonatomic) IBOutlet UIImageView *contentScrollBackground;
@property (weak, nonatomic) IBOutlet UILabel *nameYourStoryLabel;
@property (weak, nonatomic) IBOutlet UILabel *saveLabel;
@property (weak, nonatomic) IBOutlet UILabel *laterLabel;
@property (weak, nonatomic) IBOutlet UIButton *laterButton;
@property (weak, nonatomic) IBOutlet UITextField *textFieldStoryName;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (strong, nonatomic) XYZStoryOverviewTableViewController* storyOverviewTableController;

@property (weak, nonatomic) IBOutlet UIImageView *strokeLine;


@end

@implementation XYZMainScreenViewController
- (IBAction)createButtonClicked:(id)sender {
//    [self performSegueWithIdentifier:@"newStorySegue" sender:sender];
    [self NameStory];
}

- (IBAction)laterButtonPressed:(id)sender {
    _nameYourStoryExplanationLabel.hidden = true;
    _storyNameScreen.hidden = true;
    _contentScrollBackground.hidden = true;
    _textFieldStoryName.text = @"";
    _nameYourStoryLabel.hidden = true;
    _saveLabel.hidden = true;
    _storyNameScreen.userInteractionEnabled = false;
    _laterLabel.hidden = true;
    _laterButton.hidden = true;
    _textFieldStoryName.hidden = true;
    _strokeLine.hidden = true;
    _saveButton.hidden = true;
    [self performSegueWithIdentifier:@"newStorySegue" sender:sender];
}

- (IBAction)saveButtonPressed:(id)sender {
    _storyTitle = [[NSMutableString alloc]init];
    [_storyTitle appendString:_textFieldStoryName.text];
    _nameYourStoryExplanationLabel.hidden = true;
    _storyNameScreen.hidden = true;
    _textFieldStoryName.text = @"";
    _contentScrollBackground.hidden = true;
    _nameYourStoryLabel.hidden = true;
    _storyNameScreen.userInteractionEnabled = false;
    _saveLabel.hidden = true;
    _laterLabel.hidden = true;
    _laterButton.hidden = true;
    _strokeLine.hidden = true;
    _textFieldStoryName.hidden = true;
    _saveButton.hidden = true;
    [self performSegueWithIdentifier:@"newStorySegue" sender:sender];
}

-(void)NameStory{
    _blackBackground.hidden = false;
    _strokeLine.hidden = false;
    _nameYourStoryExplanationLabel.hidden = false;
    _storyNameScreen.hidden = false;
    _storyNameScreen.userInteractionEnabled = true;
    _contentScrollBackground.hidden = false;
    _nameYourStoryLabel.hidden = false;
    _saveLabel.hidden = false;
    _laterLabel.hidden = false;
    _laterButton.hidden = false;
    _textFieldStoryName.hidden = false;
    _saveButton.hidden = false;
}
- (IBAction)myStoriesButtonClicked:(id)sender {
    [self performSegueWithIdentifier:@"storyOverviewSegue" sender:sender];
}
- (IBAction)unwindToMainMenuDoingNothing:(UIStoryboardSegue *)segue{
    
}

- (IBAction)unwindToListFromOverview:(UIStoryboardSegue *)segue{
    XYZStoryOverviewTableViewController* source = [segue sourceViewController];
    self.listOfStories = source.listOfStories;
    [self storeAllData];
}
- (IBAction)unwindToListFromSettings:(UIStoryboardSegue *)segue{
    XYZsettingsScreenViewController *source = [segue sourceViewController];
    self.categoryHolder = source.categoryHolder;
    [self storeAllData];
}
- (IBAction)otherStoriesButtonClicked:(id)sender {
    _underConstructionImage.hidden = false;
    _underConstructionLabel.hidden = false;
    _closeHowItWorks.hidden = false;
    _closeHowItWorks.userInteractionEnabled = true;
    _underConstructionBackground.hidden = false;
}

- (IBAction)closeHowItWorksClicked:(id)sender {
    _howItWorks.hidden=true;
    _howItWorks.userInteractionEnabled = false;
    _closeHowItWorks.userInteractionEnabled = false;
    _closeHowItWorks.hidden = true;
    _closeHowItWorks.userInteractionEnabled = false;
    
    _underConstructionBackground.hidden = true;
    _underConstructionImage.hidden = true;
    _underConstructionLabel.hidden = true;
    
}

- (IBAction)howItWorksClicked:(id)sender {
    _closeHowItWorks.hidden = false;
    _closeHowItWorks.userInteractionEnabled = true;
    _howItWorks.hidden = false;
    _howItWorks.userInteractionEnabled = true;
}

- (IBAction)settingsClicked:(id)sender {
    NSLog(@"Settings clicked");
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"storyOverviewSegue"]){
        _storyOverviewTableController = (XYZStoryOverviewTableViewController *) [segue destinationViewController];
        [_storyOverviewTableController setUpConnectionWithParent:self];
    }
    if([segue.identifier isEqualToString:@"settingsSegue"]){
        _settingsController = (XYZsettingsScreenViewController*) [segue destinationViewController];
        [_settingsController setUpConnectionWithParent:self];
    }
    if([segue.identifier isEqualToString:@"newStorySegue"]){
        _blackBackground.hidden = true;
        XYZBuildStoryViewController* _buildStoryController = (XYZBuildStoryViewController*) [segue destinationViewController];
        _buildStoryController.categoryHolder = self.categoryHolder;
        _buildStoryController.storyTitleHolder = self.storyTitle;
        self.storyTitle = [[NSMutableString alloc]init];
    }
}

- (IBAction)unwindToListFromStoryPart:(UIStoryboardSegue *)segue{
    
    XYZBuildStoryViewController *source = [segue sourceViewController];
    if (source.listQuestions.firstObject != nil){
        NSMutableArray *listOfStoryParts = source.listQuestions;
        if ([listOfStoryParts objectAtIndex:0]!=nil) {
            XYZStoryPart* part = [listOfStoryParts objectAtIndex:0];
            part.title = source.storyTitle.text;
            [self.listOfStories addObject:listOfStoryParts];
            
            [self storeAllData];
        }
    }
}

-(void) storeAllData
{
    // Get the standardUserDefaults object, store your UITableView data array against a key, synchronize the defaults
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    //All stories[i]. i = story
    NSMutableArray* storyListArray = [[NSMutableArray alloc ]init];
    
    //Going through all stories (contains stories)
    for(int i = 0; i < [self.listOfStories count]; i++){
        
        NSMutableArray* story = [[NSMutableArray alloc] init];
        
        NSMutableArray* storyHolder = [[NSMutableArray alloc]init];
        storyHolder = [self.listOfStories objectAtIndex:i];
        
        
        
        //Going through all storyParts
        for(int b = 0; b < [storyHolder count]; ++b){
            NSMutableArray* storyPartContainer = [[NSMutableArray alloc]init];
            NSMutableArray* varContainer = [[NSMutableArray alloc] init];
            //Going through all vars in a story part by this order: question, answer, positivity meter, isDone, type.
            XYZStoryPart *part = [[XYZStoryPart alloc] init];
            part = [storyHolder objectAtIndex:b];
            [varContainer addObject:part.question];
            [varContainer addObject:part.answer];
            [varContainer addObject:[NSString stringWithFormat:@"%d",part.positivityMeter]];
            [varContainer addObject:[NSString stringWithFormat:@"%d",part.isDone]];
            [varContainer addObject:[NSString stringWithFormat:@"%d",part.type]];
            [varContainer addObject:[NSString stringWithFormat:@"%d",part.isMoodQuestion]];
            [varContainer addObject:part.listPickerQuestions];
            [varContainer addObject:part.title];
            [storyPartContainer addObject:varContainer];
            [story addObject:storyPartContainer];
            
        }
        [storyListArray addObject:story];
        
        //varContainer goes in PartContainer goes in Story goes in storyListArray
        
    }
    
    [userDefaults setObject:storyListArray forKey:@"listOfStories"];
    [userDefaults setObject:_categoryHolder forKey:@"Settings"];
    [userDefaults synchronize];
}


-(void) loadData{
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *storyListArray = [[NSMutableArray alloc]init];
    
    _categoryHolder = [userDefaults objectForKey:@"Settings"];
    
    //Arrayholder contains story arrays which contain part arrays
    storyListArray = [userDefaults objectForKey:@"listOfStories"];
    self.listOfStories = [[NSMutableArray alloc]init];
    
    
    for (int i = 0; i < [storyListArray count]; i++){
        NSMutableArray* story = [[NSMutableArray alloc] init];
        
        //Code here for processing entire story
        NSMutableArray *storyPartContainer = [[NSMutableArray alloc] init];
        storyPartContainer = [storyListArray objectAtIndex:i];
        
        for(int a = 0; a < [storyPartContainer count]; a++){
            //Code for processing parts
            
            NSMutableArray* PartContainer = [[NSMutableArray alloc]init];
            PartContainer = [storyPartContainer objectAtIndex:a];
            
            
            
            for (int b = 0; b < [PartContainer count]; b++){
                NSMutableArray* varContainer = [[NSMutableArray alloc]init];
                varContainer = [PartContainer objectAtIndex:b];
                XYZStoryPart* storyPart = [[XYZStoryPart alloc]init];
                storyPart.question = [varContainer objectAtIndex:0];
                storyPart.answer = [varContainer objectAtIndex:1];
                storyPart.positivityMeter = [[varContainer objectAtIndex:2] intValue];
                storyPart.isDone= [[varContainer objectAtIndex:3] boolValue];
                storyPart.type = [[varContainer objectAtIndex:4] intValue];
                storyPart.isMoodQuestion =[[varContainer objectAtIndex:5] boolValue];
                storyPart.listPickerQuestions =[varContainer objectAtIndex:6];
                storyPart.title =[varContainer objectAtIndex:7];
                [story addObject:storyPart];
            }
            
            
            
        }
        [self.listOfStories addObject:story];
    }
    // Use 'yourArray' to repopulate your UITableView
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _strokeLine.hidden = true;
    _blackBackground.hidden = true;
    _nameYourStoryExplanationLabel.hidden = true;
    _storyNameScreen.hidden = true;
    _contentScrollBackground.hidden = true;
    _nameYourStoryLabel.hidden = true;
    _saveLabel.hidden = true;
    _laterLabel.hidden = true;
    _laterButton.hidden = true;
    _textFieldStoryName.hidden = true;
    _saveButton.hidden = true;
    _nameYourStoryExplanationLabel.font = [UIFont fontWithName:@"Moon Flower" size:18];
    _nameYourStoryLabel.font=[UIFont fontWithName:@"Moon Flower" size:25];
    _laterLabel.font = [UIFont fontWithName:@"Moon Flower" size:18];
    _saveLabel.font = [UIFont fontWithName:@"Moon Flower" size:18];
    _textFieldStoryName.font = [UIFont fontWithName:@"Moon Flower" size:18];
    
    _storyTitle = [[NSMutableString alloc]init];
    
    _KeepItTitleLabel.font = [UIFont fontWithName:@"Moon Flower" size:100];
    _BuildYourMindmapLabel.font = [UIFont fontWithName:@"Moon Flower" size:32];
    _howItWorksLabel.font = [UIFont fontWithName:@"Moon Flower" size:25];
    _settingsLabel.font = [UIFont fontWithName:@"Moon Flower" size:25];
    _createLabel.font = [UIFont fontWithName:@"Moon Flower" size:25];
    _myStoriesLabel.font = [UIFont fontWithName:@"Moon Flower" size:25];
    _otherStoriesLabel.font = [UIFont fontWithName:@"Moon Flower" size:25];
    
    _KeepItTitleLabel.text = @"Keep It!";
    _BuildYourMindmapLabel.text = @"Build Your Mind map";
    _howItWorksLabel.text = @"How it works?";
    _settingsLabel.text = @"Settings";
    _createLabel.text = @"Create";
    _myStoriesLabel.text = @"My Stories";
    _otherStoriesLabel.text = @"Others Stories";
    self.listOfStories = [[NSMutableArray alloc]init];
    _howItWorksButton.userInteractionEnabled = true;
    _howItWorksButton.hidden=false;
    
    _howItWorks.hidden = true;
    _howItWorks.userInteractionEnabled = false;
    _closeHowItWorks.hidden = true;
    _closeHowItWorks.userInteractionEnabled = false;
    
    _underConstructionLabel.hidden = true;
    _underConstructionBackground.hidden = true;
    [self loadData];
    _underConstructionImage.hidden=true;
    _underConstructionLabel.text = @"In Development!";
    _underConstructionLabel.font = [UIFont fontWithName:@"Moon Flower" size:32];
    _underConstructionLabel.textAlignment = NSTextAlignmentCenter;
    if(_categoryHolder == nil){
        _categoryHolder = [[NSMutableArray alloc]init];
        [self loadCategoryHolderWithDefaultOptions];
    } else{
        NSMutableArray* testArray = [_categoryHolder objectAtIndex:0];
        if(testArray.count < 1){
            [self loadCategoryHolderWithDefaultOptions];
        }
    }

    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resignOnTap:)];
    [singleTap setNumberOfTapsRequired:1];
    [singleTap setNumberOfTouchesRequired:1];
    [self.view addGestureRecognizer:singleTap];
}

-(BOOL) textFieldShouldReturn: (UITextField *) textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    self.currentResponder = textField;
}


- (void)resignOnTap:(id)iSender {
    [self.view endEditing:YES];
}

- (void)loadCategoryHolderWithDefaultOptions{
    _categoryHolder = [[NSMutableArray alloc]init];
    NSMutableArray* situationArray = [[NSMutableArray alloc]init];
    
    [situationArray addObject:@"What is actually happening?"];
    [situationArray addObject:@"Whats the situation?"];
    [situationArray addObject:@"Be objective, where are you?"];
    
    
    
    NSMutableArray* automaticArray = [[NSMutableArray alloc]init];
    
    [automaticArray addObject:@"What thought goes through your mind?"];
    [automaticArray addObject:@"What is bothering you?"];
    [automaticArray addObject:@"And you are thinking that...(fill in the answer)"];
    
    
    
    NSMutableArray* believeArray = [[NSMutableArray alloc]init];
    
    [believeArray addObject:@"How much do you believe it?"];
    
    NSMutableArray* evidenceArray = [[NSMutableArray alloc]init];
    
    [evidenceArray addObject:@"What has happened to prove the thought is true?"];
    
    NSMutableArray* contraEvidenceArray = [[NSMutableArray alloc]init];
    
    [contraEvidenceArray addObject:@"What has happened to prove the thought is not true?"];
    
    NSMutableArray* behaviorArray = [[NSMutableArray alloc]init];
    
    [behaviorArray addObject:@"What can you do about it?"];
    [behaviorArray addObject:@"Which action could you take?"];
    
    NSMutableArray* contraBehaviorArray = [[NSMutableArray alloc]init];
    
    [contraBehaviorArray addObject:@"Can you find another thing that you could do?"];
    
    NSMutableArray* consequenceArray = [[NSMutableArray alloc]init];
    
    [consequenceArray addObject:@"What could happen after all?"];
    [consequenceArray addObject:@"What good would come from this action?"];
    
    NSMutableArray* moodArray = [[NSMutableArray alloc]init];
    
    [moodArray addObject:@"How do you feel about it?"];
    
    NSMutableArray* messageArray = [[NSMutableArray alloc]init];
    
    [messageArray addObject:@"You're doing great, keep going!"];
    
    NSMutableArray* alternativeArray = [[NSMutableArray alloc]init];
    
    [alternativeArray addObject:@"Write down an alternative thought surrounding this situation."];
    
    [_categoryHolder addObject:situationArray];
    [_categoryHolder addObject:automaticArray];
    [_categoryHolder addObject:believeArray];
    [_categoryHolder addObject:evidenceArray];
    [_categoryHolder addObject:contraEvidenceArray];
    [_categoryHolder addObject:behaviorArray];
    [_categoryHolder addObject:contraBehaviorArray];
    [_categoryHolder addObject:consequenceArray];
    [_categoryHolder addObject:moodArray];
    [_categoryHolder addObject:messageArray];
    [_categoryHolder addObject:alternativeArray];
    
    [self storeAllData];
    
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
