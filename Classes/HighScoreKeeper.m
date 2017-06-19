//
//  HighScoreKeeper.m
//  Mult
//
//  Created by Peter Parnes on 2/9/11.
//  Copyright 2011, 2017 Peter Parnes, Parnes Labs AB, peter@parnes.com. All rights reserved.
//

#import "HighScoreKeeper.h"

@implementation HighScoreKeeper

// @synthesize today, alltime;

#define TODAYSCOREKEY @"todayhighscore"
#define ALLTIMESCOREKEY @"alltimehighscore"

- (void)populate {
	// NSLog(@"populate");
	NSUserDefaults *prefs =  [NSUserDefaults standardUserDefaults];
	today = [ prefs objectForKey:TODAYSCOREKEY ];
	alltime = [ prefs objectForKey:ALLTIMESCOREKEY ];
	
	double startvalue = 142.42;
	NSMutableArray *tmpToday = [ NSMutableArray arrayWithCapacity:10 ];
	for(int i = 0; i < 10; i++) {
		NSDate *date = [ NSDate date ];
		// NSDate *date = [ NSDate dateWithTimeIntervalSince1970:36000 ];
		//if(i % 2) {
		//	date = [ NSDate date ];
		//}
		NSDictionary *dict = [ NSDictionary dictionaryWithObjectsAndKeys:date, @"time", @"Dr. Play", @"name", 
							  [NSNumber numberWithDouble:(.79*i+i*10+startvalue)], @"score", nil];
		
		[ tmpToday addObject:dict];
	}
	[prefs setObject:tmpToday forKey:TODAYSCOREKEY];
	
	NSMutableArray *tmpAll = [ NSMutableArray arrayWithCapacity:10 ];
	for(int i = 0; i < 10; i++) {
		NSDictionary *dict = [ NSDictionary dictionaryWithObjectsAndKeys:[ NSDate date ], @"time", @"Dr. Play", @"name", 
							  [NSNumber numberWithDouble:(.79*+i*10+startvalue)], @"score", nil];
		
		[ tmpAll addObject:dict];
	}
	[prefs setObject:tmpAll forKey:ALLTIMESCOREKEY];
	
	[ prefs setBool:true forKey:@"populated" ];

	[prefs synchronize];
}

- (BOOL)gotIn:(double)time {
	BOOL result = NO;
	
	if([today count] < 10) {
		result = YES;
	} else {
		for(NSDictionary *entry in today) {
			double tmptime = [[ entry objectForKey:@"score"] doubleValue ];
			if(time <= tmptime) {
				result = YES;
				break;
			}
		}
	}
	return result;
}

-(void)saveScores {
	NSUserDefaults *prefs = [ NSUserDefaults standardUserDefaults ];
	[ prefs setObject:today forKey:TODAYSCOREKEY ];
	[ prefs setObject:alltime forKey:ALLTIMESCOREKEY ];
	[ prefs synchronize ];
}

- (void)loadScores {
	NSUserDefaults *prefs =  [NSUserDefaults standardUserDefaults];
	NSArray *tmptoday = [ prefs objectForKey:TODAYSCOREKEY ];
	NSArray *tmpalltime = [ prefs objectForKey:ALLTIMESCOREKEY ];
	
	today = nil;
	today = [[[ NSMutableArray alloc ] initWithCapacity:10] retain];
	[today addObjectsFromArray:tmptoday ];
	alltime = nil;
	alltime = [[[ NSMutableArray alloc ] initWithCapacity:10] retain];
	[alltime addObjectsFromArray:tmpalltime ];
	
	
	// NSLog(@"%@", today);	
}

-(void)checkTimesToday {		
	
	NSDate *todaydate = [NSDate date];
	// NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	NSCalendar *calendar = [ NSCalendar autoupdatingCurrentCalendar ];
	// NSLog(@"date1: %@", [ calendar timeZone ]);
	NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
	NSDateComponents *components = [calendar components:unitFlags fromDate:todaydate];
	components.hour = 0;
	components.minute = 0;
	NSDate *midnight = [calendar dateFromComponents:components];
	
	NSMutableArray *newtoday = [[[ NSMutableArray alloc ] initWithCapacity:10 ] retain ];
	for(NSDictionary *entry in today) {
		NSDate *time = [ entry objectForKey:@"time" ];
		// NSLog(@" %@: %d", time, [ time earlierDate:midnight ] == midnight);
		if([ time earlierDate:midnight ] == midnight) {
			[newtoday addObject:entry ];
		}
	}
	today = nil;
	today = newtoday;
}

-(void)updateTimes {
	[ self checkTimesToday ];	
	[ self saveScores ];
}

-(BOOL)isPopulated {
	NSUserDefaults *prefs =  [NSUserDefaults standardUserDefaults];
	BOOL populated = [ prefs boolForKey:@"populated" ];
	// NSLog(@"pop: %d",populated);
	return populated;
}

-(id)init {
	self = [ super init ];
	if(self) {
		if(![self isPopulated]) {
			[ self populate ];
			// [ self saveScores ];
		}
		[ self loadScores ];
	}
	
	return self;
}

-(NSArray *)todaysScores {
	// return nil;
	return today;
}

-(NSArray *)allScores {
	return alltime;
}

-(void)sortScores:(NSMutableArray *)array {
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"score" ascending:YES];
	NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
	[array sortUsingDescriptors:sortDescriptors];
	[sortDescriptor release]; 
}

-(void)addScore:(double)time withName:(NSString *)name {
	// NSLog(@"addScore: %f %@", time, name);
	
	NSMutableArray *newToday = [ NSMutableArray arrayWithCapacity:([today count] + 1)];
	[ newToday addObjectsFromArray:today ];
	NSDictionary *dict = [ NSDictionary dictionaryWithObjectsAndKeys:[ NSDate date ], @"time", name, @"name", 
						  [NSNumber numberWithDouble:time], @"score", nil];
	[newToday insertObject:dict atIndex:0];
	[self sortScores:newToday];
	while([newToday count] > 10) {
		[ newToday removeLastObject ];
	}
	
	today = nil;
	today = [ newToday retain ];
	
	// NSLog(@"%@", today);
	NSMutableArray *newAll = [ NSMutableArray arrayWithCapacity:([alltime count] + 1)];
	[newAll addObjectsFromArray:alltime ];
	[newAll insertObject:dict atIndex:0];
	[self sortScores:newAll];
	while([newAll count] > 10) {
		[ newAll removeLastObject ];
	}
	
	alltime = nil;
	alltime = [ newAll retain ];
	
	[self saveScores ];
}


-(void)clear:(BOOL)all {
	[(NSMutableArray *)today removeAllObjects ];
	if(all) {
		[(NSMutableArray *)alltime removeAllObjects ];		
	} 
	[ self saveScores ];
}

@end
