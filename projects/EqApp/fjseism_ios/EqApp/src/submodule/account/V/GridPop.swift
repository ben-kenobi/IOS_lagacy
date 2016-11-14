//
//  GridPop.swift
//  am
//
//  Created by apple on 16/5/30.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit

class GridPop: BaseDialog {
    private var icon = iimg("AppIcon")
    
    let celliden = "gridPopcelliden"
    var datas:[String]?
    
    var title:String?{
        didSet{
            (titleView.viewWithTag(11) as! UILabel).text=title
        }
    }
    var droplist:[String]?{
        didSet{
            if let droplist=droplist where droplist.count>0{
                (titleView.viewWithTag(12) as! UIButton).setTitle(droplist[0], forState: UIControlState.Normal)
            }
        }
        
    }
    var onItemSelCB:((pos:Int,dialog:GridPop)->Void)?
    var onDropSelCB:((pos:Int,dialog:GridPop)->Void)?
    lazy var cv:UICollectionView = {
        var w = min(iScrW, iScrH)
        var fl:UICollectionViewFlowLayout=UICollectionViewFlowLayout()
        fl.itemSize=CGSizeMake(w/4.5, w/4.5*1.3)
        fl.minimumInteritemSpacing=5
        fl.minimumLineSpacing=5
        
        let cv = UICollectionView(frame: CGRectMake(0, 0, 0, 0), collectionViewLayout: fl)
        cv.delegate=self
        cv.dataSource=self
        cv.registerClass(GridCell.self, forCellWithReuseIdentifier: self.celliden)
        cv.backgroundColor=UIColor.clearColor()
        cv.showsVerticalScrollIndicator=true
        cv.bounces=false
        
        return cv    }()
    lazy var titleView:UIButton={
        let titleview=ComUI.comDropTitleView("", dropTitle: "", tar: self, sel: #selector(self.showDropDialog),labtag:11, droptag: 12)
        
        titleview.addTarget(self, action: #selector(self.onClick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        return titleview
    }()
    
    required init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(titleView)
        titleView.snp_makeConstraints { (make) in
            make.top.left.right.equalTo(0)
            make.height.equalTo(46)
            make.width.equalTo(self).multipliedBy(0.8)
        }
        contentView.addSubview(cv)
        cv.snp_makeConstraints { (make) in
            make.left.equalTo(8)
            make.top.equalTo(titleView.snp_bottom).offset(5)
            make.right.equalTo(-8)
            make.bottom.equalTo(-8)
            make.height.equalTo(self).multipliedBy(0.6)
        }
        
        
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    
    override func afterShow(vc: UIViewController?, basev: UIView?, anchor: View?) {
        if let droplist = droplist{
            self.onDropSelCB?(pos: idxof(droplist, tar:(titleView.viewWithTag(12) as! UIButton).titleForState(UIControlState.Normal)),dialog: self)

        }
    }
}





extension GridPop{
    func onClick(sender:UIButton){
        if sender == self.titleView{
            self.onItemSelCB?(pos: -1,dialog: self)
        }
    }
    
    func updateUI(datas:[String],icon:UIImage?){
        self.datas=datas
        if let icon = icon {
            self.icon=icon
        }
        cv.reloadData()
    }
    
    func showDropDialog(){
        let v = titleView.viewWithTag(12) as! UIButton
        ListPop.listPopWith(droplist,  w: v.w, cb: { (str, pos) in
            v.setTitle(str, forState: UIControlState.Normal)
            self.onDropSelCB?(pos: pos,dialog:self)
        }).show(basev:self,anchor:v)
    }
    class func gridPopWith(droplist:[String],title:String,cb:(pos:Int,dialog:GridPop)->(),gridsel:(pos:Int,dialog:GridPop)->())->GridPop{
        let pop = dialogWith() as GridPop
        pop.title = title
        pop.droplist=droplist
    
        pop.onDropSelCB=cb
        
        pop.onItemSelCB = gridsel
        
        return pop
    }
}

extension GridPop:UICollectionViewDataSource,UICollectionViewDelegate{
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {

        collectionView.deselectItemAtIndexPath(indexPath, animated: true)
        self.onItemSelCB?(pos: indexPath.row,dialog: self)
    }
    
    func collectionView(collectionView: UICollectionView, didEndDisplayingCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        
    }
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return datas?.count ?? 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell{
        
        let cell:GridCell = collectionView.dequeueReusableCellWithReuseIdentifier(celliden, forIndexPath: indexPath) as! GridCell
        cell.icon.image=icon
        let str = datas![indexPath.row]
        cell.title.text=str=="" ? "未指定":str
        return cell
    }
    


    
}





class GridCell: UICollectionViewCell {
    
    lazy var icon:UIImageView=UIImageView()
    lazy var title:UILabel=UILabel()
    
    
    func initUI(){
        let selbg=UIView()
        selbg.backgroundColor=iColor(0, 0, 0, 0.3)
        selectedBackgroundView=selbg
        selbg.layer.cornerRadius=7
        selbg.layer.masksToBounds=true
        
        //        selectionStyle = .None
        
        let v=UIView()
        contentView.addSubview(v)
        //        contentView.backgroundColor=UIColor.clearColor()
        backgroundColor=UIColor.clearColor()
        v.addSubview(icon)
        v.addSubview(title)
        //        v.layer.cornerRadius=5
        //        v.layer.borderWidth=0.7
        //        v.layer.borderColor=UIColor.grayColor().CGColor
        v.layer.backgroundColor=UIColor.clearColor().CGColor
        v.snp_makeConstraints { (make) -> Void in
            make.top.left.right.bottom.equalTo(0)
            
        }
        
        
        icon.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(15)
            make.top.equalTo(5)
            make.right.equalTo(-15)
            make.height.equalTo(icon.snp_width)
            
        }
        title.snp_makeConstraints { (make) -> Void in
            
            make.left.equalTo(3)
            make.right.equalTo(0)
            make.bottom.equalTo(-3)
            make.top.equalTo(icon.snp_bottom)
            
        }
        title.numberOfLines=0
        title.lineBreakMode = .ByCharWrapping
        title.font=iFont(16)
        title.textAlignment = .Center
        
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
