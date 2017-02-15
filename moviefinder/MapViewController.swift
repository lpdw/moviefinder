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
        
        let center = AppDelegate.instance().center
        let camera = MKMapCamera(lookingAtCenter: center, fromEyeCoordinate: center, eyeAltitude: 5000.0)
        self.mapView.setCamera(camera, animated: true)
        
    }
    
    func userDidChange(notification: Notification) {
        if let location = AppDelegate.instance().userLocation {
            self.mapView.setCenter(location.coordinate, animated: true)
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

}
