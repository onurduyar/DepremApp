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
    
    var image: String? {
        didSet {
            guard let image else {return}
            imageView.image = UIImage(named: image)
        }
    }
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = .systemFont(ofSize: 21)
        titleLabel.textColor = .white
        titleLabel.numberOfLines = .zero
        return titleLabel
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private lazy var gradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.startPoint = CGPoint(x: 0.5, y: 0.0)
        layer.endPoint = CGPoint(x: 0.5, y: 1.0)
        layer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        layer.locations = [0.0, 1.0]
        return layer
    }()
    
    // LifeCycle
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupImageView()
        setupTitleLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Methods
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
    func setupImageView() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        imageView.layer.insertSublayer(gradientLayer, at: .zero)
    }
    func setupTitleLabel() {
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor,constant: 16.0),
            titleLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor,constant: -8.0),
            titleLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor,constant: -10.0)
        ])
    }
}
