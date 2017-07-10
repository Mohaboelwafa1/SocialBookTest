//
//  SharePhoto.swift
//  FaceBook
//
//  Created by mohamed hassan on 7/10/17.
//  Copyright © 2017 mohamed hassan. All rights reserved.
//

import Foundation
import UIKit

import FacebookLogin
import FBSDKCoreKit

import FacebookShare
import FacebookCore
import FBSDKLoginKit

import Social
import FacebookShare
import SDWebImage

class SharePhoto: UIViewController {
    
    
    // outlets of objects from storyboard
    @IBOutlet weak var outletOfShareButton: UIButton!
    @IBOutlet weak var outletOfImageView: UIImageView!
    
    
    override func viewDidLoad() {
        // --  using library to down and cashe an image
        
        outletOfImageView.sd_setImage(with: URL(string: "https://dummyimage.com/600x400/000/fff"), placeholderImage: UIImage(named: "placeholder.png"))
    }
    
    
    
    // share the photo to facebook
    @IBAction func actionOfShareButton(_ sender: Any) {
        
        do {
            let photo = Photo(image: outletOfImageView.image!, userGenerated: true)
            let content = PhotoShareContent(photos: [photo])
            try ShareDialog.show(from: self, content: content)
        } catch {
            //handle error
            print(error)
        }
        
    }
    
}
