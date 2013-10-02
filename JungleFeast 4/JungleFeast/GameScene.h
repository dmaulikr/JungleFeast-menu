//
//  GameScene.h
//  JungleFeast
//
//  Created by Deng Yuanyuan on 13-9-16.
//  Copyright (c) 2013年 Sylvia. All rights reserved.
//

#import "CCLayer.h"

@interface GameScene : CCLayer

{
    NSMutableArray * _food;
    NSMutableArray * _danger;
    CCLabelTTF *label;
    int num;
    BOOL dragonMoving;
    int lives;
    CCMoveTo * actionMove;
    int castleInitialActionStopFlag;
    CCMenuItem *_On;
    CCMenuItem *_Off;
}
@property (nonatomic, strong) CCSprite *castle;
@property (nonatomic, strong) CCSprite *dragon;
@property (nonatomic, strong) CCParticleSystem *fire;
@property (nonatomic, strong) CCAction *walkAction;
@property (nonatomic, strong) CCAction *flyAction;
@property (nonatomic, strong) CCAction *walkAction2;
@property (nonatomic, strong) CCAction *moveAction;
@property (nonatomic, strong) CCMoveTo *castlemove;
@property (nonatomic, assign) NSMutableArray * _food;

// returns a CCScene that contains the HelloWorldLayer as the only child
//+(CCScene *) scene;
+ (GameScene*) sharedScene;
-(CCSprite*) getDragon;



@end
