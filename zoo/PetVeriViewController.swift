//
//  PetVeriViewController.swift
//  zoo
//
//  Created by luning on 2018/12/17.
//  Copyright © 2018 luning. All rights reserved.
//

import UIKit

class PetVeriViewController: UIViewController {
    
    
    
    @IBOutlet weak var petImageView: UIImageView!
    @IBOutlet weak var petNameLabel: UILabel!
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var ownerNameLabel: UILabel!
    @IBOutlet weak var ownerIDLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    
    
    var petID: Int?
    var petFeature: Data?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let petID = petID else {
            print("Pet ID is invalid.")
            self.dismiss(animated: true, completion: nil)
            return
        }
        
        guard let pet = PetsDataSource.db.findPetByID(petID) else {
            self.dismiss(animated: true, completion: nil)
            return
        }
        
        self.petNameLabel.text = pet.name
        self.categoryLabel.text = Pet.Category(rawValue: pet.category!)?.description
        
        if let imageData = pet.image {
            self.petImageView.image = UIImage(data: imageData)
        }
        
        if let ownerID = pet.ownerID {
            self.ownerIDLabel.text = ownerID
        }
        
        if let ownerName = pet.ownerName {
            self.ownerNameLabel.text = ownerName
        }
        
        if let age = pet.age {
            self.ageLabel.text = String(age)
        }
        
        if pet.gender {
            self.genderLabel.text = Pet.Gender.male.rawValue
        }else{
            self.genderLabel.text = Pet.Gender.female.rawValue
        }

        
        if let petFeatureData = pet.feature {
            self.petFeature = petFeatureData
        }else {
            print("Pet does not have face feature.")
            self.dismiss(animated: true, completion: nil)
        }

        

    }
    
    
    @IBAction func goBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func verify(_ sender: Any) {
    }
}
