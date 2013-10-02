//
//  Danger.h
//  JungleFeast
//
//  Created by Sylvia on 13-9-25.
//  Copyright 2013年 Sylvia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Danger : CCNode {
    CCSprite *charSprite;
    int speed;
    int hurt;
    CCAction *moveAction;
    BOOL isclean;
}


@property (nonatomic, retain) CCSprite *charSprite;
@property (readwrite) int speed;
@property (readwrite) int hurt;
@property (nonatomic, strong) CCAction *moveAction;
@property (readwrite) BOOL isclean;
@end
