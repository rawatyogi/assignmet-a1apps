//
//  Services.swift
//  AssignmentA1Apps
//
//  Created by Yogi Rawat on 19/09/25.
//

import Foundation

protocol Services {
    func request(request: URLRequest) async -> Result<Data,AppErrors>
}

// SERVICE: OUTFITS
class OutfitServices: Services {
    
    func request(request: URLRequest) async -> Result<Data,AppErrors> {
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let response = (response as? HTTPURLResponse), response.statusCode == 200 else {
                return .failure(.something_went_wrong)
            }
            return .success(data)
        } catch {
            print(error.localizedDescription)
            return .failure(.something_went_wrong)
        }
    }
}
