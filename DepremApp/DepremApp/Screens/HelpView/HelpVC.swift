//
//  HelpVC.swift
//  DepremApp
//
//  Created by Onur Duyar on 18.06.2023.
//

import UIKit

class HelpVC: UIViewController {
    let helpView = HelpView()
    let networkManager = LocalJSONNetworkService()
    override func viewDidLoad() {
        super.viewDidLoad()
        view = helpView
        helpView.setCollectionViewDelegate(delegate: self, andDataSource: self)
        networkManager.request(LocalRequest()) { result in
            switch result {
            case .success(let response):
                print(response)
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
        7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mediaCell", for: indexPath) as! MediaCollectionViewCell
        cell.title = "\(indexPath.row)"
        return cell
    }
}
