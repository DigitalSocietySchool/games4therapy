//
//  XYZBuildStoryViewController.m
//  KeepIt
//
//  Created by Medialab_student on 6/2/14.
//  Copyright (c) 2014 Games4Therapy. All rights reserved.
//

#import "XYZBuildStoryViewController.h"

@interface XYZBuildStoryViewController ()

@property (strong,nonatomic) XYZnoteOverviewViewController *childViewController;
@property (strong, nonatomic) XYZStoryPartListViewController *storyPartListViewController;
@property (weak, nonatomic) IBOutlet UIButton *closeButton;
@property (weak, nonatomic) IBOutlet UIView *editNoteView;
@property (weak, nonatomic) IBOutlet UIView *editNoteContainerView;
@property (weak, nonatomic) IBOutlet UIButton *annoyingbuttondoesntleave;

@property (weak, nonatomic) IBOutlet UIImageView *saveImage;
@property (weak, nonatomic) IBOutlet UILabel *SaveStoryLabel;
@property (weak, nonatomic) IBOutlet UIButton *closeSaveScreen;
@property (weak, nonatomic) IBOutlet UILabel *saveExplanationLabel;
@property (weak, nonatomic) IBOutlet UILabel *saveStoryButtonLabel;
@property (weak, nonatomic) IBOutlet UIButton *saveStoryButton;
@property (weak, nonatomic) IBOutlet UIButton *goBackButton;
@property (weak, nonatomic) IBOutlet UIImageView *redBackground;
@property (weak, nonatomic) IBOutlet UIImageView *yellowBackground;
@property (weak, nonatomic) IBOutlet UIButton *showOverviewConfirmationButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelConfirmationButton;
@property (weak, nonatomic) IBOutlet UILabel *BackToMenuLabel;
@property (weak, nonatomic) IBOutlet UIImageView *blackBackground;
@property (weak, nonatomic) IBOutlet UILabel *menuSaveLabel;
@property (weak, nonatomic) IBOutlet UILabel *menuDontSaveLabel;
@property (weak, nonatomic) IBOutlet UIImageView *menuStroke;
@property (weak, nonatomic) IBOutlet UIButton *menuSaveButton;
@property (weak, nonatomic) IBOutlet UIButton *menuDontSaveButton;

@end

@implementation XYZBuildStoryViewController
- (IBAction)goBackButtonClicked:(id)sender {
    
    _menuDontSaveButton.hidden = false;
    _menuStroke.hidden = false;
    _menuSaveLabel.hidden = false;
    _menuSaveButton.hidden = false;
    _menuDontSaveLabel.hidden = false;
    _saveImage.hidden = false;
    _saveExplanationLabel.hidden = false;
    _SaveStoryLabel.hidden = false;
    
    _annoyingbuttondoesntleave.hidden = true;
}
- (IBAction)backToMenuSaveButtonClicked:(id)sender {
    [self saveStory];
}

- (void)showSaveScreen {
    _blackBackground.hidden = false;
    _saveImage.hidden = false;
    _SaveStoryLabel.hidden = false;
    _closeSaveScreen.hidden = false;
    _saveExplanationLabel.hidden = false;
    _saveStoryButtonLabel.hidden = false;
    _saveStoryButton.hidden = false;
    _annoyingbuttondoesntleave.hidden = true;
    _SaveStoryLabel.text = @"Save Your Story";
    _saveExplanationLabel.text = @"Eventually you'll be able to categorize your story. However, you can only save it for now. Review your story at 'My Stories'!";
    _saveStoryButtonLabel.text = @"Save Story";
}

- (IBAction)cancelSaveButtonClicked:(id)sender {
    _saveImage.hidden = true;
    _SaveStoryLabel.hidden = true;
    _closeSaveScreen.hidden = true;
    _saveExplanationLabel.hidden = true;
    _saveStoryButtonLabel.hidden = true;
    _saveStoryButton.hidden = true;
    _annoyingbuttondoesntleave.hidden = false;
    _blackBackground.hidden= true;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _categoryHolder = [[NSMutableArray alloc]init];
        
    }
    return self;
}
- (IBAction)closeButtonClicked:(id)sender {
    NSLog(@"closeNotOverview");
    _noteButton.hidden = false;
    _noteButton.userInteractionEnabled = true;
    _cancelButton.hidden = false;
    _cancelButton.userInteractionEnabled = true;
    _acceptButton.hidden = false;
    _acceptButton.userInteractionEnabled = true;
    _blackBackground.hidden = true;
    _allNoteView.userInteractionEnabled = false;
    _allNoteView.hidden = true;
    _storyPartView.userInteractionEnabled = true;
    _storyPartView.hidden = false;
    _content_OverviewImage.layer.zPosition = 0;
    
    _closeButton.userInteractionEnabled = false;
    _closeButton.hidden = true;
}

- (IBAction)acceptEditButtonClicked:(id)sender {
    
    _editNoteView.hidden = false;
    _acceptEditButton.hidden = false;
    _editNoteView.userInteractionEnabled = true;
    _acceptEditButton.userInteractionEnabled = true;
    _editNoteView.layer.zPosition = MAXFLOAT;
    _acceptEditButton.layer.zPosition = MAXFLOAT;
    _blackBackground.hidden=true;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _blackBackground.hidden = true;
    
    _menuDontSaveLabel.font = [UIFont fontWithName:@"Moon Flower Bold" size:20];
    _menuSaveLabel.font = [UIFont fontWithName:@"Moon Flower Bold" size:20];
    
    _menuDontSaveButton.hidden = true;
    _menuStroke.hidden = true;
    _menuSaveLabel.hidden = true;
    _menuSaveButton.hidden = true;
    _menuDontSaveLabel.hidden = true;
    
    
    _showOverviewConfirmationButton.hidden = true;
    _cancelConfirmationButton.hidden = true;
    _saveImage.hidden = true;
    _SaveStoryLabel.hidden = true;
    _closeSaveScreen.hidden = true;
    _saveExplanationLabel.hidden = true;
    _saveStoryButtonLabel.hidden = true;
    _saveStoryButton.hidden = true;
    if(_storyTitleHolder != nil){
        _storyTitle.text = _storyTitleHolder;
    }
    _storyTitleHolder = [[NSMutableString alloc]init];
    
    _SaveStoryLabel.font = [UIFont fontWithName:@"Moon Flower Bold" size:24];
    _saveExplanationLabel.font = [UIFont fontWithName:@"Moon Flower Bold" size:16];
    _saveStoryButtonLabel.font = [UIFont fontWithName:@"Moon Flower Bold" size:20];
    _BackToMenuLabel.font = [UIFont fontWithName:@"Moon Flower Bold" size:24];
    
    
    _storyFinished = false;
    _listQuestions = [[NSMutableArray alloc]init];

    // Do any additional setup after loading the view.
    noteScroller.contentSize = CGSizeMake(240, 1200);
    noteScroller.contentInset = UIEdgeInsetsMake(0,0.0,-44.0,0.0);
    
    _closeButton.hidden = true;
    _closeButton.userInteractionEnabled = false;
    
    _currentHeight = 0;
    
    [_allNoteView addSubview:noteScroller];
 //   _editContainerView.hidden = true;
 //   _editContainerView.userInteractionEnabled=false;
    scroller.contentSize = CGSizeMake(320, 500);
    scroller.contentInset = UIEdgeInsetsMake(-64.0,0.0,0,0.0);
    
    _editNoteView.hidden = true;
    _acceptEditButton.hidden = true;
    _editNoteView.userInteractionEnabled = false;
    _acceptEditButton.userInteractionEnabled = false;
    
    _editNoteContainerView.hidden = false;
    _editNoteContainerView.userInteractionEnabled = true;
    _editNoteContainerView.layer.zPosition = MAXFLOAT;
    
    _createButton.layer.zPosition = MAXFLOAT;
    _createLabel.layer.zPosition = MAXFLOAT;
    _saveButton.layer.zPosition = MAXFLOAT;
    _cancelButton.layer.zPosition = MAXFLOAT;
    _editButton.layer.zPosition = MAXFLOAT;
    _topGreen.layer.zPosition = MAXFLOAT;
    
    _storyNameTextField.delegate = self;
    _storyNameTextField.font = [UIFont fontWithName:@"Moon Flower Bold" size:20];
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resignOnTap:)];
    [singleTap setNumberOfTapsRequired:1];
    [singleTap setNumberOfTouchesRequired:1];
 //   [self.view addGestureRecognizer:singleTap];
}

-(BOOL) textFieldShouldReturn: (UITextField *) textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    self.currentResponder = textField;
}


- (void)resignOnTap:(id)iSender {
    [self.currentResponder resignFirstResponder];
}

- (void)noteButtonClicked{
    [self fillAllNoteScrollView];
    _blackBackground.hidden = false;
    _allNoteView.userInteractionEnabled = true;
    _allNoteView.hidden = false;
    _storyPartView.userInteractionEnabled = false;
    _storyPartView.hidden = true;
    _content_OverviewImage.layer.zPosition = MAXFLOAT;
    
    _noteButton.hidden = true;
    _noteButton.userInteractionEnabled = false;
    _cancelButton.hidden = true;
    _cancelButton.userInteractionEnabled = false;
    _acceptButton.hidden = true;
    _acceptButton.userInteractionEnabled = false;
    
    _closeButton.hidden = false;
    _closeButton.userInteractionEnabled = true;
}
- (IBAction)showOverviewConfirmationButtonClicked:(id)sender {
    _blackBackground.hidden = false;
    _saveImage.hidden = true;
    _SaveStoryLabel.hidden = true;
    _closeSaveScreen.hidden = true;
    _saveExplanationLabel.hidden = true;
    _saveStoryButtonLabel.hidden = true;
    _showOverviewConfirmationButton.hidden = true;
    _annoyingbuttondoesntleave.hidden = false;
    [self noteButtonClicked];
}

- (IBAction)noteButtonClicked:(id)sender {
    _blackBackground.hidden = false;
    _saveImage.hidden = false;
    _SaveStoryLabel.hidden = false;
    _closeSaveScreen.hidden = false;
    _saveExplanationLabel.hidden = false;
    _saveStoryButtonLabel.hidden = false;
    _showOverviewConfirmationButton.hidden = false;
    _annoyingbuttondoesntleave.hidden = true;
    _saveStoryButton.hidden = true;
    _saveStoryButton.userInteractionEnabled = false;
    _cancelConfirmationButton.hidden = true;
    _SaveStoryLabel.text = @"Show your overview";
    _saveExplanationLabel.text = @"This option shows you an overview of all questions and answers in your current story. Press 'Show Overview' below to confirm";
    _saveStoryButtonLabel.text = @"Show Overview";

}

- (void)yelpMethod{
    NSLog(@"YELP!");
}

- (void)fillAllNoteScrollView
{
    
    [_childViewController fillNoteList:_storyPartListViewController.listOfParts];
}

- (void)closeNoteOverview
{
    
    NSLog(@"closeNotOverview");
    _noteButton.hidden = false;
    _noteButton.userInteractionEnabled = true;
    _cancelButton.hidden = false;
    _cancelButton.userInteractionEnabled = true;
    _acceptButton.hidden = false;
    _acceptButton.userInteractionEnabled = true;
    _blackBackground.hidden = true;
    _allNoteView.userInteractionEnabled = false;
    _allNoteView.hidden = true;
    _storyPartView.userInteractionEnabled = true;
    _storyPartView.hidden = false;
    _content_OverviewImage.layer.zPosition = 0;

}

- (IBAction)cancelButtonClicked:(id)sender {
    [self cancelButtonScreen];
}

-(void)cancelButtonScreen{
    _blackBackground.hidden = false;
    _saveImage.hidden = false;
    _SaveStoryLabel.hidden = false;
    _closeSaveScreen.hidden = false;
    _saveExplanationLabel.hidden = false;
    _saveStoryButtonLabel.hidden = false;
    _annoyingbuttondoesntleave.hidden = true;
    _cancelConfirmationButton.hidden = false;
    _SaveStoryLabel.text = @"Cancel your current story?";
    _saveExplanationLabel.text = @"Here you can go back to the main menu without saving.";
    _saveStoryButtonLabel.text = @"Go Back To Main Menu";
    
}

- (IBAction)cancelConfirmationButtonClicked:(id)sender {
    _blackBackground.hidden = true;
    _saveImage.hidden = true;
    _SaveStoryLabel.hidden = true;
    _closeSaveScreen.hidden = true;
    _saveExplanationLabel.hidden = true;
    _saveStoryButtonLabel.hidden = true;
    _cancelConfirmationButton.hidden = true;
    _annoyingbuttondoesntleave.hidden = false;
    [self performSegueWithIdentifier:@"doNothingApartFromBackToMenuSegue" sender:self];
}

- (IBAction)saveButtonClicked:(id)sender {
    [self saveStory];
    /*
    _storyFinished = true;
    

     */
     }
//- (IBAction)saveStoryClicked:(id)sender {
//    [self saveStory];
//}

- (IBAction)saveStoryScreenButtonClicked:(id)sender {
    _blackBackground.hidden = false;
    [self showSaveScreen];
}


- (IBAction)SAVESTORYLABELBUTTON:(id)sender {
    [self saveStory];
}

- (void)saveStory{
    [self performSegueWithIdentifier:@"returnToMainScreenSegue" sender:self];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)toggleBlack{
    if (_blackBackground.hidden){
    _blackBackground.hidden = false;
    }else{
        _blackBackground.hidden = true;
    }
}

- (void)createNewStoryPartButton:(XYZStoryPart *)storyPart
{
    
}
// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}


// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [_currentPart.listPickerQuestions count];
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row   forComponent:(NSInteger)component
{
    return [_currentPart.listPickerQuestions objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row   inComponent:(NSInteger)component{

}

// tell the picker the width of each row for a given component
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    int sectionWidth = 300;
    
    return sectionWidth;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel* tView = (UILabel*)view;
    if (!tView)
    {
        tView = [[UILabel alloc] init];
        [tView setFont:[UIFont fontWithName:@"Moon Flower Bold" size:13]];
        tView.textAlignment = NSTextAlignmentCenter;
        tView.numberOfLines=3;
    }
    // Fill the label text here
    tView.text=[_currentPart.listPickerQuestions objectAtIndex:row];
    return tView;
}

- (IBAction)sliderAction:(id)sender
{
    UIImage *moodFace;
    if(_currentSlider.value <= 11){
        moodFace = [UIImage imageNamed:@"mood_9.png"];
    } else if(_currentSlider.value>11 && _currentSlider.value <= 22){
        moodFace = [UIImage imageNamed:@"mood_8.png"];
    } else if(_currentSlider.value>22 && _currentSlider.value <= 33){
        moodFace = [UIImage imageNamed:@"mood_7.png"];
    } else if(_currentSlider.value>33 && _currentSlider.value <= 44){
        moodFace = [UIImage imageNamed:@"mood_6.png"];
    } else if(_currentSlider.value>44 && _currentSlider.value <= 55){
        moodFace = [UIImage imageNamed:@"mood_5.png"];
    } else if(_currentSlider.value>55 && _currentSlider.value <= 66){
        moodFace = [UIImage imageNamed:@"mood_4.png"];
    } else if(_currentSlider.value>66 && _currentSlider.value <= 77){
        moodFace = [UIImage imageNamed:@"mood_3.png"];
    } else if(_currentSlider.value>77 && _currentSlider.value <= 88){
        moodFace = [UIImage imageNamed:@"mood_2.png"];
    } else if(_currentSlider.value>88 && _currentSlider.value <= 100){
        moodFace = [UIImage imageNamed:@"mood_1.png"];
    }
    [_currentImage setImage:moodFace];
    

}

- (void)myCustomFunction:(id)sender{
    _editNoteContainerView.hidden = false;
    _editNoteContainerView.userInteractionEnabled = true;
    _editNoteContainerView.layer.zPosition = MAXFLOAT;
    
}
- (void)setBackgroundColor:(int)value{
    if(value >50){
        _yellowBackground.frame = CGRectMake( -320 + ((value- 50) * 6.4), 0, _yellowBackground.frame.size.width, _yellowBackground.frame.size.height ); // set new position exactly
        _redBackground.frame = CGRectMake( -320 , 0, _redBackground.frame.size.width, _redBackground.frame.size.height ); // set new position exactly
        
        
    }else{
        _redBackground.frame = CGRectMake( -320 + ((value - 50) * -6.4), 0, _redBackground.frame.size.width, _redBackground.frame.size.height ); // set new position exactly
        _yellowBackground.frame = CGRectMake( -320 , 0, _yellowBackground.frame.size.width, _yellowBackground.frame.size.height ); // set new position exactly
    }
}


 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 NSString * segueName = segue.identifier;
     if ([segueName isEqualToString: @"noteOverviewEmbedSegue"]) {
         _childViewController = (XYZnoteOverviewViewController *) [segue destinationViewController];
         // do something with the AlertView's subviews here...
     }
     if([segueName isEqualToString:@"storyPartListSegue"]){
         _storyPartListViewController = (XYZStoryPartListViewController *) [segue destinationViewController];
         _storyPartListViewController.listOfParts = self.listQuestions;
         _storyPartListViewController.categoryHolder = self.categoryHolder;
         [_storyPartListViewController setUpConnectionWithParent:self];
     }
     if([segueName isEqualToString:@"returnToMainScreenSegue"]){
         self.listQuestions = _storyPartListViewController.listOfParts;
     }
     _menuDontSaveButton.hidden = true;
     _menuStroke.hidden = true;
     _menuSaveLabel.hidden = true;
     _menuSaveButton.hidden = true;
     _menuDontSaveLabel.hidden = true;
     _saveImage.hidden = true;
     _saveExplanationLabel.hidden = true;
     _SaveStoryLabel.hidden = true;
}

@end
