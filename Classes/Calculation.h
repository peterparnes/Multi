//
//  Calculation.h
//  Mult
//
//  Created by Peter Parnes on 2/6/11.
//  Copyright 2011, 2017 Peter Parnes, Parnes Labs AB, peter@parnes.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Calculation : NSObject {
	NSNumber *num1, *num2;
	NSNumber *result;
	NSString *operation;
}

- (NSString *)print;
- (NSString *)printQuestion;

@property (retain) NSNumber *num1, *num2, *result;
@property (retain) NSString *operation; 

@end
