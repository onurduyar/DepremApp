//
//  HelpViewDetailVC.swift
//  DepremApp
//
//  Created by Onur Duyar on 20.06.2023.
//

import UIKit
import AVFoundation

class HelpViewDetailVC: UIViewController {
    var buttonIsHidden: Bool?
    let detailView = HelpDetailView()
    var playerManager: PlayerManager?
    var helpExpression: Help?{
        didSet{
            detailView.helpDescription = helpExpression?.desc
            detailView.buttonIsHidden = buttonIsHidden
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view = detailView
        guard let url = Bundle.main.url(forResource: "sound" , withExtension: "mp3") else {return}
        playerManager = PlayerManager(url: url)
        detailView.soundButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
    }
    override func viewDidDisappear(_ animated: Bool) {
        playerManager?.stop()
    }
    @objc func buttonTapped() {
        playerManager?.play()
    }
}
