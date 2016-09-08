//
//  NextViewController.m
//  NSURLConnection
//
//  Created by Hezhibo on 16/9/7.
//  Copyright © 2016年 Hezhibo. All rights reserved.
//

#import "NextViewController.h"

@interface NextViewController ()

@end

@implementation NextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *next = [UIButton buttonWithType:UIButtonTypeSystem];
    next.frame = CGRectMake(20, 400, 50, 50);
    next.backgroundColor = [UIColor blueColor];
    next.titleLabel.text = @"上一页";
    next.titleLabel.textColor = [UIColor blackColor];
    [next addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:next];
}

- (void)back:(UIButton *)sender {
    
    NSString *str = @"AAA";
    [self dismissViewControllerAnimated:YES completion:nil];
    if (self.block) {
        self.block(str);
    }
    
    //用Delegate反向传值
    if (self.delegate) {
        [self.delegate update:@"BBB"];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
