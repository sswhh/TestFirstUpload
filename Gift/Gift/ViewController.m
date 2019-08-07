//
//  ViewController.m
//  Gift
//
//  Created by sunwei on 2019/2/14.
//  Copyright © 2019年 sunwei. All rights reserved.
//

#import "ViewController.h"
#import "MainViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self makeView];
}

-(void)makeView {
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"点我" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    btn.frame = CGRectMake(0, self.view.frame.size.height /2, self.view.frame.size.width, 40);
    [btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];

}

-(void)click
{
    MainViewController * controller = [[MainViewController alloc]init];
    [self presentViewController:controller animated:YES completion:nil];
}


@end
