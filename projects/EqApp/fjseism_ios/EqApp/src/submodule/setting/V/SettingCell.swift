//
//  SettingCell.swift
//  EqApp
//
//  Created by apple on 16/8/31.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit

class SettingCell: UITableViewCell {
    static let suitname:String="settingPref"
    var dict:[String:String]?{
        didSet{
            updateUI()
        }
    }
    
    
    class func cellWith(tv:UITableView,dicti:[String:AnyObject])->SettingCell{
        let dict = dicti as! [String:String]
        let styiden:(UITableViewCellStyle,String) = self.styleBy(dict["cellstyle"])
        var cell = tv.dequeueReusableCellWithIdentifier(styiden.1) as? SettingCell
        if cell == nil{
            cell=SettingCell(style: styiden.0, reuseIdentifier: styiden.1)
        }
        
        cell?.dict=dict
        return cell!
    }
    
    
    
    
    
    
    func updateUI(){
        guard let dict = dict else{
            return
        }
        self.textLabel?.text=dict["title"]
        if let imgname = dict["img"]{
            self.imageView?.image=iimg(imgname)
        }
        self.detailTextLabel?.text=dict["detail"]
        self.detailTextLabel?.textColor=iColor(dict["detailcolor"])
        
        
        let ac=iClassFromStr(dict["acclz"])
        
        if let ac = ac as? UIImageView{
            ac.image=iimg(dict["acimg"])
            ac.sizeToFit()
            self.accessoryView=ac
            
        }else if let ac = ac as? UISwitch{
            if let key = dict["acimg"]{
                ac.on=iPref(SettingCell.suitname)?.boolForKey(key) ?? false
                ac.addTarget(self, action: #selector(self.onChange(_:)), forControlEvents: UIControlEvents.ValueChanged)
            }else if let selname = dict["sel"]{
                ac.on=UserInfo.isautologin()
                let sel = NSSelectorFromString(selname)
                if self.respondsToSelector(sel){
                    ac.addTarget(self, action: sel, forControlEvents: UIControlEvents.ValueChanged)
                }
            }
            
            self.accessoryView=ac
            
        }
        
        
    }
    
    func autologinChange(sender:UISwitch){
        UserInfo.setautologin(sender.on)
    }
    
    func onChange(sender:UISwitch){
        guard let dict = dict else {
            return
        }
        if let  key = dict["acimg"]{
            iPref(SettingCell.suitname)?.setBool(sender.on, forKey:key)
            iPref(SettingCell.suitname)?.synchronize()
        }
        
    }
    
    
    class func styleBy(str1:String?)->(UITableViewCellStyle,String){
        var  style=UITableViewCellStyle.Default
        let str=str1?.lowercaseString
        if str == "value1" {
            style=UITableViewCellStyle.Value1
        }else if str == "value2" {
            style=UITableViewCellStyle.Value2
        }else if str == "subtitle"{
            style=UITableViewCellStyle.Subtitle
        }
        
        return (style,"settingcelliden_\(style)")
    }
    
    
}
