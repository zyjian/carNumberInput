//
//  ViewController.m
//  CarNumberTF
//
//  Created by carlt on 2019/7/18.
//  Copyright © 2019 carlt. All rights reserved.
//

#import "ViewController.h"
#import "PlateNumEnteringController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)pressbtn:(id)sender {
    PlateNumEnteringController *vc = [[PlateNumEnteringController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
