//
//  Game.m
//  PingPongGame
//
//  Created by luowei on 14-6-3.
//  Copyright (c) 2014年 rootls. All rights reserved.
//

#import "Game.h"

int Y;
int X;

@interface Game (){
    NSTimer *timer;
    
}
@property (weak, nonatomic) IBOutlet UIImageView *ball;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UIImageView *player;
@property (weak, nonatomic) IBOutlet UIImageView *computer;

@end

@implementation Game

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *drag = [[event allTouches] anyObject];
    _player.center = [drag locationInView:self.view];
    
    if(_player.center.y > 520 || _player.center.y < 520){
        _player.center = CGPointMake(_player.center.x, 520);
    }
    if(_player.center.x < 40){
        _player.center = CGPointMake(40, _player.center.y);
    }
    if(_player.center.x > 280){
        _player.center = CGPointMake(280, _player.center.y);
    }
}

//computer 跟着球走
-(void)computerMovement{
    if(_computer.center.x > _ball.center.x){
        _computer.center = CGPointMake(_computer.center.x-2, _computer.center.y);
    }
    if(_computer.center.x < _ball.center.x){
        _computer.center = CGPointMake(_computer.center.x + 2, _computer.center.y);
    }
    if(_computer.center.x < 40){
        _computer.center = CGPointMake(40, _computer.center.y);
    }
    if(_computer.center.x > 280){
        _computer.center = CGPointMake(280, _computer.center.y);
    }
}

//开始发球
- (IBAction)startButton:(id)sender {
    Y = arc4random() % 11;
    Y -= 5;
    
    X = arc4random() % 11;
    X -= 5;
    
    if(Y==0){
        Y = 1;
    }
    if(X==0){
        X = 1;
    }
    
    
    
    timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(ballMovement) userInfo:nil repeats:YES];
    
}

-(void)ballMovement{
    [self computerMovement];
    
    _ball.center = CGPointMake(_ball.center.x+X, _ball.center.y+Y);
    
    if(_ball.center.x < 0 || _ball.center.x > 290){
        X = 0 - X;
    }
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
