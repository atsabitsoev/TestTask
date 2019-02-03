
//
//  ProductListVC.swift
//  TestTask
//
//  Created by Ацамаз on 31/01/2019.
//  Copyright © 2019 a.s.bitsoev. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class ProductListVC: UITableViewController {
    
    
    
    
    var products = [Product]()
    @IBOutlet weak var refresher: UIRefreshControl!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(loadingStarted),
                                               name: NSNotification.Name("loadingProductsStarted"),
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(productsUpdated),
                                               name: NSNotification.Name(rawValue: "productsUpdated"),
                                               object: nil)
        
        refresher.addTarget(self,
                            action: #selector(updateProductList),
                            for: .valueChanged)
        
        updateProductList()
        
    }

    
    
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        if products.count == 0 {
            
            let view = UIView(frame: tableView.frame)
            
            let label = UILabel(frame: CGRect(x: 16,
                                              y: Int(view.bounds.height/2),
                                              width: Int(view.bounds.width - 32),
                                              height: 50))
            label.text = "Ожидание..."
            label.textColor = UIColor.darkGray
            label.textAlignment = .center
            
            view.addSubview(label)
            tableView.backgroundView = view
            
        } else {
            tableView.backgroundView = UIView()
        }
        
        return 1
        
    }
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return products.count
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productListCell")! as! ProductListCell
        
        cell.labName.text = products[indexPath.row].name
        cell.labTagline.text = products[indexPath.row].tagline
        cell.labUpvotes.text = "\(products[indexPath.row].upvotes) votes"
        
        Alamofire.request(products[indexPath.row].thumbnailUrl).responseImage
            { (response) in
                
                if let image = response.result.value {
                    cell.imThumbnail.image = image
                }
                
            }
        
        return cell
    }

    
    @objc func updateProductList() {
        
        ApiService.standard.setArrayOfProducts()
        
    }
    
    
    @objc func productsUpdated() {
        
        self.products = ApiService.standard.currentArrayOfProducts
        
        self.navigationController?.navigationBar.items?.first?.rightBarButtonItem?.title = ApiService.standard.currentTopic.name
        
        self.tableView.reloadData()
        
        refresher.endRefreshing()

    }
    
    
    @objc func loadingStarted() {
        
    }
    
    
    @IBAction func topicButtonTapped(_ sender: UIBarButtonItem) {
    }
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toProductVC" {
            
            let destination = segue.destination as! ProductVC
            
            let indexPath = tableView.indexPathForSelectedRow
            destination.currentProduct = products[indexPath!.row]
            
        }
        
        
    }
    

}
