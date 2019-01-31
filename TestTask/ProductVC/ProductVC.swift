//
//  ProductVC.swift
//  TestTask
//
//  Created by Ацамаз on 31/01/2019.
//  Copyright © 2019 a.s.bitsoev. All rights reserved.
//

import UIKit

class ProductVC: UIViewController {

    
    @IBOutlet weak var labName: UILabel!
    @IBOutlet weak var labUpvotes: UILabel!
    @IBOutlet weak var labTagline: UILabel!
    @IBOutlet weak var imScreenshot: UIImageView!
    var currentProduct: Product?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        labName.text = currentProduct!.name
        labTagline.text = currentProduct!.tagline
        labUpvotes.text = "\(currentProduct!.upvotes) upvotes"
        do {
            let imData = try Data(contentsOf: (currentProduct?.screenshotUrl)!)
            imScreenshot.image = UIImage(data: imData)
        } catch {
            print(error)
        }
        
    }
    
    
    @IBAction func getItButTapped(_ sender: UIBarButtonItem) {
        
        let url = currentProduct!.link
        UIApplication.shared.open(url)
        
    }
    

}
