//
//  ViewController.m
//  weatherapp
//
//  Created by Mark Pettersson on 2016-10-08.
//  Copyright © 2016 Mark Pettersson. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
CLLocationManager *locationManager;
Forecast *myForecast;

int dayCount;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.leftButton.hidden = YES;
    self.rightButton.hidden = YES;

    [self setNeedsStatusBarAppearanceUpdate];
    dayCount = 0;
    locationManager = [[CLLocationManager alloc]init]; // initializing locationManager
    locationManager.delegate = self; // we set the delegate of locationManager to self.
    locationManager.desiredAccuracy = kCLLocationAccuracyKilometer; // setting the accuracy
    locationManager.distanceFilter = 1000;
    if ([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [locationManager requestWhenInUseAuthorization];
    }
    [locationManager startUpdatingLocation];  //requesting location updates
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setUIWithWeather:(Weather *) thisWeather
{
    if ([thisWeather.cityName isEqualToString: @"Location"])
    {
        self.dateLabel.text = @"Can't find location";
        self.weatherLabel.text = @"Please enable location in Settings";
        self.iconLabel.text = @"😖";
    }
    else  if ([thisWeather.cityName isEqualToString: @"Internet"])
    {
        self.dateLabel.text = @"Can't get weather";
        self.weatherLabel.text = @"Please enable internet in Settings";
        self.iconLabel.text = @"😳";
    } else
    {
        self.cityLabel.text = thisWeather.cityName;
        self.temperatureLabel.text = thisWeather.temperature;
        self.iconLabel.text = thisWeather.imageIcon;
        self.dateLabel.text = thisWeather.dateString;
        self.weatherLabel.text = thisWeather.weatherName;
        self.barometricLabel.text = thisWeather.barometricPressure;
        self.humidityLabel.text = thisWeather.humidity;
        self.windLabel.text = thisWeather.windSpeed;
    }
}

#pragma mark - CLLocationManagerDelegate

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@"Unable to get your location"
                                  message:@"Make sure your location settings are enabled"
                                  preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"OK"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             [alert dismissViewControllerAnimated:YES completion:nil];
                    
                         }];
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
    Weather *locationFailure =[[Weather alloc] init];
    locationFailure.cityName = @"Location";
    [self setUIWithWeather:locationFailure];

}
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    NSLog(@"didUpdateToLocation: %@", [locations lastObject]);
    CLLocation *currentLocation = [locations lastObject];

    
    if (currentLocation != nil) {
        [[WeatherAPIManager sharedManager] getWeather:currentLocation     success:^(Forecast * responseObject) {
            dispatch_sync(dispatch_get_main_queue(), ^{
                myForecast = responseObject;
                if ([responseObject.weatherByDay count] > 0)
                    self.rightButton.hidden = NO;
                [self setUIWithWeather:[responseObject.weatherByDay objectAtIndex:dayCount]];
            });
        } failure:^(NSError *error) {
            NSLog(@"%@", error);
            UIAlertController * alert=   [UIAlertController
                                          alertControllerWithTitle:@"Unable to access the weather report"
                                          message:@"Make sure your internet is available"
                                          preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* ok = [UIAlertAction
                                 actionWithTitle:@"OK"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction * action)
                                 {
                                     [alert dismissViewControllerAnimated:YES completion:nil];
                                     
                                 }];
            [alert addAction:ok];
            [self presentViewController:alert animated:YES completion:nil];
            Weather *locationFailure =[[Weather alloc] init];
            locationFailure.cityName = @"Internet";
            [self setUIWithWeather:locationFailure];

        }];
    }
}
- (IBAction)leftButtonPressed:(UIButton *)sender {
    dayCount -= 1;
    if (dayCount == 8)
    {
        self.rightButton.hidden = NO;
    }
    if (dayCount == 0)
    {
        self.leftButton.hidden = YES;
    }
    if ([myForecast.weatherByDay count] >= dayCount)
    {
        [self setUIWithWeather:[myForecast.weatherByDay objectAtIndex:dayCount]];
    }

}
- (IBAction)rightButtonPressed:(UIButton *)sender {
    dayCount += 1;
    if (dayCount == 1)
    {
        self.leftButton.hidden = NO;
    }
    if (dayCount == 9)
    {
        self.rightButton.hidden = YES;
    }
    if ([myForecast.weatherByDay count] >= dayCount)
    {
        [self setUIWithWeather:[myForecast.weatherByDay objectAtIndex:dayCount]];
    }
}
- (UIStatusBarStyle) preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
@end
