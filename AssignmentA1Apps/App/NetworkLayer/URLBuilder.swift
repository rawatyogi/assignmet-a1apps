//
//  URLBuilder.swift
//  AssignmentA1Apps
//
//  Created by Yogi Rawat on 19/09/25.
//

import Foundation

protocol URLBuilder {
    func createRequest(endpoint: Endpoints) -> URLRequest? //get
}

class RequestBuilder : URLBuilder {
    func createRequest(endpoint: Endpoints) -> URLRequest? {
        guard let url = URL(string: BaseURL.baseURL + endpoint.rawValue) else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        return request
    }
}
