//
//  LevelChooseVC.swift
//  EqApp
//
//  Created by apple on 16/9/12.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit

class LevelChooseVC: BaseVC {
    
    lazy var datas:[String]={
        var datas:[String] = []
        for i in 1...12{
            datas.append(String(format: "description_%02d", i))
        }
        return datas
        
    }()
    var cb:((idx:Int)->())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title="烈度选择"
        let sv = UIScrollView(frame:CGRectMake(0, 0, iScrW, iScrH-iTopBarH))
        view.addSubview(sv)
        
        
        let contentV=UIView()
        let titleiv = UIImageView(image: iimg("description_00"))
        contentV.addSubview(titleiv)
        sv.addSubview(contentV)
        contentV.frame=CGRectMake(0, 0, titleiv.w, sv.h)
        
        sv.contentSize=CGSizeMake(titleiv.w, 0)
        sv.bounces=false
        
        
        let sv2 = UIScrollView(frame:CGRectMake(0, titleiv.b, titleiv.w, sv.h-titleiv.b))
        contentV.addSubview(sv2)
        sv2.bounces=false
        var ivs:[UIButton]=[]
        for (idx,str) in datas.enumerate(){
            ivs.append(UIButton(img: iimg(str),tar:self,action:#selector(self.onClick(_:)),tag:idx))
            
            sv2.addSubview(ivs[idx])
            
            if idx>0{
                ivs[idx].y=ivs[idx-1].b
                let line = UIView()
                sv2.addSubview(line)
                line.frame=CGRectMake(0, ivs[idx].y,titleiv.w , 1)
                line.backgroundColor=iColor(0xff888888)
            }
            if idx==5{
                ivs[idx].x=1
            }
            if(idx == 6){
                ivs[idx].x = -1
                
            }
            if(idx == 10){
                ivs[idx].x = -2
                
            }
        }
        sv2.contentSize=CGSizeMake(0, ivs[ivs.count-1].b)
        
        
        
        
    }
    
    func onClick(sender:UIButton){
        navigationController?.popViewControllerAnimated(true)
        cb?(idx:
            sender.tag)
    }
}