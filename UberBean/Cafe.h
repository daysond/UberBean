//
//  Cafe.h
//  UberBean
//
//  Created by Dayson Dong on 2019-05-17.
//  Copyright © 2019 Dayson Dong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Cafe : NSObject

@property (nonatomic,readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic) NSString* name;
@property (nonatomic) NSURL* imageURL;
@property (nonatomic) NSString* rating;

- (instancetype)initWithCafeInfo: (NSDictionary*)cafeInfo;

@end

NS_ASSUME_NONNULL_END
