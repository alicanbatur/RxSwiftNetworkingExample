//
//  CountriesViewController.swift
//  RxSwiftExample3
//
//  Created by Ali Can Batur on 10/02/17.
//  Copyright © 2017 alikooo. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Moya
import Moya_ModelMapper

class CountriesViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!

    let disposeBag = DisposeBag()
    var provider: RxMoyaProvider<Countries>!
    var latestCountryName: Observable<String> {
        return searchBar
            .rx
            .text
            .orEmpty
            .debounce(0.5, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
    }
    var countryTracker: CountryTracker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Comment out which func you wanna use.
        // setupRxWithAllCountries()
        setupRxWithStringInput()
    }
    
    func setupRxWithStringInput() {
        provider = RxMoyaProvider<Countries>()
        countryTracker = CountryTracker(provider: provider, countryName: latestCountryName)
        countryTracker
            .trackCountries()
            .bindTo(tableView.rx.items) {
                tableView, row, country in
                let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: IndexPath(row: row, section: 0))
                cell.textLabel?.text = country.name
                return cell
            }
            .addDisposableTo(disposeBag)
        
        tableView
            .rx
            .itemSelected
            .subscribe(onNext: { indexPath in
                if self.searchBar.isFirstResponder {
                    self.view.endEditing(true)
                }
            })
            .addDisposableTo(disposeBag)

    }
    
    func setupRxWithAllCountries() {
        provider = RxMoyaProvider<Countries>()
        
        countryTracker = CountryTracker(provider: provider, countryName: latestCountryName)
        countryTracker.retrieveAllCountries().bindTo(tableView.rx.items) {
            tableView, row, country in
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: IndexPath(row: row, section: 0))
            cell.textLabel?.text = country.name
            return cell
        }
        .addDisposableTo(disposeBag)
        
        tableView
            .rx
            .itemSelected
            .subscribe(onNext: { indexPath in
                if self.searchBar.isFirstResponder {
                    self.view.endEditing(true)
                }
            })
            .addDisposableTo(disposeBag)
        
    }

}
