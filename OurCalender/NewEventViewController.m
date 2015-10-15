//

//  EventsViewController.m

//  OurCalender

//

//  Created by shuang yang on 3/10/15.

//  Copyright (c) 2015 shuang yang. All rights reserved.

//



#import "NewEventViewController.h"
#import "ChatViewController.h"
#import "User.h"
#import "Event.h"

@interface NewEventViewController ()


@property (weak, nonatomic) IBOutlet UIBarButtonItem *rightB;


@end



@implementation NewEventViewController
{
    int numInvites;
    BOOL editingStartTime;
    BOOL editingEndTime;
    ChatViewController *chat;
}


- (void)viewDidLoad {
    
    chat = [[ChatViewController alloc]init];
    
    editingStartTime = TRUE;
    editingEndTime = TRUE;

    NSDate *date = [NSDate date];
    NSDateFormatter *format = [[NSDateFormatter alloc]init];
    format.timeStyle = NSDateFormatterMediumStyle;
    format.dateStyle = NSDateFormatterMediumStyle;
    NSString *getDate = [format stringFromDate:date];
    self.startDate.text = getDate;
    self.endDate.text = getDate;
    numInvites = 0;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1 && indexPath.row == 1) { // this is my picker cell
        if (editingStartTime) {
            [self.startPicker setHidden:YES];
            return 0;
        } else {
            [self.startPicker setHidden:NO];
            return 219;
        }
    }
    
    else if (indexPath.section == 1 && indexPath.row == 3) { // this is my picker cell
        if (editingEndTime) {
            [self.endPicker setHidden:YES];
            return 0;
        } else {
            [self.endPicker setHidden:NO];
            return 219;
        }
    }
    else if (indexPath.section == 2 && indexPath.row > numInvites) {
        return 0;
    }
    else if (indexPath.section == 3 && indexPath.row == 0) {
        return 70;
    }
    else {
        return self.tableView.rowHeight;
    }

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 1 && indexPath.row == 0) { // this is my date cell above the picker cell
        editingStartTime = !editingStartTime;
        [tableView beginUpdates]; [tableView endUpdates];
    }
    
    if (indexPath.section == 1 && indexPath.row == 2) { // this is my date cell above the picker cell
        editingEndTime = !editingEndTime;
        [tableView beginUpdates]; [tableView endUpdates];
    }
}



- (IBAction)getStartDate:(UIDatePicker *)sender
{
    NSDate *date = sender.date;
    NSDateFormatter *format = [[NSDateFormatter alloc]init];
    format.timeStyle = NSDateFormatterMediumStyle;
    format.dateStyle = NSDateFormatterMediumStyle;
    NSString *getDate = [format stringFromDate:date];
    self.startDate.text = getDate;
    
}

- (IBAction)getEndDate:(UIDatePicker *)sender
{
    NSDate *date = sender.date;
    NSDateFormatter *format = [[NSDateFormatter alloc]init];
    format.timeStyle = NSDateFormatterMediumStyle;    
    format.dateStyle = NSDateFormatterMediumStyle;
    NSString *getDate = [format stringFromDate:date];
    self.endDate.text = getDate;
    
}

- (IBAction)addInvites:(id)sender {
    if (numInvites < 6) {
        numInvites += 1;
        [self.tableView beginUpdates]; [self.tableView endUpdates];
    }
}


- (IBAction)saveAndSend:(UIBarButtonItem*)sender {
    NSString *username = [User getUsername];
    NSString *title = self.eventTitle.text;
    NSString *location = self.eventLocation.text;
    NSString *detail = self.eventdetail.text;
    NSData *startDate = self.startPicker.date;
    NSData *endDate = self.endPicker.date;
    if ([sender.title isEqualToString:@"Save"]) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
        NSString *start = [dateFormatter stringFromDate: startDate];
        NSString *end = [dateFormatter stringFromDate: endDate];
        
        NSString *msg = [NSString stringWithFormat:@"5%@^%@^%@^%@^%@^%@^", username, title, location, detail, start, end];
        NSString *iv = @"";
        int i = 0;
        for (UITextField *o in self.invites) {
            if (i++ < numInvites) {
                iv = [[iv stringByAppendingString:o.text] stringByAppendingString:@","];
            }
        }
        //iv = [iv substringToIndex:iv.length-1];
        msg = [msg stringByAppendingString:iv];
        msg = [msg stringByAppendingString:@"\n"];
        [chat sendMsg:msg];
    } else if ([sender.title isEqualToString:@"Accept"]) {
        NSString *username = [User getUsername];
        NSString *hostname = [self.title substringToIndex:self.title.length-13];

        NSString *msg = [NSString stringWithFormat:@"6%@_%@_%@", hostname, title, username];

        msg = [msg stringByAppendingString:@"\n"];
        [chat sendMsg:msg];
    }

}


 




/*
 
 // Override to support editing the table view.
 
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 
 // Delete the row from the data source
 
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 
 }
 
 }
 
 */



/*
 
 // Override to support rearranging the table view.
 
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 
 }
 
 */



/*
 
 // Override to support conditional rearranging of the table view.
 
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 
 // Return NO if you do not want the item to be re-orderable.
 
 return YES;
 
 }
 
 */



/*
 
 #pragma mark - Table view delegate
 
 
 
 // In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
 
 - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
 
 // Navigation logic may go here, for example:
 
 // Create the next view controller.
 
 <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
 
 
 
 // Pass the selected object to the new view controller.
 
 
 
 // Push the view controller.
 
 [self.navigationController pushViewController:detailViewController animated:YES];
 
 }
 
 */



/*
 
 #pragma mark - Navigation
 
 
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 
 // Get the new view controller using [segue destinationViewController].
 
 // Pass the selected object to the new view controller.
 
 }
 
 */



@end

