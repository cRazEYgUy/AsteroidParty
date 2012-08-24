//
//  Spaceship.h
//  AsteroidParty
//
//  Created by Rose CW on 8/23/12.
//  Copyright (c) 2012 Rose CW. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Spaceship : NSObject
@property CALayer* layer;
+(Spaceship*)createSpaceshipWithPosition:(CGPoint)pos withView:(UIView*)view withImage:(UIImage*)image;
-(void)destroy;
-(void)rotate:(double)destinationAngle;
@end
