
//
//  StrAryPV.swift
//  EqApp
//
//  Created by apple on 16/9/23.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit

class StrAryPV: BottomPopV {

   
    lazy var pv:UIPickerView={
        let pv = UIPickerView()
        pv.delegate=self
        pv.dataSource=self
        return pv
        
    }()
    var datas:[String]?
    var selidx:Int = 0
    override func custCotent(cv: UIView) {
        pv.frame=cv.bounds
        cv.addSubview(pv)
        update()
    }
    
    func update(){
        pv.selectRow(selidx, inComponent: 0, animated: false)
    }
    func selIdx()->Int{
        return pv.selectedRowInComponent(0)
    }
    
}

extension StrAryPV:UIPickerViewDelegate,UIPickerViewDataSource{
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return datas?.count ?? 0
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return datas![row]
    }
    func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 44
    }
}
