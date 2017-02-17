//
//  Theater.swift
//  moviefinder
//
//  Created by Margaux Smits on 17/02/2017.
//  Copyright © 2017 Margaux Smits, Paul Vialart. All rights reserved.
//

import Foundation

import UIKit
import MapKit

class Theater: NSObject, MKAnnotation {
    
    var name: String?
    var url: String?
    
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?

    init(coordinate: CLLocationCoordinate2D, name: String?, url: String?) {
        self.coordinate = coordinate
        self.name = name
        self.url = url
        super.init()
    }
}
