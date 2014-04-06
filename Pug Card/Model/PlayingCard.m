//
//  PlayingCard.m
//  Pug Card
//
//  Created by Nathan Hayflick on 3/27/14.
//  Copyright (c) 2014 Nathan Hayflick. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

- (NSString *)contents
{
    return [[PlayingCard rankStrings][self.rank]stringByAppendingString:self.suit];
}

+ (NSArray *)validSuits
{
    return @[@"♠︎",@"♣︎",@"♥︎",@"♦︎"];
}

@synthesize suit = _suit;

- (void)setSuit:(NSString *)suit
{
    if ([[PlayingCard validSuits] containsObject:suit]){
        _suit = suit;
    }
}

- (NSString *)suit
{
   return _suit ? _suit : @"?";
}

+ (NSArray *)rankStrings
{
    return @[@"?",@"A",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

+(NSUInteger)maxRank
{
    return [[self rankStrings] count] - 1;
}

-(void)setRank:(NSUInteger)rank
{
    if (rank <= [PlayingCard maxRank]){
        _rank = rank;
    }
}

- (int)match:(NSMutableArray *)otherCards
{
    int score = 0;
    
    if ([otherCards count] == 1){
        PlayingCard *otherCard = [otherCards firstObject];
        if (self.rank == otherCard.rank) {
            score = 4;
        } else if ([self.suit isEqualToString:otherCard.suit]){
            score = 1;
        }
    } else {
        NSMutableArray *allCards = [[NSMutableArray alloc] initWithArray:otherCards copyItems:NO];
        [allCards addObject:self];
        NSMutableArray *cardPairs = [[NSMutableArray alloc] init];
        for (int i = 0; i < allCards.count; i++) {
            for (int j = i + 1; j < allCards.count; j++){
                [cardPairs addObject:@[allCards[i], allCards[j]]];
            }
        }
        for (NSArray *cardPair in cardPairs){
            score += [cardPair[0] match:@[cardPair[1]]];
        }

    }
        
    return score;
}

@end
