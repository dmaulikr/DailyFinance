//
//  DailyInfo.h
//  Daily$
//
//  Created by chance on 8/17/16.
//  Copyright © 2016 bychance. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CostInfo.h"

@interface DailyInfo : NSObject

@property (nonatomic, copy) NSString *dateString;
@property (nonatomic, copy) NSArray *costInfos;

@end
