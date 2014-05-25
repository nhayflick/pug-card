//
//  CardGameHistoryViewController.m
//  Pug Card
//
//  Created by Nathan Hayflick on 5/24/14.
//  Copyright (c) 2014 Nathan Hayflick. All rights reserved.
//

#import "CardGameHistoryViewController.h"

@interface CardGameHistoryViewController ()
@property (weak, nonatomic) IBOutlet UITextView *historyTextView;
@property (strong, nonatomic)NSMutableAttributedString *historyText;

@end

@implementation CardGameHistoryViewController

- (void)setHistory:(NSMutableAttributedString *)history;
{
//    [self.historyTextView setText:@"here"];
    self.historyText = history;
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
    self.historyTextView.attributedText = self.historyText;
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
