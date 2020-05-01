//
//  ViewController.swift
//  TestAssignment
//
//  Created by Abhishek Singla on 29/04/20.
//  Copyright © 2020 Abhishek Singla. All rights reserved.
//

import UIKit

///This class acts as view
class ViewController: UIViewController {
    
    // MARK: - Variables
    var factsTableView: UITableView!
    let countryVM = CountryVM()
    private let control: UIRefreshControl = UIRefreshControl()
    let estimatedRowHeight = 400.00
    
    // MARK: - Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        countryVM.loadData()
        
        countryVM.needsRefresh = { [weak self] in
            DispatchQueue.main.async {
                
                if let control = self?.factsTableView.refreshControl, control.isRefreshing {
                    control.endRefreshing()
                }
                self?.factsTableView.reloadData()
                self?.navigationItem.title = self!.countryVM.name
            }
        }
        control.addTarget(self, action: #selector(reloadData), for: .valueChanged)
        
        factsTableView.refreshControl = control
        self.factsTableView.estimatedRowHeight = CGFloat(estimatedRowHeight)
    }
    
    override func loadView() {
        factsTableView = UITableView()
        factsTableView.register(UITableViewCell.self, forCellReuseIdentifier: CountryFactsCell.identifier)
        factsTableView.dataSource = self
        factsTableView.delegate = self
        factsTableView.tableFooterView = UIView()
        view = factsTableView
    }
    
    // MARK: - Pull to refresh Function
    @objc private func reloadData() {
        countryVM.loadData()
    }
}
