//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!
    
    //MARK: - Properties
    var operationText = Operation()
    
    //MARK: - View Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    
    //MARK: - actions
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
            return
        }
        operationText.addNewNumber(number: numberText)
    }
    
    @IBAction func tappedAdditionButton(_ sender: UIButton) {
        operationText.addOperator (operateur: "+")
    }
    
    @IBAction func tappedSubstractionButton(_ sender: UIButton) {
        operationText.addOperator (operateur: "-")
    }

    @IBAction func tappedDivisionButton(_ sender: UIButton) {
        operationText.addOperator (operateur: "%")
    }
    
    @IBAction func tappedEraseButton(_ sender: UIButton) {
        operationText.erase ()
    }
    
    @IBAction func tappedMultiplicationButton(_ sender: UIButton) {
        operationText.addOperator (operateur: "x")
    }
    
    @IBAction func tappedEqualButton(_ sender: UIButton) {
        
            operationText.calculateTotal ()
    }
    
    func bind() {
        operationText.calculText = { [ weak self ] text in
            self?.textView.text = text
        }
        operationText.displayAlert = displayAlert
    }
    
    func displayAlert (message: String) {
        let alertVC = UIAlertController(title: "zero!", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "ok", style: .cancel, handler: nil))
        present(alertVC, animated: true)
    }
}

