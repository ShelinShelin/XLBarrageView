//
//  ViewController.m
//  XLBarrageView
//
//  Created by Shelin on 16/12/26.
//  Copyright © 2016年 StarUnion. All rights reserved.
//

#import "ViewController.h"
#import "XLBarrageView.h"

@interface ViewController () <XLBarrageViewDelegate>

@property (nonatomic, strong) XLBarrageView *barrageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    XLBarrageView *barrageView = [[XLBarrageView alloc] initWithTrackCount:4];
    barrageView.frame = CGRectMake(0, 200, self.view.frame.size.width, 200);
    barrageView.delegate = self;
    [self.view addSubview:barrageView];
    
    self.barrageView = barrageView;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.barrageView insertBarrageWithModel:@""];
}

- (void)barrageViewDidFinishAllBarrages:(XLBarrageView *)barrageView {
    NSLog(@"barrageViewDidFinishAllBarrages");
}

@end
