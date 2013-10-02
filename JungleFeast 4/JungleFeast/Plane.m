//
//  Plane.m
//  JungleFeast
//
//  Created by Sylvia on 13-9-25.
//  Copyright 2013年 Sylvia. All rights reserved.
//

#import "Plane.h"


@implementation Plane


-(id) init{
    self = [super init];
    if (!self) {
        return nil;
    }
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"AnimPlane_HD.plist"];
    
    CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"AnimPlane_HD.png"];
    [self addChild:spriteSheet];
    
    NSMutableArray *flyAnimFrames = [NSMutableArray array];
    for (int i=1; i<=2; i++) {
        [flyAnimFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          [NSString stringWithFormat:@"plane%d.png",i]]];
    }
    
    
    self.charSprite = [CCSprite spriteWithSpriteFrameName:@"plane2.png"];
    self.hurt = 100;
    isclean = NO;
    
    // add amination
    CGSize winSize = [CCDirector sharedDirector].winSize;
    int minY = 3*winSize.height/5;
    int maxY = winSize.height - charSprite.contentSize.height/2;
    int rangeY = maxY - minY;
    int actualY = (arc4random() % rangeY) + minY;
    charSprite.position = ccp(3*winSize.width + charSprite.contentSize.width/2, actualY);
    int size = charSprite.contentSize.height;
    
    //Choose the animation according to the time
    CCAnimation *flyAnim = [CCAnimation
                            animationWithSpriteFrames:flyAnimFrames delay:0.6f];
    CCAction *flyAction = [CCRepeatForever actionWithAction:
                 [CCAnimate actionWithAnimation:flyAnim]];
    [charSprite runAction:flyAction];
    int minDuration = 8.0;
    int maxDuration = 12.0;
    int rangeDuration = maxDuration - minDuration;
    int actualDuration = (arc4random() % rangeDuration) + minDuration;
    
    // Create the actions
    CCMoveTo * actionMove = [CCMoveTo actionWithDuration:actualDuration position:ccp(-charSprite.contentSize.width/2, actualY)];
    CCCallBlockN * actionMoveDone = [CCCallBlockN actionWithBlock:^(CCNode *node) {
        [node removeFromParentAndCleanup:YES];
        isclean = YES;
    }];
    self.moveAction = [CCSequence actions:actionMove, actionMoveDone, nil];
    [charSprite runAction: self.moveAction];
    
    
    return self;
}

- (void) dealloc
{
    self.charSprite = nil;
    [super dealloc];
}
@end
