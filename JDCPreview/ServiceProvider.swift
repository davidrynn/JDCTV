//
//  ServiceProvider.swift
//  JDCPreview
//
//  Created by David Rynn on 11/9/15.
//  Copyright © 2015 David Rynn. All rights reserved.
//

import Foundation
import TVServices

class ServiceProvider: NSObject, TVTopShelfProvider {

    override init() {
        super.init()
    }

    // MARK: - TVTopShelfProvider protocol

    var topShelfStyle: TVTopShelfContentStyle {
        // Return desired Top Shelf style.
        return .Inset
    }

    var topShelfItems: [TVContentItem] {
        // Create an array of TVContentItems.
        let item1 = TVContentItem(contentIdentifier: TVContentIdentifier(identifier: "JDCTV.item1", container: nil)!)
        item1?.imageURL = NSURL(string: "https://tctechcrunch2011.files.wordpress.com/2015/01/jet.png?w=680&h=394")
        let item2 = TVContentItem(contentIdentifier: TVContentIdentifier(identifier: "JDCTV.item1", container: nil)!)

        item2?.imageURL = NSURL(string: "http://cdn2.hubspot.net/hub/427956/hubfs/jet-1.jpg?t=1441885473008&width=493")
        item2?.imageShape = TVContentItemImageShape.Square
        return [item1!, item2!]
    }
    

}



