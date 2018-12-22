//
//  FirstViewController.swift
//  zoo
//
//  Created by luning on 2018/12/17.
//  Copyright © 2018 luning. All rights reserved.
//

import UIKit

class PetsListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
 
    private var petsIDs : [Int]? = nil
    
    // MARK: properties
    @IBOutlet weak var petsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        petsIDs = PetsDataSource.db.getAllPetSIDs()

        //petsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "PetCell")
        
    }
    
    
    // MARK: actions
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let petsCount = self.petsIDs?.count {
            return petsCount
        }
        else
        {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PetCell", for: indexPath)

        guard let petID = self.petsIDs?[indexPath.row] else {
            return cell
        }
        
        guard let pet = PetsDataSource.db.findPetByID(petID) else {
            return cell
        }
        
        
        if let imageData = pet.image {
            var image = UIImage(data: imageData)!
            image = resizeImage(image: image, newSize: CGSize(width: 50, height: 50))
            cell.imageView?.image = image
        }
        else{
            var image = UIImage(named: "placeholder")!
            image = resizeImage(image: image, newSize: CGSize(width: 50, height: 50))
            cell.imageView?.image = image
        }
        
        let name = pet.name
        let category = pet.category
        
        cell.textLabel?.text = name
        cell.detailTextLabel?.text = Pet.Category(rawValue: category!)?.description
        
        return cell
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "ShowPetDetails":
            guard let cell = sender as? UITableViewCell else {
                return
            }
            guard let indexPath = self.petsTableView.indexPath(for: cell) else {
                return
            }
            
            if let selectedPetID = self.petsIDs?[indexPath.row] {
                let dest = segue.destination as! PetVeriViewController
                dest.petID = selectedPetID
            }
            
        default:
            return
        }
    }
    
    //MARK: methods
    func reloadTableView()  {
        petsIDs = PetsDataSource.db.getAllPetSIDs()
        self.petsTableView.reloadData()
    }


}

