//
//  ViewController.swift
//  AutoSizingCell
//
//  Created by huangkun on 2019/3/30.
//  Copyright © 2019 huangkun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var tableView: UITableView!
    
    var flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    var collectionView: UICollectionView!
    var collectionCellWidth: CGFloat = 0
    
    var messages: [Message] = Message.load()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupCollectionView()
        collectionView.isHidden = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // The collection cell width must smaller than collection view width minus horizontal (section/content) insets
        collectionCellWidth = collectionView.bounds.inset(by: collectionView.layoutMargins).size.width
    }
    
    @IBAction func toggleViews(_ sender: UISegmentedControl) {
        if (sender.selectedSegmentIndex == 0) {
            tableView.isHidden = false
            collectionView.isHidden = true
        } else {
            tableView.isHidden = true
            collectionView.isHidden = false
        }
    }
    
    func setupTableView() {
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.register(MsgTableCell.self, forCellReuseIdentifier: "MsgTableCell")
        tableView.showsVerticalScrollIndicator = false
        tableView.dataSource = self
        view.addSubview(tableView)
        
        // Auto Sizing for Table View
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        let tableTop = tableView.topAnchor.constraint(equalTo: view.topAnchor)
        let tableLeft = tableView.leftAnchor.constraint(equalTo: view.leftAnchor)
        let tableRight = tableView.rightAnchor.constraint(equalTo: view.rightAnchor)
        let tableBottom = tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        NSLayoutConstraint.activate([tableTop, tableLeft, tableRight, tableBottom])
    }
    
    func setupCollectionView() {
        // Auto Sizing for Collection View
        flowLayout.estimatedItemSize = CGSize(width: view.bounds.size.width, height: 44)
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: flowLayout)
        collectionView.register(MsgCollectionCell.self, forCellWithReuseIdentifier: "MsgCollectionCell")
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        view.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        let collectionTop = collectionView.topAnchor.constraint(equalTo: view.topAnchor)
        let collectionLeft = collectionView.leftAnchor.constraint(equalTo: view.leftAnchor)
        let collectionRight = collectionView.rightAnchor.constraint(equalTo: view.rightAnchor)
        let collectionBottom = collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        NSLayoutConstraint.activate([collectionTop, collectionLeft, collectionRight, collectionBottom])
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MsgTableCell", for: indexPath) as! MsgTableCell
        cell.setMessage(messages[indexPath.row])
        return cell
    }
    
}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MsgCollectionCell", for: indexPath) as! MsgCollectionCell
        cell.setMessage(messages[indexPath.item], width: collectionCellWidth)
        return cell
    }
    
}
