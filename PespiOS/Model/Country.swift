//
//  Country.swift
//  PespiOS
//
//  Created by JuanSosa on 9/24/19.
//  Copyright © 2019 JuanSosa. All rights reserved.
//

import UIKit
import Alamofire


 protocol CountryImageProtocol {
     func finishDownloadCountryImage()
}

class Country: NSObject {
    static let shared = Country()
    var delegate : CountryImageProtocol?
    var nativeName = ""
    var name = ""
    var timezones: [String] = []
    var numericCode = 0
    var levelDomain:[String] = []
    var region = ""
    var alphaCode = ""
    var capital = ""
    var subregion = ""
    var population = 0
    var demonym = ""
    var coin = ""
    var area = 0
    var currencies = Dictionary<String,Any>()
    var callingCodes: [String] = []
    var coordinates: [Double] = []
    var altSpellings: [String] = []
    var borders: [String] = []
    var languages: [String] = []
    var traducciones: [String:String] = [:]
    var regionalBlocs: [String] = []
    var flagURL : URL?
    
    override init() { }
    
    init(with details : [String:Any]) {
        super.init()

        if let Name = details["name"] as? String {
                     name = Name
          }
        
        if let are = details["area"] as? Int {
                     area = are
          }
        
        if let domain = details["topLevelDomain"] as? [String] {
                     levelDomain = domain
          }
        
        if let alpha = details["alpha2Code"] as? String {
                     alphaCode = alpha
          }
        
        if let reg = details["region"] as? String {
                     region = reg
          }
        
        if let calling = details["callingCodes"] as? [String] {
            callingCodes = calling
        }
        
        if let capi = details["capital"] as? String {
             capital = capi
         }
        
        if let sub = details["subregion"] as? String {
             subregion = sub
         }
        
        if let popul = details["population"] as? Int {
             population = popul
         }
        
        
        if let coordinate = details["latlng"] as? [Double] {
             coordinates = coordinate
         }
        
        if let demo = details["demonym"] as? String {
              demonym = demo
          }
                
        if let time = details["timezones"] as? [String] {
              timezones = time
          }
        
        if let border = details["borders"] as? [String] {
            borders = border
        }
        
        if let calling = details["callingCodes"] as? [String] {
            callingCodes = calling
        }

        if let NameNative = details["nativeName"] as? String {
              nativeName = NameNative
          }
        
        if let numeric = details["numericCode"] as? Int {
             numericCode = numeric
         }
        
        if let capi = details["capital"] as? String {
             capital = capi
         }
        
        if let currencie = details["currencies"] as? Dictionary<String,Any> {
            currencies = currencie
        }
        
        if let lang = details["languages"] as? [[String :String]]{
            for item:[String:String] in lang {
                languages.append(item["name"]!)
            }
        }
        
        if let regional = details["regionalBlocs"] as? [[String :String]]{
            for item:[String:String] in regional {
                regionalBlocs.append(item["name"]!)
            }
        }
        
        if let translation = details["translations"] as? [String :String]{
                traducciones = translation
        }
        
        if let flag = details["flag"] as? String {            
            if let the_url = URL(string: flag) {
                     self.flagURL = the_url
            }
        }
        
        if let coins = details["cioc"] as? String {
                    coin = coins
            }
    }
    
}
