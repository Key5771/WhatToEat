//
//  ViewController.swift
//  WhatToEat
//
//  Created by 김기현 on 2020/07/15.
//  Copyright © 2020 김기현. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.text = """
        오늘
        뭐먹지
        """
        label.textColor = UIColor.white
        
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 10
        
        
    }


}

