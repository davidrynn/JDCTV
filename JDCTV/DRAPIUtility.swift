//
//  DRAPIUtility.swift
//  JDCSwiftTV
//
//  Created by David Rynn on 11/7/15.
//  Copyright © 2015 David Rynn. All rights reserved.
//

typealias imageClosure = (UIImage, NSIndexPath) -> Void


import UIKit
import Alamofire

class DRAPIUtility: NSObject {
    func getImages(fromPage pageNumber: Int,
        withImageClosure imageClosure:((UIImage, NSIndexPath) -> Void)?, andCompletionHandler completion:(()->Void)?){
            
            let placeholderImage = UIImage(named: "jdc")

            let queue = NSOperationQueue()
            queue.maxConcurrentOperationCount = 10
            
            let imageQueue = NSOperationQueue()
            imageQueue.maxConcurrentOperationCount = 10
            
            let instagramURL = NSURL(string: "https://api.instagram.com/v1/tags/jetdotcom/media/recent?client_id=" + Constants.Keys.CLIENT_ID + "&count=33")
            
            let request = NSURLRequest(URL: instagramURL!)
            
            Alamofire.request(request).responseJSON{ response in
//                print("Response JSON: \(response.result.value)")
                if let dictionary = response.result.value as? [String: AnyObject] {
                    let dataArray = dictionary["data"]
                    let desiredCount = dataArray?.count
                    for var i=0; i<desiredCount; i++ {
                        var image: UIImage
                        if let imageURL = NSURL(string: ((dataArray![i]["images"]!!["low_resolution"]!!["url"]) as? String)!) {
                            let imageData = NSData(contentsOfURL: imageURL)
                            image = UIImage(data: imageData!)!
                        } else {
                            image = placeholderImage!
                        }
                        let indexPath = NSIndexPath(forItem: i, inSection: 0)
                        imageClosure!(image, indexPath)
                        
                    }
                }
            }
    }
 
}
