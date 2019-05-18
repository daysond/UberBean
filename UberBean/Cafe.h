//
//  Cafe.h
//  UberBean
//
//  Created by Dayson Dong on 2019-05-17.
//  Copyright © 2019 Dayson Dong. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Cafe : NSObject <MKAnnotation>

@property (nonatomic,readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, readonly, copy) NSString* title;
@property (nonatomic) NSURL* imageURL;
@property (nonatomic) NSString* rating;

- (instancetype)initWithCafeInfo: (NSDictionary*)cafeInfo;

@end

NS_ASSUME_NONNULL_END
