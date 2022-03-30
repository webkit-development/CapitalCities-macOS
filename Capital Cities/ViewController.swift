//
//  ViewController.swift
//  Capital Cities
//
//  Created by Kevin Stradtman on 3/30/22.
//

import Cocoa
import MapKit

class ViewController: NSViewController, MKMapViewDelegate {

    @IBOutlet var mapView: MKMapView!
    @IBOutlet var scoreLabel: NSTextField!
    @IBOutlet var questionLabel: NSTextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        let recognizer = NSClickGestureRecognizer(target: self, action: #selector(mapClicked))
        mapView.addGestureRecognizer(recognizer)
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    func addPin(at coord: CLLocationCoordinate2D) {
        let guess = Pin(title: "Your guess", coordinate: coord, color: NSColor.red)
        mapView.addAnnotation(guess)
    }
    
    @objc func mapClicked(recognizer: NSClickGestureRecognizer) {
        let location = recognizer.location(in: mapView)
        let coordinates = mapView.convert(location, toCoordinateFrom: mapView)
        addPin(at: coordinates)
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let pin = annotation as? Pin else {return nil}
        let identifier = "Guess"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        } else {
            annotationView!.annotation = annotation
        }
        annotationView?.canShowCallout = true
        annotationView?.pinTintColor = pin.color
        return annotationView
    }
    
}

