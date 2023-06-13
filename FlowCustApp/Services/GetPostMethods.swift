//
//  GetPostMethods.swift
//  FlowCustApp
//
//  Created by Thana Priya on 18/04/1944 Saka.
//  Copyright © 1944 comorins. All rights reserved.
//

import Foundation

func getRequest() {
    guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
    let request = URLRequest(url: url)
    URLSession.shared.dataTask(with: request) {data, _, error in
        DispatchQueue.main.async {
            if let data = data {
                do {
                    let decodedData = try JSONSerialization.data(withJSONObject: data, options: .fragmentsAllowed)
                    print(decodedData)
                } catch {
                    print(error)
                }
            }
        }
    }.resume()
}

func postRequest() {
    guard let url = URL(string: "http://13.234.42.35:8000/api/cust_mob/login") else { return }
    
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    let body : [String: AnyHashable] = [
        "country_code": "UGA",
        "mobile_num": "756729120",
        "pin": 1234
    ]
    request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
    
    URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    let str = String(decoding: data, as: UTF8.self)
                    print("str \(str)")
                    let response = try! JSONSerialization.data(withJSONObject: data, options: .fragmentsAllowed)
                    print(response)
                }
                
            }
    }.resume()
}
