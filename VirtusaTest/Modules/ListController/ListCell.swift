//
//  ListCell.swift
//  VirtusaTest
//
//  Created by Mahendra Shivapurapu on 20/03/23.
//

import UIKit
import SnapKit

class ListCell: UITableViewCell {
    
    private lazy var titleLabel: UILabel = {
        getLabel(font: .preferredFont(forTextStyle: .headline))
    }()
    
    private lazy var descLabel: UILabel = {
        getLabel(font: .preferredFont(forTextStyle: .body))
    }()
    
    func getStackView(subviews: [UIView]? = nil,
                      spacing: CGFloat? = nil,
                      distribution: UIStackView.Distribution? = nil) -> UIStackView {
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupConstraints()
    }
    
    override init(style: UITableViewCell.CellStyle,
                  reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        let stackView = getStackView(subviews: [titleLabel, descLabel], spacing: 8)
        self.contentView.addSubview(stackView)
        stackView.snp.makeConstraints({ make in
            make.left.top.equalTo(20)
            make.right.equalTo(-20)
            make.bottom.equalTo(-20)
        })
    }
    
    func setDatasource(listData: ListData) {
        self.titleLabel.text = listData.schoolName
        self.descLabel.text = listData.phoneNumber
    }
}
