//
//  CountryDetailViewController.swift
//  PespiOS
//
//  Created by JuanSosa on 9/25/19.
//  Copyright © 2019 JuanSosa. All rights reserved.
//

import UIKit
import GoogleMaps
import SVGKit


class CountryDetailViewController: UIViewController {
    
    class func makeCountryDetailViewController() -> CountryDetailViewController {
           return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CountryDetailViewController") as! CountryDetailViewController
       }

    @IBOutlet weak var scroll: UIScrollView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var nativeName: UILabel!
    @IBOutlet weak var region: UILabel!
    @IBOutlet weak var subregion: UILabel!
    @IBOutlet weak var capital: UILabel!
    @IBOutlet weak var coin: UILabel!
    @IBOutlet weak var population: UILabel!
    @IBOutlet weak var dominio: UILabel!
    @IBOutlet weak var languages: UILabel!
    @IBOutlet weak var alfaCode: UILabel!
    @IBOutlet weak var translations: UILabel!
    @IBOutlet weak var demonym: UILabel!
    @IBOutlet weak var callingCodes: UILabel!
    @IBOutlet weak var borders: UILabel!
    @IBOutlet weak var numericCode: UILabel!
    @IBOutlet weak var area: UILabel!
    @IBOutlet weak var timezones: UILabel!
    @IBOutlet weak var viewMaps: GMSMapView!
    @IBOutlet weak var btnOpenGoogle: UIButton!
    @IBOutlet weak var imageFlag: UIImageView!
    
    var country = Country()
    var formatStr = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()
        name.text = country.name
        nativeName.text = country.nativeName
        region.text = country.region
        subregion.text = country.subregion
        capital.text = country.capital
        coin.text = country.coin
        alfaCode.text = country.alphaCode
        numericCode.text = "\(country.numericCode)"
        population.text = "\(country.population)"
        demonym.text = country.demonym
        area.text = "\(country.area)"

        
        for language in country.languages {
            formatStr += "\(language) \n"
        }
        languages.text = formatStr
        
         formatStr = ""
        for (x,y) in country.traducciones {
            formatStr += "\(x): \(y)\n"
        }
        translations.text = formatStr
        
         formatStr = ""
        for borde in country.borders {
            formatStr += "\(borde)\n"
        }
        borders.text = formatStr
        
        formatStr = ""
        for domain in country.levelDomain {
            formatStr += "\(domain)\n"
        }
        dominio.text = formatStr
        
        formatStr = ""
        for time in country.timezones {
                  formatStr += "\(time)\n"
        }
        timezones.text = formatStr
        
        formatStr = ""
        for call in country.callingCodes {
                  formatStr += "\(call)\n"
        }
        callingCodes.text = formatStr
        let imageSVG = SVGKImage(contentsOf: country.flagURL)
        imageFlag.image = imageSVG?.uiImage
        imageFlag.contentMode = .scaleAspectFit
        imageFlag.clipsToBounds = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        if country.coordinates.count > 0 {
            let camera = GMSCameraPosition.camera(withLatitude: country.coordinates[0], longitude: country.coordinates[1], zoom: 1)
            viewMaps.camera = camera
             let position = CLLocationCoordinate2D(latitude: country.coordinates[0], longitude: country.coordinates[1])
                   let marker = GMSMarker(position: position)
                   marker.title = country.name
                      marker.map = viewMaps
        }

    }
    
    @IBAction func openGoogle(_ sender: Any) {
        let ac = UIAlertController(title: "Google Maps", message: "¿Desea abrir la ubicación en Google Maps?", preferredStyle: .alert)
                   ac.addAction(UIAlertAction(title: "Abrir Google Maps", style: .default) { action in
                    self.openInGoogleMaps()
                          })
        ac.addAction(UIAlertAction(title: "Cancelar", style: .default))
                   present(ac, animated: true)
    }
    
    func openInGoogleMaps(){
        if (UIApplication.shared.canOpenURL(NSURL(string:"comgooglemaps://")! as URL)) {
                   UIApplication.shared.open(URL(string: "comgooglemaps://?saddr=&daddr=\(country.coordinates[0]),\(country.coordinates[1])&directionsmode=driving")!, options:[:]) { (true) in
                   }
               }
    }

}

extension UIViewController {
    
    func showCountryDetailViewController(country: Country) {
        let countryViewController = CountryDetailViewController.makeCountryDetailViewController()
        countryViewController.country = country
        present(countryViewController, animated: true, completion: nil)
    }
}
