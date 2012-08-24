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
#import <QuartzCore/QuartzCore.h>
@interface AsteroidsView()
@property (strong) NSMutableArray* asteroids;
@property (strong) NSMutableArray* asteroidImages;
@property (strong) Spaceship* spaceship;
@end



@implementation AsteroidsView
@synthesize asteroids;
@synthesize asteroidImages;
@synthesize spaceship;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIColor* background = [[UIColor alloc]initWithPatternImage:[UIImage imageNamed:[NSString stringWithFormat:@"background.png"]]];
        [self setBackgroundColor:background];
        self.asteroidImages = [NSMutableArray new];
        for (int i = 1; i < 5; ++i) {
            [self.asteroidImages addObject:[UIImage imageNamed:[NSString stringWithFormat:@"asteroid%d.png",i]]];
        }
        
        self.asteroids = [NSMutableArray new];
        for (int i = 0; i<= 20; i++) {
            CGFloat x = ((double) arc4random()/UINT_MAX) * frame.size.width;
            CGFloat y = ((double) arc4random()/UINT_MAX) * frame.size.height;
            Asteroid* asteroid = [Asteroid createAsteroidWithPosition:CGPointMake(x, y) withView:self withImage:[self.asteroidImages objectAtIndex:(arc4random()%[self.asteroidImages count])]];
            [self.asteroids addObject:asteroid];
        }
        for (Asteroid* asteroid in self.asteroids){
            [asteroid move];
        }
        CGFloat centerX = (self.bounds.size.width/2.0);
        CGFloat centerY = (self.bounds.size.height/2.0);
        
        self.spaceship = [Spaceship createSpaceshipWithPosition:CGPointMake(centerX, centerY) withView:self withImage:[UIImage imageNamed:@"ned.png"]];
        
        [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(timerFired) userInfo:nil repeats:NO];
        
    }
    return self;
}

-(void)timerFired {
    for (Asteroid* asteroid in self.asteroids) {
        if (CGRectIntersectsRect(self.spaceship.layer.frame, ((CALayer*)asteroid.layer.presentationLayer).frame)) {
            [self.spaceship destroy];
            UIAlertView* endAlert = [[UIAlertView alloc]initWithTitle:@"You've been hit!" message:@"oh no!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Play Again", nil];
            [endAlert show];
            return;
        }
    }
    [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timerFired) userInfo:nil repeats:NO];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch* touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self];
    NSMutableArray *itemsToDelete = [NSMutableArray new];
    for (Asteroid* asteroid in self.asteroids) {
        if ([asteroid isTouchOnAsteroid:touchPoint]) {
            [itemsToDelete addObject:asteroid];
            [asteroid destroy];

        }
    }
    [self.asteroids removeObjectsInArray:itemsToDelete];
    
    CGFloat dy = self.center.y - touchPoint.y;
    CGFloat dx = touchPoint.x - self.center.x;
    double angle = atan(dy/dx);
    [self.spaceship rotate:angle];
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
