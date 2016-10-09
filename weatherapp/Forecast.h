//
//  Forecast.h
//  weatherapp
//
//  Created by Mark Pettersson on 2016-10-08.
//  Copyright © 2016 Mark Pettersson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Weather.h"
@interface Forecast : NSObject
@property (nonatomic, retain) NSMutableArray *weatherByDay;

- (id)initWithDic: (NSDictionary *)myDic;

@end
