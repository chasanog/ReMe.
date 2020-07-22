//
//  Remi.swift
//  ReMi
//
//  Created by Cihan Hasanoglu on 06.07.20.
//  Copyright © 2020 Cihan Hasanoglu. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Remi: Codable, Identifiable {
    @DocumentID var id: String?
    var remiDescription: String
    var count: Int
    @ServerTimestamp var createdTime: Timestamp?
    var userID: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case remiDescription
        case count
        case createdTime
        case userID
    }
}
#if DEBUG
//let testDataRemi = [
//    Remi(remiDescription: "This is the Title of a Story", count: 10),
//    Remi(remiDescription: "This is another Title of a Story", count: 20),
//    Remi(remiDescription: "This is the third Title of a Story", count: 32),
//    Remi(remiDescription: "This is the fourth Title of a Story", count: 33),
//    Remi(remiDescription: "This is another Title of a Story", count: 20),
//    Remi(remiDescription: "This is the third Title of a Story", count: 32),
//    Remi(remiDescription: "This is the fourth Title of a Story", count: 33)
//]
#endif
