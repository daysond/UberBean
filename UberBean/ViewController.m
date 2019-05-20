//
//  ViewController.m
//  UberBean
//
//  Created by Dayson Dong on 2019-05-17.
//  Copyright © 2019 Dayson Dong. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "NetWorkManager.h"


@interface ViewController () <CLLocationManagerDelegate,MKMapViewDelegate>

@property (nonatomic) CLLocationManager *locationManager;
@property (nonatomic) NetWorkManager *networkManager;
@property (weak, nonatomic) IBOutlet MKMapView *cafeMap;
@property (nonatomic) NSMutableArray <Cafe*> *cafes;
@property (nonatomic) NSInteger currentIndex;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.currentIndex = 0;
    
    [self.cafeMap setShowsUserLocation:YES];
    
    [self.locationManager requestWhenInUseAuthorization];
    
    self.cafes = [NSMutableArray array];
    
    [self fetchData];
    
    [self.cafeMap registerClass:[MKMarkerAnnotationView class] forAnnotationViewWithReuseIdentifier:@"marker"];
    

    
}

#pragma mark - Initializer 

-(CLLocationManager*)locationManager {
    
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc]init];
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        _locationManager.distanceFilter = 15;
        _locationManager.delegate = self;
    }
    return _locationManager;
}

-(NetWorkManager*)networkManager {
    
    if (!_networkManager) {
        _networkManager = [NetWorkManager new];
    }
    return _networkManager;
}

#pragma mark - Data source

-(void)fetchData{
    
    [self.networkManager fetchCafeData:^(NSArray * _Nonnull businesses) {
        for (NSDictionary* cafeInfo in businesses) {
            Cafe *cafe = [[Cafe alloc]initWithCafeInfo:cafeInfo];
            [self.cafes addObject:cafe];
        }
        
        [self fetchImage];
       
        for (Cafe *cafe in self.cafes) {
            [self.cafeMap addAnnotation:cafe];
        }
        
        [self.cafeMap showAnnotations:self.cafes animated:YES];
    }];

}

-(void)fetchImage{
    
    for (Cafe *cafe in self.cafes) {
        NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        
        NSURLSessionDownloadTask * downloadTask = [session downloadTaskWithURL:cafe.imageURL completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            if (error) {
                NSLog(@"Error: %@", error);
            }
            
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                
                UIImage *cafeImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:location]];
                cafe.cafeImage = cafeImage;
                
            }];
        }];
        
        [downloadTask resume];
        
    }
    
}

#pragma mark - Delegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    
    CLLocation *location = locations[0];
    MKCoordinateRegion region = MKCoordinateRegionMake(location.coordinate, MKCoordinateSpanMake(0.003, 0.003));
    [self.cafeMap setRegion:region animated:YES];
    
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    
    NSLog(@"Error:%@",error);
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {

    if (status == kCLAuthorizationStatusAuthorizedAlways || status == kCLAuthorizationStatusAuthorizedWhenInUse) {
        [self.locationManager requestLocation];
    }
    
}


- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {


    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    MKMarkerAnnotationView *marker = (MKMarkerAnnotationView*) [mapView dequeueReusableAnnotationViewWithIdentifier:@"marker" forAnnotation:annotation];

    UIButton *button = [UIButton buttonWithType:UIButtonTypeInfoLight];
    

    marker.rightCalloutAccessoryView = button;
    
    UIImageView *image = [[UIImageView alloc]initWithImage:self.cafes[self.currentIndex].cafeImage];
    
    self.currentIndex ++;
    
    marker.leftCalloutAccessoryView = image;

    [marker setEnabled:YES];
    [marker setCanShowCallout:YES];


    
    return marker;

}




@end
