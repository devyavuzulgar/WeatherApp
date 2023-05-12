//
//  ViewController.swift
//  WeatherApp
//
//  Created by Yavuz Ulgar on 22.04.2023.
//

import UIKit
import Alamofire
import Kingfisher

class WeatherViewController: UIViewController {

    @IBOutlet weak var currentFeelslike: UILabel!
    @IBOutlet weak var currentWind: UILabel!
    @IBOutlet weak var currentHumidity: UILabel!
    @IBOutlet weak var currentDate: UILabel!
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var currentTemp: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var blueView: UIView!
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    var choosenCity: String?
    var weatherModel: WeatherModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        blueView.layer.cornerRadius = blueView.frame.width / 5
        blueView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        collectionView.layer.cornerRadius = 30
        
        if let city = choosenCity {
            
            guard let urlString = URL(string: "https://api.weatherapi.com/v1/forecast.json?key=13b87f2854b74f7d8c2133324232204&q=\(city)&days=3&aqi=no&alerts=no") else { return }
            
            NetworkManager().downloadData(url: urlString) { weatherModels in
                if let data = weatherModels {
                    self.parse(data: data)
                    
                }
            }
        }
        
    }
    
    private func parse(data: Data) {

        do {
            let weatherModel = try JSONDecoder().decode(WeatherModel.self, from: data)
            self.weatherModel = weatherModel
            
        } catch {
            print(error.localizedDescription)
        }
            
        guard let weatherModel = self.weatherModel else { return }
            
        DispatchQueue.main.async {
            self.cityLabel.text = weatherModel.location.name
            self.currentTemp.text = String(weatherModel.current.tempC)
            self.conditionLabel.text = weatherModel.current.condition.text
                
            self.currentDate.text = weatherModel.location.localtime
            self.currentHumidity.text = "\(weatherModel.current.humidity)% \nHumidity"
            self.currentWind.text = "\(weatherModel.current.windKph) kph \nWind"
            self.currentFeelslike.text = "\(weatherModel.current.feelslikeC)° \nFeels Like"
            self.imageView.kf.setImage(with: URL(string: "https:\(weatherModel.current.condition.icon)"))
                
            self.collectionView.reloadData()
        }
    }
    
}

extension WeatherViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weatherModel?.forecast.forecastday.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "daysCell", for: indexPath) as! DaysCell
        let weather = weatherModel?.forecast.forecastday[indexPath.row]
        cell.dayDateLabel.text = "Day: \(weather?.date ?? "")"
        cell.minDegreeLabel.text = "Min: \(weather?.day.mintempC ?? 0)°"
        cell.maxDegreeLabel.text = "Max: \(weather?.day.maxtempC ?? 0)°"
        if let dayImage = weather?.day.condition.icon {
            cell.dayImageview.kf.setImage(with: URL(string: "https:\(dayImage)"))
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 1.7, height: collectionView.frame.height)
    }
    
    
}

