//
//  TableViewController.swift
//  CoreDataDemo1
//
//  Created by Shinkangsan on 1/20/17.
//  Copyright © 2017 Sheldon. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController,UISearchBarDelegate {

    fileprivate var imageItemArray = [imageItem]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateData()
        
        //presetCoreData()
        setUpSearchBar()
        
    }
    
    //MARK: - search bar related
    fileprivate func setUpSearchBar() {
        let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 65))
        
        searchBar.showsScopeBar = true
        searchBar.scopeButtonTitles = ["name","by","year"]
        searchBar.selectedScopeButtonIndex = 0
        
        searchBar.delegate = self
        
        self.tableView.tableHeaderView = searchBar
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        guard !searchText.isEmpty else {
            imageItemArray = CoreDataManager.fetchObj()
            tableView.reloadData()
            return
        }
        
        imageItemArray = CoreDataManager.fetchObj(selectedScopeIdx: searchBar.selectedScopeButtonIndex, targetText:searchText)
        tableView.reloadData()
        print(searchText)
    }
    
    func presetCoreData() {
        CoreDataManager.storeObj(name: "img001", by: "Sheldon", year: "2011")
        CoreDataManager.storeObj(name: "img002", by: "Xiaodan", year: "2009")
        CoreDataManager.storeObj(name: "img003", by: "Developer", year: "2016")
        CoreDataManager.storeObj(name: "img004", by: "iOSeTutorials", year: "2017")
        CoreDataManager.storeObj(name: "img005", by: "unkown", year: "2020")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateData() {
        imageItemArray = CoreDataManager.fetchObj()
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageItemArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell

        let imgItem = imageItemArray[indexPath.row]
        
        cell.imgView.image = UIImage(named:imgItem.imageName!)
        cell.nameLabel.text = imgItem.imageName!
        cell.byLabel.text = imgItem.imageBy!
        cell.yearLabel.text = imgItem.imageYear!
        
        return cell
    }
    
    
   
}
