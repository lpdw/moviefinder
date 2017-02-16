//
//  Movie.swift
//  moviefinder
//
//  Created by Margaux Smits on 16/02/2017.
//  Copyright © 2017 Margaux Smits, Paul Vialart. All rights reserved.
//

import Foundation

import UIKit
import MapKit

class Movie: NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D
    
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
        super.init()
    }
}
