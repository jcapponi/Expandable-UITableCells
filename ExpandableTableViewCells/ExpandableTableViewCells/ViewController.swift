//
//  ViewController.swift
//  ExpandableTableViewCells
//
//  Created by Juan Capponi on 12/28/20.
//

import UIKit

class Section {
    let title: String
    let options: [String]
    var isOpened: Bool = false
    
    init(title: String, options: [String], isOpened:Bool) {
        self.title = title
        self.options = options
        self.isOpened = isOpened
    }
}



class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private var sections = [Section]()
    
    private let tableView : UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        self.navigationItem.title = "Expandable Cells"
        
        sections = [Section(title: "Cars", options: ["Mercedes", "BMW", "Toyota"], isOpened: false),
                    Section(title: "Bikes", options: ["Yamaha", "Honda", "KTM"], isOpened: false),
                    Section(title: "Kites", options: ["Cabrinha", "Naish", "Duotone"], isOpened: false)]
    }


    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = sections[section]
        if section.isOpened {
            return section.options.count + 1
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if indexPath.row == 0 {
            
            cell.textLabel?.text = sections[indexPath.section].title
            return cell
        } else {
            cell.textLabel?.text = sections[indexPath.section].options[indexPath.row - 1]
        }
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        sections[indexPath.section].isOpened = !sections[indexPath.section].isOpened
        tableView.reloadSections([indexPath.section], with: .none)
    }
}

