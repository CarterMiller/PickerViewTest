//
//  ViewController.swift
//  TestCookingTimes
//
//  Created by Russell Morgan on 21/12/2020.
//

import UIKit

struct CookingTimes
{
    var cutOfMeat           : String
    var cookingTimePerKg    : Int
    
    // because we include _ in the initialiser, we don't have to name the parameters when we use it
    init(_ cutOfMeat : String, _ cookingTimePerKg : Int)
    {
        self.cutOfMeat          = cutOfMeat
        self.cookingTimePerKg   = cookingTimePerKg
    }
}
class ViewController: UIViewController {

    @IBOutlet weak var pickerMeat: UIPickerView!
    @IBOutlet weak var pickerCut: UIPickerView!
    @IBOutlet weak var pickerWeight: UIPickerView!
    @IBOutlet weak var lblInfo: UILabel!

    let typeOfMeat = ["Beef", "Pork", "Lamb", "Poultry"]
    var cutOfMeat = [[CookingTimes]]()
    let weightOfMeat = [0.5, 1.0, 1.5, 2, 2.5, 3, 4, 5]
    
    var typeOfMeatSelected  = 0
    var weightSelected      = 0.5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // set up the Beef cuts
        cutOfMeat.append([CookingTimes("Boneless Short Ribs", 10),
                          CookingTimes("Chuck Steak (Cubed)", 11),
                          CookingTimes("Minced Beef (From Frozen)", 12),
                          CookingTimes("Minced Beef", 13),
                          CookingTimes("Burgers (Air-crisp)", 14),
                          CookingTimes("Chuck-Eye Roast", 15),
                          CookingTimes("Beef Brisket", 16),
                          CookingTimes("Steak (Air-Crisp, rare", 17)])
        // set up the Pork
        cutOfMeat.append([CookingTimes("Bacon (Air-Crisp)", 20),
                          CookingTimes("Sausages (Air-Crisp)", 21),
                          CookingTimes("Boneless Pork Shoulder", 22),
                          CookingTimes("Minced Pork (From Frozen", 23),
                          CookingTimes("Minced Pork", 24),
                          CookingTimes("Pork Tenderloins (Air-crisp)", 25),
                          CookingTimes("Baby Back Pork", 26),
                          CookingTimes("Pork Chops (Boneless, Air Crisp", 27),
                          CookingTimes("Pork Chops (With Bone, Air-Crisp",28)])
        // setup the Lamb
        cutOfMeat.append([CookingTimes("Leg of Lamb (Boneless)", 31),
                          CookingTimes("Leg of Lamb", 32),
                          CookingTimes("Lamb Chops (Boneless)", 33),
                          CookingTimes("Lamb Chops", 34),
                          CookingTimes("Lamb Steak", 35),
                          CookingTimes("Minced Lamb",36)])
        // setup the Poultry
        cutOfMeat.append([CookingTimes("Chicken Breast (Unfrozen)", 40),
                        CookingTimes("Chicken Breast", 41),
                        CookingTimes("Chicken Thighs", 42),
                        CookingTimes("Chicken Legs", 43),
                        CookingTimes("Chicken Nuggets", 44),
                        CookingTimes("Turkey Breast", 45),
                        CookingTimes("Minced Turkey (Frozen)", 46),
                        CookingTimes("Minced Turkey",47) ])
        
        // start with the first option selected
        calculateAndPrintTotal()
        
    }

    func calculateAndPrintTotal()
    {
        // display timings / recipe based on selection
        // simple assumption that cooking time is time per Kg x weight
        // in practise, the time per Kg may reduce for larger weights,
        // but you could add that in the struct CookingTimeswith something like timePerKG_Under3Kg, timePerKG_Over3Kg
        let meat    = typeOfMeat[typeOfMeatSelected]
        let cut     = cutOfMeat[typeOfMeatSelected][pickerCut.selectedRow(inComponent: 0)].cutOfMeat
        
        let cookingTime = weightSelected * Double(cutOfMeat[typeOfMeatSelected][pickerCut.selectedRow(inComponent: 0)].cookingTimePerKg)

        
        lblInfo.text = "Show details for \(meat), \(cut), \(weightSelected) Kg \n\n Cooking time is \(cookingTime) minutes"

    }

}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource
{
    // PickerView methods
    // the type of meat picker has tag = 0, the cutOfMeat picker is tag = 1, the weight is tag = 2
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        // this is the same for both pickers, so no check required
        return 1
    }
   
     func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
     {
        //if the type of Meat is selected, change the tracking variable 'typeOfMeatSelected'
        // and refresh the cutofmeat picker
        switch pickerView.tag {
        case 0:
            // type of meat
            typeOfMeatSelected = row
            pickerCut.reloadAllComponents()
            // select the first entry, otherwise you could have a selected row higher then the current type of meat
            pickerCut.selectRow(0, inComponent: 0, animated: true)
        case 1:
            // cut of meat
            // display the calculated timings / recipe
            calculateAndPrintTotal()
        case 2:
            // weight of meat
            weightSelected = weightOfMeat[row]
            // display the calculated timings / recipe
            calculateAndPrintTotal()
        default:
            // not required
            print("Something is missing if we see this")
        }
     }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {

        switch pickerView.tag {
        case 0:
            return typeOfMeat.count

        case 1:
            return cutOfMeat[typeOfMeatSelected].count
        
        case 2:
            return weightOfMeat.count
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        switch pickerView.tag {
        case 0:
            return typeOfMeat[row]

        case 1:
            return cutOfMeat[typeOfMeatSelected][row].cutOfMeat
        
        case 2:
            return ("\(weightOfMeat[row]) Kg")
        default:
            return "unknown"
        }
    }
}
