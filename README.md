## Description

MCCCell lets you create a highly effective custom UITableViewCell with a block drawing it's content.
This also allows you to avoid custom class creation and put the drawing calls where they are used for better clarity.

MCCCell is Key-Value Coding compliant so that exchanging data between the UITableView datasource/delegate and the drawBlock is easy.

## Dependency

MCCCell depends on MCCView which you can find here: https://github.com/Orion98MC/MCCView

## Example

```objective-c
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *identifier = @"identifier";
  
  MCCCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
  if (!cell) {
    [[[MCCCell alloc]initWithReuseIdentifier:identifier drawBlock:^(MCCCell* _cell, CGRect rect) {
      if ([_cell isHighlighted]) [[UIColor whiteColor]set];
      else [[UIColor blackColor]set];
        
      CGContextRef context = UIGraphicsGetCurrentContext();
  
      CGContextSaveGState(context);
      CGContextSetShadowWithColor(context, (CGSize){0.0, 1.0}, 0.0, [_cell isHighlighted] ? [UIColor blackColor].CGColor : [UIColor whiteColor].CGColor);
      [[_cell valueForKey:@"name" ] drawAtPoint:CGPointMake(95, 10) withFont:[UIFont systemFontOfSize:18]];
      CGContextRestoreGState(context);
      
      if ([_cell valueForKey:@"picture"]) {
        [(UIImage *)[_cell valueForKey:@"picture"] drawAtPoint:CGPointMake(10, 10)];
      }
    }]autorelease];
  }
  
  // Set the cell data content:
  [cell setValue:@"Albert" forKey:@"name"];
  [cell setValue:[UIImage imageNamed:@"albert.jpg"] forKey:@"picture"];
  
  return cell;
}
```

## License terms

Copyright (c), 2012 Thierry Passeron

The MIT License

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.