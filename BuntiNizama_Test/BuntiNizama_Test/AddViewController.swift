//
//  AddViewController.swift
//  BuntiNizama_Test
//
//  Created by Bunti Nizama on 01/07/20.
//

import UIKit
import RealmSwift
protocol AddViewControllerDelegate: class {
    func doneTapped()
    
}
class AddViewController: UIViewController {
    
    @IBOutlet weak var titleTextField : UITextField!
    @IBOutlet weak var descriptionTextView : UITextView!
    weak var delegate: AddViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        descriptionTextView.text = "Description"
        descriptionTextView.textColor = UIColor.lightGray
        // Do any additional setup after loading the view.
    }
    

    @IBAction func doneTapped(){
        if validateData() == true {
            let realm = try! Realm()
            try! realm.write{
                let item = Item()
                item.title = titleTextField.text!
                item.itemDescription = descriptionTextView.text!
                realm.add(item)
                delegate?.doneTapped()
            }
        }
    }
    
    @IBAction func cancelTapped(){
        self.navigationController?.popViewController(animated: true)
    }
    
    func validateData()-> Bool {
        if titleTextField.text?.count == 0 {
            self.shorAlert(title: "Empty", message: "Please enter title.")
            return false
        }
        if descriptionTextView.textColor == UIColor.lightGray || descriptionTextView.text.count == 0 {
            self.shorAlert(title: "Empty", message: "Please enter description.")
            return false
        }
        return true
    }
    
    func shorAlert(title : String ,message : String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension AddViewController : UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.count == 0 {
            descriptionTextView.text = "Description"
            descriptionTextView.textColor = UIColor.lightGray
        }
    }
}
