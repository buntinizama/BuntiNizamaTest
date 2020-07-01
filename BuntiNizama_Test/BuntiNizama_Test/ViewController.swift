//
//  ViewController.swift
//  BuntiNizama_Test
//
//  Created by Bunti Nizama on 30/06/20.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {
    
    @IBOutlet var tableView : UITableView!
    @IBOutlet var searchBar : UISearchBar!
    
    var itemArray = [Item]()
    var displayArray = [Item]()

    override func viewDidLoad() {
        super.viewDidLoad()
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))

        self.navigationItem.rightBarButtonItem = addButton
        self.loadData()
    }
    
    func loadData()  {
        let realm = try! Realm()
        itemArray = Array(realm.objects(Item.self).sorted(byKeyPath: "isSelected"))
       
        self.searchData(searchText: searchBar.text!)
        
    }
    
    func searchData(searchText : String) {
        if searchText.count  == 0 {
                   displayArray = itemArray
       } else {
            displayArray = itemArray.filter({(item) ->Bool in
                if item.title.lowercased().contains(searchText.lowercased()) || item.itemDescription.lowercased().contains(searchText.lowercased()){
                    return true
                } else {
                    return false
                }
            })
       }
        tableView.reloadSections(IndexSet(integer: 0), with: .fade)
    }
    

    @objc func addTapped(){
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let addVC = storyBoard.instantiateViewController(withIdentifier: "AddViewController") as! AddViewController
        addVC.delegate = self
        self.navigationController?.pushViewController(addVC, animated: true)
    }
    
    @objc func checkMarkTapped(sender : UIButton) {
         let realm = try! Realm()
        try! realm.write{
            displayArray[sender.tag].isSelected =  !displayArray[sender.tag].isSelected
            self.loadData()
        }
    }

}

extension ViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell") as! ItemCell
        cell.setData(item: displayArray[indexPath.row])
        cell.checkMarkButton.tag = indexPath.row
        cell.checkMarkButton.addTarget(self, action: #selector(self.checkMarkTapped(sender:)), for: .touchUpInside)

        return cell
    }
    
    
}

extension ViewController : UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
        self.loadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        self.searchData(searchText: searchText)
    }
}

extension ViewController : AddViewControllerDelegate {
    func doneTapped() {
        self.navigationController?.popViewController(animated: true)
        self.loadData()
    }
}

