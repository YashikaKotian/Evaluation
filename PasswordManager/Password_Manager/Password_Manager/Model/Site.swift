//
//  Site.swift
//  Password_Manager
//
//  Created by Yashika on 1/11/20.
//  Copyright © 2020 Yashika. All rights reserved.
//

import Foundation

class SiteInfo: NSObject, NSCoding {
    var url: String = ""
    var siteName: String = ""
    var sectorOrFolder: String = ""
    var userName: String = ""
    var password: String = ""
    var notes: String?
    
    init(url: String, siteName: String, sectorOrFolder: String, userName: String, password: String, notes: String? = nil) {
        self.url = url
        self.siteName = siteName
        self.sectorOrFolder = sectorOrFolder
        self.userName = userName
        self.password = password
        self.notes = notes
    }
        
    required init(coder decoder: NSCoder) {
        super.init()
        url = decoder.decodeObject(forKey: "url") as? String ?? ""
        siteName = decoder.decodeObject (forKey: "siteName") as? String ?? ""
        sectorOrFolder = decoder.decodeObject (forKey: "sectorOrFolder") as? String ?? ""
        userName = decoder.decodeObject (forKey: "userName") as? String ?? ""
        password = decoder.decodeObject (forKey: "password") as? String ?? ""
        notes = decoder.decodeObject (forKey: "notes") as? String ?? "mockAvatar"
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(url, forKey:"url")
        coder.encode(siteName, forKey:"siteName")
        coder.encode(sectorOrFolder, forKey:"sectorOrFolder")
        coder.encode(userName, forKey:"userName")
        coder.encode(password, forKey:"password")
        coder.encode(notes, forKey:"notes")
    }
}
