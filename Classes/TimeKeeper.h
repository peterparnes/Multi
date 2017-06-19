//
//  TimeKeeper.h
//  Mult
//
//  Created by Peter Parnes on 2/7/11.
//  Copyright 2011, 2017 Peter Parnes, Parnes Labs AB, peter@parnes.com. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface TimeKeeper : NSObject {
	NSDate *start;  
}

-(void)reset;

+(NSString *)formatTime:(NSTimeInterval)time;

@property (readonly) NSTimeInterval elapsed;

@end
