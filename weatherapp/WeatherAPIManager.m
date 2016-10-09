//
//  WeatherAPIManager.m
//  weatherapp
//
//  Created by Mark Pettersson on 2016-10-08.
//  Copyright © 2016 Mark Pettersson. All rights reserved.
//


#import "WeatherAPIManager.h"
static NSString *const WEATHERURL = @"http://api.openweathermap.org/data/2.5/forecast/daily?cnt=10&lat=";
static NSString *const APIKEY = @"428881fbbd13362d2f27b4df592fca79";

@implementation WeatherAPIManager


#pragma mark - WEatherAPI Manager Singleton -
+ (id)sharedManager {
    static WeatherAPIManager *sharedWeatherAPI = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedWeatherAPI = [[self alloc] init];
    });
    
    return sharedWeatherAPI;
}

- (id)init {
    if (self = [super init]) {
    }
    return self;
}




- (void)getWeather:(CLLocation *)searchLocation
            success:(WeatherNetworkingSuccess)success
            failure:(WeatherNetworkingFailure)failureRespond {
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSString *mystring = [NSString stringWithFormat:@"%@%f&lon=%f&appid=%@", WEATHERURL, searchLocation.coordinate.latitude, searchLocation.coordinate.longitude, APIKEY ];
    
    [[session dataTaskWithURL:[NSURL URLWithString:mystring]
            completionHandler:^(NSData *data,
                                NSURLResponse *response,
                                NSError *error) {
                if (data != nil)
                {
                NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
 
                Forecast * thisForecast = [[Forecast alloc] initWithDic:jsonDic];
                success(thisForecast);
                }
                else
                {
                    failureRespond(error);
                }
                
            }] resume];
}

@end












