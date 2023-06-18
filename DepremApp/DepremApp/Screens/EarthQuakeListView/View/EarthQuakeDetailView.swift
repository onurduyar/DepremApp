//
//  EarthQuakeDetailView.swift
//  DepremApp
//
//  Created by Onur Duyar on 13.06.2023.
//

import UIKit

class EarthQuakeDetailView: UIView {
    
    var title: String? {
        didSet{
            titleLabel.text = title
        }
    }
    var date: String? {
        didSet{
            dateLabel.text = "Tarih: \(date ?? "")"
        }
    }
    var mag: Double? {
        didSet{
            magLabel.text = "Depremin Büyüklüğü: \(mag ?? 0.0)"
        }
    }
    var depth: Double? {
        didSet{
            depthLabel.text = "Depremin Derinliği: \(depth ?? 0.0)"
        }
    }
    private lazy var titleLabel = {
        var titleLabel = UILabel()
        titleLabel.textAlignment = .center
        titleLabel.font =  UIFont.systemFont(ofSize: 24, weight: .bold)
        titleLabel.numberOfLines = 3
        return titleLabel
    }()
    
    private lazy var dateLabel = {
        var dateLabel = UILabel()
        return dateLabel
    }()
    
    private lazy var magLabel = {
        var magLabel = UILabel()
        return magLabel
    }()
    
    private lazy var depthLabel = {
        var depthLabel = UILabel()
        return depthLabel
    }()
    
    private lazy var stackView = {
        var stackView = UIStackView(arrangedSubviews: [dateLabel,magLabel,depthLabel])
        stackView.axis = .vertical
        stackView.spacing = 30
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configureTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 30),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
        ])
    }
    func setupView() {
        configureTitleLabel()
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 30),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -30),
        ])
    }
    
}
