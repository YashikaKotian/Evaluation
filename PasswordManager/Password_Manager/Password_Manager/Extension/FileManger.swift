//
//  FileManger.swift
//  Password_Manager
//
//  Created by Yashika on 1/11/20.
//  Copyright © 2020 Yashika. All rights reserved.
//

import Foundation

extension FileManager {
    static func  getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
