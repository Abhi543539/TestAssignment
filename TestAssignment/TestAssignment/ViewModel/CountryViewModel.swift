//
//  CountryViewModel.swift
//  TestAssignment
//
//  Created by Abhishek Singla on 29/04/20.
//  Copyright © 2020 Abhishek Singla. All rights reserved.
//
import Foundation
import UIKit

/// This class acts as view-model class
 class CountryVM {

    // MARK: - Variables
    private var country: Country? {
        didSet {
            needsRefresh?()
        }
    }

    var needsRefresh: (() -> Void)?
    var showError: ((String) -> Void)?
    var factsCount: Int {
        country?.facts.count ?? 0
    }

    var name: String {
        country?.title.capitalized ?? ""
    }

    // MARK: - Functions
    init() {}

    /// Method called when data is required from server or from local json file for unit testing
    func loadData() {
        #if TEST
            getJsonStaticFeeds()
         #else
            NetworkManager.shared().callGetAPI(apiURL: API.kFactsFeeds) { (error: Error?, country: Country?) in
                      if let error = error {
                          self.showError?(String(describing: error))
                          return
                      }

                      if let country = country {
                          self.country = country
                      }
                  }
         #endif
    }

    /// Method called to read json file
    private func getJsonStaticFeeds() {
        let bundle = Bundle.main.url(forResource: "feeds", withExtension: "json")
        let json = try! Data.init(contentsOf: bundle!)
        self.country = try! JSONDecoder().decode(Country.self, from: json)
    }

    /// Called to get fact title
    /// - parameter _: Set index for cell to show data
    /// - Returns: String at specific index
    func factTitle(_ idx: Int) -> String {
        country?.facts[idx].title!.capitalized ?? ""
    }

    /// Called to get fact description
    /// - parameter _: Set index for cell to show data
    /// - Returns: String at specific index
    func description(_ idx: Int) -> String {
        country?.facts[idx].rowDescription?.filter { !"\n".contains($0) } ?? ""
    }

    /// Called to get fact image
    /// - parameter _: Set index for cell to show data
    /// - parameter completion: Set images assynchronously
    func image(_ idx: Int, completion: @escaping((UIImage?) -> Void)) {
        // Image download logic
        if let link = country?.facts[idx].imageHref, let url = URL(string: link) {
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url)
                if let data = data, let image = UIImage(data: data) {
                    completion(image)
                } else {
                    completion(nil)
                }
            }
        } else {
            completion(nil)
        }

    }
}
