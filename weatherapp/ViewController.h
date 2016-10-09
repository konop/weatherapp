//
//  ViewController.h
//  weatherapp
//
//  Created by Mark Pettersson on 2016-10-08.
//  Copyright © 2016 Mark Pettersson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "WeatherAPIManager.h"
#import "Weather.h"
@interface ViewController : UIViewController <CLLocationManagerDelegate>
@property (nonatomic, retain) IBOutlet UILabel *cityLabel;
@property (nonatomic, retain) IBOutlet UILabel *weatherLabel;
@property (nonatomic, retain) IBOutlet UILabel *temperatureLabel;
@property (nonatomic, retain) IBOutlet UILabel *iconLabel;
@property (nonatomic, retain) IBOutlet UILabel *dateLabel;
@property (nonatomic, retain) IBOutlet UILabel *barometricLabel;
@property (nonatomic, retain) IBOutlet UILabel *humidityLabel;
@property (nonatomic, retain) IBOutlet UILabel *windLabel;
@property (weak, nonatomic) IBOutlet UIButton *rightButton;
@property (weak, nonatomic) IBOutlet UIButton *leftButton;
- (IBAction)rightButtonPressed:(UIButton *)sender;

- (IBAction)leftButtonPressed:(UIButton *)sender;
@end

