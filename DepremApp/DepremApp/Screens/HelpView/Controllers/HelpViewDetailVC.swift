//
//  HelpViewDetailVC.swift
//  DepremApp
//
//  Created by Onur Duyar on 20.06.2023.
//

import UIKit

class HelpViewDetailVC: UIViewController {
    var buttonIsHidden: Bool?
    let detailView = HelpDetailView()
    var helpExpression: Help?{
        didSet{
            detailView.helpDescription = helpExpression?.desc
            detailView.buttonIsHidden = buttonIsHidden
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view = detailView
       
    }
}
