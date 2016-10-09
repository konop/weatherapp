//
//  Forecast.m
//  weatherapp
//
//  Created by Mark Pettersson on 2016-10-08.
//  Copyright © 2016 Mark Pettersson. All rights reserved.
//

#import "Forecast.h"

@implementation Forecast

- (id)initWithDic: (NSDictionary *)myDic {
    self = [super init];
    if (self) {
        NSDictionary * cityDic = [myDic objectForKey:@"city"];
        NSString *cityString = [cityDic objectForKey:@"name"];
        NSArray *forecastArray = [myDic objectForKey:@"list"];
        self.weatherByDay = [NSMutableArray array];
        for (NSDictionary * weatherDic in forecastArray) {
            Weather *thisWeather = [[Weather alloc] initWithDic:weatherDic andCity:cityString];
            [self.weatherByDay addObject:thisWeather];
        }
    }
    return self;
}
@end
