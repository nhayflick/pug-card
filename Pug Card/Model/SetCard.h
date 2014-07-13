//
//  SetCard.h
//  Pug Card
//
//  Created by Nathan Hayflick on 4/15/14.
//  Copyright (c) 2014 Nathan Hayflick. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card

@property (nonatomic) NSUInteger shape;
@property (nonatomic) NSUInteger foregroundColor;
@property (nonatomic) NSUInteger alpha;
@property (nonatomic) NSUInteger quantity;

@end
