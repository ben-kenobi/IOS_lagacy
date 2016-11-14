//
//  EditSceneVC.swift
//  EqApp
//
//  Created by apple on 16/9/7.
//  Copyright © 2016年 apple. All rights reserved.
//

import Foundation
class EditSceneVC:BaseVC{
    var flag:Int = 0 // 1: new scene
    var curscene:Tscene?
    var usesrc:UISwitch?
    var addlab:UILabel?
    var timeLab:UILabel?

    var eqidenlab:UILabel?
    var levelbtn:UIButton?
    var descbtn:UIButton?
    var detailTv:AutoHeightTextView?
    var eqinfos:[EQInfo]?
    var eqinfoidx:Int=0
    
    
    lazy var gv:PicPickerCV={
        return  PicPickerCV(curscene:self.curscene!)
    }()
    var levelidx:Int = 0{
        didSet{
            levelbtn?.setTitle(iConst.eqlevel[levelidx], forState: .Normal)

        }
    }
    var summaryIdx:Int = 0{
        didSet{
            descbtn?.setTitle(iConst.eqsummary[summaryIdx], forState: .Normal) 
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "信息采集"
        initUI()
        
        detailTv?.text=curscene?.detail
        timeLab?.text=iConst.TIMESDF.stringFromDate(curscene!.addtime)
        addlab?.text=String(format: "%.2f",curscene!.loc_lon) + " , " + String(format: "%.2f", curscene!.loc_lat)
        
        
        levelbtn?.setTitle(iConst.eqlevel[levelidx], forState: .Normal)
        descbtn?.setTitle(iConst.eqsummary[summaryIdx], forState: .Normal)
 
        let eqinfo = PrefUtil.getEQInfo2()
        if let eqinfo = eqinfo {
            eqidenlab?.text = eqinfo.description
        }else{
           eqidenlab?.text=""
        }
        gv.vc=self
        updateUI()
        summaryIdx=curscene!.summaryidx
        levelidx=curscene!.eqlevelidx
        if curscene?.flag != 0{
            eqidenlab?.text = curscene?.event_id
        }
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    }
    
}


extension EditSceneVC{
    func onClick(sender:UIButton){
        if sender == navigationItem.rightBarButtonItem?.customView{
            onSubmit()
        }else if sender == levelbtn{
            showLevels(sender)
        }else if sender == descbtn{
            showSummaries(sender)
        }else if sender.tag==1{
            toggleLvDialog()
        }else if sender.tag == 2{
            createNshowDensityDescription()

        }else if sender.tag == 3{
            gv.selectPic()
        }else if sender.tag == 4{
            
            gv.startCamera()
        }else if sender.tag == 5{
            
            gv.startVideo()
        }
    }
    
    
    
   
}
