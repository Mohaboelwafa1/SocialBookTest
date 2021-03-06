//
//  Reachability.swift
//  FaceBook
//
//  Created by mohamed hassan on 7/10/17.
//  Copyright © 2017 mohamed hassan. All rights reserved.
//

import Foundation
import SystemConfiguration



// Check internet connection wifi or mobile data

public class Reachability {
    class func isConnectedToNetwork()->Bool {
        
        var Status:Bool = false
        let url = NSURL(string: "http://google.com/")
        let request = NSMutableURLRequest(url: url! as URL)
        request.httpMethod = "HEAD"
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringLocalAndRemoteCacheData
        request.timeoutInterval = 10.0
        
        var response: URLResponse?
        
        
        do {
            _ = try NSURLConnection.sendSynchronousRequest(request as URLRequest, returning: &response)
            
        } catch {
            
        }
        if let httpResponse = response as? HTTPURLResponse {
            if httpResponse.statusCode == 200 {
                Status = true
            }
        }
        
        return Status
    }
    
}
