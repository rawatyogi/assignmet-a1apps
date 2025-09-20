//
//  Parser.swift
//  AssignmentA1Apps
//
//  Created by Yogi Rawat on 19/09/25.
//

import Foundation


protocol DataParser {
    func decode<T: Decodable>(data: Data, as type: T.Type) -> Result<T, AppErrors>
}

struct Parser: DataParser {
    func decode<T>(data: Data, as type: T.Type) -> Result<T, AppErrors> where T : Decodable {
        do {
            let decoded = try JSONDecoder().decode(T.self, from: data)
            return .success(decoded)
        } catch {
            return .failure(.data_could_not_parse)
        }
    }
}
