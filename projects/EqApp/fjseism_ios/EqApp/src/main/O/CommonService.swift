//
//  CommonService.swift
//  am
//
//  Created by apple on 16/5/12.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit

class CommonService {
    
    
    class func checkAccessKey(accessKey:String) -> Bool{
        if (isBlank(accessKey)){
            return false;
            
        }
        return accessKey==getAccessKey();
    }
    
    class func  getAccessKey()->String{
        var accessKey:String="";
        let list=ISQLite.ins.rawQuery("select " + MetaDataColumns.ACCESSKEY
            + " from " + ISQLite.TABLE_META_DATA)
        if list.count>0{
            accessKey = (list[0][MetaDataColumns.ACCESSKEY] as? String) ?? ""
        }
        
        
        return accessKey;
    }
    
    
    /**
     * method: login
     *
     * @param accessKey
     * @return
     */
    class func login(accessKey:String)->Bool {
        if (isBlank(accessKey)){
            return false;
        }
        var b = false;
        let key = getAccessKey()
        if isBlank(key){
            b=true
            ISQLite.ins.rawUpdate("update " + ISQLite.TABLE_META_DATA + " set "
                + MetaDataColumns.ACCESSKEY + "=?;",args: [accessKey])
        }else {
            
            b = (key.equalIgnoreCase(accessKey))
            if(!b){
                iPop.toast("验证失败")
            }
        }
        return b
        
        
        
    }
    
    /**
     * method:modifyAccessKey
     *
     * @param newAccessKey
     * @return
     */
    
    class func  modifyAccessKey(oldAccessKey:String,
                                newAccessKey:String) -> Bool{
        if (isBlank(oldAccessKey)||isBlank(newAccessKey)){
            return false;
        }
        var b = false;
        let key = getAccessKey()
        if oldAccessKey.equalIgnoreCase(key){
            b = ISQLite.ins.rawUpdate("update " + ISQLite.TABLE_META_DATA + " set "
                + MetaDataColumns.ACCESSKEY + "=?;",args:
                [newAccessKey ]) != -1
        }
        return b
        
    }
    
    /**
     * methodname:getAccessibilityByName
     *
     * @param name
     * @return
     */
    
    class func isAccessKeyEnable(name:String)->Bool {
        
        if (isBlank(name)){
            return true;
        }
        let list = ISQLite.ins.rawQueryAry("select  " + AccessColumns.ACCESSIBILITY
            + "  from  " + ISQLite.TABLE_ACCESS + "  where "
            + AccessColumns.NAME + " =?;",args: [ name ])
        if list.count > 0 {
            if let i = list[0][0] as? Int where i==0{
                return false
            }
        }
        return true;
    }
    
    
    class func modifyAccessibility(name:String, accessibility:Int)->Bool{
        if isBlank(name){
            return false
        }
        
        return ISQLite.ins.rawUpdate("UPDATE "+ISQLite.TABLE_ACCESS+" SET "+AccessColumns.ACCESSIBILITY +
            " = ? Where "+AccessColumns.NAME+"=?;",args: [accessibility,name]) > 0
        
    }
    
    class func toggleAccessibility(name:String)->Bool {
        if (isAccessKeyEnable(name)){
            return disableAccessKey(name);
        }else{
            return enableAccessKey(name);
        }
    }
    
    /**
     * enableAccessKey
     *
     * @param name
     * @return
     */
    class func enableAccessKey(name:String)->Bool {
        return modifyAccessibility(name, accessibility: 1);
    }
    
    /**
     * disableAccessKey
     *
     * @param name
     * @return
     */
    class func disableAccessKey(name:String)->Bool {
        return modifyAccessibility(name, accessibility: 0);
    }
    
    class func getIntentByAccessName(name:String)->UINavigationController {
        var vc:UIViewController? = nil
        if (iConst.ACCOUNT==name) {
            vc=AccountVC()
        } else if (iConst.FILESYSTEM==(name)) {
            vc=FilesystemVC()
        } else if (iConst.CONTACTS==(name)) {
            vc=ContactsVC()
        } else{
            vc=FilesystemVC()

        }
        
        return MainNavVC(rootViewController: vc!);
    }
    
    //    class func getItemDetailIntentByPlatform(String platform,Context context)->Intent{
    //    if (IConstants.ACCOUNT.equals(platform)) {
    //    return new Intent(context,AccountDetailActivity.class);
    //    }else if (IConstants.CONTACTS.equals(platform)) {
    //    return new Intent(context,ContactDetailActivity.class);
    //    }
    //    return null;
    //    }
    //
    //    class func deleteItemsByPlatform(ids:Set<Int>,platform:String)->Bool{
    //    var b = false;
    //
    //    if (iConst.ACCOUNT==platform){
    //    b=AccountService.removeAccount(ids);
    //    } else if (IConstants.CONTACTS.equals(platform)) {
    //    b=ContactsService.removeContacts(ids);
    //    }
    //    return b;
    //    }
    //
    //    class func queryDistinctColumnByPlatform(String platform,String column)->Cursor{
    //    Cursor cursor = null;
    //    if(IConstants.ACCOUNT.equals(platform)){
    //    if(TextUtils.isEmpty(column))
    //				column=AccountColumns.GROUP;
    //    cursor=AccountService.queryDistinctColumn(column);
    //    }else if(IConstants.CONTACTS.equals(platform)){
    //    if(TextUtils.isEmpty(column))
    //				column=ContactColumns.GROUP;
    //    cursor=ContactsService.queryDistinctColumn(column);
    //    }
    //    return cursor;
    //    }
    //
    //    class func queryAllByPlatform(String platform)->Cursor{
    //    Cursor cursor=null;
    //    if(IConstants.ACCOUNT.equals(platform))
    //    cursor=AccountService.queryByColumn("",IConstants.MATCH_ALL);
    //    else if(IConstants.CONTACTS.equals(platform))
    //    cursor= ContactsService.queryByColumn("",IConstants.MATCH_ALL);
    //    return cursor;
    //    }
    //
    //    class func queryByPlatformNColumn(String platform,String colName,String colValue)->Cursor{
    //    Cursor cursor=null;
    //    if(IConstants.ACCOUNT.equals(platform))
    //    cursor=AccountService.queryByColumn(colName, colValue);
    //    else if(IConstants.CONTACTS.equals(platform))
    //    cursor= ContactsService.queryByColumn(colName, colValue);
    //    return cursor;
    //    }
    //
    //    class func batchInsertByPlatform(String platform,List<ContentValues> cvs)->void{
    //    if(IConstants.ACCOUNT.equals(platform))
    //    AccountService.batchAddAccount(cvs);
    //    else if(IConstants.CONTACTS.equals(platform))
    //    ContactsService.batchInsert(cvs);
    //    }
    //
    //
    //    /**
    //     * method:concatenateIds
    //     *
    //     * @param idset
    //     * @return
    //     */
    //    class func concatenateIds(Set<Integer> idset)->String {
    //    StringBuffer sb = new StringBuffer();
    //    for (Iterator<Integer> it = idset.iterator(); it.hasNext();) {
    //    sb.append(it.next() + ",");
    //    }
    //    if (sb.length() > 1)
    //    sb.deleteCharAt(sb.length() - 1);
    //    return sb.toString();
    //    }
    
    
}
