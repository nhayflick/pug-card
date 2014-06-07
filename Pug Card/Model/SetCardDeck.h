//
//  SetCardDeck.h
//  Pug Card
//
//  Created by Nathan Hayflick on 4/20/14.
//  Copyright (c) 2014 Nathan Hayflick. All rights reserved.
//

#import "Deck.h"

@interface SetCardDeck : Deck
- (instancetype) initWithShapes:(NSArray *)validShapes validForegroundColors:(NSArray *)validForegroundColors validAlphas:(NSArray *)validAlphas;
@end
