//
//  ViewBanner.h
//  BannerTrack
//
//  Created by Giovanne Dias on 6/19/15.
//  Copyright (c) 2015 Giovanne Dias. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kURLGetBanner @"http://localhost:1337/banner/2"
#define kURLInitImage @"http://screenshots.en.sftcdn.net/en/scrn/12000/12381/"

#define kIDBanner @"idBanner"
#define kHeightBanner @"height"
#define kWidthBanner @"width"
#define kURLImageBanner @"URLImage"
#define kLinkBanner @"linkFwrd"


@interface ViewBanner : UIView

@property (strong, nonatomic) NSURL *URLfwrd;
@property (strong, nonatomic) NSURL *URLimage;
@property (strong, nonatomic) NSString *bannerID;
@property (strong, nonatomic) NSString *appKey;

@property (strong, nonatomic) UIImageView *image;


- (instancetype)initWithFrame:(CGRect)frame andAppKey:(NSString *)appKey;

@end
