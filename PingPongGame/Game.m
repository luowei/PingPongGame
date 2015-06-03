//
//  Game.m
//  PingPongGame
//
//  Created by luowei on 14-6-3.
//  Copyright (c) 2014年 rootls. All rights reserved.
//

#import "Game.h"

#define SCREEN_SIZE [UIScreen mainScreen].bounds.size

int Y;
int X;
int playerScoreNumber;
int computerScoreNumber;

@interface Game (){
    NSTimer *timer;
    
}
@property (weak, nonatomic) IBOutlet UIImageView *ball;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UIImageView *player;
@property (weak, nonatomic) IBOutlet UIImageView *computer;
@property (weak, nonatomic) IBOutlet UILabel *playScore;
@property (weak, nonatomic) IBOutlet UILabel *computerScore;
@property (weak, nonatomic) IBOutlet UILabel *winOrLose;
@property (weak, nonatomic) IBOutlet UIButton *exit;

@end

@implementation Game

//发生碰撞，球往回弹
-(void)collision{
    if(CGRectIntersectsRect(_player.frame, _ball.frame)){
        Y = arc4random() % 5;
        Y = 0 - Y;
    }
    if (CGRectIntersectsRect(_computer.frame, _ball.frame)) {
        Y = arc4random() % 5;
    }

}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *drag = [[event allTouches] anyObject];
    _player.center = [drag locationInView:self.view];
    
    if(_player.center.y > SCREEN_SIZE.height-50 || _player.center.y < SCREEN_SIZE.height-50){
        _player.center = CGPointMake(_player.center.x, SCREEN_SIZE.height-50);
    }
    if(_player.center.x < 40){
        _player.center = CGPointMake(40, _player.center.y);
    }
    if(_player.center.x > SCREEN_SIZE.width-40){
        _player.center = CGPointMake(SCREEN_SIZE.width-40, _player.center.y);
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
    if(_computer.center.x > SCREEN_SIZE.width-40){
        _computer.center = CGPointMake(SCREEN_SIZE.width-40, _computer.center.y);
    }
    
    //computer失误
    if(_ball.center.y < 50){
        playerScoreNumber += 1;
        _playScore.text = [NSString stringWithFormat:@"%i",playerScoreNumber];

        [self resetGame];

        if(playerScoreNumber > 10){
            _startButton.hidden = YES;
            _exit.hidden = NO;
            _winOrLose.hidden = NO;
            _winOrLose.text = [NSString stringWithFormat:@"你赢了！！"];
        }
    }
    
    //player失误
    if(_ball.center.y > SCREEN_SIZE.height-50){
        computerScoreNumber += 1;
        _computerScore.text = [NSString stringWithFormat:@"%i",computerScoreNumber];

        [self resetGame];

        if(computerScoreNumber > 10){
            _startButton.hidden = YES;
            _exit.hidden = NO;
            _winOrLose.hidden = NO;
            _winOrLose.text = [NSString stringWithFormat:@"你输了！"];
        }
    }
}

- (void)resetGame {
    [timer invalidate];
    _startButton.hidden = NO;

    _ball.center = CGPointMake(SCREEN_SIZE.width/2+15, SCREEN_SIZE.height/2-45);
    _computer.center = CGPointMake(SCREEN_SIZE.width/2+40, 50);
    _player.center = CGPointMake(SCREEN_SIZE.width/2+40, SCREEN_SIZE.height-50);
}

//开始发球
- (IBAction)startButton:(id)sender {
    
    _startButton.hidden = YES;
    _exit.hidden = YES;
    
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
    [self collision];
    
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
    
    playerScoreNumber = 0;
    computerScoreNumber = 0;
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
