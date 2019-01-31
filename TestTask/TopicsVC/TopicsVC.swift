//
//  TopicsVC.swift
//  TestTask
//
//  Created by Ацамаз on 31/01/2019.
//  Copyright © 2019 a.s.bitsoev. All rights reserved.
//

import UIKit

class TopicsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfTopics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "topicCell")!
        
        cell.textLabel?.text = arrayOfTopics[indexPath.row].name

        return cell
    
    }
    

    
    @IBOutlet weak var tableView: UITableView!
    var arrayOfTopics = [Topic]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateTopicsArray),
                                               name: NSNotification.Name("topicsUpdated"),
                                               object: nil)
        
        ApiService.standard.setTopicsArray()
        
    }
    
    
    @objc func updateTopicsArray() {
        arrayOfTopics = ApiService.standard.topicsArray
        tableView.reloadData()
    }
    

    @IBAction func closeButtonTapped(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    // CELL SELECTED
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let name = arrayOfTopics[indexPath.row].name
        let id = arrayOfTopics[indexPath.row].id
        
        ApiService.standard.currentTopic = Topic(name: name, id: id)

        self.dismiss(animated: true, completion: nil)

    }
    
    
}
