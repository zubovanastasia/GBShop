//
//  SelfyForMap.swift
//  GBShop
//
//  Created by Anastasiia Zubova on 23.06.2022.
//

import Foundation
import UIKit

class SelfyViewController: UIViewController {
    @IBOutlet private weak var photo: UIImageView!
    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photo.image = image
    }
}
