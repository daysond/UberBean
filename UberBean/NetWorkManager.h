//
//  NetWorkManager.h
//  UberBean
//
//  Created by Dayson Dong on 2019-05-17.
//  Copyright © 2019 Dayson Dong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Cafe.h"

NS_ASSUME_NONNULL_BEGIN

@interface NetWorkManager : NSObject

-(void)fetchCafeData:(void(^)(NSArray *businesses))completionHandler;
@end

NS_ASSUME_NONNULL_END
