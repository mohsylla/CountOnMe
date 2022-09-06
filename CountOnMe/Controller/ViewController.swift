//
//  ViewController.swift
//  SimpleCalc
//
//  Created by MohSylla on 19/09/2021.
//  Copyright © 2020 Vincent Saluzzo. All rights reserved.
//


import UIKit

class ViewController: UIViewController {
    
    // Outlets
    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!
    
    
    //Instance of Calculation
    var myCalculation = Calculation()
    
    // View Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // Method to attribute the text view
    func attributeText () {
        textView.text = myCalculation.calculationText
    }
    
    // View actions
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
            return
        }
        
        myCalculation.tappedNumber(numberText: numberText)
        
        //refresh the text by calling below method
        attributeText()
    }
    
    @IBAction func tappedAdditionButton(_ sender: UIButton) {
        myCalculation.addition()
        attributeText()
        
        guard !myCalculation.canAddOperator else {
            alert(title: "Zéro !", message: "Un operateur est déja mis !")
            return
        }
    }
    
    @IBAction func tappedSubstractionButton(_ sender: UIButton) {
        myCalculation.substraction()
        attributeText()
        
        guard !myCalculation.canAddOperator else {
            alert(title: "Zéro !", message: "Un operateur est déja mis !")
            return
        }
    }
    
    
    @IBAction func tappedMultiplicationButton(_ sender: UIButton) {
        myCalculation.multiplication()
        attributeText()
        
        guard !myCalculation.canAddOperator else {
            alert(title: "Zéro !", message: "Un operateur est déja mis !")
            return
        }
    }
    
    @IBAction func tappedDivisionButton(_ sender: UIButton) {
        myCalculation.division()
        attributeText()
        
        guard !myCalculation.canAddOperator else {
            alert(title: "Zéro !", message: "Un operateur est déja mis !")
            return
        }
    }
    
    
    @IBAction func tappedAcButton(_ sender: UIButton) {
        myCalculation.reset()
        textView.text = myCalculation.calculationText    }
    
    @IBAction func tappedEqualButton(_ sender: UIButton) {
        guard myCalculation.expressionIsCorrect else {
            alert(title: "Zéro !", message: "Entrez une expression correcte !")
            return
        }
        
        guard myCalculation.expressionHaveEnoughElement else {
            alert(title: "Zéro !", message: "Démarrez un nouveau calcul !")
            return
        }
        
        // Call the result method
        myCalculation.result()
        
        // Check if division by zero is in the expression
        guard !myCalculation.expressionHasNoZeroDivision else {
            alert(title: "Zéro !", message: "La division par zero est impossible !")
            attributeText()
            return
        }
        
        //Refresh the text by calling below method
        attributeText()
    }
    
    // Method to call an alert
    func alert(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        return self.present(alertVC, animated: true, completion: nil)
    }

}

