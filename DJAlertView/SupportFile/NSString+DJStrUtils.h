//
//  NSString+DJStrUtils.h
//  Pods
//
//  Created by iBlock on 16/8/25.
//
//

#import <Foundation/Foundation.h>

@interface NSString (DJStrUtils)
+ (BOOL)isEmptyString:(NSString *)str;
- (id)toJsonObject;
- (NSString *)urlEncode;
/** 验证手机号 */
- (BOOL)verifyPhoneNumber;
- (BOOL)verifyPhoneAndHomeTel;
- (BOOL)isChineseString;
/** 过滤表情符号 */
- (NSString *)filterEmoticon;
/** 从URL中获取参数字典 */
- (NSDictionary *)fetchParameterFromUrlStr;
/** 拼接参数到URL中 */
- (NSString *)jointUrlParameters:(NSDictionary *)parameters;

@end
