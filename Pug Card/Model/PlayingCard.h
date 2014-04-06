//
//  PlayingCard.h
//  Pug Card
//
//  Created by Nathan Hayflick on 3/27/14.
//  Copyright (c) 2014 Nathan Hayflick. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;

@end
