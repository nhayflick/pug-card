//
//  SetMatchingGame.m
//  Pug Card
//
//  Created by Nathan Hayflick on 4/20/14.
//  Copyright (c) 2014 Nathan Hayflick. All rights reserved.
//

#import "SetMatchingGame.h"
@interface SetMatchingGame()
@property (nonatomic, readwrite) NSUInteger score;
@property (strong, nonatomic) NSMutableArray *cards; // of Cards
@end

@implementation SetMatchingGame
- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck
{
    self = [super init];
    
    return self;
}

@end
