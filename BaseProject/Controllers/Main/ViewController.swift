//
//  ViewController.swift
//  BaseProject
//
//  Created by Danish on 12/06/22.
//

import UIKit

class ViewController: UIViewController {

    let apiManager = APIManager.shared()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
            self.apiManager.call(type: EndpointItem.login) { (_: LoginModel?, error) in
                
            }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
