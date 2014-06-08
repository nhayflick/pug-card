//
//  PlayingCardGameViewController.m
//  Pug Card
//
//  Created by Nathan Hayflick on 4/14/14.
//  Copyright (c) 2014 Nathan Hayflick. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "CardGameHistoryViewController.h"
#import "PlayingCardDeck.h"
#import "PlayingCardView.h"


@interface PlayingCardGameViewController ()
//@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *playingCardButtons;
@property (weak, nonatomic) IBOutlet UILabel *resultsLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@end



@implementation PlayingCardGameViewController

- (NSUInteger) startingCardCount
{
    return 12;
}


- (PlayingCardDeck *)createDeck{
    return [[PlayingCardDeck alloc] init];
}


- (void)touchCardButton:(NSUInteger)index {
    [super touchCardButton:index];
}

#pragma mark - Gestures

- (void)swipeCard:(UIGestureRecognizer *)target
{
    NSLog(@"outer swipe");
    if ([target.view isKindOfClass:[PlayingCardView class]]) {
        NSLog(@"innder swipe");
        PlayingCardView *playingCardView = (PlayingCardView *)target.view;
        [playingCardView flip];
        [self touchCardButton:playingCardView.index];
    }
}

#pragma mark - Game Logic

- (void)updateUI
{
//    Update Label
    if (self.game.lastSelectedCards.count > 1) {
//        For correct matches
        if (self.game.score > self.lastScore) {
            self.resultsString = [[NSMutableAttributedString alloc] initWithString:@"Matched "];
            for (Card *card in self.game.lastSelectedCards) {
                [self.resultsString appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ ", card.contents]]];
            }
            [self.resultsString appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"for %d points.", self.game.score - self.lastScore]]];
//        For incorrect matches
        } else {
            self.resultsString = [[NSMutableAttributedString alloc] init];
            for (Card *card in self.game.lastSelectedCards) {
                [self.resultsString appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ ", card.contents]]];
            }
            [self.resultsString appendAttributedString:[[NSAttributedString alloc] initWithString:@"don't match."]];
        }
    } else {
        self.resultsString = [[NSMutableAttributedString alloc] initWithString:@"Picked "];
        for (Card *card in self.game.lastSelectedCards) {
            [self.resultsString appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ ", card.contents]]];
        }
    }
    self.resultsLabel.attributedText = self.resultsString;
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    [self.gameHistory appendAttributedString:self.resultsString];
    [self.gameHistory appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n"]];
}

- (void) renderCards;
{
    NSLog(@"%@", self.game.cards);
    NSLog(@"here");
    //    Update Cards
    NSUInteger i = 0;
    for (PlayingCard *card in self.game.cards){
//        Card *card = [self.game cardAtIndex:i];
        PlayingCardView *playingCardView = [[PlayingCardView alloc] initWithFrame:[self cardPosition:i]];
        playingCardView.rank = card.rank;
        playingCardView.suit = card.suit;
        playingCardView.index = [self.game.cards indexOfObject:card];
        [playingCardView addGestureRecognizer:[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeCard:)]];
        [self.view addSubview:playingCardView];
        i++;
        
//        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
//        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
//        cardButton.enabled = !card.isMatched;
    }
}
         


- (IBAction)resetGame:(id)sender
{
    self.game = [[CardMatchingGame alloc] initWithCardCount:self.startingCardCount usingDeck:[self createDeck]];
    [self updateUI];
}


- (NSString *)titleForCard:(Card *)card
{
    return card.isChosen ? card.contents : @"";
}

- (UIImage *)backgroundImageForCard:(Card *)card
{
    UIImage *image = [UIImage imageNamed:card.isChosen ? @"CardFront" : @"CardBack"];
    return card.isMatched ?  [UIImage imageNamed:@"CardDisabled"] : image;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self renderCards];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
