//
//  HomeViewModel.swift
//  Deprem
//
//  Created by Onur Duyar on 16.04.2023.
//

import Foundation

final class HomeViewModel {
    static let shared = HomeViewModel()
    
    var lastEarthQuakes: [EarthQuake]?
    private init() {}
    
    func fetchData(completion: @escaping ((Result<[EarthQuake]?, Error>) -> Void )){
        BaseNetworkService().request(APIRequest()) { result in
            switch result {
            case .success(let response):
                self.lastEarthQuakes = response.result
                completion(.success(self.lastEarthQuakes))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
