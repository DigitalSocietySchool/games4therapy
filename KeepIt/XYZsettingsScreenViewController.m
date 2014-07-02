//
//  XYZsettingsScreenViewController.m
//  KeepIt
//
//  Created by Medialab_student on 6/11/14.
//  Copyright (c) 2014 Games4Therapy. All rights reserved.
//

#import "XYZMainScreenViewController.h"
#import "XYZsettingsScreenViewController.h"
#import "XYZnewQuestionViewController.h"

@interface XYZsettingsScreenViewController ()
@property (weak, nonatomic) IBOutlet UITableView *questionsTable;
@property (weak, nonatomic) IBOutlet UITableView *categoryTable;
@property (weak, nonatomic) IBOutlet UIButton *dropdownMenuButton;
@property (weak, nonatomic) IBOutlet UILabel *currentCategoryLabel;
@property (weak, nonatomic) IBOutlet UILabel *selectContentLabel;
@property (weak, nonatomic) IBOutlet UILabel *menuLabel;

@property (strong, nonatomic) XYZMainScreenViewController* parent;

@property int categoryRow;
@property int questionRowSelected;

@property (strong, nonatomic) NSMutableArray* categoryNames;

@end

@implementation XYZsettingsScreenViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)dropdownButtonClicked:(id)sender {
    _categoryTable.hidden = false;
}

- (IBAction)unwindToSettings:(UIStoryboardSegue *)segue{
    XYZnewQuestionViewController *source = [segue sourceViewController];
    NSMutableArray* array = [_categoryHolder objectAtIndex:_categoryRow];
    [array addObject:source.answerHolder];
    [_questionsTable reloadData];
    [_categoryTable reloadData];
}

- (void)setUpConnectionWithParent:(XYZMainScreenViewController*)parent{
    _parent = parent;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _categoryTable.hidden = true;
    _questionsTable.delegate = self;
    _categoryTable.delegate = self;
    _categoryTable.dataSource = self;
    _questionsTable.dataSource = self;
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"backgroundLowerHalf.jpg"]];
    _questionsTable.backgroundView = imageView;
    _questionsTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    _categoryNames = [[NSMutableArray alloc]init];
    
    _categoryRow = 0;
    _currentCategoryLabel.text = @"Situation";
    
    _currentCategoryLabel.font = [UIFont fontWithName:@"Moon Flower Bold" size:18];
    _menuLabel.font = [UIFont fontWithName:@"Moon Flower Bold" size:24];
    
    [_categoryNames addObject:@"Situation"];
    [_categoryNames addObject:@"Automatic Thoughts"];
    [_categoryNames addObject:@"Believe"];
    [_categoryNames addObject:@"Evidence"];
    [_categoryNames addObject:@"Contra Evidence"];
    [_categoryNames addObject:@"Behavior"];
    [_categoryNames addObject:@"Contra Behavior"];
    [_categoryNames addObject:@"Consequences"];
    [_categoryNames addObject:@"Mood Check"];
    [_categoryNames addObject:@"Messages"];
    [_categoryNames addObject:@"Alternative Thoughts"];
    
    _categoryHolder = _parent.categoryHolder;
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView == self.questionsTable){
        // Return the number of rows in the section.
        NSMutableArray* listOfQuestions = [self.categoryHolder objectAtIndex:_categoryRow];
        return [listOfQuestions count];
    }else {
        return [_categoryNames count];
    }
}
- (IBAction)deleteButtonClicked:(id)sender {
    NSMutableArray* array = [_categoryHolder objectAtIndex:_categoryRow];
    if([array count] > 0){
    [array removeObjectAtIndex:_questionRowSelected];
    [_questionsTable reloadData];
    }
}

-(CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath {
    
    if(tableView ==self.questionsTable){
    
    // Retrieve the line for this index (from JSON)
        NSMutableArray* listOfQuestions = [self.categoryHolder objectAtIndex:_categoryRow];
        NSString* holder = [listOfQuestions objectAtIndex:indexPath.row];
    
        
        UILabel *myLabel = [[UILabel alloc]initWithFrame:CGRectMake(25, 0, 270, 100)];
        [myLabel setText:holder];
        myLabel.font = [UIFont fontWithName:@"Moon Flower Bold" size:23];
        myLabel.textAlignment = NSTextAlignmentCenter;
        myLabel.numberOfLines = 10;
        CGSize maximumLabelSize = CGSizeMake(296, FLT_MAX);
        
        CGSize expectedLabelSize = [myLabel.text sizeWithFont:myLabel.font constrainedToSize:maximumLabelSize lineBreakMode:myLabel.lineBreakMode];
        
        return expectedLabelSize.height;
    }else{
        
        NSString* holder = [_categoryNames objectAtIndex:indexPath.row];
        UILabel *myLabel = [[UILabel alloc]initWithFrame:CGRectMake(25, 0, 270, 100)];
        [myLabel setText:holder];
        myLabel.font = [UIFont fontWithName:@"Moon Flower Bold" size:23];
        myLabel.textAlignment = NSTextAlignmentCenter;
        myLabel.numberOfLines = 10;
        CGSize maximumLabelSize = CGSizeMake(296, FLT_MAX);
        
        CGSize expectedLabelSize = [myLabel.text sizeWithFont:myLabel.font constrainedToSize:maximumLabelSize lineBreakMode:myLabel.lineBreakMode];
        
        return expectedLabelSize.height;
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(tableView == self.questionsTable){
        static NSString *CellIdentifier = @"questionRow";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        NSMutableArray* listOfQuestions = [self.categoryHolder objectAtIndex:_categoryRow];
        NSString* holder = [listOfQuestions objectAtIndex:indexPath.row];
        cell.textLabel.text = holder;
        cell.textLabel.font = [UIFont fontWithName:@"Moon Flower Bold" size:23];
        cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
        cell.textLabel.numberOfLines = 5;
        [cell setOpaque:FALSE];
        [cell setBackgroundColor:[UIColor clearColor]];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        
        UILabel *myLabel = [[UILabel alloc]initWithFrame:CGRectMake(25, 0, 270, 100)];
        [myLabel setText:holder];
        myLabel.font = [UIFont fontWithName:@"Moon Flower Bold" size:23];
        myLabel.textAlignment = NSTextAlignmentCenter;
        myLabel.numberOfLines = 10;
        CGSize maximumLabelSize = CGSizeMake(296, FLT_MAX);
        
        CGSize expectedLabelSize = [myLabel.text sizeWithFont:myLabel.font constrainedToSize:maximumLabelSize lineBreakMode:myLabel.lineBreakMode];
        
        UIButton *myButton = [UIButton alloc];
        myButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [myButton addTarget:self action:@selector(myCustomFunction:) forControlEvents:UIControlEventTouchUpInside];
        [myButton setBackgroundImage:[UIImage imageNamed:@"dottedline_full.png"] forState:UIControlStateNormal];
        myButton.frame = CGRectMake(0, expectedLabelSize.height, 380, 1);
        myButton.userInteractionEnabled = false;
        [cell addSubview:myButton];
        
        return cell;
    } else {
        static NSString *CellIdentifier = @"contentRow";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        cell.textLabel.font = [UIFont fontWithName:@"Moon Flower Bold" size:18];
        cell.textLabel.text = [_categoryNames objectAtIndex:indexPath.row];
        [cell setOpaque:FALSE];
        [cell setBackgroundColor:[UIColor clearColor]];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        
        UIButton *myButton = [UIButton alloc];
        myButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [myButton addTarget:self action:@selector(myCustomFunction:) forControlEvents:UIControlEventTouchUpInside];
        [myButton setBackgroundImage:[UIImage imageNamed:@"dottedline_full.png"] forState:UIControlStateNormal];
        myButton.frame = CGRectMake(0, 38, 380, 1);
        myButton.userInteractionEnabled = false;
        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == self.questionsTable){
        _questionRowSelected = indexPath.row;
    }else{
        _categoryRow = indexPath.row;
        _currentCategoryLabel.text = [_categoryNames objectAtIndex:_categoryRow];
        _categoryTable.hidden = true;
        [_questionsTable reloadData];
    }
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}


 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
     if([segue.identifier isEqualToString:@"addNewQuestionSegue"]){
     XYZnewQuestionViewController* newC = segue.destinationViewController;
     NSMutableString *string = [[NSMutableString alloc]init];
     [string appendString:@"Add Question To "];
     [string appendString:[_categoryNames objectAtIndex:_categoryRow]];
     newC.questionHolder = string;
     }
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }


@end
