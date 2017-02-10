//
//  CountriesEndpoint.swift
//  RxSwiftExample3
//
//  Created by Ali Can Batur on 10/02/17.
//  Copyright © 2017 alikooo. All rights reserved.
//

import Foundation
import Moya

private extension String {
    var URLEscapedString: String {
        return self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed)!
    }
}

enum Countries {
    case allCountries()
    case findCountry(string: String)
}

extension Countries: TargetType {
    
    var baseURL: URL { return URL(string: "https://restcountries.eu/rest/v1/")! }
    
    var path: String {
        switch self {
        case .allCountries():
            return "all"
        case .findCountry(let string):
            return "name/\(string)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .allCountries(), .findCountry(_) : return .get
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .allCountries(), .findCountry(_):
            return nil
        }
    }
    
    var sampleData: Data {
        switch self {
        case .allCountries(), .findCountry(_):
            return "[{\"name\": \"Afghanistan\",\"capital\": \"Kabul\",\"population\": 26023100},{\"name\": \"Turkey\",\"capital\": \"Ankara\",\"population\": 77695904}]".data(using: .utf8)!
            
        }
    }
    
    var task: Task { return .request }

    var parameterEncoding: ParameterEncoding { return JSONEncoding.default }
    
}

