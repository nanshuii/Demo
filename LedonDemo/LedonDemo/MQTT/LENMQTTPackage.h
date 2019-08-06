//
//  LENMQTTPackage.h
//  LedonDemo
//
//  Created by 林南水 on 2019/8/2.
//  Copyright © 2019 ledon. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LENMQTTPackage : NSObject

/**
 * 校验和
 * @param bytes 字节数组
 * @param size 字节数组长度
 * @return 8 位校验和
 */
UInt8 CheckSum(UInt8 *bytes, NSUInteger size);

/**
 * 字节数组转十六进制字符串
 * @param bytes 字节数组
 * @param size UInt8数组的长度
 * @return 十六进制字符串
 */
NSString *UInt8s2Hex(UInt8 *bytes, NSUInteger size);

/**
 * 字节数组转十六进制字符串
 * @param byte 字节数
 * @return 十六进制字符串
 */
NSString *UInt8ToHex(UInt8 byte);

/**
 * 字节数组转十六进制字符串
 * @param byte 字节数
 * @return 十六进制字符串，网络字节序
 */
NSString *UInt16ToHex(UInt16 byte);

/**
 * 十六进制字符串转字节数组
 * @param bytes 字节数据，返回生成字节数据
 * @param str 十六进制字符串
 */
void Hex2UInt8s(NSString *str, UInt8 *bytes);

/**
 * 十六进制字符串转字节数
 * @param str 十六进制字符串
 */
UInt8 Hex2UInt8(NSString *str);

/**
 * 十六进制字符串转字节数
 * @param str 十六进制字符串
 */
UInt16 Hex2UInt16(NSString *str);

/**
 *  二进制字符串转换成十六进制
 * @param str 二进制字符串
 */
NSString *Hex2ToInt8(NSString *str);

@end

NS_ASSUME_NONNULL_END
