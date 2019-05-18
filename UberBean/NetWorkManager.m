//
//  NetWorkManager.m
//  UberBean
//
//  Created by Dayson Dong on 2019-05-17.
//  Copyright © 2019 Dayson Dong. All rights reserved.
//

#import "NetWorkManager.h"

@implementation NetWorkManager

-(void)fetchData {
    
    NSURL *url = [NSURL URLWithString:@"https://api.yelp.com/v3/businesses/search?term=cafe&latitude=49.281815&longitude=-123.108414"];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    [request addValue:@"Bearer rJ6vNsW4WqNLgWnUIPjgSu7Mmx6Pm1-sF9OPSRR7HJru78M586gsW351vE2bH7o_WzBYe7-mI_KUh0_Sc3se5thzN7M-9dBR9R94pMWA4f4bOSskC83dunoo3izfXHYx" forHTTPHeaderField:@"Authorization"];
    
    [request setHTTPMethod:@"GET"];
    
    NSURLSession * session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"Error: %@",error);
        }
        
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*) response;
        
        if (httpResponse.statusCode != 200) {
            NSLog(@"HTTP Status code: %ld",httpResponse.statusCode);
        }
        
        NSError *jsonError;
        NSData *jsonData = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        
        if (jsonError) {
            NSLog(@"JSON Error: %@", jsonError);
        }
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            
            
        }];
        
        NSLog(@"%@",jsonData);
        
    }];
    
    [dataTask resume];
    
    
    
}

@end
