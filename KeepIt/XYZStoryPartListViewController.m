//
//  XYZStoryPartListViewController.m
//  KeepIt
//
//  Created by Medialab_student on 6/10/14.
//  Copyright (c) 2014 Games4Therapy. All rights reserved.
//

#import "XYZStoryPartListViewController.h"

@interface XYZStoryPartListViewController ()
@property (strong, nonatomic) IBOutlet UIScrollView *childScroller;
@property (strong, nonatomic) XYZStoryPart* currentPart;
@property int currentHeight;
@property (strong, nonatomic) UIImageView* currentImage;
@property (weak, nonatomic) UISlider* currentSlider;
@property (strong, nonatomic) NSMutableArray* listQuestions;
@property (weak, nonatomic) IBOutlet UIView *editNoteViewContainer;
@property (strong, nonatomic) IBOutlet UIView *storyPartListView;
@property (weak, nonatomic) IBOutlet UIImageView *editNoteImage;
@property (weak, nonatomic) IBOutlet UIButton *acceptAnswerButton;
@property (strong, nonatomic) UILabel* titleLabel;
@property (strong, nonatomic) XYZBuildStoryViewController* buildStoryController;
@property (strong, nonatomic) NSMutableArray* viewHolderMarkedForDelete;
@property bool messageSent;
@property (strong, nonatomic) UILabel* percentageLabelHolder;
@property bool firstEntry;
@property (strong, nonatomic) UITextView *txtview;
@property (strong, nonatomic) NSString* pickerAnswer;
@property (weak, nonatomic) IBOutlet UIImageView *red_background;
@property (weak, nonatomic) IBOutlet UIImageView *yellow_background;
@property UILabel *labelHolder;
@property (weak, nonatomic) IBOutlet UIImageView *blackBackground;

@property UITapGestureRecognizer *singleTap;

@property (strong, nonatomic) IBOutlet UITableView* firstTableView;

@end

@implementation XYZStoryPartListViewController


- (void)setUpConnectionWithParent:(XYZBuildStoryViewController *)parent
{
    _buildStoryController = parent;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (IBAction)acceptButtonClicked:(id)sender {
    _blackBackground.hidden = true;
    [_buildStoryController toggleBlack];
    _currentPart.answer = _txtview.text;
    _currentPart.isDone = true;
    _childScroller.hidden = false;
    _childScroller.scrollEnabled = true;
    _editNoteImage.hidden = true;
    _acceptAnswerButton.hidden = true;
    _acceptAnswerButton.userInteractionEnabled = false;
    _txtview.hidden = true;
    _txtview.userInteractionEnabled = false;
    _txtview.layer.zPosition = 0;
    _titleLabel.hidden = true;
    
    [self  cleanView];
    [self generateNextQuestion];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _messageSent = false;
    _blackBackground.hidden = true;
    _blackBackground.layer.zPosition = MAXFLOAT;
    _firstEntry = true;
    _currentStoryFinished = false;
    _firstTimeNineteen = true;
    _firstTimeOne = true;
    _firstTimeSeventeen = true;
    _firstTimeTwelve = true;
    _firstTimeTwentyOne = true;
    _firstTimeTwentyThree = true;
    _firstTimeTwentyTwo = true;
    _firstTimeFourteen = true;
    _quickRouteToFinish = true;
    
    
    _currentStoryFinished = false;
    _viewHolderMarkedForDelete = [[NSMutableArray alloc]init];
    _editNoteImage.hidden= true;
    _editNoteImage.userInteractionEnabled = false;
    _acceptAnswerButton.hidden = true;
    _acceptAnswerButton.userInteractionEnabled = false;
    
    _currentStoryFinished = false;
    
    _listOfParts = [[NSMutableArray alloc]init];
    _listQuestions = [[NSMutableArray alloc]init];
    _firstTableView = [[UITableView alloc]init];
    
    _firstTableView.dataSource = self;
    _firstTableView.delegate = self;
    [_firstTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"contentRow"];
    _firstTableView.dataSource = self;
    _firstTableView.delegate = self;
    
    [self generateNextQuestion];
    
    [self drawAllParts];
    
    _singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resignOnTap:)];
    [_singleTap setNumberOfTapsRequired:1];
    [_singleTap setNumberOfTouchesRequired:1];
    [self.view addGestureRecognizer:_singleTap];
}

- (void)cleanView{
    for (UIView *view in _viewHolderMarkedForDelete) {
        [view removeFromSuperview];
    }
}


// 0 = situation
// 1 = automatic thoughts
// 2 = believe
// 3 = evidence
// 4 = contra evidence
// 5 = behavior
// 6 = contra behavior
// 7 = consequence
// 8 = mood check
// 9 = messages
- (void)generateNextQuestionAnswer:(int)type
{
    XYZStoryPart *Question = [[XYZStoryPart alloc] init];
    NSMutableArray *array = [_categoryHolder objectAtIndex:type];
    if([array count] >0){
        if([array count] > 1){
            int r = arc4random() %([array count] - 1);
            Question.question =[array objectAtIndex:r];
        }else{
            Question.question =[array objectAtIndex:0];
        }
    }else{
        switch (type) {
            case 0:{
                Question.question = @"What is your current situation?";
                break;
            }
            case 1:{
                Question.question = @"What is your first thought about this?";
                break;
            }
            case 2:{
                Question.question = @"How much do you believe this thought?";
                break;
            }
            case 3:{
                Question.question = @"What evidence do you have that proves your thought is true?";
                break;
            }
            case 4:{
                Question.question = @"What evidence do you have that proves your thought is not true?";
                break;
            }
            case 5:{
                Question.question = @"What could you do to improve your situation?";
                break;
            }
            case 6:{
                Question.question = @"Is there something else you could do to improve your situation?";
                break;
            }
            case 7:{
                Question.question = @"What is the consequence of this?";
                break;
            }
            case 8:{
                Question.question = @"How do you feel about this?";
                break;
            }
            case 9:{
                Question.question = @"Here's a message to cheer you up. You're doing good";
                break;
            }
                
                break;
                
            default:
                break;
        }
        Question.question = @"ERROR! NO QUESTIONS IN CATEGORY";
    }
    Question.type = 0;
    [self.listOfParts addObject:Question];
    [self drawAllParts];
}

- (void)generateNextQuestionAnswer:(int) type: (NSString*)q
{
    XYZStoryPart *Question = [[XYZStoryPart alloc] init];
    Question.question = q;
    Question.type = 0;
    [self.listOfParts addObject:Question];
    [self drawAllParts];
}


- (void)generateNextQuestionBelieve:(int)type{
    XYZStoryPart *Question = [[XYZStoryPart alloc] init];
    Question.type=1;
    Question.isMoodQuestion = false;
    NSMutableArray *array = [_categoryHolder objectAtIndex:type];
    if([array count] >0){
        if([array count] > 1){
            int r = arc4random() %([array count] - 1);
            Question.question =[array objectAtIndex:r];
        }else{
            Question.question =[array objectAtIndex:0];
        }
    }else{
        switch (type) {
            case 0:{
                Question.question = @"What is your current situation?";
                break;
            }
            case 1:{
                Question.question = @"What is your first thought about this?";
                break;
            }
            case 2:{
                Question.question = @"How much do you believe this thought?";
                break;
            }
            case 3:{
                Question.question = @"What evidence do you have that proves your thought is true?";
                break;
            }
            case 4:{
                Question.question = @"What evidence do you have that proves your thought is not true?";
                break;
            }
            case 5:{
                Question.question = @"What could you do to improve your situation?";
                break;
            }
            case 6:{
                Question.question = @"Is there something else you could do to improve your situation?";
                break;
            }
            case 7:{
                Question.question = @"What is the consequence of this?";
                break;
            }
            case 8:{
                Question.question = @"How do you feel about this?";
                break;
            }
            case 9:{
                Question.question = @"Here's a message to cheer you up. You're doing good";
                break;
            }
                
                break;
                
            default:
                break;
        }
    }
    [self.listOfParts addObject:Question];
    [self drawAllParts];
}

- (void)generateNextQuestionMood:(int)type
{
    XYZStoryPart *Question = [[XYZStoryPart alloc] init];
    Question.type=1;
    Question.isMoodQuestion = true;
    NSMutableArray *array = [_categoryHolder objectAtIndex:type];
    if([array count] >0){
        if([array count] > 1){
            int r = arc4random() %([array count] - 1);
            Question.question =[array objectAtIndex:r];
        }else{
            Question.question =[array objectAtIndex:0];
        }
    }else{
        switch (type) {
            case 0:{
                Question.question = @"What is your current situation?";
                break;
            }
            case 1:{
                Question.question = @"What is your first thought about this?";
                break;
            }
            case 2:{
                Question.question = @"How much do you believe this thought?";
                break;
            }
            case 3:{
                Question.question = @"What evidence do you have that proves your thought is true?";
                break;
            }
            case 4:{
                Question.question = @"What evidence do you have that proves your thought is not true?";
                break;
            }
            case 5:{
                Question.question = @"What could you do to improve your situation?";
                break;
            }
            case 6:{
                Question.question = @"Is there something else you could do to improve your situation?";
                break;
            }
            case 7:{
                Question.question = @"What is the consequence of this?";
                break;
            }
            case 8:{
                Question.question = @"How do you feel about this?";
                break;
            }
            case 9:{
                Question.question = @"Here's a message to cheer you up. You're doing good";
                break;
            }
                
                break;
                
            default:
                break;
        }
    }
    [self.listOfParts addObject:Question];
    [self drawAllParts];
}

- (void)generateNextChoice:(NSArray*)options
{
    XYZStoryPart *Question =[[XYZStoryPart alloc] init];
    Question.question =@"Which question do you want next?";
    Question.type = 2;
    
    for(int i = 0; i < [options count]; i++){
        [Question.listPickerQuestions addObject:[options objectAtIndex:i] ];
    }
    
    [self.listOfParts addObject:Question];
    [self drawAllParts];
    
}
- (void)generateMessage{
    _messageSent = true;
    XYZStoryPart* messagePart = [[XYZStoryPart alloc] init];
    NSMutableArray* array = [_categoryHolder objectAtIndex:9];
    if([array count] >0){
        if([array count] > 1){
            int r = arc4random() %([array count] - 1);
            messagePart.question =[array objectAtIndex:r];
        }else{
            messagePart.question =[array objectAtIndex:0];
        }
    }else{
        messagePart.question = @"Here's a message to cheer you up. You're doing good";
    }
    messagePart.answer = @"";
    messagePart.isDone = true;
    [_listOfParts addObject:messagePart];
}

- (void)generateNextQuestion
{
    [self cleanScroller];
    
    switch(_currentTrack){
        case (0):{
            switch(_trackCount){
                case (0):{
                    [self generateNextQuestionAnswer:0];
                    _trackCount++;
                    break;
                }
                case (1):{
                    [self generateNextQuestionAnswer:1];
                    _trackCount++;
                    break;
                }
                case (2):{
                    [self generateNextQuestionBelieve:2];
                    _trackCount++;
                    break;
                }
                case (3):{
                    [self generateNextQuestionMood:8];
                    _trackCount++;
                    break;
                }
                case (4):{
                    XYZStoryPart *storypart = [self.listOfParts lastObject];
                    if([storypart.answer intValue] <= 49){
                        _currentTrack = 1;
                        _trackCount = 0;
                    }else{
                        _currentTrack = 5;
                        _trackCount = 0;
                    }
                    [self generateNextQuestion];
                    break;
                }
                    break;
            }
            break;
        }
        case (1):{
            if(self.firstTimeOne == true){
                _quickRouteToFinish = false;
                switch(_trackCount){
                    case(0):{
                        [self generateNextQuestionAnswer:10];
                        _trackCount++;
                        break;
                    }
                    case(1):{
                        //[self generatemessage];
                        _trackCount++;
                    }
                    case(2):{
                        _currentTrack = 0;
                        _trackCount = 0;
                        [self generateNextQuestion];
                        _firstTimeOne = false;
                        break;
                    }
                        break;
                        
                }
                break;
                
            } else {
                switch(_trackCount){
                    case(0):{
                        [self generateNextQuestionAnswer:3];
                        _trackCount++;
                        break;
                    }
                    case(1):{
                        [self generateNextQuestionBelieve:2];
                        _trackCount++;
                        break;
                    }
                    case(2):{
                        _currentTrack = 2;
                        _trackCount = 0;
                        XYZStoryPart *storypart = [self.listOfParts lastObject];
                        if([storypart.answer intValue] <= 49){
                            _currentTrack = 14;
                            _trackCount = 0;
                        }
                        [self generateNextQuestion];
                        break;
                    }
                        break;
                }
                break;
            }
            break;
        }
        case (2):{
            switch(_trackCount){
                case (0):{
                    [self generateNextQuestionAnswer:4];
                    _trackCount++;
                    break;
                }
                case (1):{
                    [self generateNextQuestionBelieve:2];
                    _trackCount++;
                    break;
                }
                case (2):{
                    _currentTrack = 3;
                    _trackCount = 0;
                    XYZStoryPart *storypart = [self.listOfParts lastObject];
                    if([storypart.answer intValue] <= 49){
                        _currentTrack = 22;
                        _trackCount = 0;
                    }
                    [self generateNextQuestion];
                    break;
                }
                    break;
            }
            break;
        }
        case (3):{
            switch(_trackCount){
                case(0):{
                    //[self generatemessage];
                    _trackCount++;
                }
                case(1):{
                    NSArray  * choiceArray = [NSArray arrayWithObjects:@"What do you think now?",@"Deny previous thought",nil];
                    _trackCount++;
                    [self generateNextChoice:choiceArray];
                    break;
                }
                case(2):{
                    _currentTrack = 25;
                    _trackCount = 0;
                    XYZStoryPart *storypart = [self.listOfParts lastObject];
                    storypart.isDone = true;
                    if([storypart.answer isEqualToString:@"What are you thinking now?"]){
                        
                        _currentTrack = 4;
                        _trackCount = 0;
                    }
                    [self generateNextQuestion];
                    break;
                }
                    break;
            }
            break;
        }
        case (4):{
            switch(_trackCount){
                case (0):{
                    [self generateNextQuestionAnswer:1];
                    _trackCount++;
                    break;
                }
                case(1):{
                    NSArray * choiceArray2 = [NSArray arrayWithObjects:@"Keep thinking", @"Lead a thought", nil];
                    _trackCount++;
                    [self generateNextChoice:choiceArray2];
                    break;
                }
                case(2):{
                    _currentTrack = 26;
                    _trackCount = 0;
                    XYZStoryPart * storypart = [self.listOfParts lastObject];
                    if ([storypart.answer isEqualToString:@"Lead a thought"]){
                        _currentTrack = 27;
                        _trackCount = 0;
                    }
                    [self generateNextQuestion];
                    break;
                }
                    break;
            }
            break;
        }
        case (5):{
            switch (_trackCount){
                case (0):{
                    _trackCount++;
                    if(_quickRouteToFinish){
                        [self generateNextQuestionAnswer:10 :@"If you feel positive about it, what do you want to achieve with the app?"];
                        _quickRouteToFinish = false;
                        break;
                    }
                }
                case(1):{
                    NSArray * choiceArray3 = [NSArray arrayWithObjects:@"Reinforce the thought", @"Encourage to take power on the situation", @"Show Overview", nil];
                    [self generateNextChoice:choiceArray3];
                    _trackCount++;
                    break;
                }
                case (2):{
                    _trackCount = 0;
                    XYZStoryPart * storypart = [self.listOfParts lastObject];
                    if([storypart.answer isEqualToString:@"Reinforce the thought"]){
                        _currentTrack = 13;
                    } else if([storypart.answer isEqualToString:@"Encourage to take power on the situation"]){
                        _currentTrack = 9;
                    } else if([storypart.answer isEqualToString:@"Show Overview"]){
                        _currentTrack = 6;
                    }
                    [self generateNextQuestion];
                    break;
                }
                    break;
            }
            break;
        }
        case (6):{
            switch (_trackCount){
                case (0):{
                    [self showOverview:@"Alright, lets review the progress you've made"];
                    _trackCount++;
                }
                case(1):{
                    NSArray * choiceArray3 = [NSArray arrayWithObjects:@"Continue", @"Finish", nil];
                    _trackCount++;
                    [self generateNextChoice:choiceArray3];
                    break;
                }
                case (2):{
                    _trackCount = 0;
                    XYZStoryPart * storypart = [self.listOfParts lastObject];
                    if([storypart.answer isEqualToString:@"Continue"]){
                        _currentTrack = 0;
                    } else if([storypart.answer isEqualToString:@"Finish"]){
                        _currentTrack = 7;
                    }
                    [self generateNextQuestion];
                    break;
                }
                    break;
            }
            break;
        }
        case (7):{
            switch (_trackCount) {
                case (0):{
                    [self finished];
                    break;
                }
                    break;
            }
            break;
        }
        case (8):{
            switch(_trackCount) {
                case(0):{
                    [self generateNextQuestionBelieve:2];
                    _trackCount++;
                    break;
                }
                case(1):{
                    [self generateNextQuestionMood:8];
                    _trackCount++;
                    break;
                }
                case(2):{
                    XYZStoryPart *storypart = [self.listOfParts lastObject];
                    if([storypart.answer intValue] <= 49){
                        _currentTrack = 1;
                        _trackCount = 0;
                    }else{
                        _currentTrack = 5;
                        _trackCount = 0;
                    }
                    [self generateNextQuestion];
                    break;
                }
                    break;
            }
            break;
        }
        case (9):{
            switch(_trackCount){
                case (0):{
                    [self generateNextQuestionAnswer:5];
                    _trackCount++;
                    break;
                }
                case(1):{
                    [self generateNextQuestionAnswer:7];
                    _trackCount++;
                    break;
                }
                case(2):{
                    [self generateNextQuestionMood:8];
                    _trackCount++;
                    break;
                }
                case(3):{
                    _currentTrack = 10;
                    _trackCount = 0;
                    XYZStoryPart *storypart = [self.listOfParts lastObject];
                    if([storypart.answer intValue] <= 49){
                        _currentTrack = 11;
                        _trackCount = 0;
                    }
                    [self generateNextQuestion];
                    break;
                }
                    break;
            }
            break;
        }
        case (10):{
            switch(_trackCount){
                case (0):{
                    //[self generatemessage];
                    _trackCount++;
                    
                }
                case(1):{
                    _currentTrack = 6;
                    _trackCount = 0;
                    [self generateNextQuestion];
                    break;
                }
            }
            break;
        }
        case (11):{
            switch(_trackCount){
                case (0):{
                    [self generateNextQuestionAnswer:4];
                    _trackCount++;
                    break;
                }
                case (1):{
                    [self generateNextQuestionBelieve:2];
                    _trackCount++;
                    break;
                }
                case (2):{
                    _trackCount = 0;
                    XYZStoryPart *storypart = [self.listOfParts lastObject];
                    if([storypart.answer intValue] <= 49){
                        _currentTrack = 12;
                        _trackCount = 0;
                    }else{
                        _currentTrack = 15;
                    }
                    break;
                }
                    break;
            }
            break;
        }
        case (12):{
            if(_firstTimeTwelve){
                switch(_trackCount){
                    case (0):{
                        [self generateNextQuestionAnswer:7];
                        _trackCount++;
                        break;
                    }
                    case (1):{
                        [self generateNextQuestionMood:8];
                        _trackCount++;
                        break;
                    }
                    case (2):{
                        _currentTrack = 10;
                        _trackCount = 0;
                        XYZStoryPart *storypart = [self.listOfParts lastObject];
                        if([storypart.answer intValue] <= 49){
                            _currentTrack = 11;
                            _trackCount = 0;
                        }
                        _firstTimeTwelve = false;
                        [self generateNextQuestion];
                        break;
                    }
                }
                break;
            }else{
                switch(_trackCount){
                    case (0):{
                        //[self generatemessage];
                        _trackCount++;
                    }
                    case (1):{
                        [self generateNextQuestionAnswer:1];
                        _trackCount++;
                        break;
                    }
                    case (2):{
                        [self generateNextQuestionAnswer:0];
                        _trackCount++;
                        break;
                    }
                    case (3):{
                        //[self generatemessage];
                        _trackCount++;
                    }
                    case (4):{
                        [self generateNextQuestionAnswer:1];
                        _trackCount++;
                        break;
                    }
                    case (5):{
                        [self generateNextQuestionBelieve:2];
                        _trackCount++;
                        break;
                    }
                    case (6):{
                        [self generateNextQuestionMood:8];
                        _trackCount++;
                        break;
                    }
                    case (7):{
                        XYZStoryPart *storypart = [self.listOfParts lastObject];
                        if([storypart.answer intValue] <= 49){
                            _currentTrack = 1;
                            _trackCount = 0;
                        }else{
                            _currentTrack = 5;
                            _trackCount = 0;
                        }
                        [self generateNextQuestion];
                        break;
                    }
                        break;
                }
                break;
            }
            
        }
        case (13):{
            switch (_trackCount) {
                case (0):{
                    _trackCount = 0;
                    _currentTrack = 1;
                    [self generateNextQuestion];
                    break;
                }
                    break;
            }
            break;
        }
        case (14):{
            if(_firstTimeFourteen){
                switch(_trackCount){
                    case (0):{
                        //[self generatemessage];
                        _trackCount++;
                    }
                    case (1):{
                        [self generateNextQuestionAnswer:3];
                        _trackCount++;
                        break;
                    }
                    case (2):{
                        [self generateNextQuestionBelieve:2];
                        _trackCount++;
                        break;
                    }
                    case (3):{
                        _trackCount = 0;
                        _currentTrack = 2;
                        _firstTimeFourteen = false;
                        [self generateNextQuestion];
                        break;
                    }
                        break;
                }
                break;
            }else{
                switch(_trackCount){
                    case (0):{
                        _currentTrack = 3;
                        _trackCount = 0;
                        [self generateNextQuestion];
                        break;
                    }
                        break;
                }
                break;
            }
            break;
        }
        case (15):{
            switch(_trackCount){
                case (0):{
                    [self generateNextQuestionAnswer:4];
                    _trackCount++;
                    break;
                }
                case (1):{
                    [self generateNextQuestionBelieve:2];
                    _trackCount++;
                    break;
                }
                case (2):{
                    XYZStoryPart *storypart = [self.listOfParts lastObject];
                    if([storypart.answer intValue] <= 49){
                        _currentTrack = 17;
                        _trackCount = 0;
                    }else{
                        _currentTrack = 15;
                        _trackCount = 0;
                    }
                    [self generateNextQuestion];
                    break;
                }
            }
            break;
        }
        case (16):{
            switch (_trackCount) {
                case (0):{
                    _currentTrack = 6;
                    _trackCount = 0;
                    [self generateNextQuestion];
                    break;
                }
                    break;
            }
            break;
        }
        case (17):{
            if(_firstTimeSeventeen){
                switch(_trackCount){
                    case (0):{
                        //[self generatemessage];
                        _trackCount++;
                    }
                    case(1):{
                        _firstTimeSeventeen=false;
                        _currentTrack = 15;
                        _trackCount = 0;
                        [self generateNextQuestion];
                        break;
                    }
                        break;
                }
                break;
            } else{
                switch (_trackCount){
                    case (0):{
                        //[self generatemessage];
                        _trackCount++;
                    }
                    case (1):{
                        [self generateNextQuestionAnswer:6];
                        _trackCount++;
                        break;
                    }
                    case (2):{
                        [self generateNextQuestionAnswer:7];
                        _trackCount++;
                        break;
                    }
                    case(3):{
                        [self generateNextQuestionMood:8];
                        _trackCount++;
                        break;
                    }
                    case(4):{
                        XYZStoryPart *storypart = [self.listOfParts lastObject];
                        if([storypart.answer intValue] <= 49){
                            _currentTrack = 18;
                            _trackCount = 0;
                        }else{
                            _currentTrack = 20;
                            _trackCount = 0;
                        }
                        [self generateNextQuestion];
                        break;
                    }
                        break;
                }
                break;
            }
            break;
        }
        case (18):{
            switch(_trackCount){
                case (0):{
                    [self generateNextQuestionBelieve:2];
                    _trackCount++;
                    break;
                }
                case (1):{
                    XYZStoryPart *storypart = [self.listOfParts lastObject];
                    if([storypart.answer intValue] <= 49){
                        _currentTrack = 21;
                        _trackCount = 0;
                    }else{
                        _currentTrack = 19;
                        _trackCount = 0;
                    }
                    [self generateNextQuestion];
                    break;
                }
                    break;
            }
            break;
        }
        case (19):{
            if(_firstTimeNineteen){
                switch(_trackCount){
                    case (0):{
                        //[self generatemessage];
                        _trackCount++;
                    }
                    case(1):{
                        [self generateNextQuestionAnswer:4];
                        _trackCount++;
                        break;
                    }
                    case (2):{
                        [self generateNextQuestionAnswer:7];
                        _trackCount++;
                        break;
                    }
                    case (3):{
                        [self generateNextQuestionMood:8];
                        _trackCount++;
                        break;
                    }
                    case (4):{
                        //[self generatemessage];
                        _trackCount++;
                    }
                    case (5):{
                        [self generateNextQuestionAnswer:7];
                        _trackCount++;
                        break;
                    }
                    case(6):{
                        [self generateNextQuestionMood:8];
                        _trackCount++;
                        break;
                    }
                    case(7):{
                        _firstTimeNineteen = false;
                        XYZStoryPart *storypart = [self.listOfParts lastObject];
                        if([storypart.answer intValue] <= 49){
                            _currentTrack = 18;
                            _trackCount = 0;
                        }else{
                            _currentTrack = 20;
                            _trackCount = 0;
                        }
                        [self generateNextQuestion];
                        break;
                    }
                        break;
                        
                }
                break;
            }else{
                switch(_trackCount){
                    case (0):{
                        //[self generatemessage];
                        _trackCount++;
                    }
                    case (1):{
                        [self generateNextQuestionAnswer:1];
                        _trackCount++;
                        break;
                    }
                    case (2):{
                        [self generateNextQuestionAnswer:0];
                        _trackCount++;
                        break;
                    }
                    case (3):{
                        //[self generatemessage];
                        _trackCount++;
                    }
                    case (4):{
                        [self generateNextQuestionBelieve:2];
                        _trackCount++;
                        break;
                    }
                    case (5):{
                        [self generateNextQuestionMood:8];
                        _trackCount++;
                        break;
                    }
                    case (6):{
                        XYZStoryPart *storypart = [self.listOfParts lastObject];
                        if([storypart.answer intValue] <= 49){
                            _currentTrack = 1;
                            _trackCount = 0;
                        }else{
                            _currentTrack = 5;
                            _trackCount = 0;
                        }
                        [self generateNextQuestion];
                        break;
                    }
                        break;
                }
                break;
                
            }
            break;
        }
        case (20):{
            switch(_trackCount){
                case (0):{
                    //[self generatemessage];
                    _trackCount++;
                }
                case (1):{
                    [self showOverview:@"Alright, lets review the progress you've made"];
                    _trackCount++;
                }
                case(2):{
                    _trackCount++;
                    NSArray * choiceArray4 = [NSArray arrayWithObjects:@"Continue", @"Finish", nil];
                    [self generateNextChoice:choiceArray4];
                    break;
                }
                case (3):{
                    _trackCount = 0;
                    XYZStoryPart * storypart = [self.listOfParts lastObject];
                    if([storypart.answer isEqualToString:@"Continue"]){
                        _currentTrack = 8;
                    } else if([storypart.answer isEqualToString:@"Finish"]){
                        _currentTrack = 7;
                    }
                    [self generateNextQuestion];
                    break;
                }
                    break;
                    
            }
            
            break;
        }
        case (21):{
            if(_firstTimeTwentyOne){
                switch (_trackCount) {
                    case (0):{
                        //[self generatemessage];
                        _trackCount++;
                    }
                    case (1):{
                        [self generateNextQuestionAnswer:6];
                        _trackCount++;
                        break;
                    }
                    case (2):{
                        [self generateNextQuestionAnswer:7];
                        _trackCount++;
                        break;
                    }
                    case (3):{
                        [self generateNextQuestionMood:8];
                        _trackCount++;
                        break;
                    }
                    case (4):{
                        _firstTimeTwentyOne = false;
                        XYZStoryPart *storypart = [self.listOfParts lastObject];
                        if([storypart.answer intValue] <= 49){
                            _currentTrack = 18;
                            _trackCount = 0;
                        }else{
                            _currentTrack = 20;
                            _trackCount = 0;
                        }
                        [self generateNextQuestion];
                        break;
                    }
                        break;
                }
                break;
            } else{
                switch (_trackCount) {
                    case (0):{
                        //[self generatemessage];
                        _trackCount++;
                    }
                    case (1):{
                        [self showOverview:@"Alright, lets review the progress you've made"];
                        _trackCount++;
                    }
                    case(2):{
                        _trackCount++;
                        NSArray * choiceArray4 = [NSArray arrayWithObjects:@"Continue", @"Finish", nil];
                        [self generateNextChoice:choiceArray4];
                        break;
                    }
                    case (3):{
                        _trackCount = 0;
                        XYZStoryPart * storypart = [self.listOfParts lastObject];
                        if([storypart.answer isEqualToString:@"Continue"]){
                            _currentTrack = 8;
                        } else if([storypart.answer isEqualToString:@"Finish"]){
                            _currentTrack = 7;
                        }
                        [self generateNextQuestion];
                        break;
                    }
                        break;
                }
                break;
            }
            break;
        }
        case (22):{
            if(_firstTimeTwentyTwo){
                
                switch(_trackCount){
                    case (0):{
                        //[self generatemessage];
                        _trackCount++;
                    }
                    case (1):{
                        _firstTimeTwentyTwo = false;
                        _currentTrack = 2;
                        _trackCount = 0;
                        [self generateNextQuestion];
                        break;
                    }
                        break;
                }
            }else{
                switch(_trackCount){
                    case (0):{
                        _currentTrack = 3;
                        _trackCount = 0;
                        [self generateNextQuestion];
                        break;
                    }
                        break;
                }
                break;
            }
            break;
        }
        case (23):{
            if(_firstTimeTwentyThree){
                switch(_trackCount){
                    case (0):{
                        //[self generatemessage];
                        _trackCount++;
                    }
                    case (1):{
                        _firstTimeTwentyThree = false;
                        _currentTrack = 1;
                        _trackCount = 0;
                        [self generateNextQuestion];
                        break;
                    }
                        break;
                }
            } else{
                switch(_trackCount){
                    case (0):{
                        //[self generatemessage];
                        _trackCount++;
                    }
                    case (1):{
                        [self generateNextQuestionAnswer:1];
                        _trackCount++;
                        break;
                    }
                    case (2):{
                        [self generateNextQuestionAnswer:0];
                        _trackCount++;
                        break;
                    }
                    case (3):{
                        //[self generatemessage];
                        _trackCount++;
                    }
                    case (4):{
                        [self generateNextQuestionAnswer:1];
                        _trackCount++;
                        break;
                    }
                    case (5):{
                        [self generateNextQuestionBelieve:2];
                        _trackCount++;
                        break;
                    }
                    case (6):{
                        [self generateNextQuestionMood:8];
                        _trackCount++;
                        break;
                    }
                    case (7):{
                        XYZStoryPart *storypart = [self.listOfParts lastObject];
                        if([storypart.answer intValue] <= 49){
                            _currentTrack = 1;
                            _trackCount = 0;
                        }else{
                            _currentTrack = 5;
                            _trackCount = 0;
                        }
                        [self generateNextQuestion];
                        break;
                    }
                        break;
                }
                break;
            }
            break;
        }
        case (24):{
            switch(_trackCount){
                case (0):{
                    NSArray * choiceArray5 = [NSArray arrayWithObjects:@"Behaviour", @"What are you now?", nil];
                    [self generateNextChoice:choiceArray5];
                    _trackCount++;
                    break;
                }
                case (1):{
                    _trackCount = 0;
                    XYZStoryPart * storypart = [self.listOfParts lastObject];
                    if([storypart.answer isEqualToString:@"Behaviour"]){
                        _currentTrack = 29;
                    } else if([storypart.answer isEqualToString:@"What are you now?"]){
                        _currentTrack = 28;
                    }
                    [self generateNextQuestion];
                    break;
                }
                    break;
            }
            break;
        }
        case (25):{
            switch(_trackCount){
                case(0):{
                    [self generateNextQuestionAnswer:10];
                    _trackCount++;
                    break;
                }
                case(1):{
                    //[self generatemessage];
                    _trackCount++;
                }
                case(2):{
                    _currentTrack = 0;
                    _trackCount = 0;
                    [self generateNextQuestion];
                    break;
                }
                    break;
                    
            }
            break;
        }
        case (26):{
            switch(_trackCount){
                case (0):{
                    [self generateNextQuestionAnswer:0];
                    _trackCount++;
                    break;
                }
                case (1):{
                    _trackCount = 0;
                    _currentTrack = 0;
                    [self generateNextQuestion];
                    break;
                }
                    break;
            }
            break;
        }
        case (27):{
            switch(_trackCount){
                case (0):{
                    _trackCount = 0;
                    _currentTrack = 9;
                    [self generateNextQuestion];
                    break;
                }
                    break;
            }
            break;
        }
        case (28):{
            switch(_trackCount){
                case (0):{
                    _trackCount = 0;
                    _currentTrack = 4;
                    [self generateNextQuestion];
                    break;
                }
                    break;
            }
            break;
        }
        case (29):{
            switch(_trackCount){
                case (0):{
                    _trackCount = 0;
                    _currentTrack = 9;
                    [self generateNextQuestion];
                    break;
                }
                    break;
            }
            break;
        }
            //One of these "}" is probably misplaced.
            
    }
}

- (void)finished{
    _currentStoryFinished = true;
    [_buildStoryController showSaveScreen];
    
}

- (void)showOverview{
    [_buildStoryController noteButtonClicked];
    
}

- (void)showOverview:(NSString*)message{
    [self generateMessage:message];
    double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self showOverview];
    });
    
}


- (void)generateMessage:(NSString*)message{
    _messageSent = true;
    XYZStoryPart* messagePart = [[XYZStoryPart alloc] init];
    messagePart.question = message;
    messagePart.answer = @"";
    messagePart.isDone = true;
    [_listOfParts addObject:messagePart];
}

- (void)drawAllParts
{
    CGPoint previousBottomOffset = CGPointMake(0, _childScroller.contentSize.height - _childScroller.bounds.size.height);
    _currentHeight = 0;
    float prevHeight = _childScroller.contentSize.height - _childScroller.bounds.size.height;
    [self cleanScroller];
    for (int i = 0; i < _listOfParts.count; i++){
        [self createNewStoryPartButton:[_listOfParts objectAtIndex:i]];
    }
    
    [_childScroller setContentOffset:previousBottomOffset animated:NO];
    float curHeight = _childScroller.contentSize.height - _childScroller.bounds.size.height;
    if(_messageSent){
        CGPoint bottomOffset = CGPointMake(0, _childScroller.contentSize.height - _childScroller.bounds.size.height - ((curHeight - prevHeight) /2));
        [_childScroller setContentOffset:bottomOffset animated:YES];
        double delayInSeconds = 2.0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            CGPoint bottomOffset = CGPointMake(0, _childScroller.contentSize.height - _childScroller.bounds.size.height);
            [_childScroller setContentOffset:bottomOffset animated:YES];
            _messageSent = false;
        });
    }else{
        CGPoint bottomOffset = CGPointMake(0, _childScroller.contentSize.height - _childScroller.bounds.size.height);
        [_childScroller setContentOffset:bottomOffset animated:YES];
    }
    
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)openAnswerEditButtonClicked:(id)sender{
    
    _childScroller.scrollEnabled = false;
    _childScroller.hidden = true;
    _editNoteImage.hidden = false;
    _blackBackground.hidden = false;
    [_buildStoryController toggleBlack];
    int combinedHeight = 0;
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(33, 35, 250, 57)];
    [_titleLabel setText:_currentPart.question];
    _titleLabel.font = [UIFont fontWithName:@"Moon Flower Bold" size:21];
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    _titleLabel.numberOfLines = 10;
    CGSize maximumLabelSize = CGSizeMake(296, FLT_MAX);
    
    CGSize expectedLabelSize = [_titleLabel.text sizeWithFont:_titleLabel.font constrainedToSize:maximumLabelSize lineBreakMode:_titleLabel.lineBreakMode];
    
    
    //adjust the label the the new height.
    CGRect newFrame = _titleLabel.frame;
    newFrame.size.height = expectedLabelSize.height;
    combinedHeight += expectedLabelSize.height;
    combinedHeight += 5;
    _titleLabel.frame = newFrame;
    _titleLabel.layer.zPosition = MAXFLOAT-1;
    [_viewHolderMarkedForDelete addObject:_titleLabel];
    [_storyPartListView addSubview:_titleLabel];
    
    UITextView* txtview =[[UITextView alloc]initWithFrame:CGRectMake(33,35+combinedHeight,253,180)];
    txtview.text = @"set answer here";
    txtview.font = [UIFont fontWithName:@"Gujarati Sangam MN" size:14];
    [_viewHolderMarkedForDelete addObject:txtview];
    [_storyPartListView addSubview:txtview];
    UIButton *myButton = [UIButton alloc];
    _txtview = txtview;
    myButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [myButton addTarget:self action:@selector(myCustomFunction:) forControlEvents:UIControlEventTouchUpInside];
    [myButton setBackgroundImage:[UIImage imageNamed:@"dotted_lines.jpg"] forState:UIControlStateNormal];
    myButton.frame = CGRectMake(33, combinedHeight + 35, 253, 1);
    myButton.userInteractionEnabled = false;
    [_viewHolderMarkedForDelete addObject:myButton];
    [_storyPartListView addSubview:myButton];
    
    for (int b = 0; b < 180; ){
        UIButton *myButton = [UIButton alloc];
        myButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [myButton addTarget:self action:@selector(myCustomFunction:) forControlEvents:UIControlEventTouchUpInside];
        [myButton setBackgroundImage:[UIImage imageNamed:@"dotted_lines.jpg"] forState:UIControlStateNormal];
        myButton.frame = CGRectMake(33, b + combinedHeight+58, 253, 1);
        myButton.userInteractionEnabled = false;
        [_viewHolderMarkedForDelete addObject:myButton];
        [_storyPartListView addSubview:myButton];
        b += 18;
    }
    _acceptAnswerButton.userInteractionEnabled = true;
    _acceptAnswerButton.hidden = false;
    _acceptAnswerButton.layer.zPosition = MAXFLOAT;
}

- (void)cleanScroller{
    for (UIView *view in _childScroller.subviews) {
        [view removeFromSuperview];
    }
}

- (void)acceptPickerFunction:(id)sender{
    _currentPart.answer = _pickerAnswer;
    _currentPart.isDone = true;
    
    [self  cleanView];
    [self generateNextQuestion];
}

- (void)acceptSlider:(id)sender{
    int value = _currentSlider.value;
    _currentPart.answer = [NSString stringWithFormat:@"%d",(int)_currentSlider.value];
    if(_currentPart.isMoodQuestion){
        
        if(value >50){
            _yellow_background.frame = CGRectMake( -320 + ((value -50) * 6.4), -73, _yellow_background.frame.size.width, _yellow_background.frame.size.height ); // set new position exactly
            _red_background.frame = CGRectMake( -320 , 0, _red_background.frame.size.width, _red_background.frame.size.height ); // set new position exactly
            
            
        }else{
            _red_background.frame = CGRectMake( -320 + ((value - 50) * -6.4), -73, _red_background.frame.size.width, _red_background.frame.size.height ); // set new position exactly
            _yellow_background.frame = CGRectMake( -320 , 0, _yellow_background.frame.size.width, _yellow_background.frame.size.height ); // set new position exactly
        }
        [_buildStoryController setBackgroundColor:value];
    }
    _currentPart.isDone = true;
    [self  cleanView];
    [self generateNextQuestion];
    
}

- (void)openChoices:(id)sender{
    _firstTableView.hidden = false;
    _firstTableView.userInteractionEnabled = true;
    _firstTableView.layer.zPosition = MAXFLOAT;
    _firstTableView.allowsSelection = true;
    _firstTableView.editing = false;
}

- (void)chooseOption:(id)sender{
    _currentPart.answer = _labelHolder.text;
    _currentPart.isDone = true;
    [self cleanView];
    [self generateNextQuestion];
}

- (void)createNewStoryPartButton:(XYZStoryPart *)storyPart
{
    BOOL isDone = storyPart.isDone;
    int questionType = storyPart.type;
    NSString *question = storyPart.question;
    _currentPart = storyPart;
    if (_currentPart.isDone){
        UIButton *connectorLine = [UIButton buttonWithType:UIButtonTypeCustom];
        [connectorLine addTarget:self action:@selector(myCustomFunction:) forControlEvents:UIControlEventTouchUpInside];
        [connectorLine setBackgroundImage:[UIImage imageNamed:@"dottedline_contentboxes_big.png"] forState:UIControlStateNormal];
        connectorLine.frame = CGRectMake(159.5, 180 + _currentHeight, 1, 200);
        [_childScroller addSubview:connectorLine];
        
        
    }
    
    UIButton *myButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [myButton addTarget:self action:@selector(myCustomFunction:) forControlEvents:UIControlEventTouchUpInside];
    
    if([_currentPart.answer isEqualToString:@""]){
        
        [myButton setBackgroundImage:[UIImage imageNamed:@"content_messages-2.png"] forState:UIControlStateNormal];
        myButton.frame = CGRectMake(50, 50 + _currentHeight, 220, 180.0);
        [_childScroller addSubview:myButton];
        UILabel *myLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 200, 180)];
        [myLabel setBackgroundColor:[UIColor clearColor]];
        [myLabel setText:_currentPart.question];
        myLabel.font = [UIFont fontWithName:@"Moon Flower Bold" size:20];
        myLabel.textAlignment = NSTextAlignmentCenter;
        myLabel.numberOfLines = 5;
        
        [myButton addSubview:myLabel];
        
    }else{
        
        [myButton setBackgroundImage:[UIImage imageNamed:@"content_ball2-2.png"] forState:UIControlStateNormal];
        myButton.frame = CGRectMake(70.0, 50 + _currentHeight, 180.0, 180.0);
        [_childScroller addSubview:myButton];
        UILabel *myLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 17, 125, 100)];
        [myLabel setBackgroundColor:[UIColor clearColor]];
        [myLabel setText:_currentPart.question];
        myLabel.font = [UIFont fontWithName:@"Moon Flower Bold" size:20];
        myLabel.textAlignment = NSTextAlignmentCenter;
        myLabel.numberOfLines = 5;
        
        [myButton addSubview:myLabel];
        
    }
    
    
    if(true){
        //open answer
        if(questionType == 0 && _currentPart.isDone == false){
            
            _singleTap.enabled = true;
            UIButton *myButton2 = [UIButton buttonWithType:UIButtonTypeCustom];
            [myButton2 addTarget:self action:@selector(openAnswerEditButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [myButton2 setBackgroundImage:[UIImage imageNamed:@"icon_edit.png"] forState:UIControlStateNormal];
            myButton2.frame = CGRectMake(74, 140, 32.0, 32.0);
            
            [myButton addSubview:myButton2];
            
            
        }else if (questionType == 2){
            //multiple choice
            if(_currentPart.isDone){
                UIButton *myButton4 = [UIButton buttonWithType:UIButtonTypeCustom];
                [myButton4 addTarget:self action:@selector(myCustomFunction:) forControlEvents:UIControlEventTouchUpInside];
                [myButton4 setBackgroundImage:[UIImage imageNamed:@"content_scroll_big"] forState:UIControlStateNormal];
                myButton4.frame = CGRectMake(40, 234 + _currentHeight, 240, 36);
                
                [_childScroller addSubview:myButton4];
                
                UILabel *myLabel = [[UILabel alloc]initWithFrame:CGRectMake(40, 240 + _currentHeight, 240, 24)];
                [myLabel setText:_currentPart.answer];
                myLabel.font = [UIFont fontWithName:@"Moon Flower Bold" size:12];
                myLabel.textAlignment = NSTextAlignmentCenter;
                myLabel.numberOfLines = 10;
                
                
                [_childScroller addSubview:myLabel];
            }else{
                
                _singleTap.enabled = false;
                UIButton *myButton4 = [UIButton buttonWithType:UIButtonTypeCustom];
                [myButton4 addTarget:self action:@selector(openChoices:) forControlEvents:UIControlEventTouchUpInside];
                [myButton4 setBackgroundImage:[UIImage imageNamed:@"content_scroll_big"] forState:UIControlStateNormal];
                myButton4.frame = CGRectMake(40, 234 + _currentHeight, 240, 36);
                
                [_childScroller addSubview:myButton4];
                
                UILabel *myLabel = [[UILabel alloc]initWithFrame:CGRectMake(40, 240 + _currentHeight, 240, 24)];
                [myLabel setText:[_currentPart.listPickerQuestions objectAtIndex:0]];
                myLabel.font = [UIFont fontWithName:@"Moon Flower Bold" size:12];
                myLabel.textAlignment = NSTextAlignmentCenter;
                myLabel.numberOfLines = 10;
                
                
                [_childScroller addSubview:myLabel];
                _labelHolder = myLabel;
                
                UIButton *myButton2 = [UIButton buttonWithType:UIButtonTypeCustom];
                [myButton2 addTarget:self action:@selector(openChoices:) forControlEvents:UIControlEventTouchUpInside];
                [myButton2 setBackgroundImage:[UIImage imageNamed:@"icon_dropdown.png"] forState:UIControlStateNormal];
                myButton2.frame = CGRectMake(250, 240 + _currentHeight, 24, 24);
                
                [_childScroller addSubview:myButton2];
                
                CGRect fr = CGRectMake(40, 230+_currentHeight, 240, 50);
                
                _firstTableView.frame = fr;
                
                [_childScroller addSubview:_firstTableView];
                [_firstTableView reloadData];
                
                UIButton *myButton3 = [UIButton buttonWithType:UIButtonTypeCustom];
                [myButton3 addTarget:self action:@selector(chooseOption:) forControlEvents:UIControlEventTouchUpInside];
                [myButton3 setBackgroundImage:[UIImage imageNamed:@"icon_ok.png"] forState:UIControlStateNormal];
                myButton3.frame = CGRectMake(74, 140, 32.0, 32.0);
                
                [myButton addSubview:myButton3];
                _firstTableView.allowsSelectionDuringEditing = true;
                _firstTableView.allowsSelection = true;
                _firstTableView.hidden = true;
                [_firstTableView setAllowsSelection:YES];
            }
            
            
        }else if (questionType == 1){
            //slider
            if(_currentPart.isDone && _currentPart.isMoodQuestion){
                UIImage *moodFace = [UIImage imageNamed:@"mood_5.png"];
                UIView *v2 = [[UIView alloc] initWithFrame:CGRectMake(50, 90, 80, 80)];
                UIImageView *iv2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
                if([_currentPart.answer intValue] <= 11){
                    moodFace = [UIImage imageNamed:@"mood_9.png"];
                } else if([_currentPart.answer intValue]>11 && [_currentPart.answer intValue] <= 22){
                    moodFace = [UIImage imageNamed:@"mood_8.png"];
                } else if([_currentPart.answer intValue]>22 && [_currentPart.answer intValue] <= 33){
                    moodFace = [UIImage imageNamed:@"mood_7.png"];
                } else if([_currentPart.answer intValue]>33 && [_currentPart.answer intValue] <= 44){
                    moodFace = [UIImage imageNamed:@"mood_6.png"];
                } else if([_currentPart.answer intValue]>44 && [_currentPart.answer intValue] <= 55){
                    moodFace = [UIImage imageNamed:@"mood_5.png"];
                } else if([_currentPart.answer intValue]>55 && [_currentPart.answer intValue] <= 66){
                    moodFace = [UIImage imageNamed:@"mood_4.png"];
                } else if([_currentPart.answer intValue]>66 && [_currentPart.answer intValue] <= 77){
                    moodFace = [UIImage imageNamed:@"mood_3.png"];
                } else if([_currentPart.answer intValue]>77 && [_currentPart.answer intValue] <= 88){
                    moodFace = [UIImage imageNamed:@"mood_2.png"];
                } else if([_currentPart.answer intValue]>88 && [_currentPart.answer intValue] <= 100){
                    moodFace = [UIImage imageNamed:@"mood_1.png"];
                }
                [iv2 setImage:moodFace];
                [v2 addSubview:iv2];
                [myButton addSubview:v2];
            }else if (_currentPart.isDone == false){
                UIButton *myButton2 = [UIButton buttonWithType:UIButtonTypeCustom];
                [myButton2 addTarget:self action:@selector(acceptSlider:) forControlEvents:UIControlEventTouchUpInside];
                [myButton2 setBackgroundImage:[UIImage imageNamed:@"icon_ok.png"] forState:UIControlStateNormal];
                myButton2.frame = CGRectMake(74, 140, 32.0, 32.0);
                
                [myButton addSubview:myButton2];
                
                UIImage *sliderBar = [UIImage imageNamed:@"content_scroll.png"];
                UIView *v = [[UIView alloc] initWithFrame:CGRectMake(45, 248 + _currentHeight, 230, 40)];
                UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 230, 40)];
                [iv setImage:sliderBar];
                [v addSubview:iv];
                [_childScroller addSubview:v];
                
                CGRect frame = CGRectMake(50, 250 + _currentHeight, 220, 40);
                UISlider *slider = [[UISlider alloc] initWithFrame:frame];
                [slider addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
                [slider setBackgroundColor:[UIColor clearColor]];
                slider.minimumValue = 0.0;
                slider.maximumValue = 100.0;
                slider.continuous = YES;
                slider.value = 50.0;
                UIImage *sliderThumb = [UIImage imageNamed:@"content_scroll_ball.png"];
                CGSize destinationSize = CGSizeMake(28, 28);
                UIGraphicsBeginImageContext(destinationSize);
                [sliderThumb drawInRect:CGRectMake(0,0,destinationSize.width,destinationSize.height)];
                UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
                UIGraphicsEndImageContext();
                UIImageView *New = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 100, 100)];
                New.image = newImage;
                [slider setThumbImage:New.image forState:UIControlStateNormal];
                [slider setThumbImage:New.image forState:UIControlStateHighlighted];
                
                UIImage *sliderMinimum = [[UIImage imageNamed:@"content_scroll_invisible.png"] stretchableImageWithLeftCapWidth:4 topCapHeight:0];
                [slider setMinimumTrackImage:sliderMinimum forState:UIControlStateNormal];
                UIImage *sliderMaximum = [[UIImage imageNamed:@"content_scroll_invisible.png"] stretchableImageWithLeftCapWidth:4 topCapHeight:0];
                [slider setMaximumTrackImage:sliderMaximum forState:UIControlStateNormal];
                
                [_childScroller addSubview:slider];
                if(_currentPart.isMoodQuestion){
                    UIImage *moodFace = [UIImage imageNamed:@"mood_5.png"];
                    UIView *v2 = [[UIView alloc] initWithFrame:CGRectMake(65, 85, 50, 50)];
                    UIImageView *iv2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
                    [iv2 setImage:moodFace];
                    
                    [v2 addSubview:iv2];
                    
                    [myButton addSubview:v2];
                    _currentImage = iv2;
                }
                
                
                _currentSlider = slider;
            }
            if(_currentPart.isMoodQuestion == false &&_currentPart.isDone == false){
                _percentageLabelHolder = [[UILabel alloc]initWithFrame:CGRectMake(70, 70 , 270, 100)];
                NSMutableString* string = [[NSMutableString alloc]init];
                if(_currentPart.isDone){
                    [string appendString:_currentPart.answer];
                    [string appendString:@"%"];
                }else{
                    [string appendString:@"50%"];
                }
                [_percentageLabelHolder setText:string];
                _percentageLabelHolder.font = [UIFont fontWithName:@"Moon Flower Bold" size:40];
                _percentageLabelHolder.textAlignment = NSTextAlignmentLeft;
                _percentageLabelHolder.numberOfLines = 10;
                [myButton addSubview:_percentageLabelHolder];
            }else if(_currentPart.isMoodQuestion == false &&_currentPart.isDone == true){
                _percentageLabelHolder = [[UILabel alloc]initWithFrame:CGRectMake(70, 70 , 270, 100)];
                NSMutableString* string = [[NSMutableString alloc]init];
                if(_currentPart.isDone){
                    [string appendString:_currentPart.answer];
                    [string appendString:@"%"];
                }else{
                    [string appendString:@"50%"];
                }
                [_percentageLabelHolder setText:string];
                _percentageLabelHolder.font = [UIFont fontWithName:@"Moon Flower Bold" size:45];
                _percentageLabelHolder.textAlignment = NSTextAlignmentLeft;
                _percentageLabelHolder.numberOfLines = 10;
                [myButton addSubview:_percentageLabelHolder];
            }
            
        }
    }
    
    _currentHeight += 300;
    _childScroller.contentSize = CGSizeMake(240,_currentHeight+20);
    
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
    _pickerAnswer = [_currentPart.listPickerQuestions objectAtIndex:row];
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
        _pickerAnswer = [_currentPart.listPickerQuestions objectAtIndex:0];
        
    }
    
    // Fill the label text here
    tView.text=[_currentPart.listPickerQuestions objectAtIndex:row];
    
    return tView;
}

- (IBAction)sliderAction:(id)sender
{
    if(!_currentPart.isMoodQuestion){
        int moodSliderValue= _currentSlider.value;
        NSMutableString* string = [[NSMutableString alloc]init];
        [string appendString:[NSString stringWithFormat:@"%d",moodSliderValue]];
        [string appendString:@"%"];
        _percentageLabelHolder.text = string;
    }
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [_currentPart.listPickerQuestions count];
    
}

-(CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath {
    
    NSString* holder = [_currentPart.listPickerQuestions objectAtIndex:indexPath.row];
    UILabel *myLabel = [[UILabel alloc]initWithFrame:CGRectMake(25, 0, 270, 100)];
    [myLabel setText:holder];
    myLabel.font = [UIFont fontWithName:@"Moon Flower Bold" size:15];
    myLabel.textAlignment = NSTextAlignmentCenter;
    myLabel.numberOfLines = 10;
    CGSize maximumLabelSize = CGSizeMake(296, FLT_MAX);
    
    CGSize expectedLabelSize = [myLabel.text sizeWithFont:myLabel.font constrainedToSize:maximumLabelSize lineBreakMode:myLabel.lineBreakMode];
    
    return expectedLabelSize.height;
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString *CellIdentifier = @"contentRow";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.textLabel.font = [UIFont fontWithName:@"Moon Flower Bold" size:15];
    cell.textLabel.text = [_currentPart.listPickerQuestions objectAtIndex:indexPath.row];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    
    
    
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _labelHolder.text = [_currentPart.listPickerQuestions objectAtIndex:indexPath.row];
    _firstTableView.hidden = true;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

- (void)myCustomFunction:(id)sender{
    NSLog(@"button was clicked");
}

-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath;
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
