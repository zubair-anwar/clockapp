//
//  CountryViewController.swift
//  ClockClone
//
//  Created by M Zubair on 18/05/2021.
//

import UIKit

class CountryViewController: UIViewController {

    var list = [Country]()
    var searchCountry = [Country]()
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var countryList: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.countryList.separatorStyle = .none
        self.countryList.delegate = self
        self.countryList.dataSource = self
        self.searchBar.delegate = self
        
        // Do any additional setup after loading the view.
        configration()
    }
    func configration() {
        for code in NSLocale.isoCountryCodes {
            let id = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])
            let name = NSLocale(localeIdentifier: "en_US").displayName(forKey: NSLocale.Key.identifier, value: id)
//            let locale = NSLocale.init(localeIdentifier: id)
//            let countryCode = locale.object(forKey: NSLocale.Key.countryCode)
            if name != nil {
                let model = Country()
                model.name = name
                list.append(model)
            }
        }
        self.searchCountry = self.list
        self.countryList.reloadData()
    }

}

extension CountryViewController : UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searchCountry.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = countryList.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = "\(self.searchCountry[indexPath.row].name!)"
        return cell!
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchCountry = searchText.isEmpty ? list : list.filter({ (model) -> Bool in
            return model.name!.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        })
        self.countryList.reloadData()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.endEditing(true)
        self.searchCountry = self.list
    }
}
