

import Foundation

enum ModeReq {
    case new
    case next
}

protocol PresenterMainVCProtocol {
    func updateData(searchText: String)
    func dataFromServer(down: Bool)
    func getCount() -> Int
    func clear()
    func nextPage()
    func getItem(index: Int) -> Habit?
}


class PresenterMainVC {
    private var searchText: String = ""
    private var view: MainViewControllerProtocol
    private var networking: NetworkServiceProtocol
    private var page: Int = 0
    private let pageSize: Int = 20
    private var habits: [Habit] = []
    private var loading: Bool = false
    private var haveData: Bool = false
    
    init(_ view: MainViewControllerProtocol,
         _ networking: NetworkServiceProtocol) {
        self.view = view
        self.networking = networking
    }
    
    func loadData(mode: ModeReq, searchText: String? = nil) {
        
        
        if mode == .new {
            page = 0
            haveData = true
        } else {
            if loading { return }
            page += 1
        }
        loading = true
        if !haveData {
            view.stopRefreshing()
            return
        }
        
        if let searchText = searchText {
            self.searchText = searchText
        }
        view.startRefreshing()
        networking.getDataHabit(searchText: self.searchText,
                                page: page,
                                pageSize: pageSize) { [weak self] (habits, _) in
            DispatchQueue.main.async {
                self?.loading = false
                self?.view.stopRefreshing()
                if let habits = habits {
                    self?.haveData = true
                    switch mode {
                        case .new:
                            self?.habits = [Habit(id: "id", title: "title")]
                            self?.habits.append(contentsOf: habits)
                            
                        case .next:
                            self?.habits.append(contentsOf: habits)
                    }
                    self?.haveData = !habits.isEmpty
                } else {
                    self?.haveData = false
                }
                self?.view.realodData()
            }
        }
    }
}

extension PresenterMainVC: PresenterMainVCProtocol {
    func clear() {
        habits.removeAll()
    }
    
    func getItem(index: Int) -> Habit? {
        return index < habits.count ? habits[index] : nil
    }
    
    func nextPage() {
        loadData(mode: .next)
    }
    
    func updateData(searchText: String) {
        loadData(mode: .new, searchText: searchText)
    }
    
    func dataFromServer(down: Bool) {
        
    }
    
    func getCount() -> Int {
        return habits.count
    }
}
