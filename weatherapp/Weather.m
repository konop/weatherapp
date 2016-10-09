//
//  Weather.m
//  weatherapp
//
//  Created by Mark Pettersson on 2016-10-08.
//  Copyright © 2016 Mark Pettersson. All rights reserved.
//

#import "Weather.h"



@implementation Weather
- (id)initWithDic: (NSDictionary *)myDic andCity: (NSString *)myCity {
    self = [super init];
    if (self) {
        //conversion dictionay from their pngs to my emojis.  Wanted a theme as well their images were quite poor quality
        NSDictionary * originalValues = [[NSDictionary alloc] initWithObjectsAndKeys:@"☀️", @"01d",@"🌤", @"02d",
            @"🌥", @"03d", @"☁️", @"04d", @"🌧", @"09d", @"🌦",
             @"10d", @"⛈", @"11d", @"🌨", @"13d", @"🌫", @"50d",@"🌙", @"01n",@"🌤", @"02n",
             @"🌥", @"03n", @"☁️", @"04n", @"🌧", @"09n", @"🌧",
             @"10n", @"⛈", @"11n", @"🌨", @"13n", @"🌫", @"50n",
                           nil];
        NSLocale *locale = [NSLocale currentLocale];

        BOOL isMetric = [[locale objectForKey:NSLocaleUsesMetricSystem] boolValue];

        double wind =[[myDic objectForKey:@"speed"] doubleValue];
        if (isMetric)
        {
            wind *= 3.6;
            self.windSpeed = [NSString stringWithFormat:@"Wind Speed: %.01f km/h", wind];
        }
        else
        {
            wind *= 2.23694;
            self.windSpeed = [NSString stringWithFormat:@"Wind Speed: %.01f mph", wind];
        }
        double unixTimeStamp = [[myDic objectForKey:@"dt"] doubleValue];
        NSTimeInterval _interval=unixTimeStamp;
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
        NSDateFormatter *formatter= [[NSDateFormatter alloc] init];
        [formatter setLocale:[NSLocale currentLocale]];
        [formatter setDateFormat:@"E, MMM d yyyy"];
        self.dateString = [formatter stringFromDate:date];
        self.cityName = myCity;
        NSArray *weatherArray = [myDic objectForKey:@"weather"];
        NSDictionary * weatherDic = [weatherArray objectAtIndex:0];
        self.imageIcon = [originalValues objectForKey:[weatherDic objectForKey:@"icon"]];
        self.weatherName = [weatherDic objectForKey:@"description"];
        long humidity =  [[myDic objectForKey:@"humidity"] longValue];
        self.humidity = [NSString stringWithFormat:@"Humidity: %ld", humidity];
        double pressure =  [[myDic objectForKey:@"pressure"] doubleValue];
        self.barometricPressure = [NSString stringWithFormat:@"Barometric Pressure: %.01f", pressure];
        NSDictionary * tempDic = [myDic objectForKey:@"temp"];
        double temperature = [[tempDic objectForKey:@"day"] doubleValue];
        if (isMetric)
        {
            temperature -= 273.15;
        }
        else
        {
            temperature = temperature * 9.0/5.0 - 459.67;
        }
        self.temperature = [NSString stringWithFormat:@"%.01f°", temperature ];
    }
    return self;
}
@end
