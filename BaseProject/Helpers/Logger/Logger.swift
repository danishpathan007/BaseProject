//
//  Logger.swift
//  Hooty
//
//  Created by Sandeep Singh on 16/11/17.
//  Copyright © 2016 Zapbuild. All rights reserved.
//

import Foundation

class Logger {

    class func log(_ msg:Any){
        #if DEBUG
            print("\(msg)")
        #endif
    }
}

