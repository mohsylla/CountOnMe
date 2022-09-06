//
//  Calculation.swift
//  CountOnMe
//
//  Created by MohSylla on 19/09/2021.
//  Copyright © 2020 Vincent Saluzzo. All rights reserved.
//


import Foundation

class Calculation {
    
    // Parameter to store the text of the calculation
    var calculationText: String = ""
    
    // Parameter to round the result if not a decimal number
    var resultString:String!
    
    // Array of selected elements
    var elements: [String] {
        return calculationText.split(separator: " ").map { "\($0)" }
    }
    
    // Parameter used to calculate the result
    var operationsToReduce: [String]!
    
    // Error check computed variables
    var expressionIsCorrect: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "x" && elements.last != "/"
    }
    
    // Check if an operation has been demanded
    var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }
    
    // Check if operator can be added
    var canAddOperator: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "x" && elements.last != "/" && elements.first != nil
    }
    
    // Check if an operation has already been done
    var expressionHaveResult: Bool {
        return calculationText.firstIndex(of: "=") != nil
    }
    
    // Check if no division by zero
    var expressionHasNoZeroDivision: Bool = false
    
    //Method for tapped number
    func tappedNumber(numberText: String) {
        if expressionHaveResult {
            calculationText = ""
        }
        
        calculationText.append(numberText)
    }
    
    //Method for addition
    func addition() {
        if canAddOperator{
            calculationText.append(" + ")
        }
        
        // Reset calculation if result already received
        if expressionHaveResult {
            calculationText = ""
        }
    }
    
    
    //Method for substraction
    func substraction() {
        if canAddOperator{
            calculationText.append(" - ")
        }
        
        // Reset calculation if result already received
        if expressionHaveResult {
            calculationText = ""
        }
    }
    
    //Method for multiplication
    func multiplication() {
        if canAddOperator{
            calculationText.append(" x ")
        }
        
        // Reset calculation if result already received
        if expressionHaveResult {
            calculationText = ""
        }
    }
    
    //Method for division
    func division() {
        if canAddOperator{
            calculationText.append(" / ")
        }
        
        // Reset calculation if result already received
        if expressionHaveResult {
            calculationText = ""
        }
    }
    
    // Method for result
    func result() {
        // Create local copy of operations for result method
        operationsToReduce = elements
        
        // Reset calculation if result already received
        if expressionHaveResult {
            calculationText = ""
        } else {
            // Check if a division bt zero exists
            zeroDivision()
            
            if expressionHasNoZeroDivision == false {
                // Iterate over operations while an operand still here
                while operationsToReduce.count > 1 {
                    
                    // Priority to multiplication and division
                    multiplicationDivisionResult(orepand: "/")
                    
                    // Then, priority to multiplication and division
                    multiplicationDivisionResult(orepand: "x")
                    
                    // Check if addition and substractions are still in the array
                    additionAndSubstractionResult()
                }
                calculationText.append(" = \(operationsToReduce.first!)")
            }

        }
    }
    
    //Method to remove the decimal of the Double if result is an integer
    private func roundResult(result: Double) {
        if result == Double(Double(result)) {
            let roundResult = Double(result)
            resultString = String(roundResult)
        } else {
            resultString = String(result)
        }
    }
    
    
    // Multiplication result
    private func multiplicationDivisionResult(orepand: String){
        while operationsToReduce.contains(orepand){
            for i in 0...(operationsToReduce.count-1) {
                // Make sure i is still in the range
                if i > 1 && i <= operationsToReduce.count-1 {

                    // Find the multiplication and divisions
                    if operationsToReduce[i-1] == orepand {
                        
                        // Assign the numbers and operand of the local operation
                        let left = Double(operationsToReduce[i-2])!
                        let operand = operationsToReduce[i-1]
                        let right = Double(operationsToReduce[i])!
                        
                        //Make the local operation
                        var result: Double
                        switch operand {
                        case "x": result = left * right
                        case "/": result = left / right
                        default: fatalError("Unknown operator !")
                        }
                        
                        // Round the result if no decimal needed
                        roundResult(result: result)
                        operationsToReduce.insert(resultString, at: i+1)
                        
                        operationsToReduce.remove(at: i)
                        operationsToReduce.remove(at: i-1)
                        operationsToReduce.remove(at: i-2)
                    }
                }
            }
        }
    }
    
    // Addition and substraction
    private func additionAndSubstractionResult(){
        if operationsToReduce.count >= 3 {
            let left = Double(operationsToReduce[0])!
            let operand = operationsToReduce[1]
            let right = Double(operationsToReduce[2])!
            
            var result: Double
            switch operand {
            case "+": result = left + right
            case "-": result = left - right
            case "=": return
            default: fatalError("Unknown operator !")
            }
            
            operationsToReduce = Array(operationsToReduce.dropFirst(3))
            
            // Round the result if no decimal needed
            roundResult(result: result)
            operationsToReduce.insert(resultString, at: 0)
        }
    }
    
    // Method to check if division by zero is in the expression
    private func zeroDivision(){
        for i in 0...(elements.count-1) {
            // Make sure i is still in the range
            if i > 1 && i <= elements.count-1 {
                
                // Find the divisions and check if followed by zero
                if elements[i-1] == "/" && elements[i] == "0" {
                    print("division impossible")
                    calculationText = ""
                    expressionHasNoZeroDivision = true
                } else {
                    expressionHasNoZeroDivision = false
                }
            }
        }
    }
    /// Reset calculator
    func reset() {
        calculationText = "0"
    }
    
}

