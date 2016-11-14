//
//  AccountItemCell.swift
//  am
//
//  Created by apple on 16/5/24.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit

class AccountItemCell: CommonListItemCell {
    let siteAtt  = [NSForegroundColorAttributeName:iColor(38,146,42),NSFontAttributeName:ibFont(19)]
    let titleAtt  = [NSForegroundColorAttributeName:iConst.orgTitCol,NSFontAttributeName:ibFont(18)]
    let otherAtt  = [NSForegroundColorAttributeName:iColor(0xff444444),NSFontAttributeName:ibFont(17)]
    let showCols:[String] = [AccountColumns.SITENAME,
                             AccountColumns.MAILBOX,
        AccountColumns.USERNAME,
        AccountColumns.PASSWORD,
        AccountColumns.GROUP,
        AccountColumns.PASSPORT,
        AccountColumns.PHONENUM
]
  
    var showContent:NSMutableAttributedString?{
        get{
            if let mod = mod{
                let show = NSMutableAttributedString(string:showCols[0] + ": ")
                 show.addAttributes(titleAtt, range: NSMakeRange(0, show.length))
                var sub = NSAttributedString(string: "\(mod[showCols[0]]!)\n",attributes:siteAtt)
                
                show.appendAttributedString(sub)
                for (i,colname) in showCols.enumerate(){
                    if i != 0{
                        let val = "\(mod[colname]!)"
                        if !isBlank(val){
                             sub = NSAttributedString(string: colname+": ",attributes:titleAtt)
                            show.appendAttributedString(sub)

                            sub = NSAttributedString(string: "\(mod[colname]!)\n",attributes:otherAtt)
                            show.appendAttributedString(sub)

                        }
                    }
                }
                
                
               
                 show.deleteCharactersInRange(NSMakeRange(show.length-1, 1))
                return show
                
            }
            return nil
        }
    }
    
    
}

extension AccountItemCell{
    
    override func updateUI(){
        textLab.attributedText=showContent
        
    }
    
        
}

