//
//  DDConfigs.swift
//  DingDong
//
//  Created by Seppuu on 16/3/2.
//  Copyright © 2016年 seppuu. All rights reserved.
//

import UIKit
import CoreLocation

let OwnSystemLoginSuccessNoti = "OwnSystemLoginSuccessNoti"


let screenWidth = UIScreen.mainScreen().bounds.size.width
let screenHeight = UIScreen.mainScreen().bounds.size.height

let DDTimeNeverReach = 12000

let BaseUrl = "http://sso.sosys.cn:8080/mybook"
let XHPublicKey = "1addfcf4296d60f0f8e0c81cea87a099"
var DDBaseUrl:String {
    return Defaults.actualApiUrl.value!
}

var allUserIds = [String]()

///用户登录
let loginWithPhoneURL          = BaseUrl + "/rest/loginmobile"

//用户登出
let logOutURL         = BaseUrl + "/rest/logout"

//获取手机验证码
let getPhoneCodeUrl   = BaseUrl + "/rest/loginsmsgot"

//验证手机验证码
let verifyPhoneCodeUrl   = BaseUrl + "/rest/loginsmsverify"

//更新密码
let updatePassWordUrl = BaseUrl + "/rest/changeloginpassword"



//上传头像
var updateAvatarURL:String {
    return DDBaseUrl + "/rest/employee/uploadavator"
}

//完善用户资料
var updateUserInfoURL:String {
    return DDBaseUrl + "/user/index/rest?returnDataType=json&action=updateUserInfo"
}

///二维码
//通过扫码登陆ERP
var logInERPWithQRCodeUrl:String {
    return DDBaseUrl + "/rest/employee/loginqrdo"
}


//手机端指挥退出ERP
var logOutERPWithQRCodeUrl:String {
    return DDBaseUrl + "/rest/employee/logoutqrdo"
}

//获取二维码登陆状态
var getERPLogInStatusUrl:String {
    return DDBaseUrl + "/rest/employee/loginqrstatus"
}


/// 日报表

//获取日报表峰值
var GetDailyReportMaxVauleUrl:String {
    return DDBaseUrl + "/rest/employee/getdailyreportsetting"
}

//保存日报表峰值
var SaveDailyReportMaxVauleUrl:String {
    return DDBaseUrl + "/rest/employee/setdailyreportsetting"
}


//获取助手列表
var GetHelperListUrl:String {
    return DDBaseUrl +  "/rest/employee/gethelperlist"
}



//获取日报表数据
var GetDailyReportDataUrl:String {
    return DDBaseUrl + "/rest/employee/getdailyreportdata"
}


//提醒,通知列表
var GetNoticeListUrl:String {
    return  DDBaseUrl + "/rest/employee/getnoticelist"
}

//获取通知明细
var GetNoticeDetailUrl:String {
    return DDBaseUrl +  "/rest/employee/getnoticedetail"
}



///我的工作 -- 计划

//获取计划顾客列表
var GetCustomerPlanListUrl:String {
    return DDBaseUrl + "/rest/employee/getplantable"
}


//获取预约顾客列表
var getCustomerScheduleListUrl:String {
    return DDBaseUrl + "/rest/employee/getscheduletable"
}


//获取某顾客明细
var GetCustomerDetailUrl:String {
    return DDBaseUrl + "/rest/employee/getcustomerdetail"
}

//获取顾客消费记录
var GetCustomerConsumeUrl:String {
    return DDBaseUrl + "/rest/employee/getcustomerconsumelist"
}

//获取顾客预约记录
var GetCustomerSchedulesUrl:String {
    return DDBaseUrl + "/rest/employee/getcustomerschedulelist"
}


//获取项目,产品计划
var GetGoodPlanListUrl:String {
    return DDBaseUrl + "/rest/employee/getplanaddlist"
}

//保存项目,产品计划
var SaveGoodPlanUrl:String {
    return DDBaseUrl + "/rest/employee/setplanitem"
}

/// 用户关系管理

//用户联系人列表
var userListUrl:String {
    return DDBaseUrl + "/rest/employee/getuserlist"
}

/// 系统管理
var submitFeedBackURL:String {
    return DDBaseUrl + "/system/index/rest?returnDataType=json&action=submitFeedback"
}

//用户协议
var userArgeementURL:String {
    return DDBaseUrl + "/user/signup/agreement"
}

//暂时的固定的token
var defaultToken = ""

