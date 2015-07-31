//
//  LocationData.h
//  ChaseChallenge
//
//  Created by ANTHONY O. on 7/30/15.
//  Copyright (c) 2015 ANTHONY O. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocationData : NSObject

@property (nonatomic, copy) NSString *locType;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, assign) float distance;
@property (nonatomic, assign) float lat;
@property (nonatomic, assign) float lng;




@end
