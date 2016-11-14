//
//  HMStatusPictureView.swift
//  Weibo11
//
//  Created by itheima on 15/12/11.
//  Copyright © 2015年 itheima. All rights reserved.
//  配图视图

import UIKit
import SnapKit
// 重用标识符
private let HMStatusPictureViewItemId = "HMStatusPictureViewItemId"

// 每一个条目之前的间距
private let itemMargin: CGFloat = 5
// 每一个条目的宽高
private let itemWH: CGFloat = CGFloat(Int(SCREENW - itemMargin * 2 - HMStatusCellMargin * 2) / 3)

class HMStatusPictureView: UICollectionView {
    
    var sizeConstraint: Constraint?
    
    // MARK: - 设置数据
    // 当前配图视图显示的图片数据
    private var pic_urls: [HMStatusPictureInfo]?
    
    /// 设置图片信息
    ///
    /// - parameter picUrls:  配图视图大小
    /// - parameter viewSize: 视图大小
    func setPicInfo(picUrls: [HMStatusPictureInfo]?, viewSize: CGSize) {
        
        countLabel.text = "\(picUrls?.count ?? 0)"
        
        // 根据图片张图,计算当前控件的大小
        let size = viewSize
        
        // 如果是单张图片，需要根据 viewSize 调整 layout itemSize 
        // 但是，如果不是单张图片，需要使用默认的 itemSize
        // 1> 取得 layout
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        // 2> 设置 itemSize
        layout.itemSize = picUrls?.count == 1 ? viewSize : CGSize(width: itemWH, height: itemWH)
        
        // 记录配图 url
        pic_urls = picUrls
        
        // 设置当前控件的大小
        self.snp_updateConstraints { (make) -> Void in
            self.sizeConstraint = make.size.equalTo(size).constraint
        }
        
        reloadData()
    }
    
    // MARK: - 构造函数
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: UICollectionViewFlowLayout())
        setupUI()
    
        // 设置 collectionView 相关属性
        // 注册cell
        registerClass(HMStatusPictureViewCell.self, forCellWithReuseIdentifier: HMStatusPictureViewItemId)
        // 设置数据源
        dataSource = self
        delegate = self
        let layout = self.collectionViewLayout as! UICollectionViewFlowLayout
        // 设置条目的大小
        layout.itemSize = CGSize(width: itemWH, height: itemWH)
        // 指定水平方向的间距
        layout.minimumInteritemSpacing = itemMargin
        // 垂直方向
        layout.minimumLineSpacing = itemMargin
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 设置视图
    private func setupUI(){
        addSubview(countLabel)
        
        countLabel.snp_makeConstraints { (make) -> Void in
            make.center.equalTo(self)
        }
    }
    
    // 懒加载控件
    private lazy var countLabel: UILabel = UILabel(textColor: UIColor.blackColor(), fontSize: 40)
    
}

// MARK: - UICollectionViewDataSource
extension HMStatusPictureView: UICollectionViewDataSource, UICollectionViewDelegate {
    
    // 返回有多少个cell
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pic_urls?.count ?? 0
    }
    
    
    // 返回cell
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(HMStatusPictureViewItemId, forIndexPath: indexPath) as! HMStatusPictureViewCell
        cell.pictureInfo = pic_urls![indexPath.row]
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
//        SDPhotoBrowser *browser = [[SDPhotoBrowser alloc] init];
//        browser.sourceImagesContainerView = self; // 原图的父控件
//        browser.imageCount = self.photoItemArray.count; // 图片总数
//        browser.currentImageIndex = button.tag;
//        browser.delegate = self;
//        [browser show];
        
        let browser = SDPhotoBrowser()
        browser.sourceImagesContainerView = self
        // 图片张数
        browser.imageCount = pic_urls?.count ?? 0
        browser.currentImageIndex = indexPath.item
        browser.delegate = self
        browser.show()
    }
}

extension HMStatusPictureView: SDPhotoBrowserDelegate {
//    - (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
//    {
//    return [self.subviews[index] currentImage];
//    }
//    
    
    // 返回对应 index 的图片 --> 在我们这种情况下,是返回 对应 item 的 cell 里面的图片
    func photoBrowser(browser: SDPhotoBrowser!, placeholderImageForIndex index: Int) -> UIImage! {
        
        // 设置 indexPath
        let index = NSIndexPath(forItem: index, inSection: 0)
        // 通过 indexPath 获取到其对应的 cell
        if let cell = self.cellForItemAtIndexPath(index) as? HMStatusPictureViewCell {
            return cell.imgView.image
        }
        return nil
    }
    
    /// 照片浏览，替换 URL String
    func photoBrowser(browser: SDPhotoBrowser!, highQualityImageURLForIndex index: Int) -> NSURL! {
        
        let urlString = pic_urls![index].picUrl!.absoluteString.stringByReplacingOccurrencesOfString("thumbnail", withString: "bmiddle")
        
        return NSURL(string: urlString)
        
    }
    
    
//    
//    // 返回高质量图片的url
//    - (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
//    {
//    NSString *urlStr = [[self.photoItemArray[index] thumbnail_pic] stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
//    return [NSURL URLWithString:urlStr];
//    }

    
    
    
}

/// 自定义 cell
class HMStatusPictureViewCell: UICollectionViewCell {
    
    var pictureInfo: HMStatusPictureInfo? {
        didSet{
            
            if let url = pictureInfo?.picUrl {
                gifImageVIew.hidden = !url.absoluteString.hasSuffix(".gif")
                
                imgView.sd_setImageWithURL(url, placeholderImage: UIImage(named: "timeline_image_placeholder"))
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupUI(){
        // 添加子控件
        contentView.addSubview(imgView)
        contentView.addSubview(gifImageVIew)
        
        // 添加约束
        imgView.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(contentView).offset(UIEdgeInsetsZero)
        }
        
        gifImageVIew.snp_makeConstraints { (make) -> Void in
            make.trailing.equalTo(imgView)
            make.bottom.equalTo(imgView)
        }
    }
    
    // MARK: - 懒加载
    private lazy var imgView: UIImageView = {
        let imageView = UIImageView()
        // 指定内容显示模型
        imageView.contentMode = UIViewContentMode.ScaleAspectFill
        // 超出部分截取掉
        imageView.clipsToBounds = true
        return imageView
    }()
    // gif 图标
    private lazy var gifImageVIew: UIImageView = UIImageView(image: UIImage(named: "timeline_image_gif"))
    
}
