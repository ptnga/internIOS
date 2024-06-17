//
//  LocationModel.swift
//  firstApp
//
//  Created by Bunn on 10/6/24.
//

import Foundation
import UIKit
import MapKit

public final class LocationModel {
    var title: String?
    var subtitle: String?
    var latitude: Double
    var longitude: Double
    init(title: String, subtitle: String, latitude: Double, longitude: Double) {
        self.title = title
        self.subtitle = subtitle
        self.latitude = latitude
        self.longitude = longitude
    }
    convenience init(json: [String: Any]) {
            let title = json["title"] as? String ?? ""
            let subtitle = json["subtitle"] as? String ?? ""
            let latitude = (json["latitude"] as? Double ?? 0.0)
            let longitude = (json["longitude"] as? Double ?? 0.0)
            self.init(title: title, subtitle: subtitle, latitude: latitude, longitude: longitude)
            }
}
