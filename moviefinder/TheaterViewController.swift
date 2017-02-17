//
//  TheaterViewController.swift
//  moviefinder
//
//  Created by Margaux Smits on 16/02/2017.
//  Copyright © 2017 Margaux Smits, Paul Vialart. All rights reserved.
//

import UIKit

class TheaterViewController: UIViewController {
    @IBOutlet weak var back: UIButton!
    @IBOutlet weak var details: UITextView!
    var theater : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        details.text = theater.debugDescription
        // Do any additional setup after loading the view.
    }

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
