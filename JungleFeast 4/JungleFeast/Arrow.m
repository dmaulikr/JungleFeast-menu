//
//  Arrow.m
//  JungleFeast
//
//  Created by Sylvia on 13-9-26.
//  Copyright 2013年 Sylvia. All rights reserved.
//

#import "Arrow.h"
#import "GameScene.h"


@implementation Arrow


-(id) init{
    self = [super init];
    if (!self) {
        return nil;
    }
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"AnimArrow_HD.plist"];
    
    CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"AnimArrow_HD.png"];
    [self addChild:spriteSheet];
        NSMutableArray *flyAnimFrames = [NSMutableArray array];
    [flyAnimFrames addObject:
     [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
      [NSString stringWithFormat:@"arrow%d.png",1]]];
    [flyAnimFrames addObject:
     [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
      [NSString stringWithFormat:@"arrow%d.png",1]]];
    
    for (int i=1; i<=2; i++) {
        [flyAnimFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          [NSString stringWithFormat:@"arrow%d.png",i]]];
    }
    
    
    self.charSprite = [CCSprite spriteWithSpriteFrameName:@"arrow2.png"];
    self.hurt = 2;
    isclean = NO;
    
    // add amination
    CGSize winSize = [CCDirector sharedDirector].winSize;
    int minX = charSprite.contentSize.width / 2;
    int maxX = 3*winSize.width - charSprite.contentSize.width/2;
    int rangeX = maxX - minX;

    int actualY = 0;
    int actualX = (arc4random() % rangeX) + minX;
    
    // Create the monster slightly off-screen along the right edge,
    // and along a random position along the Y axis as calculated above
    charSprite.position = ccp( actualX, actualY);
    
    
    
    //Choose the animation according to the time
    CCAnimation *flyAnim = [CCAnimation
                            animationWithSpriteFrames:flyAnimFrames delay:0.5f];
    CCAction *flyAction = [CCRepeatForever actionWithAction:
                           [CCAnimate actionWithAnimation:flyAnim]];
    [charSprite runAction:flyAction];
    
    speed = 180;
    CCSprite* dragon = [GameScene sharedScene].dragon;
    CGPoint offset = ccpSub(dragon.position,charSprite.position);
    float ratio = (float) offset.x / (float) offset.y;
    float finalY = winSize.width+charSprite.contentSize.width;
    float finalX = ((finalY-charSprite.position.y) * ratio) +  charSprite.position.x;
    CGPoint realDest = ccp(finalX, finalY);
    
    // calculat the speed
    float distanceToMove = ccpLength(offset);
    float moveDuration = distanceToMove / speed;
    // Determine angle to face
    float angleRadians = atanf((float)offset.y / (float)offset.x);
    float angleDegrees = CC_RADIANS_TO_DEGREES(angleRadians);
    float cocosAngle;
    if(dragon.position.x>=charSprite.position.x){
    cocosAngle = -1 * angleDegrees;
    }
    else{
        cocosAngle = -1 * angleDegrees +180;
    }
    charSprite.rotation = cocosAngle;
    
    // Create the actions
    CCMoveTo * actionMove = [CCMoveTo actionWithDuration:moveDuration position:realDest];
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

