//
//  ViewController.h
//  OWUSU-LAB3
//
//  Created by Nana Kwame Owusu on 2/20/15.
//  Copyright (c) 2015 Nana Kwame Owusu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
#import "optionsController.h"

@interface ViewController : UIViewController {
    
    IBOutlet UISegmentedControl *gameChoice;
    
    IBOutlet UISegmentedControl *starter;
    
    
    IBOutlet UITextView *messageBox;
    
    IBOutlet UIButton *playGameButton;
    
    NSString* player2;
    
    NSMutableArray * mygrid;
    NSMutableArray * player1_locs;
    NSMutableArray * player2_locs;
   
    bool turn;//YES => player 1's turn; NO => player 2's turn;
    NSString* mark1;
    NSString* mark2;
    int plays_left;
    
    
}

@property (strong, nonatomic) IBOutlet UIButton *topLeftButton;
@property (strong, nonatomic) IBOutlet UIButton *topCenterButton;
@property (strong, nonatomic) IBOutlet UIButton *topRightButton;
@property (strong, nonatomic) IBOutlet UIButton *middleLeftButton;
@property (strong, nonatomic) IBOutlet UIButton *middleCenterButton;
@property (strong, nonatomic) IBOutlet UIButton *middleRightButton;
@property (strong, nonatomic) IBOutlet UIButton *bottomLeftButton;
@property (strong, nonatomic) IBOutlet UIButton *bottomCenterButton;
@property (strong, nonatomic) IBOutlet UIButton *bottomRightButton;





@end

