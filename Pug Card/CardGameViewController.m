//
//  CardGameViewController.m
//  Pug Card
//
//  Created by Nathan Hayflick on 3/27/14.
//  Copyright (c) 2014 Nathan Hayflick. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCard.h"
#import "CardMatchingGame.h"
#import "CardGameHistoryViewController.h"
#import "Grid.h"


@interface CardGameViewController ()
@property (strong, nonatomic, readwrite) NSMutableArray *cards;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *gameModeSelector;
@property (weak, nonatomic) IBOutlet UILabel *resultsLabel;
@property (nonatomic, readwrite) NSUInteger lastScore;


@end

@implementation CardGameViewController

@synthesize cards = _cards;

- (Deck *)createDeck
{
    return nil;
}

- (UILabel *)resultsLabel
{
    return nil;
}

- (UILabel *)scoreLabel
{
    return nil;
}

- (NSUInteger) startingCardCount
{
    return 12;
}

- (CardMatchingGame *)game
{
    if (!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:self.startingCardCount usingDeck:[self createDeck]];
    }
    return _game;
}

- (NSMutableAttributedString *)gameHistory
{
    if (!_gameHistory) {
        _gameHistory = [[NSMutableAttributedString alloc] init];
    }
    return _gameHistory;
}

- (void)setCards:(NSMutableArray *)cards
{
    _cards = cards;
}

- (NSMutableArray *)cards
{
    return nil;
}

- (IBAction)touchCardButton:(UIButton *)sender
{
    int chooseButtonIndex = [self.cards indexOfObject:sender];
    [self.game chooseCardAtIndex:chooseButtonIndex];
    [self updateUI];
    self.lastScore = self.game.score;
}


- (void)updateUI
{}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Display Info"]) {
        if ([segue.destinationViewController isKindOfClass:[CardGameHistoryViewController class]]) {
            CardGameHistoryViewController *historyViewController = (CardGameHistoryViewController *)segue.destinationViewController;
            [historyViewController setHistory:self.gameHistory];
        }
    }
}

#define CARD_ASPECT_RATIO 2.25/3.5;

- (CGRect)cardPosition:(NSUInteger)index
{
    Grid *grid = [[Grid alloc] init];
    grid.size = self.view.bounds.size;
    grid.cellAspectRatio = CARD_ASPECT_RATIO;
    grid.minimumNumberOfCells = 12;
    NSUInteger row = index / grid.columnCount;
    NSUInteger column = index - (row * grid.columnCount);
    return [grid frameOfCellAtRow:row inColumn:column];
}

- (void)resetGame
{
    self.game = [[CardMatchingGame alloc] initWithCardCount:[self.cards count]usingDeck:[self createDeck]];
    [self updateUI];
    self.lastScore = 0;
}


- (IBAction)setMatchCount:(id)sender {
   [self.game setNumberOfMatchCards:[sender selectedSegmentIndex] + 1];
}


@end
