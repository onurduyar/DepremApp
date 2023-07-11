//
//  HelpDetailView.swift
//  DepremApp
//
//  Created by Onur Duyar on 20.06.2023.
//

import UIKit

class HelpDetailView: UIView {
    // Properties
    var helpDescription:String?{
        didSet{
            helpDescLabel.text = helpDescription
        }
    }
    var buttonIsHidden: Bool?{
        didSet{
            soundButton.isHidden = buttonIsHidden ?? true
        }
    }
    lazy var soundButton: UIButton = {
        let uiButton = UIButton(type: .system)
        uiButton.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        uiButton.setTitle("Siren Çal", for: .normal)
        uiButton.backgroundColor = .red
        uiButton.tintColor = .white
        uiButton.layer.cornerRadius = 20
        uiButton.clipsToBounds = true
        uiButton.isHidden = true
        return uiButton
    }()
    private lazy var helpDescLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.numberOfLines = 50
        return label
    }()
    
    // LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // Methods
    
    func setupUI(){
        setupLabel()
        setupButton()
    }
    func setupLabel(){
        addSubview(helpDescLabel)
        helpDescLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            helpDescLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor,constant: 30),
            helpDescLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 10.0),
            helpDescLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -10.0),
        ])
    }
    func setupButton() {
        addSubview(soundButton)
        soundButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            soundButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 30),
            soundButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 70),
            soundButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -70.0),
            soundButton.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
}
