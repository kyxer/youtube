//
//  Video.swift
//  youtube
//
//  Created by German Mendoza on 7/20/16.
//  Copyright © 2016 German LLC. All rights reserved.
//

import UIKit

class Video: NSObject {

    var thumbnailImageName: String?
    var title: String?
    var numberOfViews: NSNumber?
    var uploadDate:NSDate?
    
    var channel: Channel?
    
}

class Channel: NSObject {
    
    var name:String?
    var profileImageName:String?
    
}
