

//
//  Exes.swift
//  day42-swiftbeginning
//
//  Created by apple on 15/12/3.
//  Copyright © 2015年 yf. All rights reserved.
//

import UIKit

class Exes: NSObject {

}

extension UIView{
    func x()->CGFloat{
        return frame.origin.x
    }
    func y()->CGFloat{
        return frame.origin.y
    }
    func r()->CGFloat{
        return frame.origin.x+frame.width
    }
    func b()->CGFloat{
        return frame.origin.y+frame.height
    }
    
    func x(x:CGFloat){
        frame.origin.x=x
    }
    func y(y:CGFloat){
        frame.origin.y=y
    }
    func r(r:CGFloat){
        frame.origin.x=r-frame.width
    }
    func b(b:CGFloat){
        frame.origin.y=b-frame.height
    }
    
    func x2(x:CGFloat){
        frame.size.width += frame.origin.x-x
        frame.origin.x=x
    }
    func y2(y:CGFloat){
        frame.size.height += frame.origin.y-y
        frame.origin.y=y
    }
    func r2(r:CGFloat){
        frame.size.width=r-frame.origin.x
    }
    func b2(b:CGFloat){
        frame.size.height=b-frame.origin.y
    }
    
    func w()->CGFloat{
        return frame.width
    }
    func h()->CGFloat{
        return frame.height
    }
    
    func w(w:CGFloat){
        frame.size.width=w
    }
    func h(h:CGFloat){
        frame.size.height=h
    }
    func cx()->CGFloat{
        return center.x
    }
    func cy()->CGFloat{
        return center.y
    }
    func cx(cx:CGFloat){
        center.x=cx
    }
    func cy(cy:CGFloat){
        center.y=cy
    }
    
    func ic()->CGPoint{
        return CGPoint(x: w() * 0.5, y: h() * 0.5)
    }
    
    func icx()->CGFloat{
        return w()*0.5
    }
    func icy()->CGFloat{
        return h()*0.5
    }
    
    func size()->CGSize{
        return frame.size
    }
    
    func size(size:CGSize){
        frame.size=size
    }
    
    func ori()->CGPoint{
        return frame.origin
    }
    
    func ori(ori:CGPoint){
        frame.origin=ori
    }
}





extension String{
    func len()->Int{
        return characters.count
    }
}



extension UIColor{
    
    class func randColor()->UIColor{
        return UIColor(red: randF(255.0), green: randF(255.0), blue: randF(255.0), alpha: 1)
    }
   class  func randF(base:CGFloat )->CGFloat{
        return CGFloat(random()%(Int(base)+1))/base
    }
   class  func rand(base:Int)->Int{
        return random()%(base+1)
    }
}






