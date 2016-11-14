
//
//  DeathTheaticSearchVC.swift
//  EqApp
//
//  Created by apple on 16/9/20.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit
import ArcGIS

class DeathTheaticSearchVC: BaseVC {
    let celliden = "cvcelliden"
    var po:AGSPoint?
    
    lazy var tf:UITextField = {
        let tf = UITextField(frame: nil, bg: UIColor.whiteColor(), corner: 5, bordercolor: iColor(0xff888888), borderW: 1)
        tf.leftViewMode = .Always
        tf.leftView = UIView(frame: CGRectMake(0, 0, 12, 0))
        tf.keyboardType = UIKeyboardType.DecimalPad
        tf.text="1"
        return tf
    }()
    
    
    lazy var cv:AutoHeightCV = {
        var w = min(iScrW, iScrH)
        var fl:UICollectionViewFlowLayout=UICollectionViewFlowLayout()
        fl.itemSize=CGSizeMake(w/3, w/3*0.5)
        fl.minimumInteritemSpacing=0
        fl.minimumLineSpacing=0
        
        let cv = AutoHeightCV(frame: CGRectMake(0, 0, 0, 0), collectionViewLayout: fl)
        cv.delegate=self
        cv.dataSource=self
        cv.registerClass(TextCVCell.self, forCellWithReuseIdentifier: self.celliden)
        cv.backgroundColor=UIColor.whiteColor()
        cv.showsVerticalScrollIndicator=false
        cv.bounces=false
//        cv.layer.borderColor=UIColor.whiteColor().CGColor
//        cv.layer.borderWidth=1
        
        return cv    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "周边搜索"
        initUI()
        
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        view.endEditing(true)
    }
    
    
   

}

extension DeathTheaticSearchVC:UICollectionViewDelegate,UICollectionViewDataSource{
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MapMod.controlflows.count
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(celliden, forIndexPath: indexPath) as! TextCVCell
        cell.lab.text=MapMod.controlflows[indexPath.item]
        return cell
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if let dis = Double(tf.text!) where dis > 0{
            let vc = DeathThematicQueryVC()
            // convert KM to geo degree roughly
            vc.radius = dis/3.6/33
            vc.idx=indexPath.row
            vc.po = po
            self.navigationController?.showViewController(vc, sender: nil)
        }else{
            iPop.toast("请输入搜索距离")
        }
    }
}


extension DeathTheaticSearchVC{
    func initUI(){
        let lab = UILabel(frame: nil, txt: "搜索半径(单位:KM):", color: iColor(0xff333333), font: iFont(16), align: .Left, line: 1)
        view.addSubview(lab)
        lab.snp_makeConstraints { (make) in
            make.left.equalTo(5)
            make.top.equalTo(8)
            make.height.equalTo(48)
            make.width.equalTo(150)
        }
        view.addSubview(tf)
        tf.snp_makeConstraints { (make) in
            make.left.equalTo(lab.snp_right).offset(5)
            make.height.top.equalTo(lab)
            make.right.equalTo(-5)
        }
        let line = UIView()
        line.backgroundColor=UIColor.lightGrayColor()
        view.addSubview(line)
        line.snp_makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.height.equalTo(1)
            make.top.equalTo(lab.snp_bottom).offset(15)
            
        }
        view.addSubview(cv)
        cv.snp_makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.top.equalTo(line.snp_bottom)
        }
        
        
    }
    
    
}


class TextCVCell:UICollectionViewCell{
    var lab:UILabel = UILabel(frame: nil, txt: "", color: iColor(0xff333333), font: iFont(17), align: NSTextAlignment.Center, line: 1, bgColor: iColor(0xffffffff))
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(lab)
        self.backgroundColor=UIColor.lightGrayColor()
        lab.snp_makeConstraints { (make) in
            make.top.left.equalTo(0)
            make.right.bottom.equalTo(-1)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
