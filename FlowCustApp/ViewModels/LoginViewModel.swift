//
//  LoginViewModel.swift
//  FlowCustApp
//
//  Created by Thana Priya on 18/04/1944 Saka.
//  Copyright © 1944 comorins. All rights reserved.
//

import Foundation

class LoginViewModel: ObservableObject {
    
    let defaults = UserDefaults.standard
    @Published var token = ""
    @Published var isLoggedIn = false
    let api = RequestService()
    
    func loginPost(parameters:[String : Any], completion: @escaping (Login?, URLResponse?, Error?) -> Void) -> Void {
       self.api.httpRequest(endpoint: "api/cust_mob/login", parameters: parameters, completion: completion)
    }
    
    func doLogin(param: [String: Any]) {
        loginPost(parameters: param) { (data, response, err) in
            DispatchQueue.main.async{
                if let data = data {
                   if(data.status == "success"){
                        self.defaults.set("true", forKey:"isLoggedIn" )
                        self.isLoggedIn = true
                        self.token = data.data.accessToken
                   }
                }else{
                    if let err = err {
                        print("eeee\(err.localizedDescription)")
                    }
                }
            }
        }
    }
    
}

struct Login: Codable {
    
    let status: String
    let statusCode: Int
    let data: DataClass
    let userID: Int

    enum CodingKeys: String, CodingKey {
        case status
        case statusCode = "status_code"
        case data
        case userID = "user_id"
    }
}

// MARK: - DataClass
struct DataClass: Codable {
    let accessToken, tokenType: String
    let expiresIn: Int
    let dataDefault: Default
    let userID: Int

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
        case expiresIn = "expires_in"
        case dataDefault = "default"
        case userID = "user_id"
    }
}

// MARK: - Default
struct Default: Codable {
    let category: String
    let custName: CustName
    let photoPpsPath: String
    let flowRelMgrName: FlowRelMgrName
    let accPrvdrLogos, accNumLabel, accPrvdrName: Acc
    let countryCode, currencyCode: String

    enum CodingKeys: String, CodingKey {
        case category
        case custName = "cust_name"
        case photoPpsPath = "photo_pps_path"
        case flowRelMgrName = "flow_rel_mgr_name"
        case accPrvdrLogos = "acc_prvdr_logos"
        case accNumLabel = "acc_num_label"
        case accPrvdrName = "acc_prvdr_name"
        case countryCode = "country_code"
        case currencyCode = "currency_code"
    }
}

// MARK: - Acc
struct Acc: Codable {
    let uezm, umtn, cca: String
    let udfc, uflw: String?

    enum CodingKeys: String, CodingKey {
        case uezm = "UEZM"
        case umtn = "UMTN"
        case cca = "CCA"
        case udfc = "UDFC"
        case uflw = "UFLW"
    }
}

// MARK: - CustName
struct CustName: Codable {
    let firstName: String

    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
    }
}

// MARK: - FlowRelMgrName
struct FlowRelMgrName: Codable {
    let firstName: String
    let middleName: String?
    let lastName: String

    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case middleName = "middle_name"
        case lastName = "last_name"
    }
}
