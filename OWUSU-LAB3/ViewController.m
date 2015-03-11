//
//  ViewController.m
//  OWUSU-LAB3
//
//  Created by Nana Kwame Owusu on 2/20/15.
//  Copyright (c) 2015 Nana Kwame Owusu. All rights reserved.
//

#import "ViewController.h"


@implementation ViewController

@synthesize topLeftButton;
@synthesize topCenterButton;
@synthesize topRightButton;
@synthesize middleLeftButton;
@synthesize middleCenterButton;
@synthesize middleRightButton;
@synthesize bottomLeftButton;
@synthesize bottomCenterButton;
@synthesize bottomRightButton;



- (void)viewDidLoad {
    [super viewDidLoad];
    

    
    
    
    //initialize tag numbers
    topLeftButton.tag = 0;
    topCenterButton.tag = 1;
    topRightButton.tag = 2;
    middleLeftButton.tag = 3;
    middleCenterButton.tag = 4;
    middleRightButton.tag = 5;
    bottomLeftButton.tag = 6;
    bottomCenterButton.tag = 7;
    bottomRightButton.tag = 8;
    
    //disable all buttons until options have been choses and the 'play' button as been pressed
    topLeftButton.enabled = NO;
    topCenterButton.enabled = NO;
    topRightButton.enabled = NO;
    middleLeftButton.enabled = NO;
    middleCenterButton.enabled = NO;
    middleRightButton.enabled = NO;
    bottomLeftButton.enabled = NO;
    bottomCenterButton.enabled = NO;
    bottomRightButton.enabled = NO;
    
    //initialize piece for players. Randomize
    int choice = arc4random() % 2;
    if (choice == 0){
        mark1 = @"X";
        mark2 = @"O";
        
    }
    else if (choice == 1)
    {
        mark1 = @"O";
        mark2 = @"X";
    }
    
    
    
    
    
    mygrid = [NSMutableArray arrayWithObjects:@" ", @" ", @" ", @" ", @" ", @" ", @" ", @" ", @" ", nil ];
    
    player1_locs = [NSMutableArray array];
    player2_locs = [NSMutableArray array];
    
    
    
    //initialize plays left
    plays_left = 9;
    
    // Do any additional setup after loading the view, typically from a nib.
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)markButton:(UIButton *)senderButton {
    
    
    plays_left--;
    //NSLog(@"%zd", senderButton.tag);
    
    if (turn == YES){//player 1 just played
        
        
        //make player 1 changes
        [mygrid setObject:mark1 atIndexedSubscript:senderButton.tag];
        [player1_locs addObject:[NSNumber numberWithInt:(int)senderButton.tag]];
        
        [senderButton setTitle:mark1 forState:UIControlStateNormal];
        [self showMessage:[NSString stringWithFormat:@"%@'s turn", player2]];
        
        //check if player 1 has won
        if ([self hasWon:turn]){//player 1 has won
            if (turn){
                [self showMessage:@"PLAYER 1 has won\nPlay another game?"];
            }
            else{
                [self showMessage:[NSString stringWithFormat:@"%@ has won\n Play another game?", player2]];
            }
            
            [self forceEnd];
            return;//prevents computer from playing after player 1 has won
            
        }
        else if (plays_left == 0) {
            [self showMessage:@"STALEMATE!!\n Play another game?"];
        }
        
        //change turn
        turn = !turn;
        
        //if computer is opponent, call ai function for computer's play
        if (gameChoice.selectedSegmentIndex == 0)
        {
            //call computer's play function
            //NSLog(@"Computer play function called");
            [self computerPlay];
            
            //check if that was computer's winning play
            if ([self hasWon:turn]){//computer has won
                if (turn){
                    [self showMessage:@"PLAYER 1 has won\n Play another game?"];
                }
                else{
                    [self showMessage:[NSString stringWithFormat:@"%@ has won\n Play another game?", player2]];
                }
                
                [self forceEnd];
                
                
                
            }
            else if (plays_left == 0) {
                [self showMessage:@"STALEMATE!!\n Play another game?"];
            }
            
            //change turn
            turn = !turn;
            
        }
        
        
    }
    else{//player 2 just played
        
        
        //make player 2 changes
        [mygrid setObject:mark2 atIndexedSubscript:senderButton.tag];
        [player2_locs addObject:[NSNumber numberWithInt:(int)senderButton.tag]];

        [self showMessage:@"PLAYER 1's turn"];
            [senderButton setTitle:mark2 forState:UIControlStateNormal];
        
        //check if player 2 has won
        if ([self hasWon:turn]){//player 2 has won
            if (turn){
                [self showMessage:@"PLAYER 1 has won\n Play another game?"];
            }
            else{
                [self showMessage:[NSString stringWithFormat:@"%@ has won\n Play another game?", player2]];
            }
            
            [self forceEnd];
            
        }
        else if (plays_left == 0) {
            [self showMessage:@"STALEMATE!!\n Play another game?"];
        }
        
        
        //change turn
        turn = !turn;
    }
    
    //disable button after being pressed
    senderButton.enabled = NO;
    
    
    

}

-(void) forceEnd{
    
    //disable all buttons
    topLeftButton.enabled = NO;
    topCenterButton.enabled = NO;
    topRightButton.enabled = NO;
    middleLeftButton.enabled = NO;
    middleCenterButton.enabled = NO;
    middleRightButton.enabled = NO;
    bottomLeftButton.enabled = NO;
    bottomCenterButton.enabled = NO;
    bottomRightButton.enabled = NO;
    
    
}

- (void)showMessage:(NSString*)message{
    
    [messageBox setText:message];
    
}

- (BOOL) hasWon:(BOOL)player{
    
    
    
    if (player)//player 1
    {
        for (NSNumber* num in player1_locs) {
            NSMutableArray* neighbours;
            //NSLog(@"Checking %d piece...", [num intValue]);
            if ([[mygrid objectAtIndex:[num integerValue]] isEqualToString:mark1]) {
                
                neighbours = [self getNeighboursAtIndex:[num integerValue] forPlayer:player];
                //[self printLocations:neighbours];
                for (NSNumber* mid in neighbours)
                {
                    //NSLog(@"Connecting neighbour at %d", [mid intValue]);
                    if ([self istrilogyForPlayer:player source:num middle:mid]){
                        return true;
                        
                    }
                }
            }
        }
        
    }
    else{
        for (NSNumber* num in player2_locs) {
            NSMutableArray* neighbours;
            //NSLog(@"Checking %d piece...", [num intValue]);
            if ([[mygrid objectAtIndex:[num integerValue]] isEqualToString:mark2]) {
                
                neighbours = [self getNeighboursAtIndex:[num integerValue] forPlayer:player];
                //[self printLocations:neighbours];
                for (NSNumber* mid in neighbours)
                {
                    //NSLog(@"Connecting neighbour at %d", [mid intValue]);
                    if ([self istrilogyForPlayer:player source:num middle:mid]){
                        
                        return true;
                    }
                }
            }
        }
        
    }
    
    
    return false;
}

- (BOOL) istrilogyForPlayer:(BOOL)p source:(NSNumber *)src middle:(NSNumber *)mid{
    
    NSString* target;
    if (p){//player  1
        target = mark1;
    }
    else{//player 2
        target = mark2;
    }
    
    int src_row = [src intValue] / 3;
    int src_col = [src intValue] % 3;
    int mid_row = [mid intValue] / 3;
    int mid_col = [mid intValue] % 3;
    int dest_row = mid_row + (mid_row - src_row);
    int dest_col = mid_col + (mid_col - src_col);
    if (dest_col <= 2 && dest_col >= 0){
        if (dest_row <= 2 && dest_row >= 0){
            if ([[mygrid objectAtIndex:(NSInteger)(3*dest_row + dest_col)] isEqualToString:target]){
                return true;
            }
        }
    }
    
    
    return false;
}

- (BOOL) isEmptyWithWrapAroundForPlayer:(BOOL)p source:(NSNumber *)src middle:(NSNumber *)mid{
    
    NSString* target = @" ";
    
    int src_row = [src intValue] / 3;
    int src_col = [src intValue] % 3;
    int mid_row = [mid intValue] / 3;
    int mid_col = [mid intValue] % 3;
    int dest_row = mid_row + (mid_row - src_row);
    int dest_col = mid_col + (mid_col - src_col);
    
    //perform wrap-around
    if (dest_row < 0){
        dest_row = dest_row + 3;
    }
    else if (dest_row > 2){
        dest_row = dest_row - 3;
    }
    
    if (dest_col < 0){
        dest_col = dest_col + 3;
    }
    else if (dest_col > 2){
        dest_col = dest_col - 3;
    }
    
    if ([[mygrid objectAtIndex:(NSInteger)(3*dest_row + dest_col)] isEqualToString:target]){
        return true;
    }
    
    
    
    return false;
}

-(NSMutableArray *)getNeighboursAtIndex:(NSInteger)idx forPlayer:(BOOL)p{
    NSMutableArray* neighbours = [NSMutableArray array];
    NSString* target;
    if (p){//player  1
        target = mark1;
    }
    else{//player 2
        target = mark2;
    }
    
    
    
    int row = (int)idx / 3;
    int col = (int)idx % 3;
    
    for (int i = col - 1; i <= col + 1; i++) {
        for (int j = row - 1; j <= row + 1; j++){
            if (i <= 2 && i >= 0){
                if (j <= 2 && j >= 0){
                    if (i != col || j != row){
                        if ([[mygrid objectAtIndex:[self grid2arrayWithRow:j column:i]] isEqualToString:target]){
                            //NSLog(@"Adding neighbour at row %d, col %d", j, i);
                            [neighbours addObject:[NSNumber numberWithInteger:(3*j + i)]];
                        }
                    }
                    
                }
            }
        }
    }
    
    return neighbours;
    
}

-(NSMutableArray *)getNeighboursWithWrapAroundAtIndex:(NSInteger)idx forPlayer:(BOOL)p{
    NSMutableArray* neighbours = [NSMutableArray array];
    NSString* target;
    if (p){//player  1
        target = mark1;
    }
    else{//player 2
        target = mark2;
    }
    
    
    
    int row = (int)idx / 3;
    int col = (int)idx % 3;
    
    for (int i = col - 1; i <= col + 1; i++) {
        for (int j = row - 1; j <= row + 1; j++){
            
            int real_i = i;
            int real_j = j;
            //perform wrap-around
            if (i < 0){
                real_i = real_i + 3;
            }
            else if (i > 2){
                real_i = real_i - 3;
            }
            
            if (j < 0){
                real_j = real_j + 3;
            }
            else if (j > 2){
                real_j = real_j - 3;
            }
            
            if (real_i != col || real_j != row){
                if ([[mygrid objectAtIndex:[self grid2arrayWithRow:real_j column:real_i]] isEqualToString:target]){
                    //NSLog(@"Adding neighbour at row %d, col %d", real_j, real_i);
                    [neighbours addObject:[NSNumber numberWithInteger:(3*real_j + real_i)]];
                }
            }
            
        }
    }
    
    return neighbours;
    
}

-(int)grid2arrayWithRow:(int)row column:(int)col{
    
    int val = 3*row + col;
    return val;
}


- (IBAction)setChoice:(id)sender {
    
    if (gameChoice.selectedSegmentIndex == 0) {
        [starter setTitle:@"Computer" forSegmentAtIndex:1];
        
    }
    else{
        [starter setTitle:@"Player 2" forSegmentAtIndex:1];
        
    }
    
    
}
- (IBAction)restartGame:(id)sender {
    
    topLeftButton.enabled = NO;
    topCenterButton.enabled = NO;
    topRightButton.enabled = NO;
    middleLeftButton.enabled = NO;
    middleCenterButton.enabled = NO;
    middleRightButton.enabled = NO;
    bottomLeftButton.enabled = NO;
    bottomCenterButton.enabled = NO;
    bottomRightButton.enabled = NO;
    
    starter.enabled =  YES;
    gameChoice.enabled = YES;
    playGameButton.enabled = YES;
    
    //clear squares of marks
    [topLeftButton setTitle:@" " forState:UIControlStateNormal];
    [topCenterButton setTitle:@" " forState:UIControlStateNormal];
    [topRightButton setTitle:@" " forState:UIControlStateNormal];
    [middleLeftButton setTitle:@" " forState:UIControlStateNormal];
    [middleCenterButton setTitle:@" " forState:UIControlStateNormal];
    [middleRightButton setTitle:@" " forState:UIControlStateNormal];
    [bottomLeftButton setTitle:@" " forState:UIControlStateNormal];
    [bottomCenterButton setTitle:@" " forState:UIControlStateNormal];
    [bottomRightButton setTitle:@" " forState:UIControlStateNormal];
    
    
    [self showMessage:@"Please choose one or two player game above and who should play first (player1, player2/computer or randomly choose)"];
    
    mygrid = [NSMutableArray arrayWithObjects:@" ", @" ", @" ", @" ", @" ", @" ", @" ", @" ", @" ", nil ];
    
    player1_locs = [NSMutableArray array];
    player2_locs = [NSMutableArray array];
    
    //initialize plays left
    plays_left = 9;
    
    
}

- (IBAction)playGame:(id)sender {
    
    starter.enabled =  NO;
    gameChoice.enabled = NO;
    playGameButton.enabled = NO;
    
    //disable all buttons until options have been choses and the 'play' button as been pressed
    topLeftButton.enabled = YES;
    topCenterButton.enabled = YES;
    topRightButton.enabled = YES;
    middleLeftButton.enabled = YES;
    middleCenterButton.enabled = YES;
    middleRightButton.enabled = YES;
    bottomLeftButton.enabled = YES;
    bottomCenterButton.enabled = YES;
    bottomRightButton.enabled = YES;
    
    if (gameChoice.selectedSegmentIndex == 0){//single player; AI
        player2 = @"COMPUTER";
    }
    else{
        //two player;
        player2 = @"PLAYER 2";
    }
    
    if (starter.selectedSegmentIndex == 0)//player1 starts
    {
        turn = YES;
        [self showMessage:@"PLAYER 1's turn"];
    }
    else if (starter.selectedSegmentIndex == 1)//player2/computer starts
    {
        turn = NO;
        
        [self showMessage:[NSString stringWithFormat:@"%@'s turn", player2]];
        if (gameChoice.selectedSegmentIndex == 0)
        {
            //call computer's play function
            //NSLog(@"Computer play function called");
            [self computerPlay];
            
            //change turn
            turn = !turn;
        }
        //else allow player 2 to play
    }
    else//randomize
    {
        int choice = arc4random() % 2;
        if (choice == 0){
            turn = YES;
            [self showMessage:@"PLAYER 1's turn"];
            
        }
        else if (choice == 1)
        {
            turn = NO;
            [self showMessage:[NSString stringWithFormat:@"%@'s turn", player2]];
            
            if (gameChoice.selectedSegmentIndex == 0)
            {
                //call computer's play function
                //NSLog(@"Computer play function called");
                [self computerPlay];
                //change turn
                turn = !turn;
            }
            //else allow player 2 to play
        }
    }
    
}

-(void) computerPlay{
    
    plays_left--;
    //find winning spot
    //NSLog(@"Searching for winning spot!");
    for (NSNumber* num in player2_locs) {
        NSMutableArray* neighbours;
        //NSLog(@"Checking %d piece...", [num intValue]);
        if ([[mygrid objectAtIndex:[num integerValue]] isEqualToString:mark2]) {
            
            neighbours = [self getNeighboursWithWrapAroundAtIndex:[num integerValue] forPlayer:false];
            //[self printLocations:neighbours];
            for (NSNumber* mid in neighbours)
            {
                //NSLog(@"Connecting neighbour at %d", [mid intValue]);
                if ([self isEmptyWithWrapAroundForPlayer:false source:num middle:mid]){
                    
                    //get the destination
                    NSNumber* dest = [self getDestinationWithWrapAround:false source:num middle:mid];
                    
                    if ([self isLinearSource:num middle:mid destination:dest]){
                        //NSLog(@"Winning play made at %d!", [dest intValue]);
                        [player2_locs addObject:dest];
                        [mygrid setObject:mark2 atIndexedSubscript:[dest integerValue]];
                        
                        
                        UIButton* cur;
                        //get Button
                        switch ([dest intValue]) {
                            case 0:
                                cur = topLeftButton;
                                break;
                            case 1:
                                cur = topCenterButton;
                                break;
                            case 2:
                                cur = topRightButton;
                                break;
                            case 3:
                                cur = middleLeftButton;
                                break;
                            case 4:
                                cur = middleCenterButton;
                                break;
                            case 5:
                                cur = middleRightButton;
                                break;
                            case 6:
                                cur = bottomLeftButton;
                                break;
                            case 7:
                                cur = bottomCenterButton;
                                break;
                            case 8:
                                cur = bottomRightButton;
                                break;
                                
                            default:
                                break;
                        }
                        cur.enabled = NO;
                        [cur setTitle:mark2 forState:UIControlStateNormal];
                        
                        [self showMessage:@"PLAYER 1's turn"];
                        return;
                    }
                }
            }//end of inner for loop for winning play
        }
    }//end of outer for loop for winning play
    
    //block possible win
    for (NSNumber* num in player1_locs) {
        NSMutableArray* neighbours;
        //NSLog(@"Checking %d piece...", [num intValue]);
        if ([[mygrid objectAtIndex:[num integerValue]] isEqualToString:mark1]) {
            
            neighbours = [self getNeighboursWithWrapAroundAtIndex:[num integerValue] forPlayer:true];
            //[self printLocations:neighbours];
            for (NSNumber* mid in neighbours)
            {
                //NSLog(@"Connecting neighbour at %d", [mid intValue]);
                if ([self isEmptyWithWrapAroundForPlayer:true source:num middle:mid]){
                    
                    //get the destination
                    NSNumber* dest = [self getDestinationWithWrapAround:true source:num middle:mid];
                    if ([self isLinearSource:num middle:mid destination:dest]){
                        //NSLog(@"Winning spot blocked at %d!", [dest intValue]);
                        [player2_locs addObject:dest];
                        [mygrid setObject:mark2 atIndexedSubscript:[dest integerValue]];
                        
                        UIButton* cur;
                        //get Button
                        switch ([dest intValue]) {
                            case 0:
                                cur = topLeftButton;
                                break;
                            case 1:
                                cur = topCenterButton;
                                break;
                            case 2:
                                cur = topRightButton;
                                break;
                            case 3:
                                cur = middleLeftButton;
                                break;
                            case 4:
                                cur = middleCenterButton;
                                break;
                            case 5:
                                cur = middleRightButton;
                                break;
                            case 6:
                                cur = bottomLeftButton;
                                break;
                            case 7:
                                cur = bottomCenterButton;
                                break;
                            case 8:
                                cur = bottomRightButton;
                                break;
                                
                            default:
                                break;
                        }
                        cur.enabled = NO;
                        [cur setTitle:mark2 forState:UIControlStateNormal];
                        
                        [self showMessage:@"PLAYER 1's turn"];
                        return;
                    }
                    
                    
                }
            }//end of inner for loop for blocking win
        }
    }//end of outer for loop for blocking win
    
    
    //place a mark at an empty corner
    if ([[mygrid objectAtIndex:0] isEqualToString:@" "]){
        //NSLog(@"filling topLeftButton");
        //NSLog(@"topLeft blocked");
        [player2_locs addObject:[NSNumber numberWithInt:0]];
        [mygrid setObject:mark2 atIndexedSubscript:0];
        
        topLeftButton.enabled = NO;
        [topLeftButton setTitle:mark2 forState:UIControlStateNormal];
        
        [self showMessage:@"PLAYER 1's turn"];
        return;
    }
    else if ([[mygrid objectAtIndex:2] isEqualToString:@" "]){
        //NSLog(@"topRight blocked");
        [player2_locs addObject:[NSNumber numberWithInt:2]];
        [mygrid setObject:mark2 atIndexedSubscript:2];
        
        topRightButton.enabled = NO;
        [topRightButton setTitle:mark2 forState:UIControlStateNormal];
        
        [self showMessage:@"PLAYER 1's turn"];
        return;
    }
    else if ([[mygrid objectAtIndex:6] isEqualToString:@" "]){
        //NSLog(@"bottomLeft blocked");
        [player2_locs addObject:[NSNumber numberWithInt:6]];
        [mygrid setObject:mark2 atIndexedSubscript:6];
        
        bottomLeftButton.enabled = NO;
        [bottomLeftButton setTitle:mark2 forState:UIControlStateNormal];
        
        [self showMessage:@"PLAYER 1's turn"];
        return;
    }
    else if ([[mygrid objectAtIndex:8] isEqualToString:@" "]){
        //NSLog(@"bottomRight blocked");
        [player2_locs addObject:[NSNumber numberWithInt:8]];
        [mygrid setObject:mark2 atIndexedSubscript:8];
        
        bottomRightButton.enabled = NO;
        [bottomRightButton setTitle:mark2 forState:UIControlStateNormal];
        
        [self showMessage:@"PLAYER 1's turn"];
        return;
    }
    else{//find any empty slot and fill that
        //NSLog(@"Any space blocked");
        int dest = -1;
        
        for (int i = 0; i < [mygrid count]; i++) {
            if ([[mygrid objectAtIndex:i] isEqualToString:@" "]){
                dest = i;
            }
        }
        if (dest != -1){
            
            [player2_locs addObject:[NSNumber numberWithInt:dest]];
            [mygrid setObject:mark2 atIndexedSubscript:dest];
            
            UIButton* cur;
            //get Button
            switch (dest) {
                case 0:
                    cur = topLeftButton;
                    break;
                case 1:
                    cur = topCenterButton;
                    break;
                case 2:
                    cur = topRightButton;
                    break;
                case 3:
                    cur = middleLeftButton;
                    break;
                case 4:
                    cur = middleCenterButton;
                    break;
                case 5:
                    cur = middleRightButton;
                    break;
                case 6:
                    cur = bottomLeftButton;
                    break;
                case 7:
                    cur = bottomCenterButton;
                    break;
                case 8:
                    cur = bottomRightButton;
                    break;
                    
                default:
                    break;
            }
            cur.enabled = NO;
            [cur setTitle:mark2 forState:UIControlStateNormal];
            
            [self showMessage:@"PLAYER 1's turn"];
        }
        return;
    }
    
    
}

-(BOOL)isLinearSource:(NSNumber *)src middle:(NSNumber *)mid destination:(NSNumber *)dest{
    
    bool is_horizontal = false;
    bool is_vertical = false;
    bool is_diagonal = false;
    
    //get row-col values for three points
    int src_row = [src intValue] / 3;
    int src_col = [src intValue] % 3;
    int mid_row = [mid intValue] / 3;
    int mid_col = [mid intValue] % 3;
    int dest_row = [dest intValue] / 3;
    int dest_col = [dest intValue] % 3;
    
    int mid_src_gradient = 0;
    int dest_mid_gradient = -1;
    
    if (src_col == mid_col && mid_col == dest_col) {
        is_horizontal = true;
    }
    
    if (src_row == mid_row  && src_col == dest_row){
        is_vertical = true;
    }
    if ((mid_col - src_col)!= 0) {
        mid_src_gradient = (mid_row - src_row)/(mid_col - src_col);
    }
    if ((dest_col - mid_col)!= 0) {
        dest_mid_gradient = (dest_row - mid_row)/(dest_col - mid_col);
    }
    
    
    if ( mid_src_gradient == dest_mid_gradient){
        is_diagonal = true;
    }
    
    return is_vertical || is_horizontal || is_diagonal;
}

- (NSNumber *) getDestination:(BOOL)p source:(NSNumber *)src middle:(NSNumber *)mid{
    
    int src_row = [src intValue] / 3;
    int src_col = [src intValue] % 3;
    int mid_row = [mid intValue] / 3;
    int mid_col = [mid intValue] % 3;
    int dest_row = mid_row + (mid_row - src_row);
    int dest_col = mid_col + (mid_col - src_col);
    
    
    
    return [NSNumber numberWithInt:[self grid2arrayWithRow:dest_row column:dest_col]];
    
}

- (NSNumber *) getDestinationWithWrapAround:(BOOL)p source:(NSNumber *)src middle:(NSNumber *)mid{
    
    int src_row = [src intValue] / 3;
    int src_col = [src intValue] % 3;
    int mid_row = [mid intValue] / 3;
    int mid_col = [mid intValue] % 3;
    int dest_row = mid_row + (mid_row - src_row);
    int dest_col = mid_col + (mid_col - src_col);
    
    //perform wrap-around
    if (dest_row < 0){
        dest_row = dest_row + 3;
    }
    else if (dest_row > 2){
        dest_row = dest_row - 3;
    }
    
    if (dest_col < 0){
        dest_col = dest_col + 3;
    }
    else if (dest_col > 2){
        dest_col = dest_col - 3;
    }
    
    return [NSNumber numberWithInt:[self grid2arrayWithRow:dest_row column:dest_col]];
    
}


- (void) printBoard{
 
    NSLog(@"Printing Grid:");
    for (NSString* val in mygrid){
        NSLog(@"%@", val);
    }
    NSLog(@"end of Grid");
}

- (void) printLocations:(NSMutableArray *)locs{
    
    NSLog(@"Printing Locations:");
    for (NSNumber* val in locs){
        NSLog(@"%d", [val intValue]);
    }
    NSLog(@"end of Grid");
}




@end
