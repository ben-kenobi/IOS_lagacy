
//
//  ContactsVC02.m
//  day54-QRCodeNContactsNstaticlibs
//
//  Created by apple on 15/12/27.
//  Copyright © 2015年 yf. All rights reserved.
//

#import "ContactsVC02.h"
#import <AddressBook/AddressBook.h>
@interface ContactsVC02 ()

@end

@implementation ContactsVC02

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ABAuthorizationStatus status=ABAddressBookGetAuthorizationStatus();
    if(status == kABAuthorizationStatusNotDetermined){
        ABAddressBookRef bookref=ABAddressBookCreateWithOptions(nil, nil);
        
        ABAddressBookRequestAccessWithCompletion(bookref, ^(bool granted, CFErrorRef error) {
            CFRelease(bookref);
            if(error) {
                NSLog(@"auth error");
            }else if (granted){
                 NSLog(@"auth success");
            }
        });
    }
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if(ABAddressBookGetAuthorizationStatus()==kABAuthorizationStatusAuthorized){
        ABAddressBookRef bookref = ABAddressBookCreateWithOptions(0, 0);
        CFArrayRef peopleary = ABAddressBookCopyArrayOfAllPeople(bookref);
        CFIndex count =  CFArrayGetCount(peopleary);
        for(int i = 0 ;i<count;i++){
            
            ABRecordRef people=CFArrayGetValueAtIndex(peopleary, i);
            
            NSString *name1= CFBridgingRelease(ABRecordCopyValue(people, kABPersonFirstNameProperty));
            NSString * name2=CFBridgingRelease(ABRecordCopyValue(people, kABPersonLastNameProperty));
            
            ABMultiValueRef phones= ABRecordCopyValue(people, kABPersonPhoneProperty);
            CFIndex phonecount =  ABMultiValueGetCount(phones);
            for (int i = 0; i<phonecount; i++) {
                NSString *label = CFBridgingRelease(ABMultiValueCopyLabelAtIndex(phones, i));
                NSString *value= CFBridgingRelease(ABMultiValueCopyValueAtIndex(phones, i));
                NSLog(@"%@--%@---%@----%@",name1,name2,label,value);
            }
            CFRelease(phones);
        }
        
        CFRelease(peopleary);
        CFRelease(bookref);
        
        
        
    }
}



@end
