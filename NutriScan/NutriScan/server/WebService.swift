//
//  WebService.swift
//  NutriScan
//
//  Created by KAWTHAR on 2024-03-16.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case decodingError
}

class WebService {
    //Data is a byte buffer in memory
    // pasrse argument is a closure function
    
    func get<T: Decodable>(url: URL, parse: (Data)->T?) async throws -> T {
        
        // url request session
        let (data, response) = try await URLSession.shared.data(from: url)
        
        // check response
        guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200
        else {
            throw NetworkError.invalidResponse
        }
        
        guard let result = parse(data) else {
            throw NetworkError.decodingError
        }
        
        return result
    }
    
}
