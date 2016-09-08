//
//  NextViewController.h
//  NSURLConnection
//
//  Created by Hezhibo on 16/9/7.
//  Copyright © 2016年 Hezhibo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UpdateDelegate

- (void)update:(NSString *)title;

@end

@interface NextViewController : UIViewController

@property (nonatomic, weak) id<UpdateDelegate> delegate;

typedef void (^UpdateBlock)(NSString *title);

@property (nonatomic, copy) UpdateBlock block;

@end
