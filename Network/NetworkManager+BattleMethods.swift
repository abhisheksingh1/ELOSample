//
//  NetworkManager+BattleMethods.swift
//  GameofThrones
//
//  Created by Abhishek on 05/05/18.
//  Copyright © 2018 Abhishek. All rights reserved.
//

import Foundation

extension NetworkManager {
    func requestBattleData(completionHandler: @escaping ((_ battleData: [Battle]?, _ error: String?) -> Void)) {
        callRestAPI(url: jsonUrl) { (response, error) in
            if error != nil {
                OperationQueue.main.addOperation {
                    completionHandler(nil, error?.localizedDescription)
                }
            } else {
                var battleList:[Battle] = []
                if let responseArr:Array = (response as? [AnyObject]){
                    for battle in responseArr
                    {
                        let battleEntity:Battle = Battle.mr_createEntity(in: NSManagedObjectContext.mr_default())!
                        battleEntity.mr_importValuesForKeys(with: battle)
                        battleList.append(battleEntity)
                    }
                }
                OperationQueue.main.addOperation {
                    completionHandler(battleList, nil)
                }
            }
        }
    }
}
