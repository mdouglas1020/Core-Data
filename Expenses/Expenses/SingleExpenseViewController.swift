//
//  SingleExpenseViewController.swift
//  Expenses
//
//  Created by Tech Innovator on 11/30/17.
//  Copyright © 2017 Tech Innovator. All rights reserved.
//

import UIKit

class SingleExpenseViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    var existing_expense: Expense?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "New Expense"
        
        nameTextField.delegate = self
        amountTextField.delegate = self
        nameTextField.text = existing_expense?.name
        
        if let amount = existing_expense?.amount
        {
            amountTextField.text = "\( amount )"
        }
        
        if let date = existing_expense?.date
        {
            datePicker.date = date
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveExpense(_ sender: Any) {
        let name = nameTextField.text
        let amountText = amountTextField.text ?? ""
        let amount = Double(amountText) ?? 0.0
        let date = datePicker.date
        
        var expense: Expense?
        if let existing_expense = existing_expense
        {
            existing_expense.name   = name
            existing_expense.amount = amount
            existing_expense.date   = date
            
            expense = existing_expense
        }
        else
        {
            expense = Expense( name: name, amount: amount, date: date )
        }
        
        if let expense = expense
        {
            do
            {
                let managed_context = expense.managedObjectContext
                try managed_context?.save()
                
                self.navigationController?.popViewController( animated: true )
            }
            catch
            {
                print( "Context could not be saved" )
            }
        }
    }
}

extension SingleExpenseViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
