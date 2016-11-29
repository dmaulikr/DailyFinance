//
//  CalenderCell.h
//  Daily$
//
//  Created by chance on 8/17/16.
//  Copyright © 2016 bychance. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kCalenderCellIdentifier @"CalenderCell"

@interface CalenderCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *costLabel;

@end
