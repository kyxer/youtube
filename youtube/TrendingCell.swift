//
//  TrendingCell.swift
//  youtube
//
//  Created by German Mendoza on 7/21/16.
//  Copyright © 2016 German LLC. All rights reserved.
//

import UIKit

class TrendingCell: FeedCell {

    
    override func fetchVideos() {
        
        ApiService.sharedInstance.fetchTrendingFeed { (videos) in
            self.videos = videos
            self.collectionView.reloadData()
        }
        
    }
    

}
