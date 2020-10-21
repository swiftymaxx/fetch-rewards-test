//
//  MainVC.swift
//  Fetch Rewards Exercise
//
//  Created by Maximo Liriano on 10/20/20.
//

import UIKit

class MainVC: UITableViewController {
    
    private var items = [Item]()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureTV()
        fetchItems()
    }
    
    private func configureTV() {
        title = "Fetch Rewards"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func fetchItems() {
        NetworkManager.shared.fetchItems { result in
            
            switch result {
            case .success(let items):
                self.items = items
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            case .failure(_):
                AlertManager.showAlert(title: "Something went wrong", message: "There was an issue retrieving the data. Please try again later.", vc: self)
            }
        }
    }
}

extension MainVC {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let itemDictionary = Dictionary(grouping: items, by: { $0.listId })
        
        for (key, value) in itemDictionary {
            let filtered = value.map { $0.name }.filter { $0 != "" && $0 != nil }
            
            if key == 1 && section == 0 {
                return filtered.count
            } else if key == 2 && section == 1 {
                return filtered.count
            } else if key == 3 && section == 2 {
                return filtered.count
            } else if key == 4 && section == 3 {
                return filtered.count
            }
        }
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let section = indexPath.section
        let itemDictionary = Dictionary(grouping: items, by: { $0.listId })
        
        for (key, value) in itemDictionary {
            
            let filtered = value.compactMap { $0.name }.filter { $0 != "" }.customSortByNumber
                        
            if key == 1 && section == 0 {
                cell.textLabel?.text = filtered[indexPath.row]
            } else if key == 2 && section == 1 {
                cell.textLabel?.text = filtered[indexPath.row]
            } else if key == 3 && section == 2 {
                cell.textLabel?.text = filtered[indexPath.row]
            } else if key == 4 && section == 3 {
                cell.textLabel?.text = filtered[indexPath.row]
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "List \(section + 1)"
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return ["1", "2", "3", "4"]
    }
}
