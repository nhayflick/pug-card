//
//  CardGameViewController.h
//  Pug Card
//
//  Created by Nathan Hayflick on 3/27/14.
//  Copyright (c) 2014 Nathan Hayflick. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Deck.h"
#import "CardMatchingGame.h"


@interface CardGameViewController : UIViewController

// Abstract Class - Subclass Must Implement
- (Deck *)createDeck;
- (IBAction)touchCardButton:(UIButton *)sender;

@property (nonatomic, readonly) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (nonatomic) CardMatchingGame *game;
@property (nonatomic, readonly) NSUInteger lastScore;
@property (strong, nonatomic) NSMutableAttributedString *resultsString;
@property (strong, nonatomic) NSMutableAttributedString *gameHistory;

- (void)resetGame;


@end
