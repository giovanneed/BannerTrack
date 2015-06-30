//
//  ViewController.m
//  BannerTrack
//
//  Created by Giovanne Dias on 6/19/15.
//  Copyright (c) 2015 Giovanne Dias. All rights reserved.
//

#import "ViewController.h"
#import "ViewBanner.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    ViewBanner *banner = [[ViewBanner alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2,self.view.frame.size.height/2 , 115, 38) andAppKey:@"1212112"];
    
    [self.view addSubview:banner];
    
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
