//
//  ApiService.swift
//  youtube
//
//  Created by German Mendoza on 7/21/16.
//  Copyright © 2016 German LLC. All rights reserved.
//

import UIKit

class ApiService: NSObject {
    
    static let sharedInstance = ApiService()
    
    let baseURL = "https://s3-us-west-2.amazonaws.com/youtubeassets"
    
    func fetchVideos(completion:([Video])->()){
        fetchFeedForUrlString("\(baseURL)/home.json", completion: completion)
    }
    
    func fetchTrendingFeed(completion:([Video])->()){
        fetchFeedForUrlString("\(baseURL)/trending.json", completion: completion)
    }
    
    func fetchSubscriptionFeed(completion:([Video])->()){
        fetchFeedForUrlString("\(baseURL)/subscriptions.json", completion: completion)
    }
    
    func fetchFeedForUrlString(urlString:String, completion:([Video]) ->()){
        
        let url = NSURL(string: urlString)
        
        NSURLSession.sharedSession().dataTaskWithURL(url!) { (data, response, error) in
            if error != nil {
                print(error)
                return
            }
            do {
                
                if let unwrappedData = data, jsonDictionaries = try NSJSONSerialization.JSONObjectWithData(unwrappedData, options: .MutableContainers) as? [[String:AnyObject]] {
        
                    dispatch_async(dispatch_get_main_queue(), {
                        completion(jsonDictionaries.map({ return Video(dictionary: $0) }))
                    })
                    
                }
                
            } catch let jsonError {
                print(jsonError)
            }
            
            }.resume()
        
    }

}
