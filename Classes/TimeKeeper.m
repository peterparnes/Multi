//
//  TimeKeeper.m
//  Mult
//
//  Created by Peter Parnes on 2/7/11.
//  Copyright 2011, 2017 Peter Parnes, Parnes Labs AB, peter@parnes.com. All rights reserved.
//

#import "TimeKeeper.h"

@interface TimeKeeper() 

@property (nonatomic, nonatomic, retain) NSDate* start;

@end


@implementation TimeKeeper

@synthesize start;

-(NSDate *)start {
	if(!start) {
		[ self reset ];
	}
	return start;
}

-(void)reset {
	self.start = [NSDate date];
}

-(NSTimeInterval)elapsed {
	return -[self.start timeIntervalSinceNow ];
}

#define SHOWMINUTES NO

+(NSString *)formatTime:(NSTimeInterval)time {
	int minutes =  0;
	if(SHOWMINUTES) {
		minutes = time / 60;
	}
	double seconds = round((time - 60 * minutes) * 100)/100;
	// NSLog(@"%f %d %f", delta, minutes, seconds);
	if(minutes > 0) {
		return [NSString stringWithFormat:@"%d m %.2f s", minutes, seconds];
	} else {
		return [NSString stringWithFormat:@"%.2f s", seconds];
	}
}

@end
