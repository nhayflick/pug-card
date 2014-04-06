//
//  CardGameViewController.m
//  Pug Card
//
//  Created by Nathan Hayflick on 3/27/14.
//  Copyright (c) 2014 Nathan Hayflick. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "PlayingCard.h"
#import "CardMatchingGame.h"


@interface CardGameViewController ()
@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *gameModeSelector;
@property (weak, nonatomic) IBOutlet UILabel *resultsLabel;


@end

@implementation CardGameViewController

- (Deck *)createDeck
{
    return [[PlayingCardDeck alloc] init];
}

- (CardMatchingGame *)game
{
    if (!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck]];
    }
    return _game;
}

- (IBAction)touchCardButton:(UIButton *)sender
{
    self.gameModeSelector.enabled = NO;
    int chooseButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chooseButtonIndex];
    self.resultsLabel.text = self.game.result;
    [self updateUI];
}

- (void)updateUI
{
    for (UIButton *cardButton in self.cardButtons){
        int cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    }
}

- (NSString *)titleForCard:(Card *)card
{
    return card.isChosen ? card.contents : @"";
}

- (UIImage *)backgroundImageForCard:(Card *)card
{
     UIImage *image = [UIImage imageNamed:card.isChosen ? @"CardFront" : @"CardBack"];
    return card.isMatched ?  [UIImage imageNamed:@"CardDisabled"] : image;
}

- (IBAction)resetGame {
    self.game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]usingDeck:[self createDeck]];
    self.gameModeSelector.enabled = YES;
    [self setMatchCount:self.gameModeSelector];
    [self updateUI];
}

- (IBAction)setMatchCount:(id)sender {
   [self.game setNumberOfMatchCards:[sender selectedSegmentIndex] + 1];
}

@end
