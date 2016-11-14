//
//  ISQLite.swift
//  am
//
//  Created by apple on 16/5/11.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit

class ISQLite: IFMDBMan {
    
//    private static let DB_NAME="idata.db"
//    static let  VERSION=3
    static let  TABLE_ACCOUNT="account"
    static let  TABLE_META_DATA="meta_data"
    static let  TABLE_ACCESS="access"
    static let  TABLE_IPATH="IPATH"
    static let  TABLE_CONTACTS="contacts"
    
    static let  DB_NAME = "scenedatas.db";
    
    static let  VERSION = 3;
    
    static let  TABLE_MEDIA_DATAS = "t_media";
    static let  TABLE_SCENE = "t_scene";
    static let  TABLE_LOCATIONINFO = "t_locationinfo";
    static let  CONTACT = "contact"

    
    static let ins:ISQLite=ISQLite(name: DB_NAME,version: VERSION)
    
    
    private override init(name:String,version:Int) {
        super.init(name: name, version: version)
    }
    
    override func onCreate() {
        execSql("create table " + ISQLite.TABLE_MEDIA_DATAS + "(" +
            T_MEDIA.ID + " integer primary key autoincrement," +
            T_MEDIA.SCENEID + "  integer ," +
            T_MEDIA.CONTENTNAME + "  text," +
            T_MEDIA.CONTENTPATH + "  text," +
            T_MEDIA.FLAG + "  integer DEFAULT 0" +
            
            ");");
        
        execSql("create table " + ISQLite.TABLE_SCENE + "(" +
            T_SCENE.ID + " integer primary key autoincrement," +
            T_SCENE.EVENTID + " text default '0'," +
            
            T_SCENE.LOGINNAME + " text," +
            
            
            T_SCENE.FLAG + " integer DEFAULT 0," +
            
            T_SCENE.ADDTIME + " integer DEFAULT (strftime('%s','now')*1000)," +
            T_SCENE.TITLE + " text," +
            
            T_SCENE.DETAIL + " text," +
            
            T_SCENE.REMARK + " text," +
            
            T_SCENE.EQLEVELIDX + " integer," +
            
            T_SCENE.SUMMARYIDX + " integer," +
            T_SCENE.LOC_LAT + " real," +
            T_SCENE.LOC_LON + " real," +
            T_SCENE.SUBMITTIME + " integer DEFAULT (strftime('%s','now')*1000)" +
            
            ");");
        execSql("create table " + ISQLite.TABLE_LOCATIONINFO + "(" +
            "ID integer ," +
            "REGION_ID text," +
            "REGION_NAME text," +
            "PARENT_REGION_ID text," +
            
            "LON real," +
            "LAT real," +
            "LV text" +
            
            ");");
        
        execSql4F(iRes("locationinfosql.txt")!)
        
        
        execSql("create table " + ISQLite.CONTACT + " ("
            + "[id] INTEGER  NOT NULL PRIMARY KEY autoincrement,"
            + "[serverId] VARCHAR(20) NULL,"//服务器端唯一标识
            + "[jobPost] VARCHAR(20)  NULL,"//岗位
            + "[sex] INTEGER  NULL,"//性别 1=男 2=女
            + "[co1ID] VARCHAR(20)  NULL,"//所属市行政区编码
            + "[co1] VARCHAR(20)  NULL,"//所属市
            + "[co2ID] VARCHAR(20)  NULL,"//所属区县行政编码
            + "[co2] VARCHAR(20)  NULL,"//所属区县
            + "[department] VARCHAR(20)  NULL,"//所属部门
            + "[email] VARCHAR(50)  NULL,"//email
            + "[name] VARCHAR(50)  NOT NULL,"
            + "[phone] VARCHAR(11) NOT NULL,"//手机
            + "[createDate] VARCHAR(20)  NULL,"
            + "[remark] VARCHAR(200)  NULL,"
            + "[uploaded] INTEGER NOT NULL,"//是否上传服务器 1未上传插入 0已上传 2 未上传更新
            + "[sortKey] VARCHAR(1)  NOT NULL);")
        
    }
    
    override func onUpdate() {
        execSql("create table " + ISQLite.CONTACT + " ("
            + "[id] INTEGER  NOT NULL PRIMARY KEY autoincrement,"
            + "[serverId] VARCHAR(20) NULL,"//服务器端唯一标识
            + "[jobPost] VARCHAR(20)  NULL,"//岗位
            + "[sex] INTEGER  NULL,"//性别 1=男 2=女
            + "[co1ID] VARCHAR(20)  NULL,"//所属市行政区编码
            + "[co1] VARCHAR(20)  NULL,"//所属市
            + "[co2ID] VARCHAR(20)  NULL,"//所属区县行政编码
            + "[co2] VARCHAR(20)  NULL,"//所属区县
            + "[department] VARCHAR(20)  NULL,"//所属部门
            + "[email] VARCHAR(50)  NULL,"//email
            + "[name] VARCHAR(50)  NOT NULL,"
            + "[phone] VARCHAR(11) NOT NULL,"//手机
            + "[createDate] VARCHAR(20)  NULL,"
            + "[remark] VARCHAR(200)  NULL,"
            + "[uploaded] INTEGER NOT NULL,"//是否上传服务器 1未上传插入 0已上传 2 未上传更新
            + "[sortKey] VARCHAR(1)  NOT NULL);")
    }
    func onCreate_old() {
        execSql("create table "+ISQLite.TABLE_ACCOUNT+"(" +
            AccountColumns.ID+" integer primary key autoincrement," +
                AccountColumns.MAILBOX+"  text," +
                AccountColumns.PASSPORT+"  text," +
                AccountColumns.PASSWORD+"  text," +
                AccountColumns.SITENAME+"  text," +
                AccountColumns.USERNAME+"  text," +
                AccountColumns.WEBSITE+"  text," +
                AccountColumns.PHONENUM+"  text," +
                AccountColumns.IDENTIFYING_CODE+"  text," +
                AccountColumns.ASK+"  text," +
                AccountColumns.ANSWER+"  text, " +
                AccountColumns.GROUP+" text default '' " +
            ")");
        
        execSql("create table "+ISQLite.TABLE_META_DATA+"(" +
            MetaDataColumns.LANGUAGE+"  text," +
            MetaDataColumns.ACCESSKEY+"  text"
            + ")");
        execSql("create table  "+ISQLite.TABLE_ACCESS+"  (" +
            AccessColumns.ID+" integer primary key autoincrement," +
            AccessColumns.NAME+"  text," +
            AccessColumns.ACCESSIBILITY+"   integer" +
            ")");
        execSql("create table  "+ISQLite.TABLE_IPATH+"  (" +
            IPathColumns.ID+" integer primary key autoincrement," +
            IPathColumns.NAME+"  text," +
            IPathColumns.PATH+"   text" +
            ")");
        
        execSql("create table  "+ISQLite.TABLE_CONTACTS+"  (" +
            ContactColumns.ID+" integer primary key autoincrement," +
            ContactColumns.NAME+"  text," +
            ContactColumns.GROUP+"   text," +
            ContactColumns.PHONE+"   text," +
            ContactColumns.PHONE2+"   text," +
            ContactColumns.TEL+"   text," +
            ContactColumns.CHATACCOUNT+"   text," +
            ContactColumns.EMAIL+"   text," +
            ContactColumns.PS+"   text" +
            ")");
        
        rawInsert("insert into  "+ISQLite.TABLE_META_DATA+" values('chinese','')"
        );
        rawInsert("insert into  "+ISQLite.TABLE_ACCESS+" values(1,?,1)"
            ,args: [iConst.ACCOUNT]);
        rawInsert("insert into  "+ISQLite.TABLE_ACCESS+" values(2,?,1)"
            ,args: [iConst.FILESYSTEM]);
        rawInsert("insert into  "+ISQLite.TABLE_ACCESS+" values(3,?,1)"
            ,args: [iConst.CONTACTS]);
        
        rawInsert("insert into  "+ISQLite.TABLE_IPATH+"  values(1,?,?)",
                   args: ["root","/"]);
        rawInsert("insert into  "+ISQLite.TABLE_IPATH+"  values(2,?,?)",
                   args: ["mnt","/mnt"]);
    }
}


public struct AccountColumns{
    
    static let  ID=iConst.ID,
				
    WEBSITE="website",
    
    SITENAME="sitename",
    
    USERNAME="username",
    
    PASSWORD="password",
    
    PASSPORT="passport",
    
    MAILBOX="mailbox",
    
    PHONENUM="phonenum",
    
    IDENTIFYING_CODE="identifying_code",
    
    ASK="ask",
    
    ANSWER="answer",
    
    GROUP="groupname";
    
    
    
}

public struct MetaDataColumns{
    
    static let LANGUAGE="language",
				
    ACCESSKEY="accesskey";
				
}

public struct AccessColumns{
    
    static  let ID=iConst.ID,
				
				NAME="name",
				
				ACCESSIBILITY="accessibility";
				
}

public struct IPathColumns{
    static let ID=iConst.ID,
				
				NAME="name",
				
				PATH="path";
				
}

public struct ContactColumns{
    static let ID=iConst.ID,
				
				NAME="name",
				
				GROUP="groupname",
				
				PHONE="phone",
				
				PHONE2="phone2",
				
				TEL="tel",
				
				CHATACCOUNT="chataccount",
				
				EMAIL="email",
				
				PS="postscript";
				
}



public  struct T_MEDIA {
    
    static let ID = "_id",
    SCENEID = "scene_id",
    
    
    
    FLAG = "flag",
    
    
    CONTENTNAME = "content_name",
    
    CONTENTPATH = "content_path";
    
    
    
}


public  struct T_SCENE {
    
    static let  ID = "_id",
    EVENTID = "event_id",
    
    LOGINNAME = "loginname",
    
    
    FLAG = "flag",
    
    ADDTIME = "addtime",
    TITLE = "title",
    
    DETAIL = "detail",
    
    REMARK = "remark",
    
    EQLEVELIDX = "eqlevelidx",
    
    SUMMARYIDX = "summaryidx",
    LOC_LAT = "loc_lat",
    LOC_LON = "loc_lon",
    SUBMITTIME = "submittime";
    
    
}


