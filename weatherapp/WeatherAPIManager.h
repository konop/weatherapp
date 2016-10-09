//
//  WeatherAPIManager.h
//  weatherapp
//
//  Created by Mark Pettersson on 2016-10-08.
//  Copyright © 2016 Mark Pettersson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "Forecast.h"


typedef void (^WeatherNetworkingSuccess)(id responseObject);
typedef void (^WeatherNetworkingFailure)(NSError *error);

@interface WeatherAPIManager : NSObject

+ (id)sharedManager;

- (void)getWeather:(CLLocation *)searchLocation
            success:(WeatherNetworkingSuccess)success
            failure:(WeatherNetworkingFailure)failureRespond;

@end
