//
//  ViewController.m
//  Daily$
//
//  Created by chance on 8/8/2016.
//  Copyright © 2016 bychance. All rights reserved.
//

#import <EventKit/EventKit.h>
#import "MainViewController.h"
#import "NSDate+Additions.h"
#import "Utils.h"
#import "CalenderCell.h"
#import "CalenderHeader.h"
#import "DailyInfo.h"

//666B73
@interface MainViewController ()<UITableViewDelegate, UITableViewDataSource> {
    __weak IBOutlet UITableView *_tableView;
    __weak IBOutlet UILabel *_totalLabel;
    NSArray *_dailyInfos;
    EKEventStore *_eventStore;
}

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UINib *nib = [UINib nibWithNibName:@"CalenderHeader" bundle:[NSBundle mainBundle]];
    [_tableView registerNib:nib forHeaderFooterViewReuseIdentifier:kHeaderIdentifier];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onApplicationWillEnterForegroundNotification) name:UIApplicationWillEnterForegroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onEventStoreChangedNotificaiton) name:EKEventStoreChangedNotification object:nil];
    
    _eventStore =[[EKEventStore alloc] init];
    [_eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError * _Nullable error) {
        NSLog(@"Granted: %d", granted);
    }];
    [self refreshData];
}


- (void)refreshData {
    // get all events of this year
    NSDateComponents *yearComponents = [[NSDate date] dateComponents];
    yearComponents.month = 1;
    yearComponents.day = 1;
    NSDate *thisYear = [[NSCalendar currentCalendar] dateFromComponents:yearComponents];
    NSPredicate *predicate = [_eventStore predicateForEventsWithStartDate:thisYear
                                                                  endDate:[NSDate date]
                                                                calendars:nil];
    NSArray *events = [_eventStore eventsMatchingPredicate:predicate];
    NSMutableArray *moneyEvents = [NSMutableArray array];
    for (EKEvent *event in events) {
        if ([event.notes hasPrefix:@"$"]) {
            [moneyEvents addObject:event];
        }
    }
    [moneyEvents sortUsingComparator:^NSComparisonResult(EKEvent *event1, EKEvent *event2) {
        return [event2.startDate compare:event1.startDate];
    }];
    
    // convert to daily infos
    double totalCost = 0;
    NSMutableArray *displayInfos = [NSMutableArray array];
    NSDate *currentDate;
    NSMutableArray *currentCostInfos = [NSMutableArray array];
    DailyInfo *currentDateInfo;
    for (EKEvent *event in moneyEvents) {
        if (![event.startDate isTheSameDayToDate:currentDate]) {
            currentDateInfo.costInfos = currentCostInfos;
            [currentCostInfos removeAllObjects];
            
            currentDateInfo = [DailyInfo new];
            currentDateInfo.dateString = [event.startDate formattedString];
            [displayInfos addObject:currentDateInfo];
            currentDate = event.startDate;
        }
        CostInfo *cost = [CostInfo new];
        cost.title = event.title;
        cost.cost = [event.notes substringFromIndex:1];
        [currentCostInfos addObject:cost];
        
        totalCost += [cost.cost doubleValue];
        
        if ([cost.cost doubleValue] == 0) {
            NSLog(@"Error: invalid cost: %@", event.notes);
        }
    }
    currentDateInfo.costInfos = currentCostInfos;
    _dailyInfos = [displayInfos copy];
    
    [_tableView reloadData];
    _totalLabel.text = [NSString stringWithFormat:@"$%.f", totalCost];
    _totalLabel.textColor = totalCost >= 0 ? UIColorFromRGB(0x666B73) : UIColorFromRGB(0xdf735c);
}


- (void)onApplicationWillEnterForegroundNotification {
    [self refreshData];
}


- (void)onEventStoreChangedNotificaiton {
    [self refreshData];
}


#pragma mark - TableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _dailyInfos.count;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    DailyInfo *info = _dailyInfos[section];
    return info.costInfos.count;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    CalenderHeader *headerView = (CalenderHeader *)[_tableView dequeueReusableHeaderFooterViewWithIdentifier:kHeaderIdentifier];
    DailyInfo *info = _dailyInfos[section];
    headerView.titleLabel.text = info.dateString;
    return headerView;
}


- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CalenderCell *cell = [tableView dequeueReusableCellWithIdentifier:kCalenderCellIdentifier];
    DailyInfo *info = _dailyInfos[indexPath.section];
    CostInfo *costInfo = info.costInfos[indexPath.row];
    cell.titleLabel.text = costInfo.title;
    cell.costLabel.text = costInfo.cost;
    
    return cell;
}






@end





