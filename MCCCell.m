//
//  MCCCell.m
//
//  Created by Thierry Passeron on 08/09/12.
//  Copyright (c) 2012 Monte-Carlo Computing. All rights reserved.
//

#import "MCCCell.h"

//#define DEBUG_MCCCell

@interface MCCCell ()
@property (retain, nonatomic) NSMutableDictionary *userInfo;
@property (retain, nonatomic) MCCView *customContentView;
@end

@implementation MCCCell
@synthesize userInfo, customContentView;

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier drawBlock:(void(^)(id, CGRect))block {
  self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
  if (!self) return nil;
  
  /* Key-Value Coding storage */
  self.userInfo = [NSMutableDictionary dictionary];

  /* Add the custom content view that will draw the content of the cell using a block */
  __block typeof (self) __self = self;
  self.customContentView = [[[MCCView alloc]initWithFrame:self.bounds]autorelease];
  customContentView.drawBlock = ^void(id _customContentView, CGRect rect){
    block(__self, rect);
  };
  customContentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  customContentView.opaque = YES;
  [self.contentView addSubview:customContentView];
  
  /* default cell settings */
  self.opaque = YES;
  self.contentView.opaque = YES;
  
  return self;
}

- (void)dealloc {
#ifdef DEBUG_MCCCell
  NSLog(@"dealloc %@", NSStringFromClass([self class]));
#endif
  self.customContentView = nil;
  self.userInfo = nil;
  [super dealloc];
}

- (MCCView *)customContentView { return customContentView; }

- (void)setBackgroundColor:(UIColor *)backgroundColor {
  [super setBackgroundColor:backgroundColor];
  
  if (customContentView && customContentView.opaque) {
    [customContentView setBackgroundColor:backgroundColor];
  }
}

- (void)setNeedsDisplay {
  [super setNeedsDisplay];
  [customContentView setNeedsDisplay];
}

- (void)setNeedsDisplayInRect:(CGRect)rect {
  [super setNeedsDisplayInRect:rect];
  [customContentView setNeedsDisplayInRect:rect];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
  [super setSelected:selected animated:animated];
  [customContentView setNeedsDisplay];
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
  [super setHighlighted:highlighted animated:animated];
  [customContentView setNeedsDisplay];
}


#pragma mark Key-Value Coding

- (id)valueForKey:(NSString *)key { return [userInfo valueForKey:key]; }
- (void)setValue:(id)value forKey:(NSString *)key { [userInfo setValue:value forKey:key]; }
- (id)valueForUndefinedKey:(NSString *)key { return nil; }

@end
