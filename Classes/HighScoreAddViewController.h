//
//  HighScoreAddViewController.h
//  Mult
//
//  Created by Peter Parnes on 2/10/11.
//  Copyright 2011, 2017 Peter Parnes, Parnes Labs AB, peter@parnes.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HighScoreKeeper.h"

@interface HighScoreAddViewController : UIViewController {
	IBOutlet UITextView *textView;
	IBOutlet UIButton *button;
	IBOutlet UILabel *nameLabel;
	IBOutlet UITextField *textField;
	NSTimeInterval time;
	HighScoreKeeper *keeper;
	
}

@property (retain) IBOutlet UITextView *textView;
@property (retain) IBOutlet UILabel	*nameLabel;
@property (retain) IBOutlet UIButton *button;
@property (retain) IBOutlet UITextField *textField;
@property NSTimeInterval time;
@property (retain) HighScoreKeeper *keeper;

- (IBAction)addPressed:(UIButton *)sender;
- (IBAction)editingDidEnd:(id)sender;


@end
