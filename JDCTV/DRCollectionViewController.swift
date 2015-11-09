//
//  DRCollectionViewController.swift
//  JDCSwiftTV
//
//  Created by David Rynn on 11/7/15.
//  Copyright © 2015 David Rynn. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class DRCollectionViewController: UICollectionViewController {
    var images: [NSIndexPath: UIImage]?
    var imagesArray: [UIImage]?
    let fullScreenImageView: UIImageView
    let originalImageView: UIImageView
    let effectView: UIVisualEffectView
    let instagramApi: DRAPIUtility
    
// MARK: Custom Initializer
    
    init(){
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        self.images = [:]
        self.imagesArray = [UIImage](count: 39, repeatedValue: (UIImage(named: "jdc"))!)
        self.fullScreenImageView = UIImageView()
        self.originalImageView = UIImageView()
        self.effectView = UIVisualEffectView()
        self.instagramApi = DRAPIUtility()
        super.init(collectionViewLayout: layout)
    }

    required init?(coder aDecoder: NSCoder?)
    {
        self.images = [:]
        self.imagesArray = [UIImage](count: 39, repeatedValue: UIImage(named: "jdc")!)
        self.fullScreenImageView = UIImageView()
        self.originalImageView = UIImageView()
        self.effectView = UIVisualEffectView()
        self.instagramApi = DRAPIUtility()
        super.init(coder: aDecoder!)
    }
    
//MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Register cell classes
        collectionView!.registerClass(DRCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
        collectionView?.accessibilityIdentifier = "Image List"
        collectionView?.accessibilityLabel = "Image List"
        accessibilityLabel = "Image List Controller"
        

        
        title = "Jet.com Challenge";
    
        self.setupLongGesture()
        
        collectionView?.showsVerticalScrollIndicator = false
        
        let newIndexPath = NSIndexPath.init(forItem: 3, inSection: 0)
        collectionView?.scrollToItemAtIndexPath(newIndexPath, atScrollPosition: UICollectionViewScrollPosition.Top, animated: true)
        collectionView!.backgroundColor = UIColor.whiteColor()
        

//        images = [:]
//        imagesArray = [UIImage](count: 39, repeatedValue: UIImage(named: "jdc")!)
        self.setupDataForCollectionView()
    }
    
    func setupLongGesture(){
    }
    func setupDataForCollectionView(){
        
        instagramApi.getImages(fromPage: 0, withImageClosure: { (image, indexPath) -> Void in
            self.images?.updateValue(image, forKey: indexPath)
            self.imagesArray?[indexPath.row] = image
            if indexPath.row >= 30{
            self.imagesArray?[indexPath.row-30] = image
            }
            if indexPath.row <= 2{
                self.imagesArray?[indexPath.row+36] = image
            }
            
            self.collectionView?.reloadItemsAtIndexPaths([indexPath])
            
            
            }, andCompletionHandler: nil)
        
//        [self.instagramApi getImagesPage: 0 imageBlock:^(UIImage *image, NSIndexPath *indexPath) {
//            
//            [self.images setObject:image forKey:indexPath];
//            [self.imagesArray replaceObjectAtIndex:indexPath.row+3 withObject:image];
//            //if statements setting up for infinite cycle
//            if (indexPath.row>=30) {
//            [self.imagesArray replaceObjectAtIndex:indexPath.row-30 withObject:image];
//            }
//            if (indexPath.row<=2) {
//            [self.imagesArray replaceObjectAtIndex:indexPath.row+36 withObject:image];
//            }
//            
//            [self.collectionView reloadItemsAtIndexPaths:@[indexPath]];
//            
//            } completionBlock:nil];
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
     //   navigationController?.hidesBarsOnSwipe = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 39
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! DRCollectionViewCell
        let image = UIImage(named: "jdc")!
        if (imagesArray?[indexPath.row] != nil){
        cell.imageView.image = imagesArray![indexPath.row]
        } else {
        cell.imageView.image = image
        }
        // Configure the cell

        return cell
    }


    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}
