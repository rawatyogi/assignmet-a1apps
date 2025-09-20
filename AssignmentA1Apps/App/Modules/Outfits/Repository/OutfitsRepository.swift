//
//  OutfitsRepository.swift
//  AssignmentA1Apps
//
//  Created by Yogi Rawat on 19/09/25.
//

import Foundation

protocol RepositoryOutfit {
    func fetchOutfits() async -> Result<OutfitModel, AppErrors>
}

//MARK: CLASS: OUTFITS REPO
class OutfitsRepository : RepositoryOutfit {
   
    //MARK: PROPERTIES
    private let service: Services
    private let parser: DataParser
    private let requestBuilder: URLBuilder
    
    init(service: Services, builder: URLBuilder, parser: DataParser) {
        self.parser = parser
        self.service = service
        self.requestBuilder = builder
    }
    
    //MARK: FETCH OUTFITS
    func fetchOutfits() async -> Result<OutfitModel, AppErrors> {
        
        guard let urlRequest = requestBuilder.createRequest(endpoint: .interview_details) else {
            return .failure(.invalid_url)
        }
        
        let result = await service.request(request: urlRequest)
        return result.flatMap { data in
            parser.decode(data: data, as: OutfitModel.self)
        }
    }
}


struct RepositoryFactory {
    static func makeOutfitRepository() -> RepositoryOutfit {
        OutfitsRepository(
            service: OutfitServices(),
            builder: RequestBuilder(),
            parser: Parser()
        )
    }
}
