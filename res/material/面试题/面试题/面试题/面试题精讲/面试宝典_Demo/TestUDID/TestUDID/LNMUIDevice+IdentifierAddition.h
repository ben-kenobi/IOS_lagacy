//
//  LNMUIDevice(IdentifierAddition).h
//  UIDeviceAddition
//
//  Created by Georg Kitz on 20.08.11.
//  Copyright 2011 Aurora Apps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface UIDevice (IdentifierAddition)

/*
 * @method uniqueDeviceIdentifier
 * @description use this method when you need a unique identifier in one app.
 * It generates a hash from the MAC-address in combination with the bundle identifier
 * of your app.
 *
 * 使用IFA作为唯一标识符
 * IOS6.0以上用IFA
 */

- (NSString *) uniqueDeviceIdentifier;

/*
 * @method uniqueGlobalDeviceIdentifier
 * @description use this method when you need a unique global identifier to track a device
 * with multiple apps. as example a advertising network will use this method to track the device
 * from different apps.
 * It generates a hash from the MAC-address only.
 *
 * 使用IFA作为唯一标识符
 * IOS6.0以上用IFA
 */

- (NSString *) uniqueGlobalDeviceIdentifier;

/*
* 使用IFA作为唯一标识符
* IOS6.0以上用IFA
*/
- (NSString*)sourceUniqueGlobalDeviceIdentifier;

@end
