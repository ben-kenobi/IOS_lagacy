

//
//  img+ext.swift
//  day-43-microblog
//
//  Created by apple on 15/12/5.
//  Copyright © 2015年 yf. All rights reserved.
//

import UIKit



extension UIImage{
    
    
    var h:CGFloat{
        return size.height
    }
    var w:CGFloat{
        return size.width
    }
    
    func stretch()->UIImage{
        let v=size.height*0.5,
            h=size.width*0.5
       return  resizableImageWithCapInsets(UIEdgeInsets(top: v, left: h, bottom: v, right: h), resizingMode: UIImageResizingMode.Stretch)
    }

    func roundImg(w:CGFloat=0,boderColor:UIColor?=nil,borderW:CGFloat=0)->UIImage{
        let w2=(h>self.w ? self.w : h)
        let r = w == 0 ? w2 : w
        let scale = r/w2
        let rad=r*0.5+borderW
        
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(rad*2, rad*2), false, 0)
        let con:CGContextRef=UIGraphicsGetCurrentContext()!
        if borderW>0{
            CGContextAddArc(con,rad,rad,rad,0, CGFloat(2 * M_PI),0)
            boderColor?.setFill()
            CGContextDrawPath(con, CGPathDrawingMode.Fill)
        }
        
        CGContextAddArc(con, rad, rad, r*0.5, 0, CGFloat(2 * M_PI), 0)
        CGContextClip(con)
        drawInRect(CGRect(x:r-scale*self.w+borderW, y: r-scale*self.h+borderW, width: scale*self.w, height: scale*h))
        
        let img=UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img
        
    }
    
    func scale2w(pixel:CGFloat)->UIImage{
        let size = CGSizeMake(pixel, pixel/w*h)
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        
        drawInRect(CGRectMake(0, 0, size.width, size.height))
        let img=UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img
    }
    
    
   class func launchImg()->UIImage?{
        let dict=iBundle.infoDictionary
        guard let images = dict!["UILaunchImages"] as? [[String:AnyObject]] else{
            return nil
        }
        let scrsize=iScr.bounds.size
        for subdict in images {
            let size=CGSizeFromString(subdict["UILaunchImageSize"] as! String)
            if CGSizeEqualToSize(size, scrsize) {
                return iimg(subdict["UILaunchImageName"] as! String)
            }
        }
        
        return nil
    }

    
    
    class func imgFromLayer(layer:CALayer)->UIImage{
        UIGraphicsBeginImageContextWithOptions(layer.size, false, 0)
        layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let img:UIImage=UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img
    }

    
    class func imgFromView(view:UIView)->UIImage{
        UIGraphicsBeginImageContextWithOptions(view.size, false, 0)
        view.drawViewHierarchyInRect(view.bounds, afterScreenUpdates: false)
        let img:UIImage=UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img
    }
}


extension UIImageView{
    convenience init(frame:CGRect?=nil,img:UIImage?,radi:CGFloat=0,borderColor:UIColor?=nil,borderW:CGFloat=0){
        self.init(image:img)
        if let frame=frame{
            self.frame=frame
        }
        layer.cornerRadius=radi
        layer.masksToBounds=radi>0
        if let color=borderColor{
            layer.borderColor=color.CGColor
            layer.borderWidth=borderWidth
        }
        
    }
}