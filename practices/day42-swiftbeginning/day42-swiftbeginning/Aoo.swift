//
//  Aoo.swift
//  day42-swiftbeginning
//
//  Created by apple on 15/12/2.
//  Copyright © 2015年 yf. All rights reserved.
//

import UIKit

class Aoo: NSObject {
    private var _name:String?
    var name:String?{
        set{
            _name=newValue
        }
        get{
            return _name
        }
    }
    var no:Int=0{
        didSet{
            
        }
        willSet{
            
        }
    }
        
    override init() {
        
        
        super.init()
        name="123"
       
    }
     init(name:String) {
        
        
        super.init()
        self.name=name
        
    }
    
    
    init(dict:[String:AnyObject]) {

        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
//        print(key,value)
    }
    
    override func valueForUndefinedKey(key: String) -> AnyObject? {
        return 0
    }
    
      convenience init?(name:String,no:String) {
        if(no=="123"){
            return nil
        }
        
        self.init(dict: ["name":name,"no":no])
    }
    
    
    
    
    
    
    override var description:String {
        get{
            return dictionaryWithValuesForKeys(["name","no","aoo"]).description
        }
    }
}




