//
//  ViewController.m
//  NSURLConnection
//
//  Created by Hezhibo on 16/9/7.
//  Copyright © 2016年 Hezhibo. All rights reserved.
//

#import "ViewController.h"
#import "NextViewController.h"

@interface ViewController ()<UpdateDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor redColor];
    //self.view.alpha = 0.2;
    //[self fetchAppleHtml];
    //[self fetchYahooData];
    //[self fetchYahooData2_GCD];
    //[self httpGetWithParams];
    //[self httpPostWithParams];
    [self creatLabel];
}

//asynchronousRequest connection
- (void)fetchAppleHtml {
    NSString *urlString  = @"http://www.apple.com";
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *relquest = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:30.0f];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:relquest queue:queue completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if ([data length] > 0 && connectionError == nil) {
            //请求到数据并且没有错误
            //获取沙盒目录
            NSString *documentsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
            //创建文件路径
            //stringByAppendingPathComponent 和 stringByAppendingString 区别拼接地址时候stringByAppendingPathComponent自动拼接“/”
            NSString *filePath = [documentsDir stringByAppendingPathComponent:@"apple.html"];
            [data writeToFile:filePath atomically:YES];
            NSLog(@"Successfully saved the file to %@",filePath);
            NSString *html = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            //NSLog(@"HTML = %@",html);
        }else if ([data length] == 0 && connectionError == nil) {
            NSLog(@"Nothing was downloaded");
        }else if (connectionError != nil) {
            NSLog(@"Error happend = %@",connectionError);
        }
         
    }];
}

//synchronousRequest connection
- (void)fetchYahooData {
    NSLog(@"We are here...");
    NSString *urlString = @"http://www.yahoo.com";
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLResponse *response = nil;
    NSError *error = nil;
    NSLog(@"Firing synchronous url connection...");
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    if ([data length] > 0 && error == nil) {
        NSLog(@"%lu bytes of data was retured.",(unsigned long)[data length]);
    }else if ([data length] == 0 && error == nil) {
        NSLog(@"NO data was returned");
    }else if (error != nil) {
        NSLog(@"Error happened = %@",error);
    }
    
    NSLog(@"We are done");
}

//call sendSynchronousRequest on GCD pool
- (void)fetchYahooData2_GCD {
    NSLog(@"We are here...");
    NSString *urlString = @"http://www.yahoo.com";
    NSLog(@"Firing synchronous url connection...");
    dispatch_queue_t dispatchQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(dispatchQueue , ^{
        NSURL *url = [NSURL URLWithString:urlString];
        NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
        NSURLResponse *response = nil;
        NSError *error = nil;
        NSData *data = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&response error:&error];
        if ([data length] > 0 && error == nil) {
            NSLog(@"%lu bytes of data was returned.",(unsigned long)[data length]);
        }else if ([data length] == 0 && error == nil){
            NSLog(@"No data was returned.");
        }else if (error != nil){
            NSLog(@"Error happened = %@",error);
        }
     });
    NSLog(@"We are done.");
                                     
}

- (void)httpGetWithParams {
    NSString *urlString = @"http://chaoyuan.sinaapp.com";
    urlString = [urlString stringByAppendingString:@"?p=1059"];
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setTimeoutInterval:30.0f];
    [request setHTTPMethod:@"Get"];
    NSOperation *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if ([data length] > 0 && connectionError == nil) {
            NSString *html = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"html = %@",html);
        }else if ([data length] == 0 && connectionError == nil) {
            NSLog(@"nothing was downloaded.");
        }else if (connectionError != nil) {
            NSLog(@"Error happened = %@",connectionError);
        }
    }];
}

//send a POST request to a server with some params
- (void)httpPostWithParams {
    NSString *urlString = @"http://chaoyuan.sinaapp.com";
    urlString = [urlString stringByAppendingString:@"?param1=First"];
    urlString = [urlString stringByAppendingString:@"¶m2=Second"];
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setTimeoutInterval:30.0f];
    [request setHTTPMethod:@"POST"];
    NSString *body = @"bodyParam1=BodyValue1&bodyParam2=BodyValue2";
    [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    NSOperation *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if ([data length] > 0 && connectionError == nil) {
            NSString *html = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"html = %@",html);
        }else if ([data length] == 0 && connectionError == nil) {
            NSLog(@"nothing was downloaded.");
        }else if (connectionError != nil) {
            NSLog(@"Error happened = %@",connectionError);
        }
    }];
}

- (void)creatLabel {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 200, 100, 60)];
    label.backgroundColor = [UIColor greenColor];
    label.tag = 100;
    [self.view addSubview:label];
    
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(20, 300, 100, 60)];
    label2.backgroundColor = [UIColor greenColor];
    label2.tag = 200;
    [self.view addSubview:label2];
    
    UIButton *next = [UIButton buttonWithType:UIButtonTypeSystem];
    next.frame = CGRectMake(20, 400, 50, 50);
    next.backgroundColor = [UIColor whiteColor];
    [next setTitle:@"下一页" forState:UIControlStateNormal];
    next.titleLabel.textColor = [UIColor blackColor];
    [next addTarget:self action:@selector(next:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:next];
}

- (void)next:(UIButton *)sender {
    //UIModalTransitionStyleCoverVertical = 0,
    //UIModalTransitionStyleFlipHorizontal __TVOS_PROHIBITED,
    //UIModalTransitionStyleCrossDissolve,
    //UIModalTransitionStylePartialCurl NS_ENUM_AVAILABLE_IOS(3_2) __TVOS_PROHIBITED,
    
    
    
    NextViewController *next = [[NextViewController alloc] init];
    next.delegate = self;
    [next setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    [self presentViewController:next animated:YES completion:nil];
    next.block = ^(NSString *str) {
        UILabel *label = (UILabel *)[self.view viewWithTag:100];
        label.text = [NSString stringWithFormat:@"%@",str];
    };
}

#pragma mark --UpdateDelegate
- (void)update:(NSString *)title {
    UILabel *label = (UILabel *)[self.view viewWithTag:200];
    label.text = title;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
