//
//  CountryFactsCell.swift
//  TestAssignment
//
//  Created by Abhishek Singla on 29/04/20.
//  Copyright © 2020 Abhishek Singla. All rights reserved.
//

import UIKit

class CountryFactsCell: UITableViewCell {

    private struct Constants
  {
        static let width: CGFloat = 80.0
        static let height: CGFloat = 80.0
        static let constraint10: CGFloat = 10.0
        static let constraintNeg10: CGFloat = -10.0
        static let constraintZero: CGFloat = 00.0
        static let constraint80: CGFloat = 80.0
        
  }
    
    static var identifier: String
    {
        "CountryFactCell"
    }
    
    private var name: UILabel = {
        let lb = UILabel()
        lb.textColor = .red
        lb.textAlignment = .left
        lb.numberOfLines = 0
        lb.setContentHuggingPriority(.defaultHigh, for: .vertical)
        lb.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        lb.translatesAutoresizingMaskIntoConstraints = false

        return lb
    }()
    
    private var descLb: UILabel = {
        let descLb = UILabel()
        descLb.textColor = .black
        descLb.textAlignment = .left
        descLb.numberOfLines = 0
        descLb.translatesAutoresizingMaskIntoConstraints = false
        descLb.setContentHuggingPriority(.defaultLow, for: .vertical)
        descLb.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        return descLb
    }()
    
    private let nameImage: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.clipsToBounds = false
        return imgView
    }()
   
    init() {
        super.init(style: .default, reuseIdentifier: Self.identifier)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func populate(name: String, desc: String)
    {
        self.name.text = name
        self.descLb.text = desc
    }
    
    func updateImage(image: UIImage) {
        self.nameImage.image = image
    }
   
    func setupConstraints()
    {
        contentView.addSubview(name)
        contentView.addSubview(nameImage)
        contentView.addSubview(descLb)
        
        NSLayoutConstraint.activate([
            nameImage.widthAnchor.constraint(equalToConstant: Constants.width),
            nameImage.heightAnchor.constraint(equalToConstant: Constants.height),
            nameImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            nameImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.constraint10),
            
            name.leadingAnchor.constraint(equalTo: nameImage.trailingAnchor, constant: Constants.constraint10),
            name.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Constants.constraintNeg10),
            name.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.constraint10),
            name.bottomAnchor.constraint(equalTo: descLb.topAnchor),
            
            descLb.leadingAnchor.constraint(equalTo: name.leadingAnchor, constant: Constants.constraintZero),
            descLb.trailingAnchor.constraint(equalTo: name.trailingAnchor, constant: Constants.constraintZero),
            descLb.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: Constants.constraintNeg10),
            descLb.heightAnchor.constraint(greaterThanOrEqualToConstant: Constants.constraint80)
        ])
    }
}
