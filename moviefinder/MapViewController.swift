//
//  MapViewController.swift
//  moviefinder
//
//  Created by Paul Vialart on 15/02/2017.
//  Copyright © 2017 Margaux Smits, Paul Vialart. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
import Alamofire

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Ajout d'un observer pour récupérer les notifications du délégué
        NotificationCenter.default.addObserver(self, selector: #selector(userDidChange), name: Notification.Name.userDidChange, object: nil)
        
        // Ajout des movies sur la carte
        NotificationCenter.default.addObserver(self, selector: #selector(movieDidChange), name: NSNotification.Name.moviesDidChange, object: nil)

        let center = AppDelegate.instance().center
        let camera = MKMapCamera(lookingAtCenter: center, fromEyeCoordinate: center, eyeAltitude: 5000.0)
        self.mapView.setCamera(camera, animated: true)
        
    }
    
    func userDidChange(notification: Notification) {
        if let location = AppDelegate.instance().userLocation {
            self.mapView.setCenter(location.coordinate, animated: true)
        }
    }

    func movieDidChange(notification: Notification) {
        if let movies = AppDelegate.instance().movies {
            setAnnotations(with: movies)
        }
    }
        // Do any additional setup after loading the view.

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
    
    func setAnnotations(with movies: [[String: Any]]) {
        
        let centerLocation = CLLocation(latitude: centerLat, longitude: centerLon)
        
        //        for content in fountains {
        //            if  let loc = content["loc"] as? [String: Any],
        //                let lat = loc["lat"] as? CLLocationDegrees,
        //                let lon = loc["lon"] as? CLLocationDegrees
        //            {
        //                let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        //                let fountain = Fountain(coordinate: coordinate)
        //                self.mapView.addAnnotation(fountain)
        //            }
        //        }
        //
        //
        //        let annotations0 = fountains
        //            .map { (content: [String : Any]) -> MKAnnotation in
        //                if  let loc = content["loc"] as? [String: Any],
        //                    let lat = loc["lat"] as? CLLocationDegrees,
        //                    let lon = loc["lon"] as? CLLocationDegrees
        //                {
        //                    let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        //                    let fountain = Fountain(coordinate: coordinate)
        //                    return fountain
        //                }
        //                let coordinate = CLLocationCoordinate2D()
        //                return Fountain(coordinate: coordinate)
        //            }
        
        let annotations = movies
            .flatMap { (content: [String : Any]) -> MKAnnotation? in
                if  let loc = content["loc"] as? [String: Any],
                    let lat = loc["lat"] as? CLLocationDegrees,
                    let lon = loc["lon"] as? CLLocationDegrees
                {
                    let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
                    let movie = Movie(coordinate: coordinate)
                    return movie
                }
                return nil
            }
            .sorted { /* (f0: MKAnnotation, f1: MKAnnotation) -> Bool in */
                let location0 = CLLocation(latitude: $0.coordinate.latitude,
                                           longitude: $0.coordinate.longitude)
                let location1 = CLLocation(latitude: $1.coordinate.latitude,
                                           longitude: $1.coordinate.longitude)
                let distance0 = centerLocation.distance(from: location0)
                let distance1 = centerLocation.distance(from: location1)
                
                return distance0 < distance1
        }
        
        self.mapView.addAnnotations(annotations)
    }
}
