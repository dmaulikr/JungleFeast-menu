//
//  Rabbit.m
//  JungleFeast
//
//  Created by Sylvia on 13-9-25.
//  Copyright 2013年 Sylvia. All rights reserved.
//

#import "Rabbit.h"


@implementation Rabbit


-(id) init{
    self = [super init];
    if (!self) {
        return nil;
    }
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"AnimRabbit_HD.plist"];
    
    CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"AnimRabbit_HD.png"];
    [self addChild:spriteSheet];
    
    
    NSMutableArray *foodAnimFrames2 = [NSMutableArray array];
    for (int i=1; i<=4; i++) {
        [foodAnimFrames2 addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          [NSString stringWithFormat:@"rabbit%d.png",i]]];
    }
    
    NSMutableArray *foodAnimFrames = [NSMutableArray array];
    for (int i=5; i<=8; i++) {
        [foodAnimFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          [NSString stringWithFormat:@"rabbit%d.png",i]]];
    }

    self.charSprite = [CCSprite spriteWithSpriteFrameName:@"rabbit1.png"];
    self.speed = 60;
    self.point = 2;
    isclean = NO;
    isrunning = NO;
    isAttacked = NO;
    
    // add amination
    CGSize winSize = [CCDirector sharedDirector].winSize;
    int minX = charSprite.contentSize.width / 2;
    int maxX = 3*winSize.width - charSprite.contentSize.width/2;
    int rangeX = maxX - minX;
    
    int minY = charSprite.contentSize.height/2;
    int maxY = 2*winSize.height/9;
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
        walkAnim = [CCAnimation animationWithSpriteFrames:foodAnimFrames2 delay:0.3f];
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
    self.moveAction = [CCSequence actions:actionMove1,fadeOut, actionMoveDone, nil];
    [charSprite runAction: self.moveAction];

    return self;
}
-(void) running{
    isrunning = YES;
    [self.charSprite stopAction:walkAction];
    [self.charSprite stopAction:self.moveAction];
    
    
    NSMutableArray *foodAnimFrames = [NSMutableArray array];
//    for (int i=1; i<=4; i++) {
//        [foodAnimFrames addObject:
//         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
//          [NSString stringWithFormat:@"rabbit%d.png",i]]];
//    }
    for (int i=9; i<=16; i++) {
        [foodAnimFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          [NSString stringWithFormat:@"rabbit%d.png",i]]];
    }
    //self.charSprite = [CCSprite spriteWithSpriteFrameName:@"rabbit9.png"];
    CCAnimation *runAnim;
    runAnim = [CCAnimation animationWithSpriteFrames:foodAnimFrames delay:0.1f];
    self.walkAction = [CCRepeatForever actionWithAction: [CCAnimate actionWithAnimation:runAnim]];
    [charSprite runAction:walkAction];
    
}
- (void) walking{
    isrunning = NO;
    [self.charSprite stopAction:walkAction];
    [self.charSprite stopAction:self.moveAction];
    
    NSMutableArray *foodAnimFrames = [NSMutableArray array];
    for (int i=1; i<=4; i++) {
        [foodAnimFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          [NSString stringWithFormat:@"rabbit%d.png",i]]];
    }
    //self.charSprite = [CCSprite spriteWithSpriteFrameName:@"rabbit2.png"];
    CCAnimation *walkAnim;
    walkAnim = [CCAnimation animationWithSpriteFrames:foodAnimFrames delay:0.3f];
    self.walkAction = [CCRepeatForever actionWithAction: [CCAnimate actionWithAnimation:walkAnim]];
    [charSprite runAction:walkAction];
}
- (void) dealloc
{
    self.charSprite = nil;
    [super dealloc];
}
@end
