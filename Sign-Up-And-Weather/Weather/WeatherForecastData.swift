//  Created by Mohit Andhare on 2023-09-23.
//

import Foundation

struct WeatherForecastData: Codable {
    let list: [List]
    let city: City
}

struct City: Codable {
    let name: String
}

struct List: Codable {
    let dt: Int
    let main: Main
    let weather: [Weather]
}
