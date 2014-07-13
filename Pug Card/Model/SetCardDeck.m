//
//  SetCardDeck.m
//  Pug Card
//
//  Created by Nathan Hayflick on 4/20/14.
//  Copyright (c) 2014 Nathan Hayflick. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"

@implementation SetCardDeck

- (instancetype) init{
    self = [super init];
    
    if (self) {
        for (int i = 1; i <= 3; i++) {
            for (int j = 1; j <= 3; j++) {
                for (int k = 1; k <= 3; k++) {
                    for (int l = 1; l <= 3; l++) {
                        SetCard *setCard = [[SetCard alloc] init];
                        setCard.shape = (NSUInteger)i;
                        setCard.foregroundColor = (NSUInteger)j;
                        setCard.alpha = (NSUInteger)k;
                        setCard.quantity = l;
                        [self addCard:setCard];
                    }
                }
            }
        }
    }
    
    return self;
}


@end
