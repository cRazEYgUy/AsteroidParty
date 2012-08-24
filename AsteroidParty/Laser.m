//
//  Laser.m
//  AsteroidParty
//
//  Created by Edward Kim on 8/23/12.
//  Copyright (c) 2012 Rose CW. All rights reserved.
//

#import "Laser.h"
#import <QuartzCore/QuartzCore.h>

@implementation Laser
@synthesize layer;
+ (Laser*)createLaserWithPos:(CGPoint)pos withView:(UIView*)view withAngle:(double)angle {
    Laser *laser = [Laser new];
    laser.layer = [CALayer new];
    laser.layer.position = pos;
    laser.layer.bounds = CGRectMake(0, 0, 10, 4);
    laser.layer.backgroundColor = [[UIColor redColor] CGColor];
    
    [view.layer addSublayer:laser.layer];
    [laser fireAtAngle:angle];
    return laser;
}

- (void)fireAtAngle:(double)angle {
    
    CGFloat dr = sqrt((double)pow(self.layer.superlayer.bounds.size.width/2,2) + (double)pow(self.layer.superlayer.bounds.size.height/2,2));
    CGFloat dx = cos(angle)*dr;
    CGFloat dy = sin(angle)*dr;
    
    CATransform3D transform = CATransform3DIdentity;
    transform = CATransform3DRotate(transform, angle, 0.0, 0.0, -1.0);
    self.layer.transform = transform;
    
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"position"];
    [anim setFromValue:[NSValue valueWithCGPoint:self.layer.position]];
    [anim setToValue:[NSValue valueWithCGPoint:CGPointMake(self.layer.position.x + dx, self.layer.position.y - dy)]];
    [anim setDuration:1.0];
    [self.layer addAnimation:anim forKey:nil];
}

- (void)destroy {
    [self.layer removeFromSuperlayer];
}
@end
