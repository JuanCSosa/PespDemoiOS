//
//  CountryCollectionViewCell.swift
//  PespiOS
//
//  Created by JuanSosa on 9/24/19.
//  Copyright © 2019 JuanSosa. All rights reserved.
//

import UIKit
import Alamofire
import WebKit
import SVGKit

class CountryCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var shadow: UIView!
    @IBOutlet weak var flag: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var nativeName: UILabel!
    var country = Country()
    @IBOutlet weak var imageWeb: WKWebView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func countryInfo(info:Country){
        let imageSVG = SVGKImage(contentsOf: info.flagURL)
        country = info
        name.text = info.name
        nativeName.text = info.nativeName
        flag.image = imageSVG?.uiImage
        flag.clipsToBounds = true

        shadow.setShadow()
    }
    
    func countryInfoName(info:String){
          // country = info
           name.text = info//.name
           //nativeName.text = info.nativeName
           /*DispatchQueue.main.async {
               self.imageWeb.load(URLRequest(url: self.country.flagURL!))
           }
           imageWeb.scrollView.isScrollEnabled = false*/
           shadow.setShadow()
       }

}


