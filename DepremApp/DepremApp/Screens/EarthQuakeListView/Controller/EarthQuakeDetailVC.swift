//
//  EarthQuakeDetailVC.swift
//  DepremApp
//
//  Created by Onur Duyar on 13.06.2023.
//

import UIKit

class EarthQuakeDetailVC: UIViewController {
    let detailView = EarthQuakeDetailView()
    var currentEarthQuake: EarthQuake?{
        didSet{
            detailView.title = currentEarthQuake?.title
            detailView.date = currentEarthQuake?.date
            detailView.mag = currentEarthQuake?.mag
            detailView.depth = currentEarthQuake?.depth
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = detailView
     }

}
