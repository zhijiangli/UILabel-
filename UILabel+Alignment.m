//
//  UILabel+Alignment.m
//  OCTest
//
//  Created by 小黎 on 2018/4/14.
//  Copyright © 2018年 小黎. All rights reserved.
//

#import "UILabel+Alignment.h"
#import <CoreText/CoreText.h>
@implementation UILabel (Alignment)
#pragma mark - 属性方法
-(void)setAlignment:(ZJAlignment)alignment{
    self.numberOfLines = 0 ;
    if(alignment == 1){
        [self setIsTop];
    }else if(alignment == 2){
        [self setIsTopCenter];
    }else if(alignment == 3){
        [self setIsTopRight];
    }else if(alignment == 4){
        [self setIsTopJustify];
    }else if(alignment == 5){
        [self setIsBottom];
    }else if(alignment == 6){
        [self setIsBottomCenter];
    }else if(alignment == 7){
        [self setIsBottomRight];
    }else if(alignment == 8){
        [self setIsBottomJustify];
    }else if(alignment == 9){
        [self setIsCenterJustify];
    }
}
-(ZJAlignment)alignment{
    return top;
}

#pragma mark - 顶左对齐
-(void)setIsTop{
    self.text = [self topWithString:self.text];
}
#pragma mark - 顶中对齐
-(void)setIsTopCenter{
    self.attributedText = [self centerWithString:[self topWithString:self.text]];
}
#pragma mark - 顶右对齐
-(void)setIsTopRight{
    self.attributedText = [self rightWithString:[self topWithString:self.text]];
}
#pragma mark - 顶两段对齐
-(void)setIsTopJustify{
    NSMutableAttributedString *attString01 = [self unchangedConenct];
    NSMutableAttributedString *attString02 = [self justifyWithString:[self changedConenct]];
    [attString01 appendAttributedString:attString02];
    //计算 string 的高度
    NSMutableDictionary * param = [NSMutableDictionary new];
    [param setObject:self.font forKey:NSFontAttributeName];
    CGSize fontSize = [self.text sizeWithAttributes:param];
    //  需要显示的行数
    NSInteger numline = ceilf(fontSize.width/self.frame.size.width);
    // 最多能显示的行数
    NSInteger numlines = ceilf(self.frame.size.height/fontSize.height);
    for(int i=0; i<(numlines - numline - 1); i++){
        //在文字后面添加换行符"/n"
        [attString01 appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n"]];
    }
    self.attributedText = attString01;
}
#pragma mark - 底左对齐
-(void)setIsBottom{
    self.text = [self bottomWithString:self.text];
}
#pragma mark - 底中对齐
-(void)setIsBottomCenter{
    self.attributedText = [self centerWithString:[self bottomWithString:self.text]];
}
#pragma mark - 底右对齐
-(void)setIsBottomRight{
    self.attributedText = [self rightWithString:[self bottomWithString:self.text]];
}
#pragma mark - 底两段对齐
-(void)setIsBottomJustify{
    [self setIsBottom];
    NSMutableAttributedString *attString01 = [self unchangedConenct];
    NSMutableAttributedString *attString02 = [self justifyWithString:[self changedConenct]];
    [attString01 appendAttributedString:attString02];
    self.attributedText = attString01;
}
#pragma mark - 中两段对齐
-(void)setIsCenterJustify{
    NSMutableAttributedString *attString01 = [self unchangedConenct];
    NSMutableAttributedString *attString02 = [self justifyWithString:[self changedConenct]];
    [attString01 appendAttributedString:attString02];
    self.attributedText = attString01;
}
#pragma mark  - 顶部
-(NSString *)topWithString:(NSString *)string{
    NSMutableDictionary * param = [NSMutableDictionary new];
    [param setObject:self.font forKey:NSFontAttributeName];
    CGSize fontSize = [string sizeWithAttributes:param];
    //  需要显示的行数
    NSInteger numline = ceilf(fontSize.width/self.frame.size.width);
    // 最多能显示的行数
    NSInteger numlines = ceilf(self.frame.size.height/fontSize.height);
    for(int i=0; i<(numlines - numline - 1); i++){
        //在文字后面添加换行符"/n"
        string = [string stringByAppendingString:@"\n"];
    }
    return string;
}
#pragma mark - 底部
-(NSString *)bottomWithString:(NSString *)string{
    NSMutableDictionary * param = [NSMutableDictionary new];
    [param setObject:self.font forKey:NSFontAttributeName];
    CGSize fontSize = [string sizeWithAttributes:param];
    //  需要显示的行数
    NSInteger numline = ceilf(fontSize.width/self.frame.size.width);
    // 最多能显示的行数
    NSInteger numlines = ceilf(self.frame.size.height/fontSize.height);
    for(int i=0; i<(numlines - numline - 1); i++){
        //在文字后面添加换行符"/n"
        string = [@"\n"stringByAppendingString:string];
    }
    return string;
}
#pragma mark  - 居中
-(NSMutableAttributedString*)centerWithString:(NSString *)string{
    // 调整行间距
    NSMutableAttributedString *attString = [[NSMutableAttributedString  alloc]  initWithString:string];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    // 设置文字居中
    paragraphStyle.alignment = NSTextAlignmentCenter;
    [attString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [attString length])];
    return attString;
}
/*
#pragma mark  - 两端
-(NSMutableAttributedString*)justifyWithString:(NSString *)string{
    NSMutableAttributedString *attString = [[NSMutableAttributedString  alloc]  initWithString:string];
    CGSize size = [string boundingRectWithSize:CGSizeMake(self.frame.size.width,MAXFLOAT)  options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading  attributes:@{NSFontAttributeName :self.font}  context:nil].size;
    CGFloat margin = (self.frame.size.width - size.width)/(string.length - 1);
    NSNumber *number = [NSNumber  numberWithFloat:margin];
    [attString addAttribute:NSKernAttributeName value:number range:NSMakeRange(0,string.length -1 )];
    return attString;
}
 */
#pragma mark  - 两端对齐
-(NSMutableAttributedString*)justifyWithString:(NSString *)string{
    NSInteger index = 0;
    NSMutableArray * subStrings01 = [NSMutableArray new];
    for(int i=0; i<string.length; i++){
        NSString * charString = [string substringWithRange:NSMakeRange(i, 1)];
        if([charString isEqualToString:@":"] || [charString isEqualToString:@"："]){
            NSString * subString = [string substringWithRange:NSMakeRange(index, i-index)];
            index = i+1;
            [subStrings01 addObject:subString];
        }
    }
    if(!subStrings01.count)[subStrings01 addObject:string];
    //NSArray * subStrings01 = [string componentsSeparatedByString:@":"];
    NSMutableArray * subStrings = [NSMutableArray new];
    for(int i=0; i<subStrings01.count; i++){
        NSString * subString = subStrings01[i];
        if(subString.length<1)continue;
        if(i!=0) subString = [@" " stringByAppendingString:subString];
        [subStrings addObject:subString];
    }
    // 富文本冒号尺寸
    NSMutableDictionary * param = [NSMutableDictionary new];
    [param setObject:self.font forKey:NSFontAttributeName];
    CGSize subSize = [@":" sizeWithAttributes:param];
    // 需要转富文本内容总宽度
    CGFloat attWidth = (self.frame.size.width - subSize.width*2*(subStrings.count));
    // 需要转富文本字符串
    NSString * subString02 = [subStrings componentsJoinedByString:@""];
    NSMutableAttributedString * attString = [[NSMutableAttributedString  alloc]  initWithString:@""];
    //
    for(int i=0; i<subStrings.count; i++){
        NSString * subString = subStrings[i];
        if(subString.length<1)continue;
        NSMutableAttributedString *subAttString = [[NSMutableAttributedString  alloc]  initWithString:subString];
        CGFloat subWidth = subString.length*1.0/subString02.length*attWidth;
        CGSize size = [subString boundingRectWithSize:CGSizeMake(subWidth,MAXFLOAT)  options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading  attributes:@{NSFontAttributeName :self.font}  context:nil].size;
        CGFloat margin = (subWidth - size.width)/(subString.length - 1);
        NSNumber *number = [NSNumber  numberWithFloat:margin];
        [subAttString addAttribute:NSKernAttributeName value:number range:NSMakeRange(0,subString.length -1 )];
        if(index != 0)[subAttString appendAttributedString:[[NSAttributedString alloc] initWithString:@":"]];
        [attString appendAttributedString:subAttString];
    }
    return attString;
}
#pragma mark  - 靠右
-(NSMutableAttributedString*)rightWithString:(NSString *)string{
    // 调整行间距
    NSMutableAttributedString *attString = [[NSMutableAttributedString  alloc]  initWithString:string];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    // 设置文字居中
    paragraphStyle.alignment = NSTextAlignmentRight;
    [attString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [attString length])];
    return attString;
}

#pragma mark  - 顶对齐内容
-(NSString*)topConenctWithIsChanged:(BOOL)changed{
    NSArray * lineConnect = [self linesConenct];
    NSString * string = @"";
    NSInteger num = 0;
    for(int i=0; i<lineConnect.count; i++){
        NSString * string = lineConnect[i];
        if(string.length<2){
            break;
        }
        num ++;
    }
    if(changed == false){
        for(int i=0; i<num-1; i++){
            string = [string stringByAppendingString:lineConnect[i]];
        }
        return string;
    }else{
        string = [string stringByAppendingString:lineConnect[num-1]];
        for(int i=(int)num; i<lineConnect.count; i++){
            string = [string stringByAppendingString:@"\n"];
        }
        return string;
    }
}
#pragma mark  - 变化内容
-(NSString*)changedConenct{
    NSArray * lineConnect = [self linesConenct];
    NSString * string = [lineConnect lastObject];
    return string;
}
#pragma mark  - 不变内容
-(NSMutableAttributedString*)unchangedConenct{
    NSArray * lineConnect = [self linesConenct];
    NSString * string = @"";
    for(int i=0; i<lineConnect.count-1; i++){
        string = [string stringByAppendingString:lineConnect[i]];
    }
    NSMutableAttributedString *attString = [[NSMutableAttributedString  alloc]  initWithString:string];
    return attString;
}
#pragma mark  - 获取每一行内容
-(NSArray*)linesConenct{
    NSString *text = [self text];
    UIFont *font = [self font];
    CGRect rect = [self frame];
    
    CTFontRef myFont = CTFontCreateWithName(( CFStringRef)([font fontName]), [font pointSize], NULL);
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:text];
    [attStr addAttribute:(NSString *)kCTFontAttributeName value:(__bridge  id)myFont range:NSMakeRange(0, attStr.length)];
    CFRelease(myFont);
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString(( CFAttributedStringRef)attStr);
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0,0,rect.size.width,100000));
    CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path, NULL);
    NSArray *lines = ( NSArray *)CTFrameGetLines(frame);
    NSMutableArray *linesArray = [[NSMutableArray alloc]init];
    for (id line in lines) {
        CTLineRef lineRef = (__bridge  CTLineRef )line;
        CFRange lineRange = CTLineGetStringRange(lineRef);
        NSRange range = NSMakeRange(lineRange.location, lineRange.length);
        NSString *lineString = [text substringWithRange:range];
        CFAttributedStringSetAttribute((CFMutableAttributedStringRef)attStr, lineRange, kCTKernAttributeName, (CFTypeRef)([NSNumber numberWithFloat:0.0]));
        CFAttributedStringSetAttribute((CFMutableAttributedStringRef)attStr, lineRange, kCTKernAttributeName, (CFTypeRef)([NSNumber numberWithInt:0.0]));
        //NSLog(@"''''''''''''''''''%@",lineString);
        [linesArray addObject:lineString];
    }
    CGPathRelease(path);
    CFRelease( frame );
    CFRelease(frameSetter);
    return linesArray;
}
@end
