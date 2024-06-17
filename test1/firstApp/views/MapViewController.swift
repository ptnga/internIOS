import UIKit
import MapKit

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var btTarget: UIButton!
    @IBOutlet weak var btTraffic: UIButton!
    @IBOutlet weak var btSelectedMap: UIButton!
    @IBOutlet weak var btRoute: UIButton!
    @IBOutlet weak var btTodayTask: UIButton!
    @IBOutlet weak var viewNavigationBar: UIView!
    
    let colorLocation = UIColor(rgb: 0x4965FF, alpha: 1.0)
    let colorLcUser = UIColor(rgb: 0xFFD001, alpha: 1.0)
    let colorView = UIColor(rgb: 0x303034, alpha: 1.0)
    let colorLine = UIColor(rgb: 0xFFD001, alpha: 1.0)
    
    let manager = CLLocationManager()
    var locations: [LocationModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewNavigationBar.backgroundColor = colorView
        addBottomBorderToButton()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.delegate = self
        switch manager.authorizationStatus {
        case .notDetermined: manager.requestWhenInUseAuthorization()
        case .restricted, .denied: break
        case .authorizedWhenInUse, .authorizedAlways: manager.startUpdatingLocation()
        @unknown default: break
        }
        mapView.register(MKAnnotationView.self, forAnnotationViewWithReuseIdentifier: "custom")
        mapView.delegate = self
        readJSONFile()
        if locations.count > 1 {
            for index in 0..<locations.count {
                if(index == locations.count-1) {
                    
                    pinLocation(location: locations.last!, location2: locations.last!)
                } else {
                    pinLocation(location: locations[index], location2: locations[index + 1])
                }
            }
        }

        setupNavigationBar()
        customButtonMap()
        
    }
    func center(location: CLLocation) {
        mapView.setCenter(location.coordinate, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            manager.stopUpdatingLocation()
            
            render(location)
        }
        
    }
    
    func render(_ location: CLLocation) {
        let coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        mapView.setRegion(region, animated: true)
        
    }
    func readJSONFile() {
        if let jsonObject = ReadFileJson().readJsonFile(named: "locations", ofType: "json") {
            locations.removeAll()
            if let jsonData = jsonObject["data"] as? [[String: Any]] {
                locations.removeAll()
                for json in jsonData {
                    let locationModel = LocationModel(json: json)
                    locations.append(locationModel)
                }
            }
        }
    }
    func pinLocation(location: LocationModel, location2: LocationModel) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
        annotation.title = location.title
        annotation.subtitle = location.subtitle
        mapView.addAnnotation(annotation)
        
        let annotation2 = MKPointAnnotation()
        annotation2.coordinate = CLLocationCoordinate2D(latitude: location2.latitude, longitude: location2.longitude)
        let polyline = ColoredPolyline(coordinates: [annotation.coordinate, annotation2.coordinate], count: 2)
        if(location.title == "My Location" && location2.title == "Trà Sữa TocoToCo Nguyễn Văn Cừ") {
            polyline.color = colorLine
        } else {
            polyline.color = .blue
        }
        mapView.addOverlay(polyline)
        
    }
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "custom")
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "custom")
            
        } else {
            annotationView?.annotation = annotation
            annotationView?.canShowCallout = true
        }
        
        if let title = annotation.title {
            switch title {
            case "My Location":
                let resizeImg = resizeImage(
                    image: UIImage(named: "locationUser")!,
                    targetSize: CGSize(width: 48, height: 35)
                )
                annotationView?.image = resizeImg
            case "Trà Sữa TocoToCo Nguyễn Văn Cừ":
                customPin(
                    nameImg: "locationYellw",
                    textImg: "1",
                    colorBorderPin: colorLine,
                    annotationView: annotationView,
                    sizeImg: CGSize(width: 40, height: 45.49)
                )
            case "Bánh cuốn nóng Phương Lan":
                customPin(
                    nameImg: "location",
                    textImg: "2",
                    colorBorderPin: .blue,
                    annotationView: annotationView,
                    sizeImg: CGSize(width: 40, height: 45.49)
                )
            case "Cửa Hàng Viettel 84 Ngọc Lâm":
                customPin(
                    nameImg: "location",
                    textImg: "3",
                    colorBorderPin: .blue,
                    annotationView: annotationView,
                    sizeImg: CGSize(width: 40, height: 45.49)
                )
            case "Mô Hình Việt":
                customPin(
                    nameImg: "location",
                    textImg: "4",
                    colorBorderPin: .blue,
                    annotationView: annotationView,
                    sizeImg: CGSize(width: 40, height: 45.49)
                )
            case "Nhà Nghỉ Phương Huyền":
                customPin(
                    nameImg: "location",
                    textImg: "5",
                    colorBorderPin: .blue,
                    annotationView: annotationView,
                    sizeImg: CGSize(width: 40, height: 45.49)
                )
            default:
                break
            }
        }
                return annotationView
    }
    func customPin(
        nameImg: String,
        textImg: String,
        colorBorderPin: UIColor,
        annotationView: MKAnnotationView?,
        sizeImg: CGSize) {
        let resizeImg = resizeImage(
            image: UIImage(named: nameImg)!,
            targetSize: sizeImg
        )
        let imageWithText = addTextToImage(image: resizeImg, text: textImg)
        annotationView?.image = imageWithText
        annotationView?.centerOffset = CGPoint(x: 0, y: -resizeImg.size.height / 2)
        let circularLabel = createCircularLabel(color: colorBorderPin)
        annotationView?.addSubview(circularLabel)
        circularLabel.center = CGPoint(x: (annotationView?.frame.size.width ?? 0) / 2, y: (annotationView?.frame.size.height ?? 0))
    }
    func createCircularLabel(color: UIColor) -> UILabel {
        let labelSize: CGFloat = 10
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: labelSize, height: labelSize))
        label.backgroundColor = .white
        label.layer.cornerRadius = labelSize / 2
        label.layer.masksToBounds = true
        label.layer.borderColor = color.cgColor
        label.layer.borderWidth = 3
        return label
    }
    func addTextToImage(image: UIImage, text: String) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(image.size, false, 0.0)
        image.draw(in: CGRect(origin: CGPoint.zero, size: image.size))
        let textFont = UIFont.boldSystemFont(ofSize: 18)
        let textColor = UIColor.white
        let textStyle = NSMutableParagraphStyle()
        textStyle.alignment = .center
        
        let textAttributes: [NSAttributedString.Key: Any] = [
            .font: textFont,
            .foregroundColor: textColor,
            .paragraphStyle: textStyle
        ]

        let textSize = text.size(withAttributes: textAttributes)
        
        let textRect = CGRect(
            x: 14.3,
            y: 9,
            width: textSize.width,
            height: textSize.height
        )
        
        text.draw(in: textRect, withAttributes: textAttributes)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage ?? image
    }

    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: targetSize)
        let newImage = renderer.image { _ in
            image.draw(in: CGRect(origin: .zero, size: targetSize))
        }
        return newImage
    }
    func setupNavigationBar() {
        CustomNavigationBar.setupNavigationBar(
            navigationItem: self.navigationItem,
            navigationController: self.navigationController,
            barTintColor: .black,
            leftButtonImageName: "menuIcon",
            rightButtonImageName: "mapViewIcon",
            leftFrameBT: CGRect(x: 0, y: 0, width: 36, height: 36),
            rightFrameBT: CGRect(x: 0, y: 0, width: 36, height: 36)
        )

    }
    func addBottomBorderToButton() {
        let bottomBorder = CALayer()
        let borderWidth: CGFloat = 4.0
        bottomBorder.borderColor = UIColor.white.cgColor
        bottomBorder.frame = CGRect(x: 0, y: btTodayTask.frame.size.height - borderWidth, width: btTodayTask.frame.size.width, height: borderWidth)
        bottomBorder.borderWidth = borderWidth
        
        btTodayTask.layer.addSublayer(bottomBorder)
        btTodayTask.layer.masksToBounds = true
    }
    func customButtonMap() {
        btRoute.layer.cornerRadius = btRoute.frame.size.width / 2
        btRoute.clipsToBounds = true
        
        btTarget.layer.cornerRadius = btTarget.frame.size.width / 2
        btTarget.clipsToBounds = true
        
        btTraffic.layer.cornerRadius = btTraffic.frame.size.width / 2
        btTraffic.clipsToBounds = true
        
        btSelectedMap.layer.cornerRadius = btSelectedMap.frame.size.width / 2
        btSelectedMap.clipsToBounds = true
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let coloredPolyline = overlay as? ColoredPolyline {
            
            let polylineRenderer = MKPolylineRenderer(polyline: coloredPolyline)
            
            polylineRenderer.strokeColor = coloredPolyline.color
            polylineRenderer.lineWidth = 4.0
            return polylineRenderer
            
        }
        return MKOverlayRenderer(overlay: overlay)
      }

}
