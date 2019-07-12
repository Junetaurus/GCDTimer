//
//  ViewController.m
//  GCDTimer
//
//  Created by Zhang on 2019/7/12.
//  Copyright © 2019 cue. All rights reserved.
//

#import "ViewController.h"
#import "JTimer.h"

@interface ViewController ()

@property (nonatomic, copy) NSString *name;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _name = [JTimer scheduledTimerWithTimeStart:0 interval:1 repeats:NO async:YES target:self selector:@selector(test)];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [JTimer cancelTimerWithName:_name];
    NSLog(@"%s", __func__);
}

- (void)test {
    NSLog(@"%s", __func__);
}

@end
