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
@synthesize currentAngle;

+(Spaceship*)createSpaceshipWithPosition:(CGPoint)pos withView:(UIView *)view withImage:(UIImage *)image {
    Spaceship* spaceship = [Spaceship new];
    spaceship.layer = [CALayer new];
    spaceship.layer.position = pos;
    spaceship.currentAngle = 0.0;
    spaceship.layer.bounds = CGRectMake(0, 0, 50, 50);
    spaceship.layer.contents = (__bridge id)[image CGImage];
    [view.layer addSublayer:spaceship.layer];
    
    return spaceship;
}

-(void)rotate:(double)destinationAngle {
    
    CABasicAnimation* rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotationAnimation.duration = 0;
    rotationAnimation.fromValue = [NSNumber numberWithFloat:self.currentAngle];
    rotationAnimation.toValue = [NSNumber numberWithFloat: destinationAngle];
    self.currentAngle = destinationAngle;
    rotationAnimation.additive = YES;
    
    [self.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

-(void)destroy {
    [self.layer removeFromSuperlayer];
}


@end
