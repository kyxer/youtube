//
//  SubscriptionCell.swift
//  youtube
//
//  Created by German Mendoza on 7/21/16.
//  Copyright © 2016 German LLC. All rights reserved.
//

import UIKit

class SubscriptionCell: FeedCell {
    
    override func fetchVideos() {
        
        ApiService.sharedInstance.fetchSubscriptionFeed { (videos) in
            self.videos = videos
            self.collectionView.reloadData()
        }
        
    }

}
