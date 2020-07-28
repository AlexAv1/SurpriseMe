//
//  UsersServerDataProvider.swift
//  Test
//
//  Created by iMac on 10.06.2020.
//  Copyright © 2020 AlexAviJr. All rights reserved.
//

import UIKit
import Moya

enum UsersServerDataProvider {
    case users
}

extension UsersServerDataProvider: TargetType {
    
    var baseURL: URL {
        return URL(string: "https://learnappmaking.com/ex/")!
    }
    
    var path: String {
        
        switch self {
        case .users:
            return "users.json"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Task {
        switch self {
        case .users:
            return .requestPlain
        }
    }
    
    var validationType: ValidationType {
        switch self {
        case .users:
            return .none
        }
    }
    
    var sampleData: Data {
        switch self {
        case .users:
            return "".data(using: String.Encoding.utf8)!
        }
    }
    
    var headers: [String: String]? {
        return nil
    }
    
}
