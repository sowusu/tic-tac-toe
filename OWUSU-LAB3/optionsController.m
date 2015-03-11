//
//  optionsController.m
//  OWUSU-LAB3
//
//  Created by Nana Kwame Owusu on 2/21/15.
//  Copyright (c) 2015 Nana Kwame Owusu. All rights reserved.
//

#import "optionsController.h"



@implementation optionsController

- (void)viewDidLoad {
    [super viewDidLoad];
    //
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewDidDisappear:(BOOL)animated{
    
    options = [NSUserDefaults standardUserDefaults];
    NSLog(@"setting game choice value: %zd", gameChoice.selectedSegmentIndex);
    [options setInteger:gameChoice.selectedSegmentIndex forKey:@"gameChoice"];
    
    NSLog(@"setting starter value: %zd", starter.selectedSegmentIndex);
    [options setInteger:starter.selectedSegmentIndex forKey:@"starter"];
    
    
    [options synchronize];
    
    
}




/*

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    
}*/


@end
