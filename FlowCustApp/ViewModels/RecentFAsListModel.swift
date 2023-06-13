//
//  RecentFAsListModel.swift
//  FlowCustApp
//
//  Created by Thana Priya on 18/04/1944 Saka.
//  Copyright © 1944 comorins. All rights reserved.
//

import Foundation

class RecentFAsListModel: ObservableObject {
    
    @Published var recentfas = [Datum]()
    
    let api = RequestService()
    
    func request(parameters:[String : Any], completion: @escaping (RecentFAsModel?, URLResponse?, Error?) -> Void) -> Void {
       self.api.httpRequest(endpoint: "api/cust_mob/recent_fas", parameters: parameters, completion: completion)
    }
    
    func fetchrecentfas(param: [String: Any]) {
        request(parameters: param) { (data, response, err) in
            DispatchQueue.main.async{
                if let data = data {
                   if(data.status == "success"){
                    self.recentfas = data.data
                   }
                }else{
                   print("Something went wrong")
                }
            }
        }
    }
}

struct RecentFAsModel: Codable {
    let status: String
    let statusCode: Int
    let message: String?
    let data: [Datum]

    enum CodingKeys: String, CodingKey {
        case status
        case statusCode = "status_code"
        case message, data
    }
}

// MARK: - Datum
struct Datum: Identifiable, Codable {
    let id = UUID()
    let faID: String
    let amt: Int
    let disDt, payDt: String
    let dur, fee: Int
    let paidAmt, dueDt, apCode: String

    enum CodingKeys: String, CodingKey {
        case faID = "fa_id"
        case amt
        case disDt = "dis_dt"
        case payDt = "pay_dt"
        case dur, fee
        case paidAmt = "paid_amt"
        case dueDt = "due_dt"
        case apCode = "ap_code"
    }
}
