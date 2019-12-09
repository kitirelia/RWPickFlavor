//
//  ViewController.swift
//  MyGoalQR
//
//  Created by Kitiwat Chanluthin  on 6/12/2562 BE.
//  Copyright © 2562 WisdomVast. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func qrBtnTap(_ sender: Any) {
        let vc = BarcodeVC(nibName:"BarcodeVC",bundle:nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func alamoBtnTap(_ sender: Any) {
        
        let vc = AlamoVC(nibName:"AlamoVC",bundle:nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

