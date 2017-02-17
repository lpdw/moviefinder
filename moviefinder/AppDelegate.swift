//
//  AppDelegate.swift
//  moviefinder
//
//  Created by Paul Vialart on 15/02/2017.
//  Copyright © 2017 Margaux Smits, Paul Vialart. All rights reserved.
//

import UIKit
import CoreData
import CoreLocation
import MapKit
import Alamofire


let centerLat = 20.1512
let centerLon = 2.46545

// Définition d'une notification pour prévenir les views du changement de position de l'user
extension Notification.Name {
    static let userDidChange = Notification.Name("userDidChange")
    static let moviesDidChange = Notification.Name("moviesDidChange")

}


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    let locationManager = CLLocationManager()
    var center = CLLocationCoordinate2D(latitude: centerLat, longitude: centerLon)
    
    //
    var movies: [[String: Any]]? {
        didSet {
            let notification = Notification(name: Notification.Name.moviesDidChange)
            NotificationCenter.default.post(notification)
        }
    }
    
    // définition de la localisation de l'user
    var userLocation: CLLocation? {
        didSet{
            let notification = Notification(name: Notification.Name.userDidChange)
            NotificationCenter.default.post(notification)
            
            // sitôt que la localisation est fixée
            let urlString = "http://data.tmsapi.com/v1.1/movies/showings"
            
            let date = Date()
            let formater = DateFormatter()
            
            formater.dateFormat = "yyyy-MM-dd"
            let convertedDate=formater.string(from: date as Date)
            
            
            
            print(convertedDate)
            
            let key =  "exzx3undakwb7ettub76tf2u" //"exzx3undakwb7ettub76tf2u"
            let parameters: [String: Any] = [
                "accept": "application/json",
                "startDate": convertedDate,
                "lat": userLocation!.coordinate.latitude,
                "lng": userLocation!.coordinate.longitude,
                "radius": 10,
                "api_key": key
            ]
            
            Alamofire
                .request(urlString, parameters: parameters)
                .validate()
                .responseJSON { (response: DataResponse<Any>) in
                    
                    switch response.result {
                        
                    case .success(let json):
                        self.movies = json as? [[String: Any]]
                        print(json)
                    case .failure(let error):
                        print(error)
                    }
            }
            
            
            
        }
        

    }

    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
       
        //GMSPlacesClient.provideAPIKey("AIzaSyAIn-8knnjR8hTjTn7pUbJUDwTo-9A5vrU")
        
        self.startLocate()
        
        return true
    }
    
    
    class func instance() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}


extension AppDelegate: CLLocationManagerDelegate {
    
    func startLocate() {
        self.locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.distanceFilter = 100.0
        self.locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("locations: \(locations)")
        userLocation = locations.last
        // center = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)

    }
    
}



