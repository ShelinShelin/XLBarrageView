//
//  ViewController.m
//  XLBarrageView
//
//  Created by Shelin on 16/12/26.
//  Copyright © 2016年 StarUnion. All rights reserved.
//

#import "ViewController.h"
#import "XLBarrageView.h"
#import "XLBarrageModel.h"
#import "XLBarrageSprite.h"

@interface ViewController () <XLBarrageViewDelegate>

@property (nonatomic, strong) XLBarrageView *barrageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    XLBarrageView *barrageView = [[XLBarrageView alloc] init];
    barrageView.backgroundColor = [UIColor lightGrayColor];
    barrageView.frame = CGRectMake(0, 20, self.view.frame.size.width, 300);
    barrageView.delegate = self;
    [self.view addSubview:barrageView];
    
    self.barrageView = barrageView;
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    XLBarrageModel *barrageModel = [[XLBarrageModel alloc] init];
    barrageModel.headerURL = [NSString stringWithFormat:@"icon_%d", rand() % 5];
    barrageModel.nickName = [NSString stringWithFormat:@"user_%d", rand() % 100];
    barrageModel.content = @"contentcontentcontentcontent";
    [self.barrageView insertBarrageWithModel:barrageModel];
}

#pragma mark - XLBarrageViewDelegate

- (NSInteger)numberTrackCountInBarrageView:(XLBarrageView *)barrageView {
    return 5;
}

- (XLBarrageSprite *)barrageSpriteInBarrageView:(XLBarrageView *)barrageView {
    XLBarrageSprite *barrageSprite = [[XLBarrageSprite alloc] init];
    return barrageSprite;
}

- (void)barrageView:(XLBarrageView *)barrageView didClick:(XLBarrageModel *)model {
    
}

- (void)barrageViewDidFinishAllBarrages:(XLBarrageView *)barrageView {
    NSLog(@"barrageViewDidFinishAllBarrages");
}

@end
