

//
//  img+ext.swift
//  day-43-microblog
//
//  Created by apple on 15/12/5.
//  Copyright © 2015年 yf. All rights reserved.
//

import UIKit

extension UIImage{
    func stretch()->UIImage{
        let v=size.height*0.5,
            h=size.width*0.5
       return  resizableImageWithCapInsets(UIEdgeInsets(top: v, left: h, bottom: v, right: h), resizingMode: UIImageResizingMode.Stretch)
    }
}