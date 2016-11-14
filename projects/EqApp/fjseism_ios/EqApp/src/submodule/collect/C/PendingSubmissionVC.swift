//
//  PendingSubmissionVC.swift
//  EqApp
//
//  Created by apple on 16/9/13.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit

class PendingSubmissionVC: UICollectionViewController {
    let celliden = "gridcelliden"
    let supcelliden = "gridsupcelliden"
    let footcelliden = "gridfootcelliden"


    var editMode:Bool = false
    var ondel:((idx:Int,del:Bool)->())?
    lazy var list:[Tscene] = {
        return SceneService.ins.findAllBy(UserInfo.me.NAME!,flag: "0")
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "待提交数据"
        view.backgroundColor=iColor(0xffffffff)
          ondel  = { [unowned self] (idx,del) in
            if !del{
                self.selectAt(idx)
                return
            }
            let avc = UIAlertController(title: "警告", message: "确定删除该条采集信息", preferredStyle: .Alert)
            avc.addAction(UIAlertAction(title: "确定", style: UIAlertActionStyle.Default, handler: { (ac) in
                self.deleteAt(idx);

            }))
            avc.addAction(UIAlertAction(title: "取消", style: .Default, handler: nil))
            self.presentViewController(avc, animated: true, completion: nil)
        }
    }
    func deleteAt(pos:Int){
        let ts = list.removeAtIndex(pos)
        collectionView!.reloadData()
        ts.delete()
    }
    
    init(){
        let w = min(iScrW, iScrH)
        let fl:UICollectionViewFlowLayout=UICollectionViewFlowLayout()
        fl.itemSize=CGSizeMake(w/4-2, w/4*1.1)
        fl.minimumInteritemSpacing=1
        fl.minimumLineSpacing=2
        fl.sectionInset=EdgeInsetsMake(2, left: 2, bottom: 2, right: 2)
  
        super.init(collectionViewLayout: fl)
        
        collectionView!.registerClass(PicPickerCVCell.self, forCellWithReuseIdentifier: self.celliden)
        collectionView!.registerClass(CVTwoLineSupV.self, forSupplementaryViewOfKind:UICollectionElementKindSectionHeader, withReuseIdentifier: supcelliden)
        collectionView!.registerClass(VCProgressFootV.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: footcelliden)
        collectionView!.backgroundColor=UIColor.clearColor()
        collectionView!.showsVerticalScrollIndicator=true
        collectionView!.bounces=false
        navigationItem.rightBarButtonItem=UIBarButtonItem(title:"编辑" , titleColor:iColor(0xff55aaff),tar: self, action: #selector(self.onClick(_:)))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func onClick(sender:UIButton){
        if sender == navigationItem.rightBarButtonItem?.customView{
            toggleEditMode()
            sender.setTitle(editMode ? "取消" : "编辑",forState: .Normal)

        }
    }
    
    
    func toggleEditMode(){
        editMode = !editMode
        collectionView?.reloadData()
    }
    func updateDatas(){
        for (idx,ts) in list.enumerate() {
            if(ts.flag != 0){
                list.removeAtIndex(idx)
            }
        }
        collectionView?.reloadData()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        updateDatas()
    }
}


extension PendingSubmissionVC:UICollectionViewDelegateFlowLayout{
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        collectionView.deselectItemAtIndexPath(indexPath, animated: true)
        selectAt(indexPath.section)
    }
    
    func selectAt(idx:Int){
        if !editMode && !isUploadAt(idx){
            let vc = EditSceneVC()
            vc.curscene=list[idx]

            presentViewController(MainNavVC(rootViewController: vc), animated: true, completion: nil)

        }
    }
    
    override func collectionView(collectionView: UICollectionView, didEndDisplayingCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        
    }
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return list.count
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return list[section].fpaths.count
        
    }
    override func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionElementKindSectionHeader{
            let sp=collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: supcelliden, forIndexPath: indexPath) as! CVTwoLineSupV
            sp.cb=self.ondel
            sp.title.text=list[indexPath.section].event_id
            sp.detail.text = iConst.TIMESDF.stringFromDate(list[indexPath.section].addtime)
            sp.del.hidden = !editMode
            sp.del.tag=indexPath.section
            sp.bgbtn.tag=indexPath.section

            return sp
        }else{
            let sp=collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: footcelliden, forIndexPath: indexPath) as! VCProgressFootV
          
            sp.tp=UserInfo.uploadingMap[list[indexPath.section]._id]
            sp.tag=indexPath.section
            sp.cb={
                [weak self] (idx,complete) in
                if let se = self{
                    if complete{
                        se.list.removeAtIndex(idx)
                        collectionView.deleteSections(NSIndexSet(index: idx))
                    }else{
                        collectionView.reloadSections(NSIndexSet(index: idx))
                    }
                }
            }
            return sp
        }
       
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell{
        
        let cell:PicPickerCVCell = collectionView.dequeueReusableCellWithReuseIdentifier(celliden, forIndexPath: indexPath) as! PicPickerCVCell
        let path = path4idx(indexPath)
        cell.videoflag.hidden = !path.hasSuffix(".mp4")
        if path.hasSuffix(".mp4"){
            UIImage.generateVideoImage(NSURL(fileURLWithPath: path), cb: { (img) in
                cell.icon.image=img
            })
        }else{
            cell.icon.sd_setImageWithURL(NSURL.fileURLWithPath(path), placeholderImage: iimg("loading_icon"))
        }
        
        return cell
    }
    
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSizeMake(collectionView.w,55)
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if isUploadAt(section){
            return CGSizeMake(collectionView.w, 44)
        }else{
            return CGSizeMake(collectionView.w, 0)

        }
    }
    
    
    func path4idx(idx:NSIndexPath)->String{
        return list[idx.section].fpaths[idx.row]
    }
    func isUploadAt(pos:Int)->Bool{
       let tp = UserInfo.uploadingMap[list[pos]._id]
        return tp !=  nil && tp!.state != 2
    }
 
}


class CVTwoLineSupV:UICollectionReusableView{
     var title:UILabel
     var detail:UILabel
    lazy var bgbtn:UIButton = UIButton(frame: self.bounds, tar: self, action: #selector(self.onClick(_:)), tag: 0)
    lazy var del:UIButton = ImgPaddingBtn(frame: CGRectMake(self.frame.maxX-self.frame.height-5, 0, self.frame.height, self.frame.height), img: iimg("deletered"), tar: self, action: #selector(self.onClick(_:)), tag: 0)
    
    var cb:((idx:Int,del:Bool)->())?
    
    override init(frame: CGRect) {
        title = UILabel(frame: CGRectMake(12, 6, frame.width, frame.height*0.5), txt: "title", color: iColor(0xff000000), font: ibFont(18), align: NSTextAlignment.Left, line: 1)
        detail = UILabel(frame: CGRectMake(12, title.b, frame.width, frame.height-title.b), txt: "detail", color: iColor(0xff444444), font: iFont(16), align: NSTextAlignment.Left, line: 1)
        super.init(frame: frame)

        addSubview(title)
        addSubview(detail)
        addSubview(bgbtn)
        addSubview(del)
        backgroundColor = iConst.iGlobalBG
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func onClick(sender:UIButton){
        cb?(idx:sender.tag,del:sender == del)
    }
}


class VCProgressFootV:UICollectionReusableView,UploadProgUpdater{
    
    var detail:UILabel
   
    lazy var cancelBtn:UIButton = UIButton(frame: nil,  title: "取消", font: iFont(15), titleColor: iColor(0xffffffff), titleHlColor: iColor(0xffff7777), bgcolor: iColor(0xffee4444), corner: 3, bordercolor: iColor(0xffaaaaaa), borderW: 1, tar: self, action: #selector(self.onClick(_:)), tag: 0)
    lazy var prog:ProgressV = ProgressV(frame: CGRectMake(0, 0, 0, 12), bg: iColor(0xffeeeeee), corner: 6, bordercolor: iColor(0xffee88aa), borderW: 2)
    var cb:((idx:Int,complete:Bool)->())?
    var _tp:TsceneProg?
    var tp:TsceneProg?{
        set{
            _tp?.cb=nil
            _tp=newValue
            _tp?.cb=self
            update()
        }
        get{
            return _tp
        }
    }
    override init(frame: CGRect) {

        detail = UILabel(frame: nil, txt: "", color: iColor(0xff444444), font: iFont(16), align: NSTextAlignment.Left, line: 1)
        super.init(frame: frame)
        
        
        addSubview(detail)
        addSubview(cancelBtn)
        addSubview(prog)
        backgroundColor = UIColor.whiteColor()
        cancelBtn.snp_makeConstraints { (make) in
            make.right.equalTo(-8)
            make.top.equalTo(6)
            make.bottom.equalTo(-6)
            make.width.equalTo(65)
        }
        detail.snp_makeConstraints { (make) in
            make.left.equalTo(8)
            make.right.equalTo(cancelBtn.snp_left).offset(-8)
            make.bottom.equalTo(-4)
            
        }
        prog.snp_makeConstraints { (make) in
            make.left.right.equalTo(detail)
            make.height.equalTo(12)
            make.top.equalTo(4)
        }
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func onClick(sender:UIButton){
        
        if let tp = tp{
            tp.uploadhandler?.cancel()
            tp.describe="取消上传"
            tp.state=2
            cb?(idx: self.tag,complete: false)
        }
    }
    
    func update() {
        if let tp = tp{
            if tp.compressing{
                prog.progress=0
                cancelBtn.hidden=true
                detail.text=tp.describe
                detail.textColor=iColor(0xff555555)
            }else if (tp.state == 2){
                prog.progress=0
                cancelBtn.hidden=true
                detail.text=tp.describe
                detail.textColor=iColor(0xffee5555)
            }else if tp.state==1{
                detail.textColor=iColor(0xff55ff55)
                prog.total=10
                prog.progress=10
                cancelBtn.hidden=true
                detail.text=tp.describe
                UserInfo.uploadingMap.removeValueForKey(tp._id)
                // rm  scene
                cb?(idx: self.tag,complete: true)
            }else{
                detail.text=tp.describe
                detail.textColor=iColor(0xff555555)
                cancelBtn.hidden=false
                prog.total=CGFloat(tp.total)
                prog.progress=CGFloat(tp.progress)
                
            }
        }
       

    }
}
