//
//  AsteroidsView.m
//  AsteroidParty
//
//  Created by Rose CW on 8/23/12.
//  Copyright (c) 2012 Rose CW. All rights reserved.
//

#import "AsteroidsView.h"
#import "Asteroid.h"
#import "Spaceship.h"
#import "Laser.h"

#import <QuartzCore/QuartzCore.h>
@interface AsteroidsView()
@property (strong) NSMutableArray* asteroids;
@property (strong) NSMutableArray* asteroidImages;
@property (strong) NSMutableArray* lasers;
@property (strong) Spaceship* spaceship;
@property (strong) CALayer* backgroundLayer;
@end



@implementation AsteroidsView
@synthesize asteroids;
@synthesize asteroidImages;
@synthesize spaceship;
@synthesize backgroundLayer;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        UIColor* background = [[UIColor alloc]initWithPatternImage:[UIImage imageNamed:[NSString stringWithFormat:@"background.png"]]];

        UIImage* background =  [UIImage imageNamed:[NSString stringWithFormat:@"background.png"]];
        
        self.backgroundLayer = [CALayer new];
        self.backgroundLayer.bounds = CGRectMake(0, 0, 500, 900);
        self.backgroundLayer.position = CGPointMake(200, 300);
        self.backgroundLayer.contents = (__bridge id)[background CGImage];
        [self.layer addSublayer:backgroundLayer];
    
        [self moveBackground:self.backgroundLayer];
        self.asteroidImages = [NSMutableArray new];
        self.lasers = [NSMutableArray new];
        for (int i = 1; i < 5; ++i) {
            [self.asteroidImages addObject:[UIImage imageNamed:[NSString stringWithFormat:@"asteroid%d.png",i]]];
        }
        
        self.asteroids = [NSMutableArray new];
        for (int i = 0; i<= 20; i++) {
            CGFloat x,y;
            do {
                x = (((double) arc4random()/UINT_MAX) * frame.size.width) - frame.size.width;
                y = (((double) arc4random()/UINT_MAX) * frame.size.height) - frame.size.height;
            } while ( sqrt(pow(x, 2)+pow(y, 2)) < 150 );
            Asteroid* asteroid = [Asteroid createAsteroidWithPosition:CGPointMake(self.center.x + x, self.center.y + y) withView:self withImage:[self.asteroidImages objectAtIndex:(arc4random()%[self.asteroidImages count])]];
            [self.asteroids addObject:asteroid];
        }
        for (Asteroid* asteroid in self.asteroids){
            [asteroid move];
        }
        
        self.spaceship = [Spaceship createSpaceshipWithPosition:self.center withView:self withImage:[UIImage imageNamed:@"ned.png"]];
        
        [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timerFired) userInfo:nil repeats:NO];
        
    }
    return self;
}

-(void)timerFired {
    NSMutableArray *asteroidsToDelete = [NSMutableArray new];
    NSMutableArray *lasersToDelete = [NSMutableArray new];
    for (Asteroid* asteroid in self.asteroids) {
        if (CGRectIntersectsRect(self.spaceship.layer.frame, ((CALayer*)asteroid.layer.presentationLayer).frame)) {
            [self.spaceship destroy];
            UIAlertView* endAlert = [[UIAlertView alloc]initWithTitle:@"You've been hit!" message:@"oh no!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Play Again", nil];
            [endAlert show];
            return;
        }
        for (Laser* laser in self.lasers) {
            if (CGRectIntersectsRect(((CALayer*)laser.layer.presentationLayer).frame, ((CALayer*)asteroid.layer.presentationLayer).frame)) {
                [laser destroy];
                [lasersToDelete addObject:laser];
                [asteroid destroy];
                [asteroidsToDelete addObject:asteroid];
            } else if (((CALayer*)laser.layer.presentationLayer).position.x <= 0 || ((CALayer*)laser.layer.presentationLayer).position.x >= self.layer.bounds.size.width ||
                       laser.layer.position.y <= 0 || laser.layer.position.y >= self.layer.bounds.size.height) {
                [laser destroy];
                [lasersToDelete addObject:laser];
            }
        }
        [self.lasers removeObjectsInArray:lasersToDelete];
    }
    
    [self.asteroids removeObjectsInArray:asteroidsToDelete];
    [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(timerFired) userInfo:nil repeats:NO];
}

-(void)fireLaser:(CGPoint)point {
    CGFloat dy = self.center.y - point.y;
    CGFloat dx = point.x - self.center.x;
    double angle = atan(dy/dx);
    if (dx < 0) {
        angle += M_PI;
    }
    [self.spaceship rotate:angle];
    
    Laser *laser = [Laser createLaserWithPos:self.center withView:self withAngle:angle];
    [self.lasers addObject:laser];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch* touch = [touches anyObject];
    [self fireLaser:[touch locationInView:self]];

}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch* touch = [touches anyObject];
    [self fireLaser:[touch locationInView:self]];
}


-(void)moveBackground:(CALayer*)layer {
     CABasicAnimation *backgroundScroll;
     backgroundScroll=[CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
     backgroundScroll.duration=20;
     backgroundScroll.repeatCount=100;
     backgroundScroll.autoreverses=NO;
     backgroundScroll.fromValue=[NSNumber numberWithFloat:0];
     backgroundScroll.toValue=[NSNumber numberWithFloat:-360];
     [layer addAnimation:backgroundScroll forKey:@"animateLayer"];
}
 
 
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
