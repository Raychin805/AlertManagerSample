//
//  ViewController.m
//  AlertManagerSample
//
//  Created by raymond on 2017/10/31.
//  Copyright © 2017年 Raymond. All rights reserved.
//

#import "ViewController.h"
#import "AlertManager.h"

@interface ViewController ()
{
    int testIndex;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)pressedOKAlertButton:(id)sender {
    
    [AlertManager showOKAlertWithTitle:@"OK Alert" message:@"Message" okHandler:^{
        NSLog(@"Done");
    }];
}

- (IBAction)pressedCustomActionAlertButton:(id)sender {
    
    AlertAction *cancelAction = [AlertAction actionWithTitle:@"Cancel" handler:^{
        NSLog(@"Cancel");
    }];
    
    AlertAction *confirmAction = [AlertAction actionWithTitle:@"Confirm" handler:^{
        NSLog(@"Confirm");
    }];
    
    [[AlertManager sharedManager] showAlertWithTitle:@"Custom Action Alert" message:@"Message" actions:@[cancelAction, confirmAction]];
}

- (IBAction)pressedPendingDemoButton:(id)sender {
    
    testIndex = 1;
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        
        if (testIndex <= 5) {
            
            [AlertManager showOKAlertWithTitle:[NSString stringWithFormat:@"Alert %d", testIndex] message:nil okHandler:nil];
            testIndex += 1;
            
        } else {
            [timer invalidate];
        }
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
