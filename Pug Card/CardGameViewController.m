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


@interface CardGameViewController ()
@property (strong, nonatomic, readwrite) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *gameModeSelector;
@property (weak, nonatomic) IBOutlet UILabel *resultsLabel;
@property (nonatomic, readwrite) NSUInteger lastScore;



@end

@implementation CardGameViewController

@synthesize cardButtons = _cardButtons;

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

- (CardMatchingGame *)game
{
    if (!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck]];
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

- (void)setCardButtons:(NSArray *)cardButtons
{
    _cardButtons = cardButtons;
}

- (NSArray *)cardButtons
{
    return nil;
}

- (IBAction)touchCardButton:(UIButton *)sender
{
    int chooseButtonIndex = [self.cardButtons indexOfObject:sender];
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

- (void)resetGame
{
    self.game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]usingDeck:[self createDeck]];
    [self updateUI];
    self.lastScore = 0;
}


- (IBAction)setMatchCount:(id)sender {
   [self.game setNumberOfMatchCards:[sender selectedSegmentIndex] + 1];
}

@end
