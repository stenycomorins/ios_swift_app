//
//  RequestService.swift
//  FlowCustApp
//
//  Created by Thana Priya on 18/04/1944 Saka.
//  Copyright © 1944 comorins. All rights reserved.
//

import Foundation

struct Constants {
    static let BASEURL : String = "http://13.234.42.35:8000/"
}

class RequestService {
    func httpRequest <T: Codable>(
            endpoint: String,
            parameters: [String: Any],
            completion: @escaping(T?, URLResponse?, Error?) -> Void
        ) {
        guard let url = URL(string : Constants.BASEURL + endpoint) else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {
            return
        }
        
        request.httpBody = httpBody
        request.timeoutInterval = 20
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                completion(nil, response, error)
                return
            }
            if let decodedData = try? self.newJSONDecoder().decode(T.self, from: data) {
                completion(decodedData,response,nil)
            } else {
                print("decoding error")
            }
            
//
            }.resume()
    }

    func newJSONDecoder() -> JSONDecoder {
       let decoder = JSONDecoder()
       if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
           decoder.dateDecodingStrategy = .iso8601
       }
       return decoder
    }
    
}
