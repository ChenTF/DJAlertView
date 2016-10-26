//
//  NSString+DJStrUtils.m
//  Pods
//
//  Created by iBlock on 16/8/25.
//
//

#import "NSString+DJStrUtils.h"

@implementation NSString (DJStrUtils)

+ (BOOL)isEmptyString:(NSString *)str {
    if ([str isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if (str == nil) {
        return YES;
    }
    if (str.length == 0 ||
        [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length == 0) {
        return YES;
    }
    if ([str isEqualToString:@"null"]) {
        return YES;
    }
    return NO;
}

- (id)toJsonObject {
    if (self == nil) {
        return nil;
    }
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    id jsonObj = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    if (jsonObj == nil) {
        NSLog(@"json parse failed \r\n");
        return jsonObj;
    }
    return jsonObj;
}

- (NSString *)urlEncode {
    NSString *encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
                                                                                                    kCFAllocatorDefault, (CFStringRef)self, NULL, (CFStringRef) @"!$&'()*+,-./:;=?@_~%#[]",
                                                                                                    kCFStringEncodingUTF8));
    return encodedString;
}

- (BOOL)verifyPhoneNumber {
    //手机号以13， 15，18开头，八个 \d 数字字符
    //    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    //    NSString *phoneRegex = @"^1[3|5|7|8]\\d{9}$";
    //    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    //    return [phoneTest evaluateWithObject:mobile];
    //  2.2版本后只需要验证数字1开头的
    
    NSString *numStr =
    [self stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    if (numStr.length > 0) {
        return FALSE;
    }
    
    if ([self hasPrefix:@"1"] && self.length == 11) {
        return TRUE;
    }
    else {
        return FALSE;
    }
}

- (BOOL)verifyPhoneAndHomeTel {
    if ([self verifyPhoneNumber]) {
        return YES;
    }
    
    NSString *CT = @"^0(10|2[0-5789]|\\d{3,4})\\d{7,8}$";
    NSPredicate *cateMobileStr1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    if ([cateMobileStr1 evaluateWithObject:self]) {
        return YES;
    }
    
    return NO;
    
    //    NSString *mobileStr = @"^((145|147)|(15[^4])|(17[6-8])|((13|18)[0-9]))\\d{8}$";
    //    NSPredicate *cateMobileStr = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mobileStr];
    //
    //    NSString *CR = @"^([1-9]|\\d{3,4})\\d{4}$";
    //    NSPredicate *cateMobileStr2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CR];
    //    if ([cateMobileStr evaluateWithObject:mobileNumber] || [cateMobileStr1 evaluateWithObject:mobileNumber] || [cateMobileStr2 evaluateWithObject:mobileNumber]) {
    //        return YES;
    //    }
    //    return NO;
}

- (BOOL)isChineseString {
    NSString *const regularExpression = @"^[\u4E00-\u9FA5]+$";
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regularExpression
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    NSUInteger numberOfMatches;
    if ([self length] > 0) {
        numberOfMatches = [regex numberOfMatchesInString:self options:0 range:NSMakeRange(0, [self length])];
    }
    return numberOfMatches > 0;
}

- (NSString *)filterEmoticon {
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]"options:NSRegularExpressionCaseInsensitive error:nil];
    NSString *modifiedString = [regex stringByReplacingMatchesInString:self
                                                               options:0
                                                                 range:NSMakeRange(0, [self length])
                                                          withTemplate:@""];
    return modifiedString;
}

- (NSDictionary *)fetchParameterFromUrlStr {
    NSMutableDictionary *paramsDic = [[NSMutableDictionary alloc] init];
    NSArray *urlParts = [(NSMutableString *)self componentsSeparatedByString:@"?"];
    if ([urlParts count] > 1) {
        NSMutableString *params = [urlParts objectAtIndex:1];
        NSArray *paramsArray = [params componentsSeparatedByString:@"&"];
        for (NSMutableString *param in paramsArray) {
            NSArray *parts = [param componentsSeparatedByString:@"="];
            NSMutableString *name = [parts objectAtIndex:0];
            NSMutableString *value = [NSMutableString stringWithString:@""];
            if ([parts count] > 1) {
                value = [parts objectAtIndex:1];
            }
            [paramsDic setObject:value forKey:name];
        }
    }
    return paramsDic;
}

- (NSString *)jointUrlParameters:(NSDictionary *)parameters {
    if (parameters == nil) {
        return self;
    }
    
    NSMutableString *urlStrWithParam = [[NSMutableString alloc] init];
    [urlStrWithParam appendString:self];
    int i = 0;
    for (NSString *key in parameters.keyEnumerator) {
        if (i == 0) {
            if ([self fetchParameterFromUrlStr].count == 0) {
                [urlStrWithParam appendString:@"?"];
            } else {
                [urlStrWithParam appendString:@"&"];
            }
        }
        else
            [urlStrWithParam appendString:@"&"];
        id value = [parameters objectForKey:key];
        [urlStrWithParam appendFormat:@"%@=%@", key, value];
        i++;
    }
    return urlStrWithParam;
}

@end
