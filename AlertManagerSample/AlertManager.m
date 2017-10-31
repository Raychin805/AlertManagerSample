//
//  AlertManager.m
//  AlertManagerSample
//
//  Created by raymond on 2017/10/31.
//  Copyright © 2017年 Raymond. All rights reserved.
//

#import "AlertManager.h"
@import UIKit;

@interface AlertManager ()
@property (nonatomic) UIWindow *alertWindow;
@property (nonatomic) NSMutableArray *pendingArray;

@end

@implementation AlertManager

+ (instancetype)sharedManager {
    static dispatch_once_t p;
    
    __strong static AlertManager *_sharedManager = nil;
    
    dispatch_once(&p, ^{
        _sharedManager = [[self alloc] init];
        _sharedManager.pendingArray = [NSMutableArray array];
    });
    
    return _sharedManager;
}

- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message actions:(NSArray<AlertAction *> *)actions {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    for (AlertAction *actionObject in actions) {
        
        UIAlertAction *alertAction = [UIAlertAction actionWithTitle:actionObject.title style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            if (actionObject.handler) {
                actionObject.handler();
            }
            
            [self dismissAlertWindow];
            [self handlePendingAlert];
            
        }];
        
        [alertController addAction:alertAction];
    }
    
    
    if (!self.alertWindow) {
        
        [self createAlertWindow];
        [self.alertWindow.rootViewController presentViewController:alertController animated:NO completion:nil];
        
    } else {
        
        [self.pendingArray addObject:alertController];
        
    }
    
}

- (void)createAlertWindow {
    
    UIViewController *blankViewController = [[UIViewController alloc] init];
    [[blankViewController view] setBackgroundColor:[UIColor clearColor]];
    
    UIWindow *window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [window setRootViewController:blankViewController];
    [window setBackgroundColor:[UIColor clearColor]];
    UIWindow *topWindow = [UIApplication sharedApplication].windows.lastObject;
    window.windowLevel = topWindow.windowLevel + 1;
    [window makeKeyAndVisible];
    
    self.alertWindow = window;
    
}

- (void)dismissAlertWindow {
    
    self.alertWindow.hidden = YES;
    self.alertWindow = nil;
    
}

- (void)handlePendingAlert {
    
    if (self.pendingArray.count) {
        UIViewController *nextAlertController = self.pendingArray.firstObject;
        [self.pendingArray removeObject:nextAlertController];
        
        [self createAlertWindow];
        [self.alertWindow.rootViewController presentViewController:nextAlertController animated:NO completion:nil];
    }
    
}


#pragma - mark Commonly Used Alert

+ (void)showOKAlertWithTitle:(NSString *)title message:(NSString *)message okHandler:(void (^)(void))handler {
    
    AlertAction *okAction = [AlertAction actionWithTitle:@"OK" handler:handler];
    
    [[AlertManager sharedManager] showAlertWithTitle:title message:message actions:@[okAction]];
    
}

@end



@implementation AlertAction

+ (instancetype)actionWithTitle:(NSString *)title handler:(void (^)(void))handler {
    
    AlertAction *action = [[AlertAction alloc] init];
    action.title = title;
    action.handler = handler;
    
    return action;
}

@end

