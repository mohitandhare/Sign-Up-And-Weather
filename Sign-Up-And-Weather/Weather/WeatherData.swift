
//  Created by Mohit Andhare on 2023-09-23.
//

import Foundation

struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]


}

struct Main: Codable {
    let temp: Double
    let feels_like: Double
    let humidity: Int
}

struct Weather: Codable {
    let description: String
    let id: Int
}



