//
//  ViewController.m
//  DLSimpleAutolayoutDemo
//
//  Created by Dan.Lee on 2017/4/26.
//  Copyright © 2017年 Dan Lee. All rights reserved.
//

#import "ViewController.h"
#import "DLSimpleAutolayout.h"

@interface ViewController ()

@property (nonatomic, strong) UIButton *button1;
@property (nonatomic, strong) UIButton *button2;

@end

@implementation ViewController

- (UIButton *)button1 {
    if (_button1 == nil) {
        _button1 = [UIButton new];
        [_button1 setTitle:@"Button One" forState:UIControlStateNormal];
        [_button1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _button1.backgroundColor = [UIColor brownColor];
    }
    return _button1;
}

- (UIButton *)button2 {
    if (_button2 == nil) {
        _button2 = [UIButton new];
        [_button2 setTitle:@"Button Two" forState:UIControlStateNormal];
        [_button2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _button2.backgroundColor = [UIColor purpleColor];
    }
    return _button2;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.button1];
    [self.view addSubview:self.button2];
    
    @[
      self.button1.dl_top.equalTo(self.view).offset(100),
      self.button1.dl_left.equalTo(self.view).offset(10),
      self.button1.dl_right.equalTo(self.view).offset(-10),
      self.button1.dl_height.equalTo(@40),
    ].dl_constraint_install();
    
    @[
      self.button2.dl_top.equalTo(self.button1.dl_bottom).offset(10),
      self.button2.dl_left.equalTo(self.button1),
      self.button2.dl_right.equalTo(self.button1),
      self.button2.dl_height.equalTo(@60),
    ].dl_constraint_install();
}



@end
