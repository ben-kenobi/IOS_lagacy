//
//  FilePreviewVC.swift
//  EqApp
//
//  Created by apple on 16/9/14.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit

class FilePreviewVC: BaseVC {
    lazy var previewvc:UIDocumentInteractionController={
        let pre = UIDocumentInteractionController()
        pre.delegate=self
        return pre
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
 
   

}


extension FilePreviewVC:UIDocumentInteractionControllerDelegate{
    func documentInteractionControllerViewControllerForPreview(controller: UIDocumentInteractionController) -> UIViewController {
        if let nav = self.navigationController{
            return nav
        }
        return self
        
    }
    
    
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
//                let url2 =  NSURL(fileURLWithPath: "aabb.pdf".strByAp2Doc())
//        preview(url2)
        
    }
    func previewFile(path:String){
        preview(NSURL(fileURLWithPath: path))
    }
    
    func preview(url:NSURL){
        self.previewvc.URL=url
        //        self.previewvc!.UTI="com.adobe.pdf"
        //        self.previewvc!.presentOptionsMenuFromRect(CGRectMake(0, 0, iScrW, iScrH), inView: self.view, animated: true)
        self.previewvc.presentPreviewAnimated(true)
    }

}