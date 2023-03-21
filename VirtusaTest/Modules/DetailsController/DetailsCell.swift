//
//  DetailsCell.swift
//  VirtusaTest
//
//  Created by Mahendra Shivapurapu on 21/03/23.
//

import Foundation
import UIKit
import SnapKit

class DetailsCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        setup()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var headerLabel: UILabel = {
        getLabel(font: .preferredFont(forTextStyle: .headline))
    }()
    
    private lazy var descLabel: UILabel = {
        getLabel(font: .preferredFont(forTextStyle: .body))
    }()
    
    private lazy var infoLabel: UILabel = {
        getLabel(font: .preferredFont(forTextStyle: .body))
    }()
    
    private lazy var infoLabel2: UILabel = {
        getLabel(font: .preferredFont(forTextStyle: .callout))
    }()
    
    private lazy var infoLabel3: UILabel = {
        getLabel(font: .preferredFont(forTextStyle: .caption1))
    }()
    
    private lazy var locationLabel: UILabel = {
        getLabel(font: .preferredFont(forTextStyle: .caption1))
    }()
    
    private lazy var websiteLabel: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.isUserInteractionEnabled = true
        textView.textColor = .black
        textView.textAlignment = .left
        textView.dataDetectorTypes = .all
        textView.font = .preferredFont(forTextStyle: .caption1)
        return textView
    }()
    
    func getStackView(subviews: [UIView]? = nil, spacing: CGFloat? = nil, distribution: UIStackView.Distribution? = nil) -> UIStackView {
        let vStack = UIStackView(arrangedSubviews: subviews ?? [])
        vStack.alignment = .leading
        vStack.axis = .vertical
        vStack.distribution = distribution ?? .fillProportionally
        vStack.spacing = spacing ?? 0.0
        return vStack
    }
    
    func getLabel(font: UIFont? = nil) -> UILabel {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.font = font
        return label
    }
    
    func setup() {
        
        let containerStack1 = getStackView(subviews: [descLabel, infoLabel],
                                           spacing: 8)
        let containerStack2 = getStackView(subviews: [infoLabel2, infoLabel3], spacing: 8)
        let containerStack3 = getStackView(subviews: [locationLabel, websiteLabel], spacing: 8)
        
        let parentStack = getStackView(subviews: [headerLabel, containerStack1, containerStack2, containerStack3], spacing: 16)
        self.contentView.addSubview(parentStack)
        parentStack.snp.makeConstraints({ make in
            make.left.top.equalTo(20)
            make.right.equalTo(-20)
            make.bottom.greaterThanOrEqualTo(20)
        })
    }
    
    func setDatasource(listData: ListData) {
        headerLabel.text = listData.schoolName
        descLabel.text = listData.overviewParagraph
        infoLabel.text = listData.academicopportunities1
        infoLabel2.text = "Programs: \n \(listData.ellPrograms ?? "")"
        locationLabel.text = listData.location
        infoLabel3.text = "Contact: \(listData.phoneNumber ?? "")"
        websiteLabel.text = listData.website
    }
}
