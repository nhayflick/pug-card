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
@end

@implementation CardMatchingGame

- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck
{
    self = [super init];
    
    if (self) {
        for (int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
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

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

- (void)chooseCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    
    if (!card.isMatched) {
        int matchesFound = 0;
        NSMutableArray *otherCards = [[NSMutableArray alloc] init];
        for (Card *otherCard in self.cards) {
            if (otherCard.isChosen && !otherCard.isMatched && otherCard != card) {
                NSLog(@"here");
                [otherCards addObject:otherCard];
                NSLog(@"%d", otherCards.count);
                if (matchesFound++ > self.numberOfMatchCards) break;
            }
        }
        if (otherCards.count == 0){
            if (card.chosen){
                card.chosen = NO;
                self.result = @"";
            } else {
                card.chosen = YES;
                self.result = [NSString stringWithFormat:@"Picked %@", card.contents];
            }
        } else if (matchesFound >= self.numberOfMatchCards) {
            int matchScore = [card match:otherCards];
            if (matchScore) {
                self.score += matchScore * MATCH_BONUS;
                card.matched = YES;
                NSString *resultString = [NSString stringWithFormat:@"Matched %@ ", card.contents];
                for (Card *chosenCard in otherCards) {
                    NSLog(@"%@", chosenCard.contents);
                    resultString = [resultString stringByAppendingString:[NSString stringWithFormat:@"%@ ", chosenCard.contents]];
                    chosenCard.chosen = YES;
                    chosenCard.matched = YES;
                }
                resultString = [resultString stringByAppendingString:[NSString stringWithFormat:@"for %d", matchScore * MATCH_BONUS]];
                self.result = resultString;
            } else {
                card.matched = NO;
                NSString *resultString = [NSString stringWithFormat:@"%@ ", card.contents];
                for (Card *chosenCard in otherCards) {
                    chosenCard.chosen = NO;
                    chosenCard.matched = NO;
                    resultString = [resultString stringByAppendingString:[NSString stringWithFormat:@"%@ ", chosenCard.contents]];
                }
                resultString = [resultString stringByAppendingString:[NSString stringWithFormat:@"don't match. %d point penalty!", MISMATCH_PENALTY]];
                self.result = resultString;
                self.score -= MISMATCH_PENALTY;
            }
         
            card.chosen = YES;
        } else {
            card.chosen = YES;
            self.result = [NSString stringWithFormat:@"Picked %@", card.contents];
        }
        self.score -= COST_TO_CHOOSE;
    }
}

@end
