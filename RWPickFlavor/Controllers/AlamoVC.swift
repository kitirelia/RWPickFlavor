//
//  AlamoVC.swift
//  MyGoalQR
//
//  Created by Kitiwat Chanluthin  on 6/12/2562 BE.
//  Copyright © 2562 WisdomVast. All rights reserved.
//

import UIKit
import SVProgressHUD
import Alamofire

class AlamoVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        SVProgressHUD.show()
        getData()
    }

    
    func getData(){
       
        
        Alamofire.request("https://www.raywenderlich.com/downloads/Flavors.plist").responseJSON { response in
            print("AlamoVC:\(response.request)")   // original url request
            SVProgressHUD.showSuccess(withStatus: "Success")
            SVProgressHUD.dismiss(withDelay: 1)
           
            let alert = UIAlertController(title: "Success", message: "Test Alamofire Success", preferredStyle: UIAlertController.Style.alert)
                   alert.addAction(UIAlertAction(title: "Done", style: UIAlertAction.Style.default, handler: nil))
                   self.present(alert, animated: true, completion: nil)
        }
    }
  

}
