


//
//  CVVC.swift
//  day50-pageController-ThirdParty
//
//  Created by apple on 15/12/19.
//  Copyright © 2015年 yf. All rights reserved.
//

import UIKit

private let celliden = "Celliden"

class CVVC: UICollectionViewController {
    
    var name:String?{
        didSet{

        }
    }
    
    lazy var imgs:[UIImage?]? = {
        var imgs = [UIImage?]()
        imgs.append(iimg("The roar.jpg"))
        imgs.append(iimg("Dragon Spirit.jpg"))
        imgs.append(iimg("Night.jpg"))
        return imgs
    }()
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor=UIColor.whiteColor()
        self.collectionView!.registerClass(CVCell01.self, forCellWithReuseIdentifier: celliden)

    }



    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {

        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return 55
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(celliden, forIndexPath: indexPath) as! CVCell01
        cell.iv.image=imgs![indexPath.row%imgs!.count]
        
        return cell
    }

      
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nil, bundle: nil)
    }
    init() {
        let layout=UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing=1
        layout.minimumLineSpacing=1
        layout.itemSize=CGSizeMake(iScrW/4-3, iScrW/4-3)
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


class CVCell01:UICollectionViewCell{
    
    lazy var iv:UIImageView=UIImageView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(iv)
        iv.frame=self.bounds
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
}
