//
//  SetMatchingGame.h
//  Pug Card
//
//  Created by Nathan Hayflick on 4/20/14.
//  Copyright (c) 2014 Nathan Hayflick. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface SetMatchingGame : NSObject
//Designated Initializer
- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck;
@property (readonly) NSUInteger score;
@end
