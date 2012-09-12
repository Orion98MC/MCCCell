//
//  MCCCell.h
//
//  Created by Thierry Passeron on 08/09/12.
//  Copyright (c) 2012 Monte-Carlo Computing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCCView.h"

@interface MCCCell : UITableViewCell

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier drawBlock:(void(^)(id _cell, CGRect rect))block;

- (MCCView *)customContentView; /* The content view that draws itself with the drawBlock */

#pragma mark Key-Value Coding

- (id)valueForKey:(NSString *)key;
- (void)setValue:(id)value forKey:(NSString *)key;

@end
