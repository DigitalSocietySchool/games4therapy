//
//  XYZStoryOverviewTableViewController.m
//  KeepIt
//
//  Created by Medialab_student on 6/10/14.
//  Copyright (c) 2014 Games4Therapy. All rights reserved.
//

#import "XYZStoryOverviewTableViewController.h"
#import "XYZMainScreenViewController.h"
#import "XYZOverviewViewController.h"

@interface XYZStoryOverviewTableViewController ()
@property (strong, nonatomic) XYZMainScreenViewController *controller;
@property (weak, nonatomic) IBOutlet UILabel *createButtonLabel;
@property (weak, nonatomic) IBOutlet UILabel *mainMenuLabel;
@property (strong, nonatomic) IBOutlet UITableView *tableview;
@end

@implementation XYZStoryOverviewTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.listOfStories = [[NSMutableArray alloc]init];
    self.currentStory = [[NSMutableArray alloc]init];
    
    if (self.controller == nil){
        [self loadInitialData];
    } else {
        self.listOfStories = _controller.listOfStories;
    }
    _mainMenuLabel.font =[UIFont fontWithName:@"Moon Flower Bold" size:24];
    _createButtonLabel.font =[UIFont fontWithName:@"Moon Flower" size:12];
    _createButtonLabel.userInteractionEnabled = false;

    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"backgroundLowerHalf.jpg"]];
    self.tableView.backgroundView = imageView;
    _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    

}


- (void)setUpConnectionWithParent:(XYZMainScreenViewController *)parent
{
    _controller = parent;
}

- (void)loadInitialData{
    
    NSLog(@"loadInitialDataCalled");
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.listOfStories count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"StoryOverviewRow";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    NSMutableArray *story = [self.listOfStories objectAtIndex:indexPath.row];
    XYZStoryPart *storyPart = [story objectAtIndex:0];
    if(![storyPart.title isEqualToString:@""]){
        cell.textLabel.text = storyPart.title;
    }else{
        cell.textLabel.text = @"No Title";
    }
    cell.textLabel.font = [UIFont fontWithName:@"Moon Flower Bold" size:23];
    [cell setOpaque:FALSE];
    [cell setBackgroundColor:[UIColor clearColor]];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    
    UIButton *myButton = [UIButton alloc];
    myButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [myButton addTarget:self action:@selector(myCustomFunction:) forControlEvents:UIControlEventTouchUpInside];
    [myButton setBackgroundImage:[UIImage imageNamed:@"dottedline_full.png"] forState:UIControlStateNormal];
    myButton.frame = CGRectMake(0, 38, 380, 1);
    myButton.userInteractionEnabled = false;
    [cell addSubview:myButton];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _currentStory = [_listOfStories objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"showOverviewSegue" sender:self];
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //remove the deleted object from your data source.
        //If your data source is an NSMutableArray, do this
        [self.listOfStories removeObjectAtIndex:indexPath.row];
        [tableView reloadData]; // tell table to refresh now
    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"showOverviewSegue"]){
    XYZOverviewViewController* overviewController = [segue destinationViewController];
    [overviewController setUpConnectionWithParent:self];
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    }
    
}

- (IBAction)unwindToList:(UIStoryboardSegue *)segue
{
    
}

@end
