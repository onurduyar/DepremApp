//
//  HelpVC.swift
//  DepremApp
//
//  Created by Onur Duyar on 18.06.2023.
//

import UIKit

class HelpVC: UIViewController {
    let helpView = HelpView()
    var helpData: [Help]?
    
    let networkManager = LocalJSONNetworkService()
    override func viewDidLoad() {
        super.viewDidLoad()
        view = helpView
        title = "Yardım"
        navigationController?.navigationBar.prefersLargeTitles = true
        helpView.setCollectionViewDelegate(delegate: self, andDataSource: self)
        networkManager.request(LocalRequest()) { result in
            switch result {
            case .success(let response):
                self.helpData = response
            case .failure(let error):
                print(error)
            }
        }
    }
}
extension HelpVC: UICollectionViewDelegate{
    
}

extension HelpVC: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        helpData?.count ?? .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mediaCell", for: indexPath) as! MediaCollectionViewCell
        cell.title = "\(helpData?[indexPath.row].title ?? "")"
        cell.image = helpData?[indexPath.row].image
        return cell
    }
}
