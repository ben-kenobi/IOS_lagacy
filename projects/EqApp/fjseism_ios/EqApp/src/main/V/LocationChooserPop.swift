//
//  LocationChooserPop.swift
//  EqApp
//
//  Created by apple on 16/9/6.
//  Copyright © 2016年 apple. All rights reserved.
//

import Foundation
class LocationChooserPop:CommonDialog{
    let lineh:CGFloat = 70
    
    
    
    
    required init(frame: CGRect) {
        super.init(frame: frame)
        midContent.snp_updateConstraints { (make) in
            make.height.equalTo(lineh*3+30)
        }
        initUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    class func locationChooserPopWith(title:String,btns:[String],cb:((pos:Int,dialog:CommonDialog)->Bool)?)->Self{
        let pop = dialogWith()
        pop.bgcolor = iColor(0x88000000)
        pop.dismissOnTouchOutside = false
        pop.titleLab.backgroundColor=iColor(0xffffffff)
        pop.midContent.backgroundColor=iColor(0xffffffff)
        
        pop.titleLab.text=title
        pop.btns=btns
        pop.cb=cb
        
        return pop
    }
    
    var drops:[UIButton] = []
    var dropVs:[ComListAdap] = []
    
    var selpos:Int = 0
    var onItemSelCB:((d:ComListAdap,pos:Int)->Void)?=nil
    
    
    func getSelItem()->LocationInfo{
        return dropVs[2].datas![selpos] as! LocationInfo
    }
    
    func initUI(){
        onItemSelCB={
            (d,pos) in
            let li=d.datas![pos] as! LocationInfo
            self.drops[d.tag].setTitle((li).REGION_NAME, forState: UIControlState.Normal)
            if d==self.dropVs[0]{
                let par:LocationInfo? = self.dropVs[0].datas![pos] as? LocationInfo
                self.dropVs[1].datas=LocationInfoService.ins.findByParent(par)
                self.onItemSelCB?(d:self.dropVs[1],pos:0)
            }else if d == self.dropVs[1]{
                let par:LocationInfo? = self.dropVs[1].datas![pos] as? LocationInfo
                self.dropVs[2].datas=LocationInfoService.ins.findByParent(par)
                self.onItemSelCB?(d:self.dropVs[2],pos:0)

            }else if d == self.dropVs[2]{
                self.selpos=pos
            }
            
        }
        let getView:((d:ComListAdap,pos:Int)->UITableViewCell)={
            (d,pos) in
            let cell = (d.tv.dequeueReusableCellWithIdentifier("celliden") as? ListPopCell) ?? ListPopCell()
            cell.scrolLab.text=(d.datas![pos] as! LocationInfo).REGION_NAME
            return cell
        }
        
        let titles:[String]=["市: ","县: ","乡/镇: "]
        let titlew:CGFloat = 80
        for i in 0..<titles.count{
            let lab = UILabel(frame: CGRectMake(0, lineh*CGFloat(i)+10, titlew, lineh), txt: titles[i], color: iColor(0xff000000), font: iFont(17), align: .Right, line: 1)
            midContent.addSubview(lab)
            let btn = ComUI.dropBtn("", tar: self, sel: #selector(self.onSel(_:)), tag: i)
            midContent.addSubview(btn)
            btn.frame=CGRectMake(lab.r+12,  lineh*CGFloat(i)+13+10, 200, lineh-26)
            
            drops.append(btn)
          
            let lv = ComListAdap.comListAdapWith(nil, w: 200,tag:i, cb:onItemSelCB , getv: getView)
            lv.scale=false
            dropVs.append(lv)
        }
        dropVs[0].datas=LocationInfoService.ins.findByParent(nil)
        onItemSelCB?(d:dropVs[0],pos:0)

        
    }
    
    func onSel(b:UIButton){
        dropVs[b.tag].show(basev:self,anchor: drops[b.tag])
    }
    
    
    
}