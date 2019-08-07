//
//  MainViewController.m
//  Gift
//
//  Created by sunwei on 2019/2/14.
//  Copyright © 2019年 sunwei. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController () <UIScrollViewDelegate>

@property(nonatomic,strong) UIScrollView * scrollView;
@property(nonatomic,strong) UILabel * mainLabel;
@property(nonatomic,strong) NSTimer * timer;
@property(nonatomic,strong) UIButton * btn;

@end

@implementation MainViewController
{
    NSInteger _currentIndex;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _currentIndex = -1;
    [self makeView];
    [self setupEmitter];
}

- (void)setupEmitter{
    // Cells spawn in the bottom, moving up
    CAEmitterLayer *fireworksEmitter = [CAEmitterLayer layer];
    CGRect viewBounds = self.view.layer.bounds;
    fireworksEmitter.emitterPosition = CGPointMake(viewBounds.size.width/2.0, viewBounds.size.height);
    fireworksEmitter.emitterSize    = CGSizeMake(1, 0.0);
    fireworksEmitter.emitterMode    = kCAEmitterLayerOutline;
    fireworksEmitter.emitterShape    = kCAEmitterLayerLine;
    fireworksEmitter.renderMode        = kCAEmitterLayerAdditive;
    //fireworksEmitter.seed = 500;//(arc4random()%100)+300;
    
    // Create the rocket
    CAEmitterCell* rocket = [CAEmitterCell emitterCell];
    
    rocket.birthRate        = 6.0;
    rocket.emissionRange    = 0.12 * M_PI;  // some variation in angle
    rocket.velocity            = 500;
    rocket.velocityRange    = 150;
    rocket.yAcceleration    = 0;
    rocket.lifetime            = 2.02;    // we cannot set the birthrate < 1.0 for the burst
    
    rocket.contents            = (id) [[UIImage imageNamed:@"ball"] CGImage];
    rocket.scale            = 0.2;
    //    rocket.color            = [[UIColor colorWithRed:1 green:0 blue:0 alpha:1] CGColor];
    rocket.greenRange        = 1.0;        // different colors
    rocket.redRange            = 1.0;
    rocket.blueRange        = 1.0;
    
    rocket.spinRange        = M_PI;        // slow spin
    
    
    
    // the burst object cannot be seen, but will spawn the sparks
    // we change the color here, since the sparks inherit its value
    CAEmitterCell* burst = [CAEmitterCell emitterCell];
    
    burst.birthRate            = 1.0;        // at the end of travel
    burst.velocity            = 0;
    burst.scale                = 2.5;
    burst.redSpeed            =-1.5;        // shifting
    burst.blueSpeed            =+1.5;        // shifting
    burst.greenSpeed        =+1.0;        // shifting
    burst.lifetime            = 0.35;
    
    // and finally, the sparks
    CAEmitterCell* spark = [CAEmitterCell emitterCell];
    
    spark.birthRate            = 666;
    spark.velocity            = 125;
    spark.emissionRange        = 2* M_PI;    // 360 deg
    spark.yAcceleration        = 75;        // gravity
    spark.lifetime            = 3;
    
    spark.contents            = (id) [[UIImage imageNamed:@"fire"] CGImage];
    spark.scale                =0.5;
    spark.scaleSpeed        =-0.2;
    spark.greenSpeed        =-0.1;
    spark.redSpeed            = 0.4;
    spark.blueSpeed            =-0.1;
    spark.alphaSpeed        =-0.5;
    spark.spin                = 2* M_PI;
    spark.spinRange            = 2* M_PI;
    
    // putting it together
    fireworksEmitter.emitterCells    = [NSArray arrayWithObject:rocket];
    rocket.emitterCells                = [NSArray arrayWithObject:burst];
    burst.emitterCells                = [NSArray arrayWithObject:spark];
    [self.view.layer addSublayer:fireworksEmitter];
    
}

-(void)makeView {

    self.view.backgroundColor = [UIColor blackColor];
    
    UILabel * topLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 40)];
    topLabel.text = @"情人节快乐";
    topLabel.textColor = [UIColor whiteColor];
    topLabel.textAlignment = NSTextAlignmentCenter;
    topLabel.font = [UIFont systemFontOfSize:30];
    [self.view addSubview:topLabel];

    self.btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btn setTitle:@"点我" forState:UIControlStateNormal];
    [self.btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.btn.frame = CGRectMake(0, self.view.frame.size.height-80, self.view.frame.size.width, 60);
    [self.btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btn];
    
}

-(void)click {
    [self.view addSubview:self.scrollView];
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width*2, self.view.frame.size.height);
    self.mainLabel.frame = CGRectMake(0, 0, self.view.frame.size.width*2, self.scrollView.frame.size.height);
    [self.scrollView addSubview:self.mainLabel];
    self.mainLabel.text = @"张先兰，认识你很开心，我应该庆幸你今天还单身😄";
    
    [self makeTimer];
    self.btn.hidden = YES;

}

-(void)makeTimer {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.8 target:self selector:@selector(scrollChange) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];

}

-(void)scrollChange {
    _currentIndex ++;
    if (_currentIndex == 10) {
        _currentIndex = 0;
    }
    self.scrollView.contentOffset = CGPointMake(self.view.frame.size.width/5*_currentIndex, 0);
}

#pragma scrollviewdelegete
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
}


-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-300, self.view.frame.size.width, 60)];
        _scrollView.delegate = self;
    }
    return _scrollView;
}

-(UILabel *)mainLabel{
    if (!_mainLabel) {
        _mainLabel = [[UILabel alloc]init];
        _mainLabel.textColor = [UIColor whiteColor];
        _mainLabel.font = [UIFont systemFontOfSize:30];
    }
    return _mainLabel;
}

@end
