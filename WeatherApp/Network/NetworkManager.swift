//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by Yavuz Ulgar on 29.04.2023.
//

import Foundation
import Alamofire

struct NetworkManager {
    
    static let shared = NetworkManager()
    // Download a random story
    func downloadData(url: URL, completion: @escaping (Data?) -> ()) {
        
        AF.request(url).response { result in
            if let error = result.error {
                print(error.localizedDescription)
            } else if let data = result.data {
                let weatherModels = data
                completion(weatherModels)
            }
        }
    }
}
