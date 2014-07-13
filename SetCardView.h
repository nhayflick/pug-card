//
//  SetCardView.h
//  Pug Card
//
//  Created by Nathan Hayflick on 6/7/14.
//  Copyright (c) 2014 Nathan Hayflick. All rights reserved.
//

#import "CardView.h"

@interface SetCardView : CardView

@property (nonatomic) NSUInteger shape;
@property (nonatomic) NSUInteger foregroundColor;
@property (nonatomic) NSUInteger alpha;
@property (nonatomic) NSUInteger quantity;

- (void)pick;

@end
