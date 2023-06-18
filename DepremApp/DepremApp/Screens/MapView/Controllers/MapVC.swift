//
//  ViewController.swift
//  Deprem
//
//  Created by Onur Duyar on 14.04.2023.
//

import UIKit
import MapKit
import CoreLocation

final class MapVC: UIViewController {
    
    let baseViewModel = HomeViewModel.shared
    var lastEarthQuakes: [EarthQuake]?
    let mapView = MKMapView(frame: UIScreen.main.bounds)
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        baseViewModel.fetchData { result in
            switch result {
            case .success(let response):
                self.lastEarthQuakes = response
                self.annotateAllEarthQuakes()
            case .failure(let error):
                fatalError(error.localizedDescription)
            }
        }
        view.addSubview(mapView)
        mapView.delegate = self
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func annotateAllEarthQuakes() {
        guard let closestQuake: EarthQuake = self.findClosestQuake() ,let maxQuake: EarthQuake = self.findMaxMagnitude() else {return}
        // ALL OF THEM
        for earthQuake in self.lastEarthQuakes! {
            if earthQuake == closestQuake || earthQuake == maxQuake{
                continue
            }
            let latitude = earthQuake.geojson?.coordinates?.last
            let longitude = earthQuake.geojson?.coordinates?.first
            let magnitude = earthQuake.mag
            createAnnotation(latitude: latitude, longitude: longitude, title: nil, subtitle: "Deprem Bölgesi")
            createCircle(latitude: latitude, longitude: longitude, magnitude: magnitude,title: nil,subtitle: "Büyüklük: \(magnitude ?? 0.0)")
            
        }
        
        // CLOSEST
        
        let magnitude = closestQuake.mag ?? 0.0
        let latitude = closestQuake.geojson?.coordinates?.last
        let longitude = closestQuake.geojson?.coordinates?.first
        createAnnotation(latitude: latitude, longitude: longitude, title: "En yakın deprem bölgesi", subtitle: "En yakın deprem bölgesi")
        createCircle(latitude: latitude, longitude: longitude, magnitude: magnitude,title: nil,subtitle: "En yakın deprem bölgesi")
        
        
        
        let maxMagnitude = maxQuake.mag ?? 0.0
        let maxLatitude = maxQuake.geojson?.coordinates?.last
        let maxLongitude = maxQuake.geojson?.coordinates?.first
        createAnnotation(latitude: maxLatitude, longitude: maxLongitude, title: "En Büyük Deprem", subtitle: "En Büyük Deprem")
        createCircle(latitude: maxLatitude, longitude: maxLongitude, magnitude: maxMagnitude,title: nil,subtitle: "En Büyük Deprem")
        
    }
    func createAnnotation(latitude: Double?, longitude: Double?, title: String?, subtitle: String?) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: (latitude)! as Double, longitude: (longitude)! as Double)
        annotation.title = title
        annotation.subtitle = subtitle
        self.mapView.addAnnotation(annotation)
    }
    func createCircle(latitude: Double?, longitude: Double?, magnitude: Double?,title: String?, subtitle: String?) {
        let circle = MKCircle(center: CLLocationCoordinate2D(latitude: latitude!, longitude: longitude!), radius: magnitude! * 10000)
        circle.subtitle = subtitle
        self.mapView.addOverlay(circle)
    }
}
// MARK: - MKMapViewDelegate --> MAP
extension MapVC: MKMapViewDelegate {
    // didSelect
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let annotation = view.annotation as? MKPointAnnotation,
              let subtitle = annotation.subtitle, (subtitle == "Deprem Bölgesi" || subtitle == "En yakın deprem bölgesi"),
              let latitude = annotation.coordinate.latitude as Double?,
              let longitude = annotation.coordinate.longitude as Double?,
              let selectedQuake = lastEarthQuakes?.first(where: { $0.geojson?.coordinates?.first == longitude && $0.geojson?.coordinates?.last == latitude })
        else {
            return
        }
        
        let alert = UIAlertController(title: selectedQuake.title, message: "Deprem Büyüklüğü: \(selectedQuake.mag ?? 0.0) Depremin Derinliği: \(selectedQuake.depth ?? 0.0)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    // render circle
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKCircle {
            let renderer = MKCircleRenderer(overlay: overlay)
            if renderer.circle.subtitle == "En yakın deprem bölgesi" {
                renderer.fillColor = UIColor.brown.withAlphaComponent(0.84)
            }else if renderer.circle.subtitle == "En Büyük Deprem" {
                renderer.fillColor = UIColor.darkGray.withAlphaComponent(0.84)
            }else{
                if let circle = overlay as? MKCircle {
                    let magnitude = Double(circle.radius) / 10000.0
                    let alpha = (magnitude - 0.2) / (9.9 - 0.2)
                    renderer.fillColor = UIColor.red.withAlphaComponent(alpha)
                }
            }
            return renderer
        }
        return MKOverlayRenderer(overlay: overlay)
    }
    // annotation view
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? MKPointAnnotation else {
            return nil
        }
        let identifier = "customAnnotationView"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? CustomAnnotationView
        
        if annotationView == nil {
            annotationView = CustomAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
        } else {
            annotationView?.annotation = annotation
        }
        
        return annotationView
    }
    
}
// MARK: - CLLocationManagerDelegate --> User Location
extension MapVC: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        createAnnotation(latitude: latitude, longitude: longitude, title: "Bulunduğunuz Konum", subtitle: "Bulunduğunuz Konum")
        print(location)
        locationManager.stopUpdatingLocation()
    }
}
// MARK: - The Closest EarthQuake
extension MapVC {
    // distance
    func calculateDistance(from userLocation: CLLocation, to quakeLocation: CLLocationCoordinate2D) -> CLLocationDistance {
        let quakeCLLocation = CLLocation(latitude: quakeLocation.latitude, longitude: quakeLocation.longitude)
        return userLocation.distance(from: quakeCLLocation)
    }
    func findMaxMagnitude() -> EarthQuake? {
        var maxEarthQuake: EarthQuake?
        var maxMagnitude: Double? = Double.zero
        for quake in lastEarthQuakes ?? [] {
            guard let magnitude = quake.mag else { continue }
            if magnitude > maxMagnitude ?? 0.0 {
                maxMagnitude = quake.mag
                maxEarthQuake = quake
            }
            
        }
        return maxEarthQuake
    }
    func findClosestQuake() -> EarthQuake? {
        guard let userLocation = locationManager.location else { return nil }
        
        var closestQuake: EarthQuake?
        var closestDistance: CLLocationDistance = Double.infinity
        
        for quake in lastEarthQuakes ?? [] {
            guard let latitude = quake.geojson?.coordinates?.last,
                  let longitude = quake.geojson?.coordinates?.first else { continue }
            
            let quakeLocation = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            let distance = calculateDistance(from: userLocation, to: quakeLocation)
            
            if distance < closestDistance {
                closestDistance = distance
                closestQuake = quake
            }
            
            if distance < closestDistance && distance < 300000 {
                closestDistance = distance
                closestQuake = quake
            }
        }
        if let closestQuake {
            locationManager.stopUpdatingLocation()
            return closestQuake
        } else {
            return nil
        } // there is no closest earthQuake
    }
}

class CustomAnnotationView: MKPinAnnotationView {
    override var annotation: MKAnnotation? {
        didSet {
            guard let subtitle = annotation?.subtitle else { return }
            
            switch subtitle {
            case "En Büyük Deprem":
                pinTintColor = .systemGreen
            case "Bulunduğunuz Konum":
                pinTintColor = .systemBlue
            case "En yakın deprem bölgesi":
                pinTintColor = .black
            default:
                pinTintColor = .systemOrange
            }
        }
    }
}
