//
//  Asteroid.m
//  AsteroidParty
//
//  Created by Rose CW on 8/23/12.
//  Copyright (c) 2012 Rose CW. All rights reserved.
//

#import "Asteroid.h"
#import <QuartzCore/QuartzCore.h>

@interface Asteroid ()
@property int dx;
@property int dy;
@property CFTimeInterval duration;
@end

@implementation Asteroid


@synthesize layer;

+ (Asteroid*)createAsteroidWithPosition:(CGPoint)pos withView:(UIView *)view withImage:(UIImage*)image {
    Asteroid* asteroid = [Asteroid new];
    asteroid.dx = (arc4random()%150)-75;
    asteroid.dy = (arc4random()%150)-75;
    asteroid.duration = ((double)arc4random()/UINT_MAX)*2 + 1;
    
    asteroid.layer = [CALayer new];
    asteroid.layer.bounds = CGRectMake(0, 0, 40, 40);
    asteroid.layer.position = pos;
    //asteroid.layer.delegate = asteroid;
    asteroid.layer.contents = (__bridge id)[image CGImage];
    [view.layer addSublayer: asteroid.layer];
    [asteroid rotationAnimation];

    return asteroid;
}

//-(void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx{
//    CGContextSetFillColorWithColor(ctx, [[UIColor whiteColor] CGColor]);
//    CGContextFillEllipseInRect(ctx, self.layer.bounds);
//}

-(BOOL)isTouchOnAsteroid:(CGPoint)touchPoint{
    return CGRectContainsPoint(((CALayer*)self.layer.presentationLayer).frame, touchPoint);
}

-(void)destroy {
    [self.layer removeFromSuperlayer];
}


-(void)move{
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    if (self.layer.position.x < 0) {
        self.layer.position = CGPointMake(self.layer.superlayer.bounds.size.width, self.layer.position.y);
        
    } else if (self.layer.position.x > self.layer.superlayer.bounds.size.width) {
        self.layer.position = CGPointMake(0, self.layer.position.y);
    }
    if (self.layer.position.y < 0) {
        self.layer.position = CGPointMake(self.layer.position.x, self.layer.superlayer.bounds.size.height);
        
    } else if (self.layer.position.y > self.layer.superlayer.bounds.size.height) {
        self.layer.position = CGPointMake(self.layer.position.x,0);
    }
    [CATransaction commit];
    
    [CATransaction begin];
    
    CGFloat newX = self.layer.position.x + self.dx;
    CGFloat newY = self.layer.position.y + self.dy;
    
    [CATransaction setAnimationDuration:self.duration];
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
    [CATransaction setCompletionBlock:^{
        [self move];
    }];
    self.layer.position = CGPointMake(newX,newY);
    [CATransaction commit];
    
}


-(void)rotationAnimation{
    CABasicAnimation* rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotationAnimation.duration = self.duration;

    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = HUGE_VALF;
    
    [self.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    
}

@end
