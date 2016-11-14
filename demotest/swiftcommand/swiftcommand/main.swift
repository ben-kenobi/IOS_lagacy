//
//  main.swift
//  swiftcommand
//
//  Created by apple on 16/10/20.
//  Copyright © 2016年 apple. All rights reserved.
//

import Foundation
import Accelerate



func func1(){
    print("Hello, World!")
}
func func2(){
    let po1:UnsafeMutablePointer<UInt8>=UnsafeMutablePointer<UInt8>.allocate(capacity: 10)
    po1.initialize(to: 255,count:10)
    
    
    var po2:UnsafePointer<Int8>?=nil
    po2=unsafeBitCast(po1, to: UnsafePointer<Int8>.self)
    for i in 0...9{
        let v:UInt8 = po1[i]
        print(v)
    }

    for i in 0...9{
        let v:Int8 = po2![i]
        print(v)
    }
    po1.deinitialize()
    po1.deallocate(capacity: 10)
    
    var a:Int = 100
    let b = withUnsafePointer(to: &a) { (po) -> Int in
        let mpo = UnsafeMutablePointer<Int>(mutating: po)
        mpo[0] += 2
        return 1
    }
    print(a,b)
    
  

    
}

func func3(){
    var ary:[Int] = [100,101,102]
    var ary1:[Float] = [10,20,30]

    var ary2:[Float] = [1.31,2.31,3.31]
    let bp = UnsafeMutableBufferPointer<Int>(start: &ary, count: ary.count)
    var mp = bp.baseAddress
    ary[0]=104

    let b = bp[0]
    print(b)
    bp[0] = 111
    print(ary[0])
    
    ary[1]+=2
    print(mp![1])
    mp![1] += 44
    print(ary[1])
    
    mp=mp!.advanced(by: 2)
    print(mp!.distance(to: bp.baseAddress!))
    print(mp![0])
    
    var ary3:[Float]=[0,0,0]
    
    
    vDSP_vadd(ary1, 1, ary2, 1, &ary3, 1, 3 )
    let bp2 = UnsafeMutableBufferPointer<Float>(start:&ary3,count:ary3.count)
    
    for i in 0...2{
        print(bp2[i])
    }
}
func func4(){
    let str = "/usr/aa/dd.txt"
    let str2 = (str as NSString).deletingLastPathComponent
    let str3 = (str2 as NSString).deletingLastPathComponent
    let str4 = (str3 as NSString).deletingLastPathComponent
    let str5 = (str4 as NSString).deletingLastPathComponent
    print(str2,str3,str4,str5)

}
 func fileSizeAtPath(path:String)->Int64{
    let iFm = FileManager.default
    var b:ObjCBool=false
    if(iFm.fileExists(atPath: path,isDirectory:&b)){
        if(!b.boolValue){
            return (try! iFm.attributesOfItem(atPath: path)[FileAttributeKey.size] as! NSNumber).int64Value
        }else{
            var size:Int64=0
            
            let subpaths:[String] = iFm.subpaths(atPath: path) ?? []
            for file in subpaths{
                let path = (path as NSString).appendingPathComponent(file)
                if iFm.fileExists(atPath: path, isDirectory: &b) && !b.boolValue{
                    size += (try! iFm.attributesOfItem(atPath:path)[FileAttributeKey.size] as! NSNumber).int64Value
                }
                
            }
            return size;
        }
    }
    return 0;
}



func func5(_ num:Int64){
    let str1 = "9.0.1.2",str2="18.0"
    let result = str1.compare(str2)
    print(result.rawValue)
    let result2=(str1 as NSString).compare(str2, options: NSString.CompareOptions.numeric)
    print(result2 == ComparisonResult.orderedAscending)
  
}
func func6(){
    
        var ip = "1231.123.12.dqwdq:90900" as NSString
        ip = ip.substring(to: ip.range(of: ":").location) as NSString
        print(ip)
    
}
func6()












