//
//  CountryTracker.swift
//  RxSwiftExample3
//
//  Created by Ali Can Batur on 10/02/17.
//  Copyright © 2017 alikooo. All rights reserved.
//

import Foundation
import Moya_ModelMapper
import Moya
import RxOptional
import RxSwift

struct CountryTracker {
    
    let provider: RxMoyaProvider<Countries>
    let countryName: Observable<String>
    
    func retrieveAllCountries() -> Observable<[Country]> {
        return self.provider
            .request(Countries.allCountries())
            .debug()
            .mapArrayOptional(type: Country.self)
            .replaceNilWith([])
    }
    
    func trackCountries() -> Observable<[Country]> {
        return countryName
            .observeOn(MainScheduler.instance)
            .flatMapLatest { string -> Observable<[Country]> in
                print("String : \(string)")
                return self.findCountries(string: string)
        }
    }
    
    internal func findCountries(string: String) -> Observable<[Country]> {
        return self.provider
            .request(Countries.findCountry(string: string))
            .debug()
            .mapArrayOptional(type: Country.self)
            .replaceNilWith([])
    }
    
}
