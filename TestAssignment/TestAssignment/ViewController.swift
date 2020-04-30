//
//  ViewController.swift
//  TestAssignment
//
//  Created by Abhishek Singla on 29/04/20.
//  Copyright © 2020 Abhishek Singla. All rights reserved.
//

import UIKit

///This class acts as view
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // MARK: - Variables
    private var factsTableView: UITableView!
    private let countryVM = CountryVM()
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
