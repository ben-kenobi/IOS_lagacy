//
//  MainVCEx.swift
//  EqApp
//
//  Created by apple on 16/9/1.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit
extension MainVC{
    func  initNshowGroupOption(v:UIView) {
        let pickerOptions:[String]=["待提交数据","历史采集数据"
            ,"历史地震","灾情简报","辅助决策报告","防震手册","应急预案","系统设置"]
        let pickerOptionIcons:[String]=["forsubmit",
            "datas","eathquakehis","evaluate","dicision",
            "dicision","dicision",
            "settings"]
        let pop = ListPop.listPopWith(pickerOptions,w:190,cb:{
            [weak self](str,pos)->()  in
            guard let se = self else{
                return
            }
            if pos == 0 {
                let vc = PendingSubmissionVC()
                se.presentViewController(MainNavVC(rootViewController: vc), animated: true, completion: nil)
            }else if pos==1 {
                let vc = SubmissionHisVC()
                se.presentViewController(MainNavVC(rootViewController: vc), animated: true, completion: nil)
            }else if  pos==2{
                let vc = EQHisVC()
                se.presentViewController(MainNavVC(rootViewController: vc), animated: true, completion: nil)
                vc.cb = {
                  () in
                    se.locateEq()
                    se.showEarthquakePop(se.btns[0])
                    
                }
            }else if  pos==3 {
               let vc = FilePostVC(nibName: nil, bundle: nil)
                vc.type=0
                vc.title="灾情简报"
                se.presentViewController(MainNavVC(rootViewController: vc), animated: true, completion: nil)
              
            }else if pos == 4{
                let vc = FilePostVC(nibName: nil, bundle: nil)
                vc.type=1
                vc.title="辅助决策报告"
                se.presentViewController(MainNavVC(rootViewController:vc), animated: true, completion: nil)
            }else if pos == 5 {
                let vc = LocslWebVC()
                vc.path = iRes("fzsc.html")
                vc.title=str
                se.presentViewController(MainNavVC(rootViewController: vc), animated: true, completion: nil)
            }else if pos == 6{
                let vc = EmerPrescripVC()
                vc.title=str
                se.presentViewController(MainNavVC(rootViewController: vc), animated: true, completion: nil)
            }else if pos == 7{
                let vc = SettingVC()
                se.presentViewController(MainNavVC(rootViewController: vc), animated: true, completion: nil)
            }
        })
        pop.defH=55
        pop.icons=pickerOptionIcons
        pop.show(self,anchor:v)
        
    }
    func showEarthquakeDistributionPop(v:UIView){
        let pickerOptions:[String]=StaticMod.wmslayertitles
        let pickerOptionIcons:[String]=StaticMod.wmslayericons
        let pop = MainPop1.mainPop1With(pickerOptions,w:210,cb:{
            (str,pos)->()  in
           
            self.loadWmsAt(pos,title: str)
           
        })
        pop.selIdx=selLayerIdx
        pop.defH=50
        pop.iconH=28
        pop.tv.separatorStyle = .SingleLine
        pop.tv.separatorInset = UIEdgeInsets(top: 0, left: 48, bottom: 0, right: 12)
        pop.icons=pickerOptionIcons
        pop.show(self,anchor:v)
    }
    
    func showEarthquakePop(sender:UIView){
      
        let pop = EQInfoPop.eqInfoPopWith { (str, pos) in
            self.locateEq()
        }
        pop.show(self,anchor:sender)
    }

    
    
    func showControlflowPop(sender:UIView) {
        
        if controlflowPop == nil{
            let controlflows:[String]=MapMod.controlflows
            let controlflowsIconsHL:[String]=["school_s","hospital_s","evacuation_s"]
            let controlflowsIcons:[String]=["school","hospital","evacuation"]
            controlflowPop = ControlflowPop.controlflowPopWith(controlflows, imgs: controlflowsIcons, hlimgs: controlflowsIconsHL) { [weak self] (str, pos,sel) in
                guard let se = self else{
                    return
                }
                if (se.layerMap[str] != nil) {
                    se.mapV.removeMapLayer(se.layerMap[str])
                    se.layerMap.removeValueForKey(str)
                } else {
                    let tuple = se.getShapefileInfo(controlflows[pos])
                    if let layer = se.addDeathThematicLayer(tuple){
                        se.layerMap[str] = layer
                    }
                }
                
            }
        }
       
        controlflowPop?.show(self,anchor:sender)

    }
    
    func initNshowLocationChooser(sender:UIView){
        if mLocationChooserPop == nil{
            mLocationChooserPop=LocationChooserPop.locationChooserPopWith("手动选择位置", btns: ["取消","确定"], cb: { (pos, dialog) -> Bool in
                if pos == 1{
                    let li:LocationInfo = (dialog as! LocationChooserPop).getSelItem()
                    self.curLoc=EQLocation(latitude: li.LAT, longitude: li.LON, type: "manualprovider")
                    
                    print(li.description)
                    self.mapV.zoomToScale(288571.86822143558, withCenterPoint: self.curLoc!.toAGSPo(), animated: true)
                }
                return true
          })
        }
        
        mLocationChooserPop?.show(self)
    }

    
    
}
