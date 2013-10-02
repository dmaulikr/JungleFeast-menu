//
//  GameScene.m
//  JungleFeast
//
//  Created by Deng Yuanyuan on 13-9-23.
//  Copyright (c) 2013年 Sylvia. All rights reserved.
//

#import "GameScene.h"
#import "dragon.h"
#import "CCBReader.h"
#import "rabbit.h"

@implementation GameScene

- (void) onEnter
{

    [super onEnter];
    // Schedule a selector that is called every frame
    [self schedule:@selector(update:)];
    
//    CCNode* food = [CCBReader sceneWithNodeGraphFromFile:@"rabbit.ccbi"];
//    CGSize winSize = [CCDirector sharedDirector].winSize;
//    [self addChild:food];
//    food.position = ccp(winSize.width/2, winSize.height/2);
//    CCMoveTo * foodMoveTo = [CCMoveTo actionWithDuration:10
//                                                position:ccp(0, 0)];
//    [food runAction:foodMoveTo];

    //[self addFood];
    [self schedule:@selector(addFood:) interval:1];
    // Make sure touches are enabled
    [self setTouchEnabled:YES];
}
- (void) update:(ccTime)delta{
    
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    CGRect worldBoundary = CGRectMake(-winSize.width, 0, winSize.width*3, winSize.height);
    [self runAction:[CCFollow actionWithTarget:Dragon worldBoundary:worldBoundary]];
    [Dragon update];
}

- (void) addFood: (ccTime)dt
{
    NSLog(@"yu");
    //rabbit *Rabbit;
    // Load the game scene

    //rabbit * food = (rabbit *)[CCBReader sceneWithNodeGraphFromFile:@"rabbit.ccbi"];
    rabbit * food = (rabbit *)[CCBReader nodeGraphFromFile:@"rabbit.ccbi"];
    CGSize winSize = [CCDirector sharedDirector].winSize;
    int minX = -1.5*winSize.width + 40;
    int maxX = 1.5*winSize.width - 40;
    int rangeX = maxX - minX;

    int minY = 80;
    int maxY = winSize.height/4;
    int rangeY = maxY - minY;
    int actualY = (arc4random() % rangeY) + minY;
    int actualX = (arc4random() % rangeX) + minX;
    food.position = ccp( actualX, actualY);
    //food.accMoveTo;
    //food.position = ccp(winSize.width/2, winSize.height/2);
	[self addChild: food];
    int minDuration = 8.0;
    int maxDuration = 15.0;
    int rangeDuration = maxDuration - minDuration;
    int actualDuration = (arc4random() % rangeDuration) + minDuration;
    int width = 3*winSize.width;
    int disappearPoint = arc4random() % width - 1.5*winSize.width;
    
    if (actualX - disappearPoint >= 0) {
        food.rotationY = 0;
    } else {
        food.rotationY = 180;
    }
    
    CCMoveTo * accMoveTo= [CCMoveTo actionWithDuration:actualDuration
                                                 position:ccp(disappearPoint, actualY)];

    //food.accMoveTo = accMoveTo;
    CCCallBlockN * actionMoveDone = [CCCallBlockN actionWithBlock:^(CCNode *node) {
        [node removeFromParentAndCleanup:YES];
    }];
    [food runAction:[CCSequence actions:accMoveTo, actionMoveDone, nil]];
}

- (void)registerWithTouchDispatcher
{
    [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:
     self priority:0 swallowsTouches:YES];
}
- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
//    CGPoint touchLocation = [self convertTouchToNodeSpace:touch];
//    float xNew = touchLocation.x;
//    float yNew = touchLocation.y;
//    Dragon.xTarget = xNew;
//    Dragon.yTarget = yNew;
//    NSLog(@"!!!");
    return YES;
}

- (void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint touchLocation = [self convertTouchToNodeSpace:touch];
    CGPoint oldPosition = Dragon.position;
    float xNew = oldPosition.x*0.9+touchLocation.x*0.1;
    float yNew = oldPosition.y*0.9+touchLocation.y*0.1;
    Dragon.xTarget = xNew;
    Dragon.yTarget = yNew;
}
- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
//    CGPoint touchLocation = [self convertTouchToNodeSpace:touch];
//    float xNew = touchLocation.x;
//    float yNew = touchLocation.y;
//    Dragon.xTarget = xNew;
//    Dragon.yTarget = yNew;
}

@end
