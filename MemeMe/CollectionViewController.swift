//
//  CollectionViewController.swift
//  MemeMe
//
//  Created by fatema on 25/09/2019.
//  Copyright © 2019 Udacity. All rights reserved.
//

import UIKit


class CollectionViewController: UICollectionViewController {
    @IBOutlet weak var collectionflow: UICollectionViewFlowLayout!
    
    
    
     var memes:[Meme] {
           return (UIApplication.shared.delegate as! AppDelegate).memes
       }
       
       
    override func viewDidLoad() {
        super.viewDidLoad()
        let space:CGFloat = 3.0
              let dimension = (view.frame.size.width - (2 * space)) / 3
              
             collectionflow.minimumInteritemSpacing = space
             collectionflow.minimumLineSpacing = space
             collectionflow.itemSize = CGSize(width: dimension, height: dimension)
          }
            // MARK: Update Data
          override func viewWillAppear(_ animated: Bool) {
              super.viewWillAppear(animated)
             self.collectionView.reloadData()

        // Do any additional setup after loading the view.
    }
    
    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return memes.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionCell
               
               cell.imageView.image = memes[indexPath.row].memedImage
        
               // Configure the cell...

               return cell
       
    }

   
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        let meme = memes[indexPath.row]
        let detailsVS = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewC
        detailsVS.memeToShow = meme
        self.navigationController?.pushViewController(detailsVS, animated: true)
    }
    
  
}
