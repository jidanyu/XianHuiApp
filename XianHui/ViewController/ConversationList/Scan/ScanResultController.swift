//
//  ScanResultController.swift
//  XianHui
//
//  Created by jidanyu on 16/9/21.
//  Copyright © 2016年 mybook. All rights reserved.
//

import UIKit
import swiftScan
import SnapKit
import MBProgressHUD

//扫码成功界面
class ScanResultController: UIViewController {

    var codeResult:LBXScanResult!
    
    var topLabel = UILabel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        //self.edgesForExtendedLayout = UIRectEdge.None
        
        view.addSubview(topLabel)
        topLabel.snp_makeConstraints { (make) in
            make.center.equalTo(view)
            make.width.equalTo(view)
            make.height.equalTo(21)
        }
        topLabel.text = "点击确认登陆Mybook系统."
        topLabel.textColor = UIColor.lightGrayColor()
        topLabel.textAlignment = .Center
        
        let confirmButton = UIButton()
        view.addSubview(confirmButton)
        
        confirmButton.snp_makeConstraints { (make) in
            make.top.equalTo(topLabel.snp_bottom).offset(10)
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
            make.height.equalTo(44)
        }
        confirmButton.setTitle("确认登陆", forState: .Normal)
        confirmButton.titleLabel?.font = UIFont.systemFontOfSize(17)
        confirmButton.layer.cornerRadius = 5.0
        confirmButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        confirmButton.backgroundColor = UIColor ( red: 1.0, green: 0.6947, blue: 0.6038, alpha: 1.0 )
        confirmButton.addTarget(self, action: #selector(ScanResultController.confirmTap), forControlEvents: .TouchUpInside)
        
    }
    
    
    
    func confirmTap() {
       //确认登陆.向后台发送二维码
        if codeResult.strScanned != nil {
            let qrCode = codeResult.strScanned!
            LCCKUtil.showProgressText("登陆中", duration: 10.0)
            NetworkManager.sharedManager.logInERPWith(qrCode, completion: { (success, json, error) in
                
                if success == true {
                    LCCKUtil.hideProgress()
                    self.backToTopViewController()
                    
                }
                else{
                    //TODO: error
                    LCCKUtil.showProgressText("登陆失败", duration: 2.0)
                }
                
            })
        }
        else {
            //解码错误
        }
        
        
        
        
    }

    
    func backToTopViewController() {
        
        self.navigationController?.popToRootViewControllerAnimated(true)
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
}