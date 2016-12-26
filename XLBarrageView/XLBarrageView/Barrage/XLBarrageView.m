//
//  XLBarrageView.m
//  XLBarrageView
//
//  Created by Shelin on 16/12/26.
//  Copyright © 2016年 StarUnion. All rights reserved.
//

#import "XLBarrageView.h"
#import "XLBarrageSprite.h"
#import "XLBarrageModel.h"

static CGFloat const minSpace = 20.f;
static NSTimeInterval duration = 3.f;

@interface XLBarrageView () <CAAnimationDelegate>

@property (nonatomic, strong) NSMutableArray *barrages;

@end

@implementation XLBarrageView {
    dispatch_semaphore_t _seaphore; // 信号量;
    dispatch_queue_t _queue; // 执行队列
    NSInteger _barrageTaskCount;  // 等待执行动画的任务数
}

#pragma mark - init

- (instancetype)init {
    
    if (self = [super init]) {
        self.backgroundColor = [UIColor clearColor];
        self.clipsToBounds = YES;
        
        _barrages = [NSMutableArray array];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat space = minSpace;
    CGFloat barrageHeight = (self.frame.size.height - minSpace * (self.barrages.count + 1)) / self.barrages.count;
    
     for (int i = 0; i < self.barrages.count; i ++) {
         
         XLBarrageSprite *barrageSprite = self.barrages[i];
         barrageSprite.frame = CGRectMake(self.frame.size.width, space + i * (space + barrageHeight), 200, barrageHeight);
     }
}

- (void)insertBarrageWithModel:(id)model {
    
    XLBarrageModel *barrageModel = (XLBarrageModel *)model;
    _barrageTaskCount += 1;
    
    NSInteger trackCount = 1;
    
    if (!self.barrages.count) {
        if ([self.delegate respondsToSelector:@selector(numberTrackCountInBarrageView:)]) {
            trackCount = [self.delegate numberTrackCountInBarrageView:self];
        }

        // dispatch_semaphore
        _seaphore = dispatch_semaphore_create(trackCount);
        _queue = dispatch_queue_create("xl_semaphore_dispatch_async_queue", DISPATCH_QUEUE_CONCURRENT);
        
        for (int i = 0; i < trackCount; i ++) {
            if ([self.delegate respondsToSelector:@selector(barrageSpriteInBarrageView:)]) {
                XLBarrageSprite *barrageSprite = [self.delegate barrageSpriteInBarrageView:self];
                barrageSprite.isAnimating = NO;
                [self addSubview:barrageSprite];
                [_barrages addObject:barrageSprite];
            }
        }
    }
    
    dispatch_async(_queue, ^{
        
        // Wait until the semaphore is not zero -1
        dispatch_semaphore_wait(_seaphore, DISPATCH_TIME_FOREVER);
        dispatch_async(dispatch_get_main_queue(), ^{
            
            for (int i = 0; i < self.barrages.count; i ++) {

                XLBarrageSprite *barrageSprite = self.barrages[i];
                if (!barrageSprite.isAnimating) {
                    barrageSprite.barrageModel = barrageModel;
                    [self startMoveAnimation:barrageSprite animationKey:[self animationKey:i]];
                    break;
                }
            }
        });
    });
}

- (NSString *)animationKey:(NSInteger)num {
    return [NSString stringWithFormat:@"%@AnimationKey_%ld", NSStringFromClass([XLBarrageSprite class]),num];
}

#pragma mark - animation

- (void)startMoveAnimation:(UIView *)barrageSprite animationKey:(NSString *)animationKey {
    
    CABasicAnimation *moveAnimation = [CABasicAnimation animationWithKeyPath:@"position.x"];
    moveAnimation.removedOnCompletion = NO;
    moveAnimation.delegate = self;
    moveAnimation.toValue = @(self.frame.size.width);
    moveAnimation.toValue = @(-barrageSprite.frame.size.width);
    moveAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    moveAnimation.duration = duration;
    [barrageSprite.layer addAnimation:moveAnimation forKey:animationKey];
}

#pragma mark - CAAnimationDelegate

- (void)animationDidStart:(CAAnimation *)anim {
    
    for (int i = 0; i < self.barrages.count; i ++) {
        
        XLBarrageSprite *barrageSprite = self.barrages[i];
        CAAnimation *animation = [barrageSprite.layer animationForKey:[self animationKey:i]];
        if ([animation isEqual:anim]) {
            barrageSprite.isAnimating = YES;
            break;
        }
    }
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    
    _barrageTaskCount -= 1;
    
    if (!_barrageTaskCount) {  // finish
        if ([self.delegate respondsToSelector:@selector(barrageViewDidFinishAllBarrages:)]) {
            [self.delegate barrageViewDidFinishAllBarrages:self];
        }
    }
    
    // After the execution semaphore plus one again +1
    dispatch_semaphore_signal(_seaphore);
    
    for (int i = 0; i < self.barrages.count; i ++) {
        
        XLBarrageSprite *barrageSprite = self.barrages[i];
        CAAnimation *animation = [barrageSprite.layer animationForKey:[self animationKey:i]];
        if ([animation isEqual:anim]) {
            barrageSprite.isAnimating = NO;
            [barrageSprite.layer removeAnimationForKey:[self animationKey:i]];
            break;
        }
    }
}

@end
