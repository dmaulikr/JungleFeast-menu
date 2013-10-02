//
//  rabbit.h
//  JungleFeast
//
//  Created by Deng Yuanyuan on 13-9-23.
//  Copyright (c) 2013年 Sylvia. All rights reserved.
//

#import "CCNode.h"
#import "CCBReader.h"
@interface rabbit : CCNode{
    CCMoveTo * accMoveTo;
    int score;
}
@property (nonatomic,assign) int score;
@end
