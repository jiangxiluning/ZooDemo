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
    @IBOutlet weak var petImageView: UIImageView!
    
    
    private var cachedCategory: Pet.Category?
    private weak var parentView: PetsListViewController!
    
    override func viewWillAppear(_ animated: Bool) {
        parentView = self.presentingViewController as? PetsListViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: Actions
    @IBAction func goBack(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func Done(_ sender: Any) {
        guard let name: String = self.nameTextField.text else {
            self.showErrAlert("姓名不能为空！")
            return
        }
        guard let category: Pet.Category = Pet.Category(rawValue: self.categoryPicker.selectedRow(inComponent: 0)) else {
            self.showErrAlert("宠物种类不能为空！")
            return
        }
        
        if cachedCategory == nil
        {
            let d = petImageView.image!.pngData()!
            self.cachedCategory = PetsRecognizer.core.classify(image: d)
            if category != self.cachedCategory{
                self.showErrAlert("您上传的宠物类型跟您所选的不一致。")
                return
            }
        }
        
        
        if category == Pet.Category.other{
            self.showErrAlert("其他种类现在暂时不支持投保。 请过段时间再来看看哦！")
            return
        }
        
        let ownerName: String? = self.ownerNameTextField.text
        let ownerID: String? = self.ownerIDTextField.text
        let age: Int? = Int(self.ageTextField.text ?? "0")
        
        let selectedGender = self.genderPicker.selectedRow(inComponent: 0)

        let gender: Bool
        switch Pet.Gender.allCases[selectedGender] {
        case .female:
            gender = false
        default:
            gender = true
        }
        
        let image = petImageView.image!.pngData()!
        let feature = PetsRecognizer.core.featurize(image: image)
        
        do {
            try PetsDataSource.db.addPet(name: name, category: category, age: age, gender: gender, ownerName: ownerName, ownerID: ownerID, feature: feature, image: image)
            print("Insertion succeeds.")
            self.dismiss(animated: true, completion: {
                self.parentView.reloadTableView()
            })
        } catch let err {
            self.showErrAlert("\(err)")
            print("\(err)")
        }
    }
    
    
    //MARK: Methods
    
    func showErrAlert(_ msg: String){
        let alert = UIAlertController(title: "错误", message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
        }))
        self.present(alert, animated: true, completion: nil)
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
