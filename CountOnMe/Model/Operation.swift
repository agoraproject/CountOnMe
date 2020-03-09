//
//  operation.swift
//  CountOnMe
//
//  Created by Haulin Jean-Philippe on 27/08/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import Foundation

class Operation {
    
    
    var calculText: ((String) -> Void)?
    var displayAlert: ((String) -> Void)?
    
    //listenner didset property observer
    var expression: String = "1 + 1 = 2" {
        didSet {
            calculText?(expression)
        }
    }
    
    var elements: [String] {
        return expression.split(separator: " ").map { "\($0)" }
    }
    
    // Error check computed variables
    var expressionIsCorrect: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "%" && elements.last != "x"
    }
    
    var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }
    
    var canAddOperator: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "%" && elements.last != "x"
    }
    
    var expressionHaveResult: Bool {
        return expression.firstIndex(of: "=") != nil
    }
    
    func addNewNumber (number: String) {
        if expressionHaveResult {
            expression = ""
        }
        expression.append(number)
        //textView.text.append(" = \(operationsToReduce.first!)")
    }

    func addOperator (operateur: String) {
        if canAddOperator {
            expression.append(" \(operateur) ")
        } else {
            /*let alertVC = UIAlertController(title: "Zéro!", message: "Un operateur est déja mis !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertVC, animated: true, completion: nil)*/
            displayAlert?("Un operateur est déja mis !")
            
        }
    }
    
    func calculateTotal () {
        guard expressionIsCorrect else {
                /*let alertVC = UIAlertController(title: "Zéro!", message: "Entrez une expression correcte !", preferredStyle: .alert)
                alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                return self.present(alertVC, animated: true, completion: nil)*/
                displayAlert?("Entrez une expression correcte !")
                return
            }
            
        guard expressionHaveEnoughElement else {
                /*let alertVC = UIAlertController(title: "Zéro!", message: "Démarrez un nouveau calcul !", preferredStyle: .alert)
                alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                return self.present(alertVC, animated: true, completion: nil)*/
                displayAlert?("Démarrez un nouveau calcul !")
                return
            }
            
            // Create local copy of operations
            var operationsToReduce = elements
            
            // Iterate over operations while an operand still here
            while operationsToReduce.count > 1 {
                let left = Int(operationsToReduce[0])!
                let operand = operationsToReduce[1]
                let right = Int(operationsToReduce[2])!
                
                let result: Int
                switch operand {
                case "+": result = left + right
                case "-": result = left - right
                case "x": result = left * right
                case "%": result = left / right
                default: return
                }
                
                operationsToReduce = Array(operationsToReduce.dropFirst(3))
                operationsToReduce.insert("\(result)", at: 0)
            }
            expression.append(" = \(operationsToReduce.first!)")
    }
    
    func erase() {
        expression = ""
    }
}
