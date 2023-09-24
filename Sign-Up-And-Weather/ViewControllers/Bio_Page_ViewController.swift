//
//  Bio_Page_ViewController.swift
//  Sign-Up-And-Weather
//
//  Created by Mohit Andhare on 2023-09-23.
//

import UIKit
import CoreLocation

class Bio_Page_ViewController: UIViewController {
   
    
   
    
    
    @IBOutlet weak var profile_image: UIImageView!
    
    @IBOutlet weak var user_name: UILabel!
    
    @IBOutlet weak var bio: UILabel!
    
    @IBOutlet weak var city_label: UILabel!
    
    
    
    @IBOutlet weak var humidityLabel: UILabel!
    
    @IBOutlet weak var temperatureLabel: UILabel!
    
    @IBOutlet weak var searchTextField: UITextField!
    
    @IBOutlet weak var wind_speed: UILabel!
    
    
    
    
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    var forecastManager = ForecastManager()
    
    
    var userDefault = UserDefaults()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        weatherManager.delegate = self
        searchTextField.delegate = self
        forecastManager.delegate = self
        
        
        profile_image.layer.cornerRadius = profile_image.frame.size.width / 2
        profile_image.layer.masksToBounds = true
        profile_image.layer.borderWidth = 2
        profile_image.layer.borderColor = UIColor.clear.cgColor
        
        profile_image.image = getSavedImageFromUserDefaults()
        user_name.text = userDefault.string(forKey: "User_Name")
        bio.text = userDefault.string(forKey: "Bio")
        
        weatherManager.fetchWeather(cityName: "Kolkata")
        forecastManager.fetchWeather(cityName: "Kolkata")
        city_label.text = "Kolkata"
        
    }
    
    
    
    
    func getSavedImageFromUserDefaults() -> UIImage? {
        if let imageData = UserDefaults.standard.data(forKey: "selectedImage") {
            return UIImage(data: imageData)
        }
        return nil
    }
    
    
    //MARK: WEATHER FUNC
    
}

extension Bio_Page_ViewController: UITextFieldDelegate {
    
    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Type something"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let city = searchTextField.text {
            weatherManager.fetchWeather(cityName: city)
            forecastManager.fetchWeather(cityName: city)
        }
        
        city_label.text = searchTextField.text
        
        searchTextField.text = ""
        
        
    }
}
extension Bio_Page_ViewController: WeatherManagerDelegate {
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        DispatchQueue.main.async {
            
            self.temperatureLabel.text = weather.temperatureString
            self.humidityLabel.text = "\(String(weather.humdidity))%"

            
            
            }
        
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}


extension Bio_Page_ViewController: CLLocationManagerDelegate {
    
    @IBAction func locationPressed(_ sender: UIButton) {
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.fetchWeather(latitude: lat, longitude: lon)
            forecastManager.fetchWeather(latitude: lat, longitude: lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
}

extension Bio_Page_ViewController: ForecastManagerDelegate {
    
    func didUpdateWeather(_ weatherManager: ForecastManager, weather: [WeatherModel]) {
       
    }
    
}
