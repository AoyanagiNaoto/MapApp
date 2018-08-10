//
//  Pin.swift
//  MapApp
//
//  Created by Aoyagi Naoto on 2018/08/10.
//  Copyright © 2018年 vertex. All rights reserved.
//

import UIKit
import MapKit

class Pin: NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D = CLLocationCoordinate2D()
    
    var title: String?
    
    init(geo:CLLocationCoordinate2D, text: String?){
        coordinate = geo
        title = text
    }
}

func toDictionary() -> [String: Any] {
    var dict: [String: Any] = [:]
    
    dict["latitude"] = coordinate.latitude
    dict["longitude"] = coordinate.longitude
    
    if let tit = title {
        dict["title"] = tit
    }
    
    return dict
}
