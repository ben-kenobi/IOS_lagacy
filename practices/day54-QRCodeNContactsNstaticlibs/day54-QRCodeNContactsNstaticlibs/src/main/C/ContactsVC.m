

//
//  ContactsVC.m
//  day54-QRCodeNContactsNstaticlibs
//
//  Created by apple on 15/12/27.
//  Copyright © 2015年 yf. All rights reserved.
//

#import "ContactsVC.h"
#import <AddressBookUI/AddressBookUI.h>
#import <ContactsUI/ContactsUI.h>

@interface ContactsVC ()<ABPeoplePickerNavigationControllerDelegate,CNContactPickerDelegate>

@end

@implementation ContactsVC

-(void)viewDidLoad{
    [super viewDidLoad];
      self.view.backgroundColor=[UIColor orangeColor];
    
    
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self contactPickerTest];
}


-(void)contactPickerTest{
    CNContactPickerViewController *picker = [[CNContactPickerViewController alloc] init];
    picker.delegate=self;
    [self presentViewController:picker  animated:YES completion:nil];
}

#pragma --mark
#pragma --mark CNContactPickerDelegate

- (void)contactPickerDidCancel:(CNContactPickerViewController *)picker{
    
}
- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContact:(CNContact *)contact{
    NSLog(@"%@",contact.givenName);
    NSLog(@"%@",contact.familyName);
    NSLog(@"%@",contact.phoneNumbers);
    for (CNLabeledValue *labelval in contact.phoneNumbers){
        CNPhoneNumber *phone= labelval.value;
        NSLog(@"%@=%@",labelval.label,phone.stringValue );
    }
    
}
//- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContacts:(NSArray<CNContact*> *)contacts{
//    NSLog(@"%s",__func__);
//}


- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContactProperty:(CNContactProperty *)contactProperty{
    NSLog(@"%s",__func__);
}


//- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContactProperties:(NSArray<CNContactProperty*> *)contactProperties{
//    NSLog(@"%s",__func__);
//}



#pragma -------------------------------------------------------------------mark




-(void)peoplePickerTest{
        ABPeoplePickerNavigationController *nav=  [[ABPeoplePickerNavigationController alloc] init];
        nav.peoplePickerDelegate=self;
        [self presentViewController:nav animated:YES completion:nil];
}

#pragma --mark
#pragma --mark ABPeoplePickerNavigationControllerDelegate

- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController*)peoplePicker didSelectPerson:(ABRecordRef)person {
    
    CFStringRef name1= ABRecordCopyValue(person, kABPersonFirstNameProperty);
    CFStringRef name2=ABRecordCopyValue(person, kABPersonLastNameProperty);
    
    
    // bridge way1
//    NSString *fname=(__bridge NSString *)(name1);
//    NSString *sname=(__bridge NSString *)(name2);
//    CFRelease(name1);
//    CFRelease(name2);
    
    // bridge way2
//    NSString *fname=(__bridge_transfer NSString *)(name1);
//    NSString *sname=(__bridge_transfer  NSString *)(name2);
    
    
    // bridge way3
    NSString *fname=CFBridgingRelease(name1);
    NSString *sname=CFBridgingRelease(name2);
    
    //reverse transfer
//    CFStringRef reverseStr = (__bridge_retained CFStringRef)(fname);
//    CFStringRef reverseStr2 = (__bridge CFStringRef)(sname);
    NSLog(@"%@------------%@",fname,sname);
    
    ABMultiValueRef phones=ABRecordCopyValue(person, kABPersonPhoneProperty);
    
    
    for(int i =0;i<ABMultiValueGetCount(phones);i++){
        NSString *label= CFBridgingRelease( ABMultiValueCopyLabelAtIndex(phones, i));
        NSString *phone= CFBridgingRelease( ABMultiValueCopyValueAtIndex(phones, i));
        NSLog(@"-----------%@----%@",label,phone);
    }
    
    
    

}


- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController*)peoplePicker didSelectPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier {
    NSLog(@"%zd---%zd",property,identifier);
    
}


- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker{
    
}



@end
