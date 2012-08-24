//
//  Spaceship.m
//  AsteroidParty
//
//  Created by Rose CW on 8/23/12.
//  Copyright (c) 2012 Rose CW. All rights reserved.
//

#import "Spaceship.h"
#import <QuartzCore/QuartzCore.h>

@implementation Spaceship
@synthesize layer;


+(Spaceship*)createSpaceshipWithPosition:(CGPoint)pos withView:(UIView *)view withImage:(UIImage *)image {
    Spaceship* spaceship = [Spaceship new];
    spaceship.layer = [CALayer new];
    spaceship.layer.position = pos;
    spaceship.layer.bounds = CGRectMake(0, 0, 50, 50);
    spaceship.layer.contents = (__bridge id)[image CGImage];
    [view.layer addSublayer:spaceship.layer];
    
    return spaceship;
}

-(void)rotate:(double)destinationAngle {
    CATransform3D transform = CATransform3DIdentity;
    transform = CATransform3DRotate(transform, destinationAngle, 0.0, 0.0, -1.0);
    self.layer.transform = transform;
}

-(void)destroy {
    [self.layer removeFromSuperlayer];
}


@end
