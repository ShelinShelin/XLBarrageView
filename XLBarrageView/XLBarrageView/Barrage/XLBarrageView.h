//
//  XLBarrageView.h
//  XLBarrageView
//
//  Created by Shelin on 16/12/26.
//  Copyright © 2016年 StarUnion. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XLBarrageView, XLBarrageSprite, XLBarrageModel;

@protocol XLBarrageViewDelegate <NSObject>

@optional
- (void)barrageViewDidFinishAllBarrages:(XLBarrageView *)barrageView;
- (void)barrageView:(XLBarrageView *)barrageView didClick:(XLBarrageModel *)model;
- (NSInteger)numberTrackCountInBarrageView:(XLBarrageView *)barrageView; // 弹幕通道数，默认1

@required

- (XLBarrageSprite *)barrageSpriteInBarrageView:(XLBarrageView *)barrageView;

@end

@interface XLBarrageView : UIView

@property (nonatomic, weak) id <XLBarrageViewDelegate> delegate;

- (void)insertBarrageWithModel:(id)model;

@end
