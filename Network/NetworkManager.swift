//
//  NetworkManager.swift
//  GameofThrones
//
//  Created by Abhishek on 05/05/18.
//  Copyright © 2018 Abhishek. All rights reserved.
//

import UIKit
import  Alamofire

class NetworkManager: NSObject {
    static let sharedManager = NetworkManager()
    private override init() { }
    
    func callRestAPI(url: String, completionHandler: @escaping(_ response: Any?, _ error: NSError?)-> Void) {
        Alamofire.request(url).responseJSON { response in
            switch(response.result) {
            case .success(_):
                OperationQueue.main.addOperation {
                    completionHandler(response.result.value, nil)
                }
                break
            case .failure(_):
                OperationQueue.main.addOperation {
                   completionHandler(nil, response.error! as NSError)
                }
                break
            }
            if let json = response.result.value {
                print("JSON: \(json)") // serialized json response
            }
        }
    }
}
