//
//  ViewController.swift
//  SportsStore
//
//  Created by Kazutomo Kita on 2020/05/13.
//  Copyright © 2020 Kazutomo Kita. All rights reserved.
//

import UIKit

class ProductTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var stockStepper: UIStepper!
    @IBOutlet weak var stockField: UITextField!
    
    var productId: Int?
    
}

class ViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var totalStockLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    
    var products = [
        ("Kayak", "A boat for one person", "Watersports", 275.0, 10),
        ("Lifejacket", "Protective and fashonable", "Watersports", 48.95, 14),
        ("Soccer Ball", "FIFA-approved size and weight", "Soccer", 19.5, 32),
        ("Corner Flags", "Give your playing field a professional touch", "Soccer", 34.95, 1),
        ("Stadium", "Flat-packed 35,000-seat stadium", "Soccer", 79500, 4),
        ("Thinking Cap", "Improve your brain efficiency by 75%", "Chess", 16.0, 8),
        ("Unsteady Chair", "Secretly give your opponent a disadvantage.", "Chess", 29.95, 3),
        ("Human Chess Board", "A fun game for the family", "Chess", 75.0, 2),
        ("Bling-Bling King", "Gold-plated, diamond-studded King", "Chess", 1200.0, 4)
    
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayStockTotal()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func displayStockTotal() {
        let stockTotal = products.reduce(0, {(total, product) -> Int in return total + product.4})
        totalStockLabel.text = "\(stockTotal) Products in Stock"
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let product = products[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell") as! ProductTableViewCell
        cell.productId = indexPath.row
        cell.nameLabel.text = product.0
        cell.descriptionLabel.text = product.1
        cell.stockStepper.value = Double(product.4)
        cell.stockField.text = String(product.4)
        return cell
    }
    

    @IBAction func stockLevelDidChange(_ sender: Any) {
    if var currentCell = sender as? UIView {
                while(true) {
                    currentCell = currentCell.superview!
                    if let cell = currentCell as? ProductTableViewCell {
                        if let id = cell.productId {
                            
                            var newStockLabel:Int?
                            
                            if let stepper = sender as? UIStepper {
                                newStockLabel = Int(stepper.value)
                            }
                            else if let textField = sender as? UITextField {
                                if let newValue = Int(textField.text!) {
                                    newStockLabel = newValue
                                }
                            }
                            
                            if let level = newStockLabel {
                                products[id].4 = level
                                cell.stockStepper.value = Double(level)
                                cell.stockField.text = String(level)
                            }
                        }
                        break
                    }
                }
                displayStockTotal()
            }
        }
}

