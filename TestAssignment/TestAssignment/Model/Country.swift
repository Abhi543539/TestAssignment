//
//  Country.swift
//  TestAssignment
//
//  Created by Abhishek Singla on 29/04/20.
//  Copyright © 2020 Abhishek Singla. All rights reserved.
//

import Foundation

// MARK: - Country
struct Country: Codable {
    let title: String
    let facts: [CountryFact]

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decode(String.self, forKey: .title)
        let facts = try container.decode([CountryFact].self, forKey: .facts)
        self.facts = facts.filter({$0.title != nil})
    }

    private enum CodingKeys: String, CodingKey {
        case title
        case facts = "rows"
    }

}

// MARK: - Row
struct CountryFact: Codable {
    let title, rowDescription: String?
    let imageHref: String?

    enum CodingKeys: String, CodingKey {
        case title
        case rowDescription = "description"
        case imageHref
    }

}
