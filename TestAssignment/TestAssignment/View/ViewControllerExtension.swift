//
//  ViewControllerExtension.swift
//  TestAssignment
//
//  Created by Abhishek Singla on 01/05/20.
//  Copyright © 2020 Abhishek Singla. All rights reserved.
//

import UIKit

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: TableView Delegates
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countryVM.factsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: CountryFactsCell? = tableView.dequeueReusableCell(withIdentifier: CountryFactsCell.identifier) as? CountryFactsCell
        
        if cell == nil {
            cell = CountryFactsCell()
        }
        cell!.populate(title: countryVM.factTitle(indexPath.row), desc: countryVM.description(indexPath.row))
        cell!.updateImage(image: nil)
        cell!.selectionStyle = .none
        countryVM.image(indexPath.row) { (image) in
            cell!.updateImage(image: image)
        }
        return cell!
    }
    
}
