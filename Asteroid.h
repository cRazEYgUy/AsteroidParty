//
//  Asteroid.h
//  AsteroidParty
//
//  Created by Rose CW on 8/23/12.
//  Copyright (c) 2012 Rose CW. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Asteroid : NSObject
@property (strong) CALayer *layer;
+ (Asteroid*)createAsteroidWithPosition:(CGPoint)pos withView:(UIView*)view withImage:(UIImage*) image;
-(BOOL)isTouchOnAsteroid:(CGPoint)touchPoint;
-(void)destroy;
-(void)move;
@end
