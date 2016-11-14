//
//  PicPickerCV.swift
//  EqApp
//
//  Created by apple on 16/9/8.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit
import SDWebImage
import AssetsLibrary
import AVKit
import AVFoundation
import MediaPlayer


class PicPickerCV: AutoHeightCV {
    let celliden = "icelliden_01"
    var vc:UIViewController?
    var mp:MPMoviePlayerController?
    var cursecne:Tscene?{
        didSet{
            updateUI()
        }
    }
    
    
    init(curscene:Tscene) {
        let w = min(iScrW, iScrH)-16
        let fl:UICollectionViewFlowLayout=UICollectionViewFlowLayout()
        fl.itemSize=CGSizeMake(w/4-2, w/4*1.1)
        fl.minimumInteritemSpacing=2
        fl.minimumLineSpacing=2
        super.init(frame: CGRectMake(0, 0, 0, 0), collectionViewLayout: fl)
        
        self.delegate=self
        self.dataSource=self
        self.registerClass(PicPickerCVCell.self, forCellWithReuseIdentifier: self.celliden)
        self.backgroundColor=UIColor.clearColor()
        self.showsVerticalScrollIndicator=false
        self.bounces=false
        self.cursecne=curscene
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateUI(){
        self.reloadData()
    }
    
    
    func selectPic() {
        let vc = UIImagePickerController()
        vc.delegate=self
        let res=UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary)
        vc.sourceType = .PhotoLibrary
        if res {
            self.vc?.presentViewController(vc, animated: true, completion: nil)
        }else{
            iPrint("not available")
        }
    }
    
    func startCamera(){
        let vc = UIImagePickerController()
        vc.delegate=self
        
        vc.allowsEditing = true
        let res=UIImagePickerController.isSourceTypeAvailable(.Camera)
        vc.sourceType = .Camera
        if res {
            self.vc?.presentViewController(vc, animated: true, completion: nil)
        }else{
            iPrint("not available")
        }
        
    }
    
    func startVideo(){
        let vc = UIImagePickerController()
        vc.delegate=self
        
        vc.allowsEditing = true
        let res=UIImagePickerController.isSourceTypeAvailable(.Camera)
        vc.sourceType = .Camera
        
//        vc.mediaTypes = UIImagePickerController.availableMediaTypesForSourceType(UIImagePickerControllerSourceType.Camera)!
        vc.mediaTypes = [kUTTypeMovie as String]
        vc.videoMaximumDuration = 600
        vc.videoQuality = UIImagePickerControllerQualityType.TypeMedium
        if res {
            self.vc?.presentViewController(vc, animated: true, completion: nil)
        }else{
            iPrint("not available")
        }

    }
    
    
}

extension PicPickerCV:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        collectionView.deselectItemAtIndexPath(indexPath, animated: true)
        deleteIMG(indexPath.row)
    }
    
    func collectionView(collectionView: UICollectionView, didEndDisplayingCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        
    }
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return self.cursecne?.fpaths.count ?? 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell{
        
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
    
    func path4idx(idx:NSIndexPath)->String{
        return  self.cursecne?.fpaths[idx.row] ?? ""
    }
    func deleteIMG(idx:Int){
        let uc = UIAlertController(title: "提示", message: "确认移除已添加的内容吗?", preferredStyle: UIAlertControllerStyle.Alert)
        uc.addAction(UIAlertAction(title: "确认", style: UIAlertActionStyle.Cancel, handler: {(ua) in
            self.cursecne?.rmFAtIdx(idx)
            self.reloadData()
            
        }))
        uc.addAction(UIAlertAction(title: "取消", style: UIAlertActionStyle.Default, handler: nil))
        vc!.presentViewController(uc, animated: true, completion: nil)
        
    }
}

extension PicPickerCV:UINavigationControllerDelegate,UIImagePickerControllerDelegate{
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]){
        picker.dismissViewControllerAnimated(true, completion: nil)
        if picker.mediaTypes[0] == (kUTTypeMovie as String){
            let url = info[UIImagePickerControllerMediaURL] as! NSURL
            let path = FileUtil.newVideoFile().strByAp2Doc()
            try! iFm.copyItemAtURL(url, toURL: NSURL(fileURLWithPath: path))
            self.cursecne?.fpaths.append(path)
            reloadData()
            //             mp = MPMoviePlayerController()
            //
            //            mp!.contentURL = url
            //            mp!.view.frame=CGRectMake(0, 0, 320, 460)
            //            vc?.view.addSubview(mp!.view)
            //            mp!.play()
            //
            return
        }
        let img=info["UIImagePickerControllerOriginalImage"] as! UIImage
        //        img = img.scale2w(1000)
        let path = FileUtil.newImgFile().strByAp2Doc()
        self.cursecne?.fpaths.append(path)
        UIImagePNGRepresentation(img)?.writeToFile(path, atomically: false)
        reloadData()
        
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController){
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
   
}



class PicPickerCVCell:UICollectionViewCell{
    
    lazy var icon:UIImageView=UIImageView()
    lazy var videoflag:UIImageView=UIImageView(image: iimg("video_flag"))
    
    
    
    func initUI(){
        contentView.addSubview(icon)
        icon.contentMode = .ScaleAspectFill
        icon.clipsToBounds=true
        contentView.addSubview(videoflag)
        
        icon.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(0)
        }
        videoflag.snp_makeConstraints { (make) in
            make.height.width.equalTo(33)
            make.center.equalTo(0)
        }
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    
    
    
}
