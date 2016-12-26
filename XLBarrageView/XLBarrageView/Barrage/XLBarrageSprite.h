//
//  XLBarrageSprite.h
//  XLBarrageView
//
//  Created by Shelin on 16/12/26.
//  Copyright © 2016年 StarUnion. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XLBarrageModel;

@interface XLBarrageSprite : UIView

@property (nonatomic, assign) BOOL isAnimating;

@property (nonatomic, strong) XLBarrageModel *barrageModel;

@end
