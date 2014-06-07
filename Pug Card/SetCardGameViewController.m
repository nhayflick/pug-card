//
//  SetCardGameViewController.m
//  Pug Card
//
//  Created by Nathan Hayflick on 4/24/14.
//  Copyright (c) 2014 Nathan Hayflick. All rights reserved.
//

#import "SetCardGameViewController.h"
#import "SetCardDeck.h"
#import "SetCard.h"


@interface SetCardGameViewController ()
@property (strong, nonatomic) NSMutableArray *setCards; //of setCards
@property (weak, nonatomic) IBOutlet UILabel *resultsLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@end

@implementation SetCardGameViewController

- (SetCardDeck *)createDeck {
    return [[SetCardDeck alloc] initWithShapes:@[@"▲", @"●", @"◼︎"] validForegroundColors:@[[UIColor greenColor], [UIColor redColor], [UIColor blueColor]] validAlphas:@[@0.3, @0.6, @1]];
}

- (NSMutableArray *)cards
{
    NSMutableArray *cardsCollection = [super cards];
    if (!cardsCollection) {
        cardsCollection = [self setCards];
    }
    return cardsCollection;
}

- (NSUInteger) startingCardCount
{
    return 12;
}


- (IBAction)touchCardButton:(UIButton *)sender {
    [super touchCardButton:sender];
}

- (void)updateUI
{
    for (UIButton *cardButton in self.cards){
        int cardButtonIndex = [self.cards indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setBackgroundColor:[self cardBackgroundColor:card]];
        cardButton.enabled = !card.isMatched;
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    }
//    Update Label
    if (self.game.lastSelectedCards.count > self.game.numberOfMatchCards) {
        //        For correct matches
        if (self.game.score > self.lastScore) {
            self.resultsString = [[NSMutableAttributedString alloc] initWithString:@"Matched "];
            for (SetCard *card in self.game.lastSelectedCards) {
                [self.resultsString appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ ", card.shape] attributes:@{NSForegroundColorAttributeName : [card.foregroundColor colorWithAlphaComponent:[card.alpha floatValue]], NSStrokeColorAttributeName : [UIColor blackColor],NSStrokeWidthAttributeName : @-5}]];
            }
            [self.resultsString appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"for %d points.", self.game.score - self.lastScore]]];
            //        For incorrect matches
        } else {
            self.resultsString = [[NSMutableAttributedString alloc] init];
            for (SetCard *card in self.game.lastSelectedCards) {
                [self.resultsString appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ ", card.shape] attributes:@{NSForegroundColorAttributeName : [card.foregroundColor colorWithAlphaComponent:[card.alpha floatValue]], NSStrokeColorAttributeName : [UIColor blackColor],NSStrokeWidthAttributeName : @-5}]];
            }
            [self.resultsString appendAttributedString:[[NSAttributedString alloc] initWithString:@"don't match."]];
        }
    } else {
        self.resultsString = [[NSMutableAttributedString alloc] initWithString:@"Picked "];
        for (SetCard *card in self.game.lastSelectedCards) {
            [self.resultsString appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ ", card.shape] attributes:@{NSForegroundColorAttributeName : [card.foregroundColor colorWithAlphaComponent:[card.alpha floatValue]], NSStrokeColorAttributeName : [UIColor blackColor],NSStrokeWidthAttributeName : @-5}]];
        }
    }
    self.resultsLabel.attributedText = self.resultsString;
    [self.gameHistory appendAttributedString:self.resultsString];
    [self.gameHistory appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n"]];
}

- (IBAction)resetGame:(id)sender {
    [super resetGame];
    [self renderCards];
}


- (UIColor *)cardBackgroundColor:(Card *)card{
    if (card.isChosen) {
        return [UIColor grayColor];
    }
    if (card.isMatched) {
        return [UIColor cyanColor];
    }
    return [UIColor whiteColor];
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
    
    [self.game setNumberOfMatchCards:2];
    
    [self renderCards];
}

- (void)renderCards
{
    NSUInteger i = 0;
    for (SetCard *setCard in self.cards) {
        int cardButtonIndex = i++;
//        Should ensure card is subclass setCard here
        SetCard *setCard = (SetCard *) [self.game cardAtIndex:cardButtonIndex];
        NSMutableAttributedString *buttonTitle = [[NSMutableAttributedString alloc] initWithString:setCard.shape];
        [buttonTitle addAttributes:@{NSForegroundColorAttributeName : [setCard.foregroundColor colorWithAlphaComponent:[setCard.alpha floatValue]], NSStrokeColorAttributeName : [UIColor blackColor],NSStrokeWidthAttributeName : @-5} range:NSMakeRange(0, buttonTitle.length)];
//        [button setAttributedTitle:buttonTitle forState:UIControlStateNormal];
    }
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
