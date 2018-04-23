//
//  ViewController.m
//  CompassDemo
//
//  Created by ZRY on 2017/10/17.
//  Copyright © 2017年 ZRY. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>
@interface ViewController ()<CLLocationManagerDelegate>

@property(nonatomic,strong)UILabel *lbAngle;            //角度
@property(nonatomic,strong)UILabel *lbLocation;         //文字  西偏北XXX
@property(nonatomic,strong)UILabel *lbPresentLocation;  //文字  ”当前位置“
@property(nonatomic,strong)UIImageView *imgBackground;  //指南针背景图片
@property(nonatomic,strong)UIImageView *imgPointer;     //指针

@property(nonatomic,strong)CLLocationManager *mgr;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _imgBackground = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"大指南针"]];
    _imgBackground.frame = CGRectMake(20, 80, 50, 50);
    [self.view addSubview:_imgBackground];
    _imgPointer = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"指针南北指向"]];
    _imgPointer.frame = CGRectMake(20, 80, 17, 109);
    [self.view addSubview:_imgPointer];
    
    _lbAngle = [[UILabel alloc]init];
    _lbAngle.frame = CGRectMake(100, 250, 50, 20);
    _lbAngle.text = @"--";
    [self.view addSubview:_lbAngle];
    
    _lbLocation = [[UILabel alloc]init];
    _lbLocation.frame = CGRectMake(10, 250, 60, 20);
    _lbLocation.text = @"-----";
    [self.view addSubview:_lbLocation];
    
    
    self.mgr.delegate = self;
    [self.mgr startUpdatingHeading];
}
#pragma mark --- CLLocationManagerDelegate
-(void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading
{
    //如果是负数，代表当前设备朝向不可用
    if(newHeading.headingAccuracy < 0){
        return;
    }
    NSLog(@"newHeading--%f",newHeading.magneticHeading);
    CGFloat angle = newHeading.magneticHeading;
    CGFloat radian = (angle)/180.0 * M_PI;
    self.imgPointer.transform = CGAffineTransformMakeRotation(-radian);
//    [UIView animateWithDuration:0.1 animations:^{
//        self.imgPointer.transform = CGAffineTransformMakeRotation(-radian);
//    }];
    self.lbAngle.text = [NSString stringWithFormat:@"%.f°",angle];
    if (angle >= 337 || angle <= 22) {
        self.lbLocation.text = @"北";
    }
    if (angle >= 23 && angle <= 67) {
        self.lbLocation.text = @"东偏北";
    }
    if (angle >= 68 && angle <= 112) {
        self.lbLocation.text = @"东";
    }
    if (angle >= 113 && angle <= 157) {
        self.lbLocation.text = @"东偏南";
    }
    if (angle >= 158 && angle <= 202) {
        self.lbLocation.text = @"南";
    }
    if (angle >= 203 && angle <= 247) {
        self.lbLocation.text = @"西偏南";
    }
    if (angle >= 248 && angle <= 292) {
        self.lbLocation.text = @"西";
    }
    if (angle >= 293 && angle <= 336) {
        self.lbLocation.text = @"西偏北";
    }
}

-(CLLocationManager *)mgr
{
    if(!_mgr){
        _mgr = [[CLLocationManager alloc]init];
    }
    return _mgr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
