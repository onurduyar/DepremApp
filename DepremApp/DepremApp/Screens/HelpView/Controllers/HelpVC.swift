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
// MARK: - UICollectionViewDelegate
extension HelpVC: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let destinationVC = HelpViewDetailVC()
        guard let currentHelp = helpData?[indexPath.row] else {return}
        if indexPath.row == 2 {
            destinationVC.buttonIsHidden = false
        }else{
            destinationVC.buttonIsHidden = true
        }
        destinationVC.helpExpression = currentHelp
        navigationController?.pushViewController(destinationVC, animated: true)
    }
}
// MARK: - UICollectionViewDataSource
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
