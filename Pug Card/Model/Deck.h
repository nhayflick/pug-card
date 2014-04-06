//
//  Deck.h
//  Pug Card
//
//  Created by Nathan Hayflick on 3/29/14.
//  Copyright (c) 2014 Nathan Hayflick. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

- (void)addCard:(Card *)card atTop:(BOOL)atTop;
- (void)addCard:(Card *)card;


- (Card *)drawRandomCard;

@end
