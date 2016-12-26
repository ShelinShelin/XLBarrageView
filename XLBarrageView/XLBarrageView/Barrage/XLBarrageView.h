//
//  XLBarrageView.h
//  XLBarrageView
//
//  Created by Shelin on 16/12/26.
//  Copyright © 2016年 StarUnion. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XLBarrageView;

@protocol XLBarrageViewDelegate <NSObject>

- (void)barrageViewDidFinishAllBarrages:(XLBarrageView *)barrageView;

@end

@interface XLBarrageView : UIView

@property (nonatomic, weak) id <XLBarrageViewDelegate> delegate;

/**
 * trackCount 弹幕通道数，默认1
 */
- (instancetype)initWithTrackCount:(NSInteger)trackCount;

- (void)insertBarrageWithModel:(id)model;

@end
