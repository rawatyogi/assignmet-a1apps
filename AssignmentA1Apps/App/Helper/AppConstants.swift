//
//  AppConstants.swift
//  AssignmentA1Apps
//
//  Created by Yogi Rawat on 19/09/25.
//

import UIKit
import Foundation


//MARK: URL SECTION
class BaseURL {
     static var baseURL: String {
        return "https://core-apis.a1apps.co/"
    }
}

enum Endpoints: String {
    case interview_details = "ios/interview-details"
}

//MARK: ERROR HANDLING
enum AppErrors: Error {
    
    case invalid_url
    case no_data_found
    case request_failed
    case something_went_wrong
    case data_could_not_parse
    
    //populate this msg
    var errorMsg: String {
        
        switch self {
            
        case .invalid_url:
            return ""
            
        case .request_failed:
            return "Request failed, Please check your connection"
            
        case .no_data_found:
            return "data not found!"
            
        case .something_went_wrong:
            return "Something went wrong! Try Again"
            
        case .data_could_not_parse:
            return "Could not parse!"
        }
    }
}


//MARK: LOGGIONG SECTION
struct AppLogs {
   
    private init() {}
    static var shared = AppLogs()
    
    func debugLogs<T>(_ toPrint: T) {
        debugPrint(toPrint)
    }
}
