////
////  1.swift
////  ToDoApp
////
////  Created by Maks Ivshin on 5.08.23.
////
//
//import Foundation
//import UIKit
//
//class AppleProductsTableViewController: UITableViewController
//{
//    lazy var productLines: [ProductLine] = {
//        return ProductLine.productLines()
//    }()
//
//    // MARK: - VC Lifecycle
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        navigationItem.rightBarButtonItem = editButtonItem
//
//        // Make the row height dynamic
//        tableView.estimatedRowHeight = tableView.rowHeight
//        tableView.rowHeight = UITableView.automaticDimension
//    }
//
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//
//        tableView.reloadData()
//    }
//
//    // MARK: - UITableViewDataSource
//
//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        let productLine = productLines[section]
//        return productLine.name
//    }
//
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return productLines.count
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        let productLine = productLines[section]
//        return productLine.products.count   // the number of products in the section
//    }
//
//    // indexPath: which section and which row
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Product Cell", for: indexPath) as! ProductTableViewCell
//
//        let productLine = productLines[indexPath.section]
//        let product = productLine.products[indexPath.row]
//
//        cell.configureCellWith(product)
//
//        return cell
//    }
//
//    // MARK: - Edit Tableview
//
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == UITableViewCell.EditingStyle.delete {
//            let productLine = productLines[indexPath.section]
//            productLine.products.remove(at: indexPath.row)
//            // tell the table view to update with new data source
//            // tableView.reloadData()    Bad way!
//            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
//        }
//    }
//
//}
