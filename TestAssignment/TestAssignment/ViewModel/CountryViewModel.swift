//
//  CountryViewModel.swift
//  TestAssignment
//
//  Created by Abhishek Singla on 29/04/20.
//  Copyright © 2020 Abhishek Singla. All rights reserved.
//

import Foundation
import UIKit


 class CountryVM
{
    private var country: Country?
    {
        didSet
        {
            needsRefresh?()
        }
    }
    
    var needsRefresh: (() -> Void)?
    var showError: ((String) -> Void)?

    init() {}
 
    
    func loadData()
    {
        
        #if TEST
            getJsonStaticFeeds()
         #else
            NetworkManager.shared().callGetAPI(apiURL: API.kFactsFeeds) { (error: Error?, country: Country?) in
                      if let error = error
                      {
                          self.showError?(String(describing: error))
                          return
                      }

                      if let country = country
                      {
                          self.country = country
                      }
                  }
         #endif
    }
   
    private func getJsonStaticFeeds() {
        let bundle = Bundle.main.url(forResource: "feeds", withExtension: "json")
        let json = try! Data.init(contentsOf: bundle!)
        self.country = try! JSONDecoder().decode(Country.self, from: json)
    }
    
    var factsCount: Int
    {
        country?.facts.count ?? 0
    }
  
    var name: String
    {
        country?.title.capitalized ?? ""
    }
    
    func factTitle(_ idx: Int) -> String
    {
        country?.facts[idx].title!.capitalized ?? ""
    }
    
    
    func image(_ idx: Int, completion: @escaping((UIImage?) -> Void))
    {
        // Image download logic
        if let link = country?.facts[idx].imageHref, let url = URL(string: link)
        {

            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url)
                if let data = data
                {
                    DispatchQueue.main.async {
                        completion(UIImage(data: data))
                    }
                }
            }
        } else
        {
            completion(nil)
        }
    }
    
    func description(_ idx: Int) -> String
    {
        country?.facts[idx].rowDescription ?? ""
    }
}

