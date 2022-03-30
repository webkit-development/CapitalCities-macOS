//
//  ViewController.swift
//  Capital Cities
//
//  Created by Kevin Stradtman on 3/30/22.
//

import Cocoa
import MapKit

class ViewController: NSViewController {

    @IBOutlet var mapView: MKMapView!
    @IBOutlet var scoreLabel: NSTextField!
    @IBOutlet var questionLabel: NSTextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

