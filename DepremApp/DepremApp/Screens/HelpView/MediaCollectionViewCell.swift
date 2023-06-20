//
//  MediaCollectionViewCell.swift
//  DepremApp
//
//  Created by Onur Duyar on 18.06.2023.
//

import UIKit

class MediaCollectionViewCell: UICollectionViewCell {
    // MARK: - Properties
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = .systemFont(ofSize: 21)
        titleLabel.textColor = .black
        titleLabel.numberOfLines = .zero
        return titleLabel
    }()
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupTitleLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupTitleLabel() {
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor)
        ])
    }
}
