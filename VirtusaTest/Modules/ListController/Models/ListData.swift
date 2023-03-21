//
//  ListData.swift
//  VirtusaTest
//
//  Created by Mahendra Shivapurapu on 21/03/23.
//

import Foundation

struct ListData: Codable {
    let dbn, schoolName, boro, overviewParagraph: String?
    let school10ThSeats, academicopportunities1, academicopportunities2, ellPrograms: String?
    let neighborhood, buildingCode, location, phoneNumber: String?
    let faxNumber, schoolEmail, website, subway: String?
    let bus: String?
}
