//
//  AddEventController.h
//  OurCalender
//
//  Created by shuang yang on 3/10/15.
//  Copyright (c) 2015 shuang yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewEventViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UITextField *eventTitle;

@property (weak, nonatomic) IBOutlet UITextField *eventLocation;

@property (weak, nonatomic) IBOutlet UIDatePicker *startPicker;

@property (weak, nonatomic) IBOutlet UIDatePicker *endPicker;

@property (weak, nonatomic) IBOutlet UILabel *startDate;

@property (weak, nonatomic) IBOutlet UILabel *endDate;
@property (weak, nonatomic) IBOutlet UITextField *eventdetail;
@property (weak, nonatomic) IBOutlet UILabel *inviteLB;
@property (weak, nonatomic) IBOutlet UIButton *addInvites;

@property (strong, nonatomic) IBOutletCollection(UITextField) NSArray *invites;
@end
