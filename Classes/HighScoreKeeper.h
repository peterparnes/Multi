//
//  HighScoreKeeper.h
//  Mult
//
//  Created by Peter Parnes on 2/9/11.
//  Copyright 2011, 2017 Peter Parnes, Parnes Labs AB, peter@parnes.com. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface HighScoreKeeper : NSObject {
	NSMutableArray *today;
	NSMutableArray *alltime;
}

-(NSArray *)todaysScores;
-(NSArray *)allScores;
-(void)updateTimes;
-(void)addScore:(double)time withName:(NSString *)name;
-(BOOL)gotIn:(double)time;
-(void)clear:(BOOL)all;

@end
