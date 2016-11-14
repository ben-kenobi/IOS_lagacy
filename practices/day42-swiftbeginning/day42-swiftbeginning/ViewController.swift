//
//  ViewController.swift
//  day42-swiftbeginning
//
//  Created by apple on 15/12/2.
//  Copyright © 2015年 yf. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIApplicationDelegate {
    

    lazy var btn:UIButton={
        self.btn=UIButton(frame: CGRect(x: 90, y: 90, width: 100, height: 50))
        self.btn.tag=10
        self.btn.frame.size.width=80
        self.btn.backgroundColor=UIColor.whiteColor()
        self.btn.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
        self.btn.addTarget(self, action: Selector("onBtnClicked:"), forControlEvents: UIControlEvents.TouchUpInside)
        self.btn.setTitle("btn01", forState: UIControlState.Normal)
        self.view .addSubview(self.btn)
        print("0-----------------------")
        return self.btn
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor=UIColor.whiteColor()
        var view=UIView(frame:CGRect(x: 100, y: 10, width: 100, height: 100))
        view.backgroundColor=UIColor.blackColor()
        self.view.addSubview(view)
        print(String(format:"%@","hello world"))
        let _view=UIView(frame: CGRect(x: 20, y: 20, width: 110, height: 10))
        _view.backgroundColor=UIColor.redColor()
        view .addSubview(_view)
        
        view=UIView(frame: CGRect(x: 200, y: 200, width: 100, height: 100))
        view.backgroundColor=UIColor.orangeColor()
        self.view.addSubview(view)
        
    }
    
    override func viewDidAppear(animated: Bool) {
        view.backgroundColor=UIColor.greenColor()
        
    }

    func onBtnClicked( b:UIView){
//        print(b)
        var a:Int?
//        a=5
        let b=10

        print((a ?? 0) + b)

    }
    
    
    func sum(n1 x:Int ,n2 y:Int) -> Int{
        
        return x+y
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
//       print( Aoo())
//        print(Aoo(dict: ["name":"qweqw","no":11,"aoo":"eqwe"]))
//        print(Aoo(name: "qwe", no: "123"))
        self.demo09()
    }
    
    
    
    
    //newwork
    func demo09(){
        let url :NSURL? = NSURL(string: "http://localhost")
//        if(url==nil){
//            return ;
//        }
        if let u = url{
            let req:NSURLRequest  = NSURLRequest(URL: u)
            NSURLSession.sharedSession().dataTaskWithRequest(req, completionHandler: { (data, _, _) -> Void in
                guard let d=data else{
                    return
                }
                do{
                   let res = try NSJSONSerialization.JSONObjectWithData(d, options: [])
                    print(res)
                }catch{
                    print(error)
                    print(NSString(data: d, encoding: 4))
                }
            }).resume()
        }
        
        
    }
    
    
    
    //asyn task
    func demo08(){
        let clo={
            (str:String)->() in
            let v=self.view.viewWithTag(10)
            v?.backgroundColor=UIColor.grayColor()

            print(str)
        }
        
        dispatch_async(dispatch_get_global_queue(0, 0)) { () -> Void in
            NSThread.sleepForTimeInterval(1)
           let name="btnname"
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
               clo(name)
            })
        }

    }
    
    
    //closure
    func demo07(){
        var a="12312321\"\""
        var closure01={(str :String)->Bool in
            print("closure \(str)")
            return false;
        }

        func prin(clo:(String)->Bool)->Bool{
            return clo(a);
        }
        
       print("return=", prin(closure01))
    }
    
    
    //dict
    
    func demo06(){
        let dict1=["key":"val","key2":"val2"]
        
        var dict2:[String:NSObject]=[String:NSObject]()
        dict2["key1"]="value1"
        dict2["key2"]=88
        print(dict2["key1"])
        
        var dict3=[NSObject:NSObject]()
        for(k,v) in dict1{
            dict3[k]=v
        }
        for (k,v)in dict2{
            dict3[k]=v
        }
        dict3.removeValueForKey("key1")
        print(dict3)
    
    }
    
    
    
    
    ///ary
    func demo05(){
        let ary :[Int]=[1,2,3]
        print(ary)
        let ary2=[1,2,"aa"]
        print(ary2)
        let ary3:[String]=["123","111"]
        print(ary3)

        var ary4=[1,2,"eee"]
        ary4.append("qweqwe")
        print(ary4)
        
        ary4 .removeAtIndex(1)
        
        var ary5=ary2+ary4
        print(ary5)
        
        ary5.removeLast()
        
        for var i=0;i<ary5.count;i++ {
            print(ary5[i])
        }
        
        ary5 .removeFirst(4)

        
        print("--------------------")
        
        for  a in ary5{
            print(a)
        }
        
         print("--------------------")
        
        
        ary5.insert("qqq", atIndex: 0)
        for (idx,val) in ary5.enumerate(){
            print("idx=\(idx),val=\(val)")
        }
        
        var ary6:[NSObject]=[]
        ary6.append("qweqw")
        ary6.append(NSValue(CGPoint: CGPointMake(6, 8)))
        print(ary6)

        
        
    }
    
    
    
    
    //string
    func demo04(){
        let str="rwr我恩荣"
        for c in str.characters{
            print(c)
        }
        print(str.characters.count)
        print(str.utf8.count)
        print(str.lengthOfBytesUsingEncoding(4))
        
        let res1="字符"+str+"的长度＝"+String(str.characters.count)
        print(res1)
        let res2="字符\(str)的长度＝\(String(str.characters.count))"
        print(res2)
        
        print(String(format: "%02d:%02d:%02d", 1,2,3))
        print(String(format: "%02d:%02d:%02d",arguments:[1,2,3]))
        let str2="abcdef"
        
        //substr
        print(str2.substringFromIndex("ab".endIndex))
         print(str2.substringToIndex(str2.endIndex.advancedBy(-2)))
         print(str2.substringWithRange("ab".endIndex..<str2.endIndex.advancedBy(-2)))
        print((str2 as NSString).substringWithRange(NSMakeRange(2, 3)))
        
        
        //str's copy
        let a="100"
        var b=a
        print(String(format: "%p--%p", a,b))
        print(String(format: "%p--%p", a,b))
        print(String(format: "%p--%p", a,b))
        b .appendContentsOf("123")
        print(a,b,String(format: "%p--%p", a,b))
    }
    
    
    //loop
    func demo03(){
        for (var i=0;i<10;i++){
            print(i)
        }
        
        for  i in 10..<19{
            print(i)
        }
        for _ in 0...9{
            print("oo")
        }
        
        
        //while
        var i=0
        while i++ < 10 {
            print("qq")
        }
        
        //do while
        repeat {
            print("repeat")
        }while i<10
        
    }
    
    //switch
    func demo02(){
        var str="aa";
        switch str{
            case "a":
                print("\(str)")
            case "b":
                print("\(str)")
            case "c":
                print("\(str)")
            case "d":
                print("\(str)")
            default:
                print("other")
                break;
        }
        
        var val=90
        switch val{
            case let v where v>90:
                print("AAA")
            case let v where v>80:
                print("BBB")
            case let v where v>70:
                print("CCC")
            case let v where v>60:
                print("DDD")
            default :
                print("EEE")

        }
        
    }
    
    
    //if let and guard let
    func demo01(){
        let a:NSString?="111",b:Int?=22
        if let al=a,var bl=b{
            print("\(al),\(bl)");
        }
        
        
        var ab:NSString?
        ab="123"
        guard let abl=ab else{
            print("nil")
            return
        }
        print("\(abl)")

    }
}

