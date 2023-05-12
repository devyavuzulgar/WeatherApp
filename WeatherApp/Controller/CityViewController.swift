//
//  CityViewController.swift
//  WeatherApp
//
//  Created by Yavuz Ulgar on 11.05.2023.
//

import UIKit

class CityViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var cities = [City]()
    var selectedCity: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        let paris = City(cityName: "Paris")
        let helsinki = City(cityName: "Helsinki")
        let dublin = City(cityName: "Dublin")
        let rome = City(cityName: "Rome")
        let amsterdam = City(cityName: "Amsterdam")
        let moscow = City(cityName: "Moscow")
        let bern = City(cityName: "Bern")
        let london = City(cityName: "London")
        let prague = City(cityName: "Prague")
        let berlin = City(cityName: "Berlin")
        let athens = City(cityName: "Athens")
        let budapest = City(cityName: "Budapest")
        let jakarta = City(cityName: "Jakarta")
        let stockholm = City(cityName: "Stockholm")
        let ankara = City(cityName: "Ankara")
        let bangkok = City(cityName: "Bangkok")
        
        cities += [paris, helsinki, dublin, rome, amsterdam, moscow, bern, london, prague, berlin, athens, budapest, jakarta, stockholm, ankara, bangkok]
        
        
    }

}

extension CityViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell", for: indexPath)
        let city = cities[indexPath.row]
        cell.textLabel?.text = city.cityName
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCity = cities[indexPath.row].cityName
        performSegue(withIdentifier: "goDetail", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goDetail" {
            let vc = segue.destination as! WeatherViewController
            vc.choosenCity = selectedCity
        }
    }
    
    
}
