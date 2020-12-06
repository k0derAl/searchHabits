//
//  ViewController.swift
//  TeskTaskYushkov
//
//  Created by Иван Юшков on 03.12.2020.
//

import UIKit
import SnapKit
import SVProgressHUD
import RxSwift

protocol MainViewControllerProtocol {
    func startRefreshing()
    func stopRefreshing()
    func realodData()
}

class MainViewController: UIViewController {
    var inputTextToFind = PublishSubject<String>()
    var presenter: PresenterMainVCProtocol?
    
    //add first habit in array for top row of table
    
    
    
    var tableView = UITableView()
    
    lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        return searchController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if presenter == nil {
            ConfiguratorMainVC().configure(view: self, networking: DI.resolve())
        }
        initTableView()
        initSearchController()
        initNavigationController()
        initObserver()

        searchController.searchBar.becomeFirstResponder()
        
        //make constarints
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.updateData(searchText: "")
    }
    
    func initTableView() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.centerX.centerY.equalTo(self.view)
            make.height.equalTo(self.view).offset(-40)
        }
        tableView.register(MyTableViewCell.self, forCellReuseIdentifier: MyTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func initSearchController() {
       // searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
        
    }
    
    func initNavigationController() {
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationItem.largeTitleDisplayMode = .never
        title = R.string.locale1.mainpageTitle()
    }
    
    func initObserver() {
        let debounceObservable = inputTextToFind.debounce(
            .seconds(1),
            scheduler: MainScheduler.instance)
        
        _ = debounceObservable
            .subscribe(onNext: { [weak self] (result: String) in
                guard let self = self else {
                    return
                }

                self.presenter?.updateData(searchText: result)
            })
    }
    
}

    // MARK: - Table view data source & delegate
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.getCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row > (presenter?.getCount() ?? 0) - 3 {
            presenter?.nextPage()
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MyTableViewCell.identifier,
                                                       for: indexPath)
                as? MyTableViewCell else { return UITableViewCell() }
        let index = indexPath.row
        if let habit = presenter?.getItem(index: index) {
            cell.setData(item: habit, index: index, first: index == 0)
            cell.backgroundColor = index == 0 ? #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1) : UIColor.clear
        } else {
            cell.backgroundColor = .red
        }
        //create top row of table

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40.0
    }
    
}

extension MainViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar,
                   selectedScopeButtonIndexDidChange selectedScope: Int) {
        print(searchBar.text)
        //filterContentForSearchText(searchBar.text!, category: category)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            inputTextToFind.onNext(searchText)
    }
}

extension MainViewController: MainViewControllerProtocol {
    func stopRefreshing() {
        SVProgressHUD.dismiss()
    }
    
    func startRefreshing() {
        SVProgressHUD.showLight()
    }
 
    func realodData() {
        tableView.reloadData()
    }
    
}

