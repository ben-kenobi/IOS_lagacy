

//
//  SubmissionHisVC.swift
//  EqApp
//
//  Created by apple on 16/9/13.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit

class SubmissionHisVC: UICollectionViewController {
    let celliden = "gridcelliden"
    let supcelliden = "gridsupcelliden"
    
    var editMode:Bool = false
    var ondel:((idx:Int,del:Bool)->())?
    lazy var list:[Tscene] = {
        return SceneService.ins.findAllBy(UserInfo.me.NAME!,flag: "1")
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "历史采集数据"
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
    
}


extension SubmissionHisVC:UICollectionViewDelegateFlowLayout{
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        collectionView.deselectItemAtIndexPath(indexPath, animated: true)
        selectAt(indexPath.section)
    }
    
    func selectAt(idx:Int){
        if !editMode{
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
        
        let sp=collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: supcelliden, forIndexPath: indexPath) as! CVTwoLineSupV
        sp.cb=self.ondel
        sp.title.text=list[indexPath.section].event_id
        sp.detail.text = iConst.TIMESDF.stringFromDate(list[indexPath.section].addtime)
        sp.del.hidden = !editMode
        sp.del.tag=indexPath.section
        return sp
        
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
    
    
    func path4idx(idx:NSIndexPath)->String{
        return list[idx.section].fpaths[idx.row]
    }
    
    
}