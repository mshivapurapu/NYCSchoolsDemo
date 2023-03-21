//
//  ListService.swift
//  VirtusaTest
//
//  Created by Mahendra Shivapurapu on 21/03/23.
//

import Foundation
import Alamofire

protocol ListServiceProtocol {
    //Add addtional methods here
    func getList(completion: @escaping ([ListData]?)->())
}

class ListService: ListServiceProtocol {
    func getList(completion: @escaping ([ListData]?)->()) {
        let decoder: JSONDecoder = {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return decoder
        }()
        
        //TODO: Move to generic Network Manager and inject it into this service
        AF.request("https://data.cityofnewyork.us/resource/s3k6-pzi2.json").responseDecodable(of: [ListData].self,
                                                                                              decoder: decoder) { response in
            if let error = response.error {
                //handle errors and other edge cases
                completion(nil)
                return
            }
            completion(try? response.result.get())
        }
    }
}
