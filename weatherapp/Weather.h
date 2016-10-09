//
//  Weather.h
//  weatherapp
//
//  Created by Mark Pettersson on 2016-10-08.
//  Copyright © 2016 Mark Pettersson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Weather : NSObject
@property (nonatomic, retain) NSString *cityName;
@property (nonatomic, retain) NSString *weatherName;
@property (nonatomic, retain) NSString *temperature;
@property (nonatomic, retain) NSString *imageIcon;
@property (nonatomic, retain) NSString *dateString;
@property (nonatomic, retain) NSString *barometricPressure;
@property (nonatomic, retain) NSString *humidity;
@property (nonatomic, retain) NSString *windSpeed;


- (id)initWithDic: (NSDictionary *)myDic andCity: (NSString *)myCity;
@end
