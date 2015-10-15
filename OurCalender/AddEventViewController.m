//
//  AddEventView.m
//  Holiday
//
//  Created by shuang yang on 3/10/15.
//
//

#import "AddEventViewController.h"

@interface AddEventViewController ()
@property (retain, nonatomic) IBOutlet UITextField *eventTitle;
@property (retain, nonatomic) IBOutlet UITextField *eventLoc;
@property (retain, nonatomic) IBOutlet UIDatePicker *startDatePicker;
@property (retain, nonatomic) IBOutlet UIButton *startDateButton;
@property (retain, nonatomic) IBOutlet UIButton *endDateButton;
@property (retain, nonatomic) IBOutlet UIDatePicker *endDatePicker;

@end

@implementation AddEventViewController
- (IBAction)setStartDate:(UIButton *)sender
{
    CGRect frame = self.endDateButton.frame;
    CGRect frame2 = self.endDatePicker.frame;

    if ([self.startDatePicker isHidden]) {
        [self.startDatePicker setHidden:NO];
        frame.origin.y += 215; // new y coordinate
        frame2.origin.y += 215;
    } else {
        [self.startDatePicker setHidden:YES];
        frame.origin.y -= 215; // new y coordinate
        frame2.origin.y -= 215;

    }
    self.endDateButton.frame = frame;
    self.endDatePicker.frame = frame2;


}
- (IBAction)setEndDate:(UIButton *)sender
{
    if ([self.endDatePicker isHidden]) {
        [self.endDatePicker setHidden:NO];
    } else {
        [self.endDatePicker setHidden:YES];
    }
}

- (IBAction)getStartDate:(UIDatePicker *)sender
{
    NSDate *date = sender.date;
    NSDateFormatter *format = [[NSDateFormatter alloc]init];
    format.timeStyle = NSDateFormatterMediumStyle;
    format.dateStyle = NSDateFormatterMediumStyle;
    
    NSString *getDate = [format stringFromDate:date];

    [self.startDateButton setTitle:[NSString stringWithFormat:@"  Start   %@", getDate] forState:UIControlStateNormal];
}
- (IBAction)getEndDate:(UIDatePicker *)sender
{
    NSDate *date = sender.date;
    NSDateFormatter *format = [[NSDateFormatter alloc]init];
    format.timeStyle = NSDateFormatterMediumStyle;
    format.dateStyle = NSDateFormatterMediumStyle;
    
    NSString *getDate = [format stringFromDate:date];
    
    [self.endDateButton setTitle:[NSString stringWithFormat:@"  End   %@", getDate] forState:UIControlStateNormal];
}

- (void)viewDidLoad {

    [super viewDidLoad];
    // Do any additional setup after loading the view,  typically from a nib.
    NSDate *date = [NSDate date];
    NSDateFormatter *format = [[NSDateFormatter alloc]init];
    format.timeStyle = NSDateFormatterMediumStyle;
    format.dateStyle = NSDateFormatterMediumStyle;
    NSString *getDate = [format stringFromDate:date];
    [self.startDateButton setTitle:[NSString stringWithFormat:@"  Start   %@", getDate] forState:UIControlStateNormal];
    [self.endDateButton setTitle:[NSString stringWithFormat:@"  End   %@", getDate] forState:UIControlStateNormal];

}

- (void)dealloc {
    [_startDateButton release];
    [_endDatePicker release];
    [super dealloc];
}
@end