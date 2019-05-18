//
//  Cafe.m
//  UberBean
//
//  Created by Dayson Dong on 2019-05-17.
//  Copyright © 2019 Dayson Dong. All rights reserved.
//

#import "Cafe.h"

@implementation Cafe

- (instancetype)initWithCafeInfo: (NSDictionary*)cafeInfo
{
    self = [super init];
    if (self) {
        _title = cafeInfo[@"name"];
        _imageURL = [NSURL URLWithString:cafeInfo[@"image_url"]];
        _rating = cafeInfo[@"rating"];
        CLLocationDegrees lat = [cafeInfo[@"coordinates"][@"latitude"] doubleValue];
        CLLocationDegrees lon = [cafeInfo[@"coordinates"][@"longitude"] doubleValue];
        _coordinate = CLLocationCoordinate2DMake(lat, lon);
    }
    return self;
}


@end
