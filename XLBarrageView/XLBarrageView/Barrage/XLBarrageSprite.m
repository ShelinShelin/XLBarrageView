//
//  XLBarrageSprite.m
//  XLBarrageView
//
//  Created by Shelin on 16/12/26.
//  Copyright © 2016年 StarUnion. All rights reserved.
//

#import "XLBarrageSprite.h"
#import "XLBarrageModel.h"
#import "UIImage+XLAdd.h"

@interface XLBarrageSprite ()

@property (nonatomic, strong) UIImageView *headerImageView;
@property (nonatomic, strong) UILabel *nickNameLabel;
@property (nonatomic, strong) UILabel *contentLabel;

@end

@implementation XLBarrageSprite

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor clearColor];
        
        _headerImageView = [[UIImageView alloc] init];
        [self addSubview:_headerImageView];
        
        _nickNameLabel = [[UILabel alloc] init];
        _nickNameLabel.textColor = [UIColor blackColor];
        _nickNameLabel.font = [UIFont systemFontOfSize:20];
        [self addSubview:_nickNameLabel];
        
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.textColor = [UIColor blackColor];
        _contentLabel.font = [UIFont systemFontOfSize:20];
        [self addSubview:_contentLabel];
    }
    return self;
}

- (void)setBarrageModel:(XLBarrageModel *)barrageModel {
    _barrageModel = barrageModel;
    
    self.headerImageView.image = [[UIImage imageNamed:barrageModel.headerURL] circleImage];
    
    self.nickNameLabel.text = barrageModel.nickName;
    
    self.contentLabel.text = barrageModel.content;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    CGFloat height = self.frame.size.height;

    self.headerImageView.frame = CGRectMake(0, 0, height, height);
    
    self.nickNameLabel.frame = CGRectMake(CGRectGetMaxX(self.headerImageView.frame) + 5, 0, (self.frame.size.width - height), height / 2.0);
    
    self.contentLabel.frame = CGRectMake(CGRectGetMaxX(self.headerImageView.frame) + 5, height / 2, (self.frame.size.width - height), height / 2.0);
}

@end
