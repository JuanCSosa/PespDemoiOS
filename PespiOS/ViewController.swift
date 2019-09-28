//
//  ViewController.swift
//  PespiOS
//
//  Created by JuanSosa on 9/23/19.
//  Copyright © 2019 JuanSosa. All rights reserved.
//

import UIKit

private let reuseIdentifier = "countryIdentifier"

class ViewController: UIViewController, UISearchResultsUpdating {

    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var filtered:[Country] = []
    var shouldShowSearchResults = false
    var textShearch = ""
        
    @IBOutlet weak var viewSearch: UIView!
    var searchController: UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView!.register(UINib(nibName:"CountryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)

        Service.shared.delegate = self
        Service.shared.downloadCountries()
        configureSearchController()
        // Do any additional setup after loading the view.
    }
    
    func configureSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = true
        searchController.searchBar.delegate = self
        searchController.searchBar.sizeToFit()
        viewSearch.addSubview(searchController.searchBar)
    }
        
    func updateSearchResults(for searchController: UISearchController) {
        if let searchString = searchController.searchBar.text,
            !searchString.isEmpty {
            textShearch = searchString
            DispatchQueue.main.async {
                       self.filtered = Service.shared.countries.filter() {(country) -> Bool in
                        return (country.name.range(of:searchString, options: .caseInsensitive) != nil)
                       }
                    
                   }
        }
        self.collectionView.reloadData()
    }
    
}

extension ViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
     // MARK: UICollectionViewDataSource
     
      func numberOfSections(in collectionView: UICollectionView) -> Int {
     // #warning Incomplete implementation, return the number of sections
     return 1
     }
     
     
      func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
     // #warning Incomplete implementation, return the number of items
        if shouldShowSearchResults {
            return filtered.count
        }
        else {
            return Service.shared.namesCountries.count
        }
     }
     
      func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
     let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CountryCollectionViewCell
        if shouldShowSearchResults {
            cell.countryInfo(info: filtered[indexPath.row])

        }else {
            cell.countryInfo(info: Service.shared.countries[indexPath.row])
        }
     
     // Configure the cell
     
     return cell
     }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if shouldShowSearchResults {
            showCountryDetailViewController(country:filtered[indexPath.row])

        }else{
            showCountryDetailViewController(country:  Service.shared.countries[indexPath.row])
        }

    }
    
}

extension ViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        shouldShowSearchResults = true
        self.collectionView?.reloadData()
        
    }
     

     
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        shouldShowSearchResults = false
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if !shouldShowSearchResults {
            shouldShowSearchResults = true
            self.collectionView?.reloadData()
        }
     
        searchController.searchBar.resignFirstResponder()
    }

}

extension ViewController: CountryInfoProtocol {
    func finishDownloadCountryInfo() {
        self.collectionView.reloadData()
    }
}

