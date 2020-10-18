

import UIKit
import GoogleMaps
import PopupDialog

class ViewController: UIViewController {

    @IBOutlet weak var mapView: GMSMapView!
    private var zoom: Float = 15.0
    
    var userLocation = CLLocation()
    
    
    let names = ["monster1", "monster2", "monster3", "monster4", "monster5"]
    var places: [CLLocationCoordinate2D] = []
 
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let timer = Timer(timeInterval: 120, repeats: true) { _ in print("Done!")
            self.locationManager.startUpdatingLocation()
        }
        //user location stuff
        locationManager.delegate = self
        mapView.delegate = self
           locationManager.requestWhenInUseAuthorization()
           locationManager.desiredAccuracy = kCLLocationAccuracyBest
           locationManager.startUpdatingLocation()
        
       
        

    }
    
    @IBAction func plusAclion(_ sender: Any) {
        zoom = 1.15*zoom

        locationManager.startUpdatingLocation()
    }
    

    @IBAction func minusAction(_ sender: Any) {
        zoom = 0.85*zoom
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    }
    
    @IBAction func returnLocationAction(_ sender: Any) {
        locationManager.startUpdatingLocation()
    }
    
    

    
    func distanceInMeters(marker: GMSMarker) -> CLLocationDistance {
    let markerLocation = CLLocation(latitude: marker.position.latitude , longitude: marker.position.longitude)
    let metres = locationManager.location?.distance(from: markerLocation)
    return Double(metres ?? -1)
    }
}

extension ViewController: CLLocationManagerDelegate, GMSMapViewDelegate{
    private func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Error" + error.description)
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        userLocation = locations.last!
        let center = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)

        let camera = GMSCameraPosition.camera(withLatitude: userLocation.coordinate.latitude,
                                              longitude: userLocation.coordinate.longitude, zoom: zoom)

        mapView.camera = camera
        mapView.isMyLocationEnabled = true
//        self.view = mapView

        let marker = GMSMarker()
        marker.position = center
        marker.title = "Current Location"
        marker.snippet = "Here"
        marker.map = mapView
        
        addMarkers()
        
        locationManager.stopUpdatingLocation()
    }
    
    func addMarkers() {
        
        for _ in 0..<30{
            let randomLat = Double.random(in: userLocation.coordinate.latitude-0.03...userLocation.coordinate.latitude+0.03)
            let randomLong = Double.random(in: userLocation.coordinate.longitude-0.03...userLocation.coordinate.longitude+0.03)
            places.append(CLLocationCoordinate2D(latitude: randomLat, longitude: randomLong))
        }
        
        for i in 0..<30{
            let marker = GMSMarker()
            marker.position = places[i]
            marker.title = names.randomElement()!
            print(marker.title!)
            marker.snippet = "Monster"
            marker.icon = UIImage(named: marker.title!)
            marker.map = mapView
            
        }
        
        locationManager.stopUpdatingLocation()
    }

    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
    let distanceinMiles = round(100*distanceInMeters(marker: marker)*0.00062137)/100
    print(distanceinMiles)
        
    if distanceinMiles < 1 {
        let title = "Найден монстр"
        let message = "Нажмите Поймать монстра"
    let popup = PopupDialog(title: title, message: message)
        let okButton = DefaultButton(title: "Поймать!") {
            let newView: CatchViewController = self.storyboard?.instantiateViewController(withIdentifier: "CatchViewController") as! CatchViewController
            newView.name = marker.title!
            newView.level = Int.random(in: 0...20)
            newView.image = marker.title!
            self.present(newView, animated: true, completion: nil)
    //destory that marker
            marker.map = mapView
            marker.map = nil
            
    }
    popup.addButton(okButton)
    self.present(popup, animated: true, completion: nil)
    } else {
    let title = "Слишком далеко"
    let message = "Необходимо подойти ближе к монстру"
    let popup = PopupDialog(title: title, message: message)
    let okButton = DefaultButton(title: "Ok") {
    }
    popup.addButton(okButton)
    self.present(popup, animated: true, completion: nil)
    }
    return true
    }
    
    func catchView(didTapMarker marker: GMSMarker) {
        
   }

}


