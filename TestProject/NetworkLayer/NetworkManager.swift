//
//  NetworkManager.swift
//  TestProject
//
//  Created by Nana Jimsheleishvili on 23.11.23.
//

import Foundation

final class NetworkManager {
    
    static let shared = NetworkManager()
    #warning("shared has to be static")
    
    public init() {}
    
    func get<T: Decodable>(urlString: String, completion: @escaping ((Result<T, Error>) -> Void)) {
        #warning("We did not have an actual url in URL(), and changed the name to urlString, so it did not match url")
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            #warning("Best to write an error if the process doesn't go according to plan")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                completion(.failure(error))
                #warning("Missing error = error, and checked my previous homework, dispatcgQueu was nor needed")
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: -2, userInfo:[NSLocalizedDescriptionKey: "No data received"])))
                #warning("Didn't equal data to data")
                return }
            
            do {
                let decoded = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decoded.data))
                #warning("decoeded.data to get the data")
            } catch let error {
                completion(.failure(error))
            }
        }.resume()
        #warning("To resume with the app;ication")
    }
}
