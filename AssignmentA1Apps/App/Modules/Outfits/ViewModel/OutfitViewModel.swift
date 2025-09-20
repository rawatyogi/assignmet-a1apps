//
//  OutfitViewModel.swift
//  AssignmentA1Apps
//
//  Created by Yogi Rawat on 19/09/25.
//

import Foundation

class OutfitViewModel {
    
    //MARK: PROPERTIES
    var outfits = [Outfit]()
    var repository: RepositoryOutfit
    
    init(repo: RepositoryOutfit) {
        self.repository = repo
    }
    
    //MARK: Service: For fetching outfits
    func fetchOutfits() async -> Result<[Outfit], AppErrors> {
        
        let result = await repository.fetchOutfits()
        
        switch result {
            
        case .success(let success):
            self.outfits = success.data ?? []
            return .success(self.outfits)
            
        case .failure(let failure):
            return .failure(failure)
        }
    }
}
