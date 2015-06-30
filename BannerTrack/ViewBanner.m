//
//  ViewBanner.m
//  BannerTrack
//
//  Created by Giovanne Dias on 6/19/15.
//  Copyright (c) 2015 Giovanne Dias. All rights reserved.
//

#import "ViewBanner.h"


@interface ViewBanner ()

@end

@implementation ViewBanner


- (instancetype)initWithFrame:(CGRect)frame andAppKey:(NSString *)appKey;
{
    self = [super init];
    if (self) {
        
        self.frame = frame;
        NSDictionary *model = [self requestBannerControllerModelWithAppID:appKey height:frame.size.height width:frame.size.width];
        self.URLfwrd = [NSURL URLWithString:model[kLinkBanner]];
        self.URLimage = [NSURL URLWithString:model[kURLImageBanner]];
        self.bannerID = model[kIDBanner];
        self.frame = frame;
        self.image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width,frame.size.height)];
        [self.image setImage:[self imageBanner]];
        [self addSubview:self.image];
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetected)];
        [self addGestureRecognizer:singleTap];
        self.appKey = appKey;

        

    }
    
    return self;
}
-(void)tapDetected
{
    
    [[UIApplication sharedApplication] openURL:self.URLfwrd];
    
    NSString *deviceID = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    deviceID = @"690ADDA9-FAB6-474B-B50A-69FA3D99B292";

    
    [self postNotificationBannerClickedWithDeviceID:deviceID
                                             appKey:self.appKey
                                          timaStamp:[NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970] ]];
}

+(BOOL)installedAPPWithDeviceID:(NSString *)deviceID appKey:(NSString *)appKey timaStamp:(NSString *)timeStamp
{
    
    NSError *error = [[NSError alloc] init];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    
    NSDictionary *parameters = @{@"deviceID":deviceID,
                                 @"appID":appKey,
                                 @"TimeStamp":timeStamp};                                 
    
    NSData *jsondata = [NSJSONSerialization dataWithJSONObject:parameters
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    
    
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setHTTPMethod:@"POST"];
    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[jsondata length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:jsondata];
    
    
    NSString *url = [NSString stringWithFormat:@"http://localhost:1337/banner/clickedBanner"];
    [request setURL:[NSURL URLWithString:url]];
    
    NSHTTPURLResponse *responseCode = nil;
    NSLog(@"Request body %@", [[NSString alloc] initWithData:[request HTTPBody] encoding:NSUTF8StringEncoding]);
    
    
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
    
    if([responseCode statusCode] != 200){
        NSLog(@"Error getting %@, HTTP status code %li", url, (long)[responseCode statusCode]);
        return false;
    }
    
    
    return true;
}
-(UIImage *)imageBanner
{
                          
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];
    [request setURL:self.URLimage];
    NSError *error = [[NSError alloc] init];
    NSHTTPURLResponse *responseCode = nil;
    
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
    
    return [UIImage imageWithData:responseData];

}

-(BOOL)postNotificationBannerClickedWithDeviceID:(NSString *)deviceID appKey:(NSString *)appKey timaStamp:(NSString *)timeStamp
{
    NSError *error = [[NSError alloc] init];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];

    
    NSDictionary *parameters = @{@"deviceID":deviceID,
                                 @"appID":appKey,
                                 @"TimeStamp":timeStamp,
                                 @"idBanner":self.bannerID
                                 };
    
    NSData *jsondata = [NSJSONSerialization dataWithJSONObject:parameters
                                               options:NSJSONWritingPrettyPrinted
                                                 error:&error];
    
    
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setHTTPMethod:@"POST"];
    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[jsondata length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:jsondata];

    
    NSString *url = [NSString stringWithFormat:@"http://localhost:1337/banner/clickedBanner"];
    [request setURL:[NSURL URLWithString:url]];
    
    NSHTTPURLResponse *responseCode = nil;
    NSLog(@"Request body %@", [[NSString alloc] initWithData:[request HTTPBody] encoding:NSUTF8StringEncoding]);
    
    
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
    
    if([responseCode statusCode] != 200){
        NSLog(@"Error getting %@, HTTP status code %li", url, (long)[responseCode statusCode]);
        return false;
    }
    
    
    return true;

}
-(NSDictionary *)requestBannerControllerModelWithAppID:(NSString *)appID height:(NSUInteger)height width:(NSUInteger)width

{
    NSURL *path = [NSURL URLWithString:[NSString stringWithFormat:@"http://localhost:1337/banner/%@/%d/%d",appID,(int)height,(int)width]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];
    [request setURL:path];
    
    NSError *error = [[NSError alloc] init];
    NSHTTPURLResponse *responseCode = nil;
    
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
    
    if([responseCode statusCode] != 200){
        NSLog(@"Error getting %@, HTTP status code %li", path, (long)[responseCode statusCode]);
        return nil;
    }
    
    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseData
                                                         options:kNilOptions
                                                           error:&error];

    
    
    return json;
}



@end
