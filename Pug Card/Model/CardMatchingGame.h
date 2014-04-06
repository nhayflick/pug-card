//
//  CardMatchingGame.h
//  Pug Card
//
//  Created by Nathan Hayflick on 3/30/14.
//  Copyright (c) 2014 Nathan Hayflick. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject

// Designated initializer
- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck;
- (void)chooseCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;

@property (nonatomic, readonly) NSUInteger score;
@property (nonatomic) NSUInteger numberOfMatchCards;
@property (nonatomic, strong) NSString *result;



@end
