//
//  CardMatchingGame.m
//  Pug Card
//
//  Created by Nathan Hayflick on 3/30/14.
//  Copyright (c) 2014 Nathan Hayflick. All rights reserved.
//

#import "CardMatchingGame.h"
#import "Card.h"

@interface CardMatchingGame()
@property (nonatomic, readwrite) NSUInteger score;
@property (nonatomic, strong) NSMutableArray *cards; // of Cards
@property (nonatomic, readwrite) NSMutableArray *lastSelectedCards; // of Cards
@property (nonatomic, strong) Deck *deck;
@end

@implementation CardMatchingGame

- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck
{
    self = [super init];
    
    NSLog(@"in the init loop: %d", count);
    
    self.deck = deck;
    
    if (self) {
        for (int i = 0; i < count; i++) {
            Card *card = [self.deck drawRandomCard];
            if (card){
                [self.cards addObject:card];
            } else {
                self = nil;
                break;
            }
        }
    }
    
    return self;
}

- (NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (NSMutableArray *)lastSelectedCards
{
    if (!_lastSelectedCards) _lastSelectedCards = [[NSMutableArray alloc] init];
    return _lastSelectedCards;
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;
static const int NUMBER_OF_DRAW_CARDS = 3;


- (void)chooseCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    
    [self.lastSelectedCards removeAllObjects];
    if (card){
        if (card.isChosen) {
            card.chosen = NO;
        } else {
            [self.lastSelectedCards addObject:card];
            if (!card.isMatched) {
                int matchesFound = 0;
                NSLog(@"# of match cards: %d", self.numberOfMatchCards);
                NSMutableArray *otherCards = [[NSMutableArray alloc] init];
                for (Card *otherCard in self.cards) {
                    if (otherCard.isChosen && !otherCard.isMatched) {
                        [otherCards addObject:otherCard];
                        [self.lastSelectedCards addObject:otherCard];
                        if (matchesFound++ > self.numberOfMatchCards) break;
                    }
                }
                if (otherCards.count == 0){
                    NSLog(@"eeeeee: %d", card.chosen);
                    if (card.chosen){
                        card.chosen = NO;
                    } else {
                        card.chosen = YES;
                    }
                } else if (otherCards.count >= self.numberOfMatchCards) {
                    NSLog(@"else if");
                    int matchScore = [card match:otherCards];
                    if (matchScore) {
                        NSLog(@"matched!");
                        self.score += matchScore * MATCH_BONUS;
                        card.matched = YES;
                        card.chosen = YES;
                        for (Card *chosenCard in otherCards) {
                            chosenCard.matched = YES;
                        }
                    } else {
                        NSLog(@"no match!");
                        card.matched = NO;
                        card.chosen = NO;
                        for (Card *chosenCard in otherCards) {
                            chosenCard.chosen = NO;
                        }
                        self.score -= MISMATCH_PENALTY;
                    }
                } else {
                    card.chosen = YES;
                }
            }
        }
        self.score -= COST_TO_CHOOSE;
    }
}

- (void)drawCards
{
    for (int i = 0; i <= NUMBER_OF_DRAW_CARDS; i++) {
        [self.cards addObject:[self.deck drawRandomCard]];
    }
}

@end
