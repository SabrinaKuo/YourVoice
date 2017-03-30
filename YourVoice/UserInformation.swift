//
//  UserInformation.swift
//  YourVoice
//
//  Created by sabrina.kuo on 2017/3/30.
//  Copyright © 2017年 Sabrina Kuo. All rights reserved.
//

import UIKit
import FacebookCore

class UserInformation {
    
    let id: String!
    let name: String!
    let gender: String?
    let age: Int?
    let avatar: URL!
    
    init(rawData: [String: Any]){

        id = rawData["id"] as! String
        name = rawData["name"] as! String
        gender = rawData["gender"] as? String
        
        if let userID = id {
            let largePic = "http://graph.facebook.com/"+userID+"/picture?type=normal"
            print("Avatar url : \(largePic)")
            avatar = URL(string: largePic)
        } else {
            let pic = rawData["picture"] as! [String: Any]
            let data = pic["data"] as? [String: Any]
            let url = data?["url"] as? String
            print("Avatar url : \(url)")
            if url != nil {
                avatar = URL(string: url!)
            } else {
                avatar = nil
            }
        }

        age = 30
        
    }
    
    class func getUserInfomation(compeleteHandler: @escaping (UserInformation?, Error?) -> Void){
        
        let connection = GraphRequestConnection()
        connection.add(MyProfileRequest()) { response, result in
            switch result {
            case .success(let graphResponse):
                print("Custom Graph Request Succeeded: \(graphResponse.dictionaryValue)")
                
                let rawData = graphResponse.dictionaryValue!
                
                let profile = UserInformation.init(rawData: rawData)
                
                compeleteHandler(profile, nil)
                
            case .failed(let error):
                print("Custom Graph Request Failed: \(error)")
                compeleteHandler(nil, error)
            }
        }
        connection.start()
        
    }

}

struct MyProfileRequest: GraphRequestProtocol {
    struct Response: GraphResponseProtocol {
        let rawResponse: Any?
        init(rawResponse: Any?) {
            self.rawResponse = rawResponse
        }
        
        public var dictionaryValue: [String : Any]? {
            return rawResponse as? [String : Any]
        }
    }
    
    var graphPath = "/me"
    var parameters: [String : Any]? = ["fields": "birthday,email,id,name,gender,picture"]
    var accessToken = AccessToken.current
    var httpMethod: GraphRequestHTTPMethod = .GET
    var apiVersion: GraphAPIVersion = .defaultVersion

}





