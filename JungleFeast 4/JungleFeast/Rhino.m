//
//  Rhino.m
//  JungleFeast
//
//  Created by Sylvia on 13-9-25.
//  Copyright 2013年 Sylvia. All rights reserved.
//

#import "Rhino.h"
#import "GameScene.h"


@implementation Rhino


-(id) init{
    self = [super init];
    if (!self) {
        return nil;
    }
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"AnimRhino_HD.plist"];
    
    CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"AnimRhino_HD.png"];
    [self addChild:spriteSheet];
    
    
    NSMutableArray *foodAnimFrames = [NSMutableArray array];
    for (int i=1; i<=4; i++) {
        [foodAnimFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          [NSString stringWithFormat:@"Rhino%d.png",i]]];
    }
    
    self.charSprite = [CCSprite spriteWithSpriteFrameName:@"Rhino2.png"];
    self.speed = 60;
    self.point = -2;
    isclean = NO;
    isrunning = NO;
    isAttacked = NO;
    
    // add amination
    CGSize winSize = [CCDirector sharedDirector].winSize;
    int minX = charSprite.contentSize.width / 2;
    int maxX = 3*winSize.width - charSprite.contentSize.width/2;
    int rangeX = maxX - minX;
    
    int minY = charSprite.contentSize.height/2;
    int maxY = winSize.height/8+minY;
    int rangeY = maxY - minY;
    int actualY = (arc4random() % rangeY) + minY;
    int actualX = (arc4random() % rangeX) + minX;
    
    // Create the monster slightly off-screen along the right edge,
    // and along a random position along the Y axis as calculated above
    charSprite.position = ccp( actualX, actualY);
    //int actualDuration = 6;
    //****
    
    int width = 3*winSize.width;
    int disappearPoint = arc4random() % width;
    destination = disappearPoint;
    
    if (actualX - disappearPoint >= 0) {
        charSprite.flipX = NO;
    } else {
        charSprite.flipX = YES;
    }
    int actualDuration = abs(actualX - disappearPoint)/speed;
    
    //Choose the animation according to the time
    CCAnimation *walkAnim;
    if(actualDuration<4){
        walkAnim = [CCAnimation animationWithSpriteFrames:foodAnimFrames delay:0.4f];
        actualDuration = 5;
    }
    else{
        walkAnim = [CCAnimation animationWithSpriteFrames:foodAnimFrames delay:0.3f];
    }
    
    self.walkAction = [CCRepeatForever actionWithAction: [CCAnimate actionWithAnimation:walkAnim]];
    
    [charSprite runAction:walkAction];
    //    CGPoint moveDifference = ccpSub(touchLocation, self.dragon.position);
    //float distanceToMove = ccpLength(moveDifference);
    //float moveDuration = distanceToMove / dragonVelocity;
    // Create the actions
    CCMoveTo * actionMove1 = [CCMoveTo actionWithDuration:actualDuration
                                                 position:ccp(disappearPoint, actualY)];
    CCCallBlockN * actionMoveDone = [CCCallBlockN actionWithBlock:^(CCNode *node) {
        [node removeFromParentAndCleanup:YES];
        isclean = YES;
    }];
    id fadeOut = [CCFadeOut actionWithDuration:1.0f];
    self.moveAction = [CCSequence actions:actionMove1, fadeOut,actionMoveDone, nil];
    [charSprite runAction: self.moveAction];
    return self;
}
- (void) running
{}
- (void) walking
{}
- (void) dealloc
{
    self.charSprite = nil;
    [super dealloc];
}
@end