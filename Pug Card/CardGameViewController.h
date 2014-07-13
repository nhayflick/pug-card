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
#import "Grid.h"


@interface CardGameViewController : UIViewController

// Abstract Class - Subclass Must Implement
- (Deck *)createDeck;
- (void)touchCardButton:(NSUInteger)index;

@property (nonatomic, readonly) NSMutableArray *cards;
@property (nonatomic) CardMatchingGame *game;
@property (nonatomic) IBOutlet UIView *containerView;
@property (nonatomic, readonly) NSUInteger lastScore;
@property (strong, nonatomic) NSMutableAttributedString *resultsString;
@property (strong, nonatomic) NSMutableAttributedString *gameHistory;
@property (nonatomic, readwrite) NSUInteger startingCardCount;



- (void)resetGame;
- (void)updateUI;
- (CGRect)cardPosition:(NSUInteger)index;


@end
