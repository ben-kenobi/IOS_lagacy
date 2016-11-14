//
//  HomeVC.swift
//  am
//
//  Created by apple on 16/5/10.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit
let updateHomeVCNoti="updateHomeVCNoti"
let iStrings:[String:String] = iRes4Dic("strings.plist") as! [String:String]
let iStrary:[String:[String]] = iRes4Dic("stringary.plist") as! [String:[String]]

class HomeVC: BaseVC {
    let bgs=["home","home2","access"]
    let map = ["at":iConst.ACCOUNT,"filesystem":iConst.FILESYSTEM,"contacts":iConst.CONTACTS]
    
    
    
    let celliden="menutvcelliden"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(cv)
        menuInfo = iRes4Ary("menuConf.plist")
        
        iNotiCenter.addObserver(self, selector: #selector(self.showVC(_:)), name: updateHomeVCNoti, object: nil)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        view.layer.contents=iimg(bgs[irand(UInt32(bgs.count))])?.CGImage
        
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    
    
    
    var menuInfo:[AnyObject]?
    
    
    
    
    lazy var cv:UICollectionView = {
        let v = self.view
        var w = min(iScrW, iScrH)
        var fl:UICollectionViewFlowLayout=UICollectionViewFlowLayout()
        fl.itemSize=CGSizeMake(w/3, w/3)
        fl.minimumInteritemSpacing=w/9
        fl.minimumLineSpacing=w/9
        let cv=UICollectionView(frame:CGRectMake(w/9, 150, w/9*7,w/9*7 ),collectionViewLayout: fl)
        cv.delegate=self
        cv.dataSource=self
        
        cv.registerClass(MenuCell.self, forCellWithReuseIdentifier:self.celliden)
        
        cv.showsVerticalScrollIndicator=false
        cv.bounces=false
        cv.backgroundColor=UIColor.clearColor()
        return cv
    }()
    
    
    
    deinit{
        iNotiCenter.removeObserver(self)
        
    }
    override func shouldAutorotate() -> Bool {
        return false
    }
    override func preferredInterfaceOrientationForPresentation() -> UIInterfaceOrientation {
        return UIInterfaceOrientation.Portrait
    }
}




extension HomeVC:UICollectionViewDelegate,UICollectionViewDataSource{
    
    func forwardTo(name:String?,pass:Bool=false){
        if CommonService.isAccessKeyEnable(name ?? "") && !pass{
            let vc:LoginVC=LoginVC()
//            vc.name=name
            presentViewController(vc, animated: true, completion: nil)
        }else{
            if !pass{
                CommonUtils.setAccessKey(nil)
            }
            let vc = CommonService.getIntentByAccessName(name ?? "")
            presentViewController(vc, animated: true, completion: nil)

        }
        
    }
    
    func getByIdx(indexPath:NSIndexPath)->[String:AnyObject]?{
        if let dict = menuInfo?[indexPath.section] as? [String:AnyObject]{
            if let ary = dict["items"] as? [[String:AnyObject]]{
                return ary[indexPath.row]
            }
        }
        return nil
//        return menuInfo?[indexPath.section]["items"]?[indexPath.row] as? [String:AnyObject]
    }
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        collectionView.deselectItemAtIndexPath(indexPath, animated: true)
        if let str = getByIdx(indexPath)?["icon"] as? String{
            if str=="logoff"{
                exit(0)
            }else{
                forwardTo(map[str])
            }
        }else{
            
        }
        
    }
    
    func collectionView(collectionView: UICollectionView, didEndDisplayingCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return menuInfo?[section]["items"]?.count ?? 0
        
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell{
        
        let cell:MenuCell = collectionView.dequeueReusableCellWithReuseIdentifier(celliden, forIndexPath: indexPath) as! MenuCell
        //        cell.backgroundColor=UIColor.clearColor()
        if let mod = getByIdx(indexPath){
            cell.mod=mod as? [String : String]
        }
        
        return cell
    }
    
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int{
        return menuInfo?.count ?? 0
        
    }
    
    
    
    
    
    
}


extension HomeVC{
    
    
    func showVC(noti:NSNotification){
        
        guard let win = iAppDele.window else{
            return
        }
        let img=UIImage.imgFromLayer(win.layer)
        
        
        dismissViewControllerAnimated(false, completion: nil)
        forwardTo((noti.object as? String) ?? "",pass:true)

        
        let iv:UIImageView=UIImageView(image: img)
        win.addSubview(iv)
        UIView.animateWithDuration(1, animations: { () -> Void in
            iv.alpha=0.1
            iv.transform=CGAffineTransformMakeScale(2, 2)
            }, completion: { (b) -> Void in
                iv.removeFromSuperview()
        })
        
        
    }
    
    
    
    
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
    }
    
}




class Aoo:View{
    required override init(frame:CGRect){
        super.init(frame:frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    class func initwith()->Self{
        return self.init(frame: CGRectMake(0, 0, 0, 0))
    }
    func aoo()->Self{
        boo()
        return self
    }
    func boo(){
        print("aoo->boo")
    }
}

class Boo:Aoo{
    required init(frame:CGRect){
        super.init(frame:frame)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func boo(){
        print("boo->boo")
    }
}

