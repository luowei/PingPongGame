//
//  ViewController.m
//  PingPongGame
//
//  Created by luowei on 14-6-3.
//  Copyright (c) 2014年 rootls. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *animateBackground;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    _animateBackground.animationImages = [[NSArray alloc]initWithObjects:
                                          [UIImage imageNamed:@"Menu01.png"],
                                          [UIImage imageNamed:@"Menu02.png"],
                                          [UIImage imageNamed:@"Menu03.png"],
                                          [UIImage imageNamed:@"Menu04.png"],
                                          [UIImage imageNamed:@"Menu05.png"],
                                          nil];
    [_animateBackground setAnimationRepeatCount:0];
    _animateBackground.animationDuration  = 5;
    [_animateBackground startAnimating];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
