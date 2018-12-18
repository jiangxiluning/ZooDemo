//
//  AddPetViewController.swift
//  zoo
//
//  Created by luning on 2018/12/17.
//  Copyright © 2018 luning. All rights reserved.
//

import UIKit

class AddPetViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //Mark: Actions
    @IBAction func goBack(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
}
