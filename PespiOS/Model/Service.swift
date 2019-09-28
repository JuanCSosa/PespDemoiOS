//
//  Service.swift
//  PespiOS
//
//  Created by JuanSosa on 9/23/19.
//  Copyright © 2019 JuanSosa. All rights reserved.
//

import UIKit
import Alamofire

 protocol CountryInfoProtocol {
     func finishDownloadCountryInfo()
}

class Service: NSObject {
    
    static let shared = Service()
    var delegate : CountryInfoProtocol?
    var countries: [Country] = []
    var namesCountries:[String] = []
    
    func downloadCountries() {
        DispatchQueue.main.async {
            Alamofire.request( "https://restcountries.eu/rest/v2/all", method: .get, parameters: nil, headers: nil).responseJSON {
                response in
                if let result = response.result.value as? [[String:Any]] {
                    for elements in result {
                        let country = Country(with: elements)
                        self.countries.append(country)
                        self.namesCountries.append(country.name)
                    }
                    self.delegate?.finishDownloadCountryInfo()
                }
            }
        }
    }
}
