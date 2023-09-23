//  Created by Mohit Andhare on 2023-09-23.
//

import Foundation

struct WeatherModel {
    let conditionId: Int
    let cityName: String
    let temperature: Double
    let time: Int
    var humdidity: Int = 0

    

    
    
    var temperatureString: String {
        return String(format: "%.0f", temperature)
    }
    
    var timeString: String {
        return getTimeString(time: time)
    }
    
    
    func getTimeString(time: Int) -> String {
        let date = Date(timeIntervalSince1970: Double(time))
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(identifier: "IST")!
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        let result = ("\(hour):\(minutes)")
        return result
    }
    
    var conditionName: String {
        switch conditionId {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
}
    

