//
//  EventsViewController.m
//  OurCalender
//
//  Created by shuang yang on 3/10/15.
//  Copyright (c) 2015 shuang yang. All rights reserved.
//
#import "EventsViewController.h"
#import "User.h"
#import "Event.h"
#import "ChatViewController.h"
#import "NewEventViewController.h"
@interface EventsViewController ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *pendingB;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *acceptedB;

@end

@implementation EventsViewController
#pragma mark - UITableViewDataSource
{
    NSMutableArray *tableData;
    ChatViewController *chat;
    NewEventViewController *destViewController;
    NSString *selectedTitle;
    int state;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    tableData = [User getEvents];
    chat = [[ChatViewController alloc]init];
    
    if ([self.title isEqualToString:@"My Events"]) {
        state = 0;
    } else if ([self.title isEqualToString:@"My Pending Events"]) {
        [self.pendingB setTitle:@"Accepted"];
        [self.acceptedB setTitle:@"My Events"];
        state = 1;
    }
    else if ([self.title isEqualToString:@"My Accepted Events"]) {
        [self.pendingB setTitle:@"My Events"];
        [self.acceptedB setTitle:@"Pending"];
        state = 2;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableData count];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    selectedTitle = cell.textLabel.text;
    destViewController.eventTitle.text = selectedTitle;
    NSArray* events = [User getEvents];
    for (Event *o in events) {
        if ([o.eventTitle isEqualToString:selectedTitle]) {
            destViewController.title = [o.hostname stringByAppendingString:@"'s Invitation"];
            destViewController.eventLocation.text = o.eventLocation;
            destViewController.eventdetail.text = o.eventDetail;
            destViewController.startDate.text = o.startDate;
            destViewController.endDate.text = o.endDate;
            [destViewController.addInvites setHidden:YES];
            o.invites = [o.invites substringToIndex:o.invites.length-1];
            NSArray *invites = [o.invites componentsSeparatedByString:@","];
            
            NSMutableAttributedString *invitesList = [[NSMutableAttributedString alloc] initWithString:@"Invitees:"];
            for (NSString *s in invites) {
                NSString *status = [s substringToIndex:1];
                NSString *name = [s substringFromIndex:1];
                name = [name stringByAppendingString:@", "];
                NSMutableAttributedString *colorname = [[NSMutableAttributedString alloc] initWithString:name];
                if ([status isEqualToString:@"0"]) {
                    [colorname addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:NSMakeRange(0, [colorname length])];
                } else if ([status isEqualToString:@"1"]) {
                    [colorname addAttribute:NSForegroundColorAttributeName value:[UIColor greenColor] range:NSMakeRange(0, [colorname length])];
                } else if ([status isEqualToString:@"2"]) {
                    [colorname addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, [colorname length])];
                }
                [invitesList appendAttributedString:colorname];
            }
            destViewController.inviteLB.attributedText = invitesList;
        }
    }
    // now you can use cell.textLabel.text
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *eventItem = @"eventItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:eventItem];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:eventItem];
    }
    
    Event *o = [tableData objectAtIndex:indexPath.row];
    cell.textLabel.text = o.eventTitle;
    return cell;
}
- (IBAction)clear:(id)sender {
    [tableData removeAllObjects];
    NSString *un = [User getUsername];
    NSString *msg;
    if (state == 0) {
         msg = [NSString stringWithFormat:@"2%@\n", un];
    } else if (state == 1) {
        msg = [NSString stringWithFormat:@"4%@\n", un]; //pending
    } else if (state == 2) {
        msg = [NSString stringWithFormat:@"3%@\n", un]; //accepted
    }
    [chat sendMsg:msg];
    tableData = [User getEvents];
}

- (IBAction)doRefresh:(id)sender {
    tableData = [User getEvents];
    [self.tableView reloadData];
    [sender endRefreshing];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if (state == 0) {
        if ([segue.identifier isEqualToString:@"detailEvent"]) {
            destViewController = segue.destinationViewController;
            destViewController.navigationItem.rightBarButtonItem = nil;
            destViewController.tableView.userInteractionEnabled = NO;
        }
        if ([segue.identifier isEqualToString:@"pendingEvent"]) {
            destViewController = segue.destinationViewController;
            destViewController.title = @"My Pending Events";
        }
        if ([segue.identifier isEqualToString:@"acceptedEvent"]) {
            destViewController = segue.destinationViewController;
            destViewController.title = @"My Accepted Events";
        }
    } else if (state == 1) {
        if ([segue.identifier isEqualToString:@"detailEvent"]) {
            destViewController = segue.destinationViewController;
            destViewController.tableView.userInteractionEnabled = NO;
            destViewController.navigationItem.rightBarButtonItem.title = @"Accept";
        }
        if ([segue.identifier isEqualToString:@"pendingEvent"]) {
            destViewController = segue.destinationViewController;
            destViewController.title = @"My Accepted Events";
        }
        if ([segue.identifier isEqualToString:@"acceptedEvent"]) {
            destViewController = segue.destinationViewController;
            destViewController.title = @"My Events";
        }
    } else if (state == 2) {
        if ([segue.identifier isEqualToString:@"pendingEvent"]) {
            destViewController = segue.destinationViewController;
            destViewController.title = @"My Events";
        }
        if ([segue.identifier isEqualToString:@"acceptedEvent"]) {
            destViewController = segue.destinationViewController;
            destViewController.title = @"My Pending Events";
        }
    }


    
    
}
- (void) edit {
}
@end