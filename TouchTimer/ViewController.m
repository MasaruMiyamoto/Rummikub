//
//  ViewController.m
//  TouchTimer
//
//  Created by MasaruMiyamoto on 2014/11/27.
//  Copyright (c) 2014年 MasaruMiyamoto. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIButton *stop;



@end

@implementation ViewController
@synthesize setLabel;

NSTimer *timer;
int countDown;
bool flag,onOff;
NSString *useLabel;

- (void)viewDidLoad {
    [super viewDidLoad];
    useLabel = setLabel;
    self.label.text = useLabel;
    // Do any additional setup after loading the view, typically from a nib.
//    NSLog(@"hoge");
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)button:(id)sender {
    [self initTimer];
}

- (void)timerDidFire:(NSTimer*)timer
{
    // 処理内容を実装
    int countH,countM,countS;
    NSString *outLabel;
    
    for (int i=0; i < [self.label.text length];i++){
        
    }
    countH = (int)[[self.label.text substringToIndex:1] integerValue];
    countM = (int)[[self.label.text substringWithRange:NSMakeRange(2,2)] integerValue];
    countS = (int)[[self.label.text substringWithRange:NSMakeRange(5,2)] integerValue];
    
//    NSLog(@"%d,%d,%d",countH,countM,countS);
    
    countS -= 1;
    if(countS < 0){
        countS = 99;
        countM -= 1;
        if(countM < 0) {
            countM = 59;
            countH -= 1;
            if(countH < 0){
                self.label.text = @"0:00.00";
                [timer invalidate];
                flag = false;
            }
        }
    }
    
    if(flag){
        outLabel = [NSString stringWithFormat:@"%d",countH];
        outLabel = [outLabel stringByAppendingString:@":"];
        
        if(countM / 10 == 0)
            outLabel = [outLabel stringByAppendingString:@"0"];
        outLabel = [outLabel stringByAppendingString:[NSString stringWithFormat:@"%d",countM]];
        outLabel = [outLabel stringByAppendingString:@"."];
        
        if(countS / 10 == 0)
            outLabel = [outLabel stringByAppendingString:@"0"];
        outLabel = [outLabel stringByAppendingString:[NSString stringWithFormat:@"%d",countS]];
        
        self.label.text = outLabel;
    }else{
        //ここにアラート機能つける
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"しゅーりょー！" message:@"山札から１枚引いて交代です" preferredStyle:UIAlertControllerStyleAlert];
        
        //addAction　した順に左から配置
        [alertController addAction:[UIAlertAction actionWithTitle:@"はい" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            //othrボタンが押されたときの処理
            
            
            [self otherButtonPushed];
        }]];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

- (void)otherButtonPushed{
//    NSLog(@"hoge");
    [self initTimer];
}

- (void)initTimer{
//    self.label.text = @"0:04.00";
    self.label.text = useLabel;
    flag = true;
    onOff = true;
    if ([timer isValid]) {
        [timer invalidate];
    }
    timer = [NSTimer scheduledTimerWithTimeInterval:0.01 // タイマー間隔(秒)
                                             target:self
                                           selector:@selector(timerDidFire:) // タイマーで呼ばれる関数を定義
                                           userInfo:nil
                                            repeats:YES]; // リピートするかどうか
    
}

- (IBAction)Stop:(id)sender {
    if ([timer isValid]) {
        [timer invalidate];
        
    }
    [self.stop setTitle:@"Restart" forState:UIControlStateNormal
     ];
    if(!onOff){
        timer = [NSTimer scheduledTimerWithTimeInterval:0.01 // タイマー間隔(秒)
                                                 target:self
                                               selector:@selector(timerDidFire:) // タイマーで呼ばれる関数を定義
                                               userInfo:nil
                                                repeats:YES]; // リピートするかどうか
        [self.stop setTitle:@"Stop" forState:UIControlStateNormal
         ];
    }
    
    onOff = !onOff;
}






@end
