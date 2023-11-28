//
//  ViewController.swift
//  combine_TextField_toy
//
//  Created by MAC on 11/28/23.
//

import UIKit
import Combine

class ViewController: UIViewController {

    
    @IBOutlet var IdTextField: UITextField!
    @IBOutlet var PasswordTextField: UITextField!
    @IBOutlet var LiginBtn: UIButton!
    
    var viewmodel: ViewModel!
    private var mysubscription = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewmodel = ViewModel()
        
        IdTextField.myTextFieldPublisher
            .receive(on: DispatchQueue.main)
            .assign(to: \.inPutId, on: viewmodel)
            .store(in: &mysubscription)
        
        
        PasswordTextField.myTextFieldPublisher
            .receive(on: DispatchQueue.main)
            .assign(to: \.inPutPassword, on: viewmodel)
            .store(in: &mysubscription)
        
       
    }
    

    @IBAction func tapLoginBtn(_ sender: UIButton) {
        if viewmodel.myID == viewmodel.inPutId && viewmodel.myPassword == viewmodel.inPutPassword {
            let VC = storyboard?.instantiateViewController(identifier: "NiceViewController") as? NiceViewController
            self.present(VC!, animated: true)
        } else {
            let alert = UIAlertController(title: "아이디와 비밀번호가 옳지않습니다", message: nil, preferredStyle: .alert)
            let okBtn = UIAlertAction(title: "OK", style: .default)
            alert.addAction(okBtn)
            present(alert, animated: true)
        }
        
    }
    
}

extension UITextField {
    var myTextFieldPublisher: AnyPublisher<String , Never> {
        NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification, object: self)
            .compactMap{$0.object as? UITextField}
            .map{$0.text ?? ""}
            .print()
            .eraseToAnyPublisher()
    }

}

