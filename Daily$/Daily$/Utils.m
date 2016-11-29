//
//  Utils.m
//  Daily$
//
//  Created by chance on 10/8/2016.
//  Copyright © 2016 bychance. All rights reserved.
//

#import "Utils.h"

NSString *FormattedValue(double value) {
    return [NSString stringWithFormat:@"%s%.0f", value > 0 ? "+" : "", value];
}