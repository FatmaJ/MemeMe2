 //
//  TableViewController.swift
//  MemeMe
//
//  Created by fatema on 25/09/2019.
//  Copyright © 2019 Udacity. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    var memes:[Meme] {
        return (UIApplication.shared.delegate as! AppDelegate).memes
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellld")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
       
    
         return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return memes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellld")
        let meme = memes[indexPath.row]
        cell?.imageView?.image = meme.memedImage
        cell?.textLabel?.text = "\(meme.topText)...\(meme.bottomText)..."
        // Configure the cell...

        return cell!
        
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let meme = memes[indexPath.row]
        let detailsVS = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewC
        detailsVS.memeToShow = meme
        navigationController?.pushViewController(detailsVS, animated: true)

    }
    
  
    
         
}
