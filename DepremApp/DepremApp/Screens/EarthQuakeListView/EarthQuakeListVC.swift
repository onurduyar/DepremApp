//
//  EarthQuakeListVC.swift
//  Deprem
//
//  Created by Onur Duyar on 14.04.2023.
//

import UIKit

final class EarthQuakeListVC: UIViewController {
    var earthQuakes: [EarthQuake] = HomeViewModel.shared.lastEarthQuakes ?? []
    var tableView = UITableView()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        configureUI()
        title = "Deprem Listesi"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let lastEarthQuakes = HomeViewModel.shared.lastEarthQuakes {
            earthQuakes = lastEarthQuakes
            tableView.reloadData()
        }
    }
    func configureUI() {
        configureTableView()
        configureActivityIndicator()
    }
    func configureActivityIndicator() {
        let activityIndicatorView = UIActivityIndicatorView(style: .large)
         activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
         activityIndicatorView.color = .gray
         view.addSubview(activityIndicatorView)
         NSLayoutConstraint.activate([
             activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
             activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
         ])
        
            activityIndicatorView.startAnimating()
            tableView.isHidden = true
            
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
                self.tableView.isHidden = false
                activityIndicatorView.stopAnimating()
                activityIndicatorView.removeFromSuperview()
            }
    }
    func configureTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
       

        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
        
    }
}
extension EarthQuakeListVC: UITableViewDelegate {
    
}
extension EarthQuakeListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        earthQuakes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = earthQuakes[indexPath.row].title
        return cell
    }
}
