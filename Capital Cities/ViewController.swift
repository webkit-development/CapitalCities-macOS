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
    
    var cities = [Pin]()
    var currentCity: Pin?
    
    var score = 0 {
        didSet {
            scoreLabel.stringValue = "Score: \(score)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let recognizer = NSClickGestureRecognizer(target: self, action: #selector(mapClicked))
        mapView.addGestureRecognizer(recognizer)
        startNewGame()
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    func addPin(at coord: CLLocationCoordinate2D) {
        guard let actual = currentCity else {return}
        let guess = Pin(title: "Your guess", coordinate: coord, color: NSColor.red)
        mapView.addAnnotation(guess)
        mapView.addAnnotation(actual)
        let point1 = MKMapPoint(guess.coordinate)
        let point2 = MKMapPoint(actual.coordinate)
        let distance = Int(max(0, 500 - point1.distance(to: point2) / 1000))
        score += distance
        actual.subtitle = "Scored \(distance)"
        mapView.selectAnnotation(actual, animated: true)
    }
    
    @objc func mapClicked(recognizer: NSClickGestureRecognizer) {
        if mapView.annotations.count == 0 {
            addPin(at: mapView.convert(recognizer.location(in: mapView), toCoordinateFrom: mapView))
        } else {
            mapView.removeAnnotations(mapView.annotations)
            nextCity()
        }
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
    
    func startNewGame() {
        score = 0
        cities.append(Pin(title: "London", coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275)))
        cities.append(Pin(title: "Oslo", coordinate: CLLocationCoordinate2D(latitude: 59.95, longitude: 10.75)))
        cities.append(Pin(title: "Paris", coordinate: CLLocationCoordinate2D(latitude: 48.8567, longitude: 2.3508)))
        cities.append(Pin(title: "Rome", coordinate: CLLocationCoordinate2D(latitude: 41.9, longitude: 12.5)))
        cities.append(Pin(title: "Washington DC", coordinate: CLLocationCoordinate2D(latitude: 28.895111, longitude: -77.036667)))
        nextCity()
    }
    
    func nextCity() {
        if let city = cities.popLast() {
            currentCity = city
            questionLabel.stringValue = "Where is \(city.title!)?"
        } else {
            let alert = NSAlert()
            alert.messageText = "Final score \(score)"
            alert.runModal()
            startNewGame()
        }
    }
    
}

