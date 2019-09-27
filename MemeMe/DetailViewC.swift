//
//  DetailViewC.swift
//  MemeMe
//
//  Created by fatema on 25/09/2019.
//  Copyright © 2019 Udacity. All rights reserved.
//

import UIKit

class DetailViewC: UIViewController {

    @IBOutlet weak var imgeV: UIImageView!
   
        var memeToShow:Meme!
         
         override func viewDidLoad() {
             super.viewDidLoad()
             self.navigationController?.setNavigationBarHidden(false, animated: true)
             title = "View"
          
         }
         override func viewWillAppear(_ animated: Bool) {
             super.viewWillAppear(animated)
            imgeV.image = memeToShow.memedImage
              tabBarController?.tabBar.isHidden = true
         }
        
         
         override func viewWillDisappear(_ animated: Bool) {
             super.viewWillDisappear(animated)
             tabBarController?.tabBar.isHidden = false
         }

        // Do any additional setup after loading the view.
    }
    

