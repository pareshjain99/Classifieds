//
//  ViewController.swift
//  DubizzleClassified
//
//  Created by PareshJain on 12/19/19.
//  Copyright © 2019 dubizzle. All rights reserved.
//

import UIKit
import SDWebImage
import RxSwift

class ViewController: UIViewController {
    
    @IBOutlet var classifiedTableView: UITableView!
    var viewModel: ClassifiedItemViewModel?
    var isLoadingdataInProgress = false
    private let disposeBag = DisposeBag()
    
    lazy var  searchController : UISearchController = {
        
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.definesPresentationContext = false
        let searchBar = searchController.searchBar
        searchBar.backgroundColor = Constants.redColor
        searchBar.barStyle = .black
        if #available(iOS 13.0, *) {
            if let searchIcon = searchBar.searchTextField.leftView as? UIImageView {
                searchIcon.tintColor = UIColor.white
            }
        }
        searchBar.placeholder = "Search"
        searchBar.setValue("Cancel", forKey: "cancelButtonText")
        return searchController
    }()
    
    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialiseViewModel()
        self.classifiedTableView.reloadData()
        registerTableviewCell()
        customizeNavigationBar()
        viewModel?.loadData.subscribe(onNext : { [weak self] value in
            DispatchQueue.main.async() {    // execute on main thread
                self?.classifiedTableView.reloadData()
            }
        }).disposed(by: disposeBag
        )
        
        viewModel?.dataLodingInProgress.subscribe(onNext : { [weak self] (isLoding) in
            self?.isLoadingdataInProgress = isLoding
            DispatchQueue.main.async() {    // execute on main thread
                self?.classifiedTableView.reloadData()
            }
        }).disposed(by: disposeBag
        )
    }
    
    private func initialiseViewModel() {
           self.viewModel = ClassifiedItemViewModel()
           isLoadingdataInProgress = viewModel?.isLoadingdata ?? false
       }
    
    func customizeNavigationBar() {
        navigationController?.navigationBar.topItem?.title = "Classifieds"
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white, NSAttributedString.Key.font : UIFont.systemFont(ofSize: 21.0)]
        navigationController?.navigationBar.backgroundColor = Constants.redColor
        extendedLayoutIncludesOpaqueBars = true
        navigationItem.leftBarButtonItem?.title = ""
        navigationItem.searchController = searchController
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.obscuresBackgroundDuringPresentation = false

        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white, NSAttributedString.Key.font : UIFont.systemFont(ofSize: 21.0)]
            navBarAppearance.backgroundColor = Constants.redColor
            self.navigationController?.navigationBar.standardAppearance = navBarAppearance
            self.navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        }
    }
    
    func registerTableviewCell() {
        classifiedTableView.register(UINib(nibName: "ClassifiedItemTableViewCell", bundle: nil), forCellReuseIdentifier: "ClassifiedItemTableViewCell")
    }
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    // MARK: UITableViewDataSource methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.numberOfRows() ?? 0
    }
    
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            if let cell = classifiedTableView.dequeueReusableCell(withIdentifier: "ClassifiedItemTableViewCell", for: indexPath) as? ClassifiedItemTableViewCell {
                if isLoadingdataInProgress {
                    cell.shimmerView(show: true)
                }
                else{
                    if viewModel?.filterClassifiedItems?.count ?? 0 > 0 {
                                cell.shimmerView(show: false)

                                cell.configureUI(name: viewModel?.filterClassifiedItems?[indexPath.row].name ?? "", price: viewModel?.filterClassifiedItems?[indexPath.row].price ?? "", thumbnail: viewModel?.filterClassifiedItems?[indexPath.row].image_urls_thumbnails[0] ?? "", time: (viewModel?.filterClassifiedItems?[indexPath.row].created_at.toDate())?.getElapsedInterval() ?? "")
                                cell.selectionStyle = .none
                    }
                }
                return cell
                
            }
            return UITableViewCell()
        }
    
    // MARK: UITableViewDelegate methods
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let selectedClassifiedItem = viewModel?.filterClassifiedItems?[indexPath.row] {
            if let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController {
                vc.selectedClassifiedModel = ClassifiedDataModel(model: selectedClassifiedItem)
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar,
                   selectedScopeButtonIndexDidChange selectedScope: Int) {
        print("search")
    }
}

extension ViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text ?? "")
    }
    
    func filterContentForSearchText(_ searchText: String) {
        viewModel?.filterClassifiedItems  = viewModel?.classifiedItems?.filter{ $0.name.localizedCaseInsensitiveContains(searchText) }
        if isSearchBarEmpty {
            viewModel?.filterClassifiedItems = viewModel?.classifiedItems
        }
        classifiedTableView.reloadData()
    }
}
