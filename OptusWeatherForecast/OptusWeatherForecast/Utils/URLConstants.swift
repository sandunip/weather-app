//
//  URLConstants.swift
//  OptusWeatherForecast
//
//  Created by Sanduni Perera on 12/2/22.
//

import Foundation

struct URLConstants{
    
    struct Api {
        static let HOST = "https://api.publicapis.org"
        
        
        struct Path {
            static var entries:String{
                return HOST + "/entries"
            }
        }
        
        struct APIKEY {
            static let APIKEY = "4c1b3c8789d7cdd231c34e869738f403"
        }
    }
}
