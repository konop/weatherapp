//
//  weatherappTests.m
//  weatherappTests
//
//  Created by Mark Pettersson on 2016-10-08.
//  Copyright © 2016 Mark Pettersson. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Weather.h"

@interface weatherappTests : XCTestCase

@end

@implementation weatherappTests
Weather * testWeather;
- (void)setUp {
    [super setUp];
    
    NSDictionary * tempDic = [[NSDictionary alloc] initWithObjectsAndKeys:@305.42, @"eve", @284.39,@"min", @310.65, @"morn",@310.65, @"day",@310.65, @"max",@3284.39, @"night", nil];

  NSDictionary * weatherDic = [[NSDictionary alloc] initWithObjectsAndKeys:@800, @"id", @"clear sky",@"description", @"Clear", @"main",@"01d", @"icon", nil];
    NSArray * weatherArray = @[weatherDic];

    NSDictionary * originalValues = [[NSDictionary alloc] initWithObjectsAndKeys:@1476039600, @"dt",@990.74, @"pressure",
                                     @1.41, @"speed", @43, @"humidity", weatherArray, @"weather", tempDic,@"temp",
                                     nil];
    NSString *cityString = @"Cupertino";
     testWeather = [[Weather alloc] initWithDic:originalValues andCity:cityString];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    XCTAssert([testWeather.cityName isEqualToString:@"Cupertino"]);
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}


- (void)testExample2 {
    XCTAssert([testWeather.imageIcon isEqualToString:@"☀️"]);
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}
- (void)testExample3 {
    XCTAssert([testWeather.weatherName isEqualToString:@"clear sky"]);
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}
- (void)testExample4 {
    XCTAssert([testWeather.temperature isEqualToString:@"99.5°"]);
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}
- (void)testExample5 {
    XCTAssert([testWeather.dateString isEqualToString:@"Sun, Oct 9 2016"]);
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}
- (void)testExample6 {
    XCTAssert([testWeather.barometricPressure isEqualToString:@"Barometric Pressure: 990.7"]);
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}
- (void)testExample7 {
    XCTAssert([testWeather.humidity isEqualToString:@"Humidity: 43"]);
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}
- (void)testExample8 {
    XCTAssert([testWeather.windSpeed isEqualToString:@"Wind Speed: 3.2 mph"]);
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}


@end
