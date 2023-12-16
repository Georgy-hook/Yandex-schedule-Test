//
//  CityService.swift
//  Yandex-schedule-Test
//
//  Created by Georgy on 16.12.2023.
//

import Foundation

typealias CityCompletion = (Result<CityModel, Error>) -> Void

protocol CityService {
    func loadCodeOfCity(name: String, completion: @escaping CityCompletion)
}

final class CityServiceImpl: CityService {
    private let networkClient: NetworkClient
    
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    func loadCodeOfCity(name: String, completion: @escaping CityCompletion) {
        let request = CityRequest(name: name)
        
        networkClient.send(request: request, type: CityModel.self, completionQueue: .main) { result in
            switch result {
            case .success(let code):
                completion(.success(code))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
