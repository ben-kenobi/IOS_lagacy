//
//  EditSceneEvent.swift
//  EqApp
//
//  Created by apple on 16/9/8.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit
extension EditSceneVC{
    func showLevels(sender:UIButton){
        let lv = ComListAdap.comListAdapWith(iConst.eqlevel,  w: sender.w, tag: 0, cb: { (d, pos) in
            
            //            let li=d.datas![pos] as! String
            //            sender.setTitle((li), forState: UIControlState.Normal)
            self.levelidx=pos
            }, getv: { (d, pos) -> UITableViewCell in
                let cell = (d.tv.dequeueReusableCellWithIdentifier("celliden") as? TwoLinePopCell) ?? TwoLinePopCell(style: UITableViewCellStyle.Default, reuseIdentifier: "celliden")
                cell.lab.text=(d.datas![pos] as! String)
                return cell
        })
        lv.scale=false
        if empty(sender.titleForState(.Normal)){
            lv.onItemSelCB?(d: lv,pos: 0)
        }
        lv.show(basev:view,anchor: sender)
    }
    func showSummaries(sender:UIButton){
        let lv = ComListAdap.comListAdapWith(iConst.eqsummary,  w: sender.w, tag: 0, cb: { (d, pos) in
            
            //            let li=d.datas![pos] as! String
            //            sender.setTitle((li), forState: UIControlState.Normal)
            self.summaryIdx=pos
            }, getv: { (d, pos) -> UITableViewCell in
                let cell = (d.tv.dequeueReusableCellWithIdentifier("celliden") as? TwoLinePopCell) ?? TwoLinePopCell()
                cell.lab.text=(d.datas![pos] as! String)
                return cell
        })
        lv.scale=false
        if empty(sender.titleForState(.Normal)){
            lv.onItemSelCB?(d: lv,pos: 0)
        }
        lv.show(basev:view,anchor: sender)
    }
    
    
    func onSubmit(){
        let uc = UIAlertController(title: "提示", message: "直接提交或保存", preferredStyle: UIAlertControllerStyle.Alert)
        uc.addAction(UIAlertAction(title: "保存", style: UIAlertActionStyle.Cancel, handler: {(ua) in
            self.save()
            (self.navigationController as? MainNavVC)?.back()
        }))
        uc.addAction(UIAlertAction(title: "提交", style: UIAlertActionStyle.Default, handler: { (ua) in
            
            if ("-1" == (self.curscene!.event_id) ||  "0"==(self.curscene!.event_id)) {
                iPop.toast("无对应地震信息，请先保存")
                return;
            }
            self.save()
//            self.upload2()
            self.upload2_new()
            
        }))
        presentViewController(uc, animated: true, completion: nil)
        
    }
    
    
    
    func save(){
        curscene!.eqlevelidx = levelidx
        curscene!.summaryidx = summaryIdx
        curscene!.detail = detailTv?.text
        curscene!.insertOrUpdate()
    }
    
    func upload2(){
        iPop.showProg()
        dispatch_async(dispatch_get_main_queue()) {
            let tp = TsceneProg()
            tp._id=self.curscene!._id
            tp.compressing = true
            tp.describe="正在压缩。。。"
            UserInfo.uploadingMap[tp._id]=tp
            var uploadDatas:[String:NSData]  = [String:NSData]()
            for path in self.curscene!.fpaths{
                uploadDatas[(path as NSString).lastPathComponent] = self.convertImg(path)
            }
            self.doupload2(uploadDatas, tp: tp)
            
        }
        
    }
    func doupload2(datas:[String:NSData],tp:TsceneProg){
        if !NetUtil.netWorkAvailable(){
            tp.state = 2
            tp.describe = "网络不可用，请重新上传。。。"
            return
        }
        
        let name = UserInfo.me.token
        
        var map1 = [String:String]()
        map1["intensityLevel"] = "\(levelidx)"
        map1["shortDescription"] = descbtn?.titleForState(.Normal)
        map1["detailsDescription"] =  curscene!.detail
        map1["lon"] = "\(curscene!.loc_lon)"
        map1["lat"] = "\(curscene!.loc_lat)"
        map1["createtime"] = iConst.TIMESDF.stringFromDate(curscene!.addtime)
        map1["seismNo"] = curscene!.event_id
        
        let path = iConst.uploadUrl + "?token=" + name!
        
        NetUtil.commonRequest6(tp, path: path, mapo: map1, files: datas) { (data, idx) in
            
            if idx == 0{
                tp.state = 1
                tp.describe = "上传成功!"
                self.afterUpload()
                iPop.toast("上传成功")
            }else{
                tp.state=2
                tp.describe="上传失败，请重新上传。。。"
                
            }
            
        }
        
    }
    
    func upload2_new(){
        let tp = TsceneProg()
        tp._id=self.curscene!._id
        tp.compressing = true
        tp.describe="正在压缩。。。"
        UserInfo.uploadingMap[tp._id]=tp
        
        dispatch_async(dispatch_get_main_queue()) {
            var uploaFiles:[String:String]  = [String:String]()
            for path in self.curscene!.fpaths{
                uploaFiles[(path as NSString).lastPathComponent] = self.convertImgPath(path)
            }
            
            self.doupload2_new(uploaFiles, tp: tp)
            
        }
        
        
        MainVC.flag=flag
        
        (self.navigationController as? MainNavVC)?.back()
        
    }
    
    func doupload2_new(datas:[String:String],tp:TsceneProg){
        if !NetUtil.netWorkAvailable(){
            tp.state = 2
            tp.describe = "网络不可用，请重新上传。。。"
            return
        }
        
        let name = UserInfo.me.token
        
        var map1 = [String:String]()
        map1["intensityLevel"] = "\(levelidx)"
        map1["shortDescription"] = descbtn?.titleForState(.Normal)
        map1["detailsDescription"] =  curscene!.detail
        map1["lon"] = "\(curscene!.loc_lon)"
        map1["lat"] = "\(curscene!.loc_lat)"
        map1["createtime"] = iConst.TIMESDF.stringFromDate(curscene!.addtime)
        map1["seismNo"] = curscene!.event_id
        
        let path = iConst.uploadUrl + "?token=" + name!
        
        NetUtil.request4Upload(tp, path: path, para: map1, files: datas) { (data, idx) in
            
            if idx == 0{
                tp.describe = "上传成功!"
                tp.state = 1
                self.curscene?.uploaded(self.usesrc!.on)
                
            }else{
                tp.describe="上传失败，请重新上传。。。"
                tp.state=2
            }
            
        }
        
    }
    
    func  afterUpload() {
        curscene?.uploaded(usesrc!.on)
        (self.navigationController as? MainNavVC)?.back()
        
    }
    
    func convertImg(path:String)->NSData{
        if self.usesrc!.on ||  path.hasSuffix("mp4"){
            return iData4F(path)!
        }
        return UIImagePNGRepresentation(imgFromData4F(path)!.scale2w(1000))!
    }
    
    func convertImgPath(path:String)->String{
        if self.usesrc!.on || path.hasSuffix("mp4"){
            return path
        }
        let smlpath = (iConst.SMALLFILEPREFIX+(path as NSString).lastPathComponent).strByAp2Doc()
        try! UIImagePNGRepresentation(imgFromData4F(path)!.scale2w(1000))?.writeToFile(smlpath, options: NSDataWritingOptions.AtomicWrite)
        return smlpath
    }
    
    
    func createNshowDensityDescription(){
        let vc = LevelChooseVC()
        vc.cb = {(idx) in
            self.levelidx=idx
        }
        
        self.navigationController?.showViewController(vc, sender: nil)
    }
    func toggleLvDialog(){
        
        if let infos = eqinfos{
            let lv = ComListAdap.comListAdapWith(infos,  title:"手动选择地震",w: iScrW-40, tag: 0, cb: { (d, pos) in
                self.eqinfoidx = pos
                self.eqidenlab?.text=self.eqinfos![pos].description
                self.curscene?.event_id="\(infos[pos].obsTime)"
                }, getv: { (d, pos) -> UITableViewCell in
                    let cell = (d.tv.dequeueReusableCellWithIdentifier("celliden") as? TwoLinePopCell) ?? TwoLinePopCell()
                    cell.lab.text=(self.eqinfos![pos].description)
                    cell.selected = pos==self.eqinfoidx
                    return cell
            })
            lv.tv.separatorStyle = .SingleLine
            lv.show()
        }else{
            let path:String = iConst.eqHisUrl + ""
            eqinfos=[]
            NetUtil.commonRequestJson(true, path: path, para: nil, succode: ["200"],cb:{ (data, idx) in
                if idx != 0 {return}
                let list = (data as! [String:AnyObject])["data"] as! [[String:AnyObject]]
                
                for dict in list{
                    let eq = EQInfo(dict: dict)
                    eq.hasLayer=true
                    self.eqinfos!.append(eq)
                }
                self.toggleLvDialog()
            })
            
        }
        
        
    }
}


class TwoLinePopCell:UITableViewCell{
    lazy var lab:UILabel = {
        let lab = UILabel(frame: nil, txt: "", color: iColor(0xff000000), font: iFont(14), align: NSTextAlignment.Left, line: 2, bgColor: UIColor.whiteColor())
        self.contentView.addSubview(lab)
        lab.snp_makeConstraints(closure: { (make) in
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.top.bottom.equalTo(0)
        })
        return lab
        
    }()
    override var selected: Bool{
        didSet{
            if selected{
                lab.textColor=iColor(0xff5555ee)
            }else{
                lab.textColor=iColor(0xff000000)
            }
        }
    }
    
    
}
