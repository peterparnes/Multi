//
//  HighScoreViewController.h
//  Mult
//
//  Created by Peter Parnes on 2/9/11.
//  Copyright 2011, 2017 Peter Parnes, Parnes Labs AB, peter@parnes.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HighScoreKeeper.h"

@interface HighScoreViewController : UITableViewController <UIActionSheetDelegate> {
	HighScoreKeeper *keeper;
}

-(HighScoreKeeper *)getKeeper;

@end
