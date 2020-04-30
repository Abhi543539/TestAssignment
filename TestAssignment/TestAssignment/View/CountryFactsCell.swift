//
//  CountryFactsCell.swift
//  TestAssignment
//
//  Created by Abhishek Singla on 29/04/20.
//  Copyright © 2020 Abhishek Singla. All rights reserved.
//

import UIKit

/// This class creates UI of TableviewCell
class CountryFactsCell: UITableViewCell {
    
    //It consists of all constants floats for height/width/padding for contraints
    private struct Constants {
        static let width: CGFloat = 80.0
        static let height: CGFloat = 80.0
        static let constraint10: CGFloat = 10.0
        static let constraintNeg10: CGFloat = -10.0
        static let constraintZero: CGFloat = 00.0
        static let constraint60: CGFloat = 60.0
    }
    
    static var identifier: String {
        "CountryFactCell"
    }
    
    // MARK: - Variables
    private var lblTitle: UILabel = {
        let lblTitle = UILabel()
        lblTitle.textColor = .red
        lblTitle.textAlignment = .left
        lblTitle.numberOfLines = 0
        lblTitle.setContentHuggingPriority(.defaultHigh, for: .vertical)
        lblTitle.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        lblTitle.translatesAutoresizingMaskIntoConstraints = false
        return lblTitle
    }()
    
    private var lblDescription: UILabel = {
        let lblDesc = UILabel()
        lblDesc.textColor = .black
        lblDesc.textAlignment = .left
        lblDesc.numberOfLines = 0
        lblDesc.translatesAutoresizingMaskIntoConstraints = false
        lblDesc.setContentHuggingPriority(.defaultLow, for: .vertical)
        lblDesc.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        return lblDesc
    }()
    
    private let factImage: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.clipsToBounds = false
        return imgView
    }()
    
    // MARK: - Functions
    init() {
        super.init(style: .default, reuseIdentifier: Self.identifier)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Called to populate lblTitle and description
    /// - parameter title: Set lblTitle string
    /// - parameter desc: Set desc string
    func populate(title: String, desc: String) {
        self.lblTitle.text = title
        self.lblDescription.text = desc
    }
    
    /// Called to set image
    /// - parameter image: Set image reference
    func updateImage(image: UIImage?) {
        DispatchQueue.main.async {
            self.factImage.image = image ?? UIImage(named: "FactPlaceholder")
        }
    }
    
    /// Call this method to setup all contraints of subviews
    func setupConstraints() {
        contentView.addSubview(lblTitle)
        contentView.addSubview(factImage)
        contentView.addSubview(lblDescription)
        
        NSLayoutConstraint.activate([
            factImage.widthAnchor.constraint(equalToConstant: Constants.width),
            factImage.heightAnchor.constraint(equalToConstant: Constants.height),
            factImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.constraint10),
            factImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.constraint10),
            
            lblTitle.leadingAnchor.constraint(equalTo: factImage.trailingAnchor, constant: Constants.constraint10),
            lblTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Constants.constraintNeg10),
            lblTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.constraint10),
            lblTitle.bottomAnchor.constraint(equalTo: lblDescription.topAnchor),
            
            lblDescription.leadingAnchor.constraint(equalTo: lblTitle.leadingAnchor, constant: Constants.constraintZero),
            lblDescription.trailingAnchor.constraint(equalTo: lblTitle.trailingAnchor, constant: Constants.constraintZero),
            lblDescription.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: Constants.constraintNeg10),
            lblDescription.heightAnchor.constraint(greaterThanOrEqualToConstant: Constants.constraint60)
        ])
    }
}
