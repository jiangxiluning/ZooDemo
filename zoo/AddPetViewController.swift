//
//  AddPetViewController.swift
//  zoo
//
//  Created by luning on 2018/12/17.
//  Copyright © 2018 luning. All rights reserved.
//

import UIKit

class AddPetViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    //MARK: Controllers
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var categoryPicker: UIPickerView!
    @IBOutlet weak var ownerNameTextField: UITextField!
    @IBOutlet weak var ownerIDTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var genderPicker: UIPickerView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: Actions
    @IBAction func goBack(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func Done(_ sender: Any) {
    }
    
    
    //MARK: Protocols
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == categoryPicker {
            return Pet.Category.allCases.count
        }else
        {
            return 2
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == categoryPicker {
            
            return Pet.Category(rawValue: row)?.description
        }else
        {
            return Pet.Gender.allCases[row].rawValue
        }
    }
    
    
}
