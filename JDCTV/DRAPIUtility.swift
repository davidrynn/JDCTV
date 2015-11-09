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
            var returnedCount = 0
//            var desiredCount: Int
            var responseDictionary = [:]

            let queue = NSOperationQueue()
            queue.maxConcurrentOperationCount = 10
            
            let imageQueue = NSOperationQueue()
            imageQueue.maxConcurrentOperationCount = 10
            
            let instagramURL = NSURL(string: "https://api.instagram.com/v1/tags/jetdotcom/media/recent?client_id=" + Constants.Keys.CLIENT_ID + "&count=33")
            

            let request = NSURLRequest(URL: instagramURL!)
            
            Alamofire.request(request).responseJSON{ response in
//                print("Response JSON: \(response.result.value)")
                if let dico = response.result.value as? [String: AnyObject] {
                    let dataArray = dico["data"]
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
                
//                if var response.result.value = response.result.value as? [String: AnyObject] {
//                    responseDictionary = (response.result.value as? [String: AnyObject])!
//                }
                
                

            }
            

            
    }
    
    /*
    - (void)getImagesPage: (NSUInteger) pageNumber
    imageBlock:(void (^)(UIImage *, NSIndexPath *))imageBlock
    completionBlock:(void (^)())completion
    {
    __block UIImage *placeholderImage = [UIImage imageNamed:@"jdc"];
    __block NSInteger returnedCount=0;
    __block NSInteger desiredCount= 33;
    
    // make 2 threads -> one for first URLrequest, other for image requests
    NSOperationQueue* queue = [[NSOperationQueue alloc] init];
    queue.maxConcurrentOperationCount = 10;
    
    NSOperationQueue* imageQueue = [[NSOperationQueue alloc] init];
    imageQueue.maxConcurrentOperationCount = 10;
    
    // setup request operation (URL -> request -> requestOperation)
    NSURL *instagramImagesURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.instagram.com/v1/tags/jetdotcom/media/recent?client_id=%@&count=33", CLIENT_ID]];
    
    NSURLRequest* request = [NSURLRequest requestWithURL:instagramImagesURL];
    AFHTTPRequestOperation* operation =
    [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    // says we want JSON serialization (makes it a dictionary)
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    // set completion block to handle JSON response
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation* operation,
    id responseObject) {
    // cast response as a dictionary
    NSDictionary* responseDictionary = (NSDictionary*)responseObject;
    // iterate over dictionary
    for (NSInteger i = 0; i < desiredCount; i++) {
    [imageQueue addOperationWithBlock:^{
    
    // make image's index path
    NSIndexPath* indexpath = [NSIndexPath indexPathForRow:i inSection:0];
    
    // get image data
    NSArray *dataArray =responseDictionary[@"data"];
    
    // load imageData via contents with URL
    NSData* imageData = [NSData dataWithContentsOfURL:
    [NSURL URLWithString:dataArray[i][@"images"][@"low_resolution"][@"url"]]];
    
    // convert NSData to UIImage
    UIImage* instagramImage = [UIImage imageWithData:imageData];
    // if it failed, just give it the placeholder
    if (!instagramImage) {
    instagramImage = placeholderImage;
    }
    // creates operation that yields to the image block
    NSOperation *imageOperation = [NSBlockOperation blockOperationWithBlock:^{
    // yielding passes image and indexpath to collectionViewController
    imageBlock(instagramImage, indexpath);
    }];
    
    // create operation that increments count / checks completion
    NSOperation *checkCompleteOperation = [NSBlockOperation blockOperationWithBlock:^{
    returnedCount++;
    if (returnedCount==desiredCount) {
    if (completion) {
    completion();
    }
    }
    }];
    // sets "checkCompletionOperation" to fire only after "imageOperation" finishes
    [checkCompleteOperation addDependency:imageOperation];
    // calls imageOperation on main thread to free up imageThread (can only do 10 at a time)
    [[NSOperationQueue mainQueue] addOperation:imageOperation];
    // queues checkCompleteOp (only fire after imageOp) on mainThread so it will happen in order in a centralized place
    [[NSOperationQueue mainQueue] addOperation:checkCompleteOperation];
    }];
    }
    }
    // this happens when it fails...
    failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
    NSLog(@"APIUtility failure: %@", error.localizedDescription);
    }];
    
    [queue addOperation:operation];
    };
    */
}
