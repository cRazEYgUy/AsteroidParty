//
//  Laser.h
//  AsteroidParty
//
//  Created by Edward Kim on 8/23/12.
//  Copyright (c) 2012 Rose CW. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Laser : NSObject
@property (strong) CALayer *layer;
+ (Laser*)createLaserWithPos:(CGPoint)pos withView:(UIView*)view withAngle:(double)angle;
- (void)fireAtAngle:(double)angle;
- (void)destroy;
@end
