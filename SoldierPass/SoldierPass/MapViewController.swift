//
//  MapViewController.swift
//  SoldierPass
//
//  Created by 권유정 on 2022/08/13.
//

import UIKit
import CoreLocation

class MapViewController: UIViewController, MTMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet var subView: UIView!
    var mapView: MTMapView?
    
    var locationManager: CLLocationManager!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fun_mapDisplay()
        //fun_mapMyLocation()
        
        
    }
    
    func fun_mapDisplay(){
        //지도 불러오기
        mapView = MTMapView(frame: self.subView.bounds)
        if let mapView = mapView {
            //델리게이트 연결
            mapView.delegate = self
            //지도 타입 설정
            mapView.baseMapType = .standard
            //현재 위치 트래킹
            mapView.currentLocationTrackingMode = .onWithoutHeading
            mapView.showCurrentLocationMarker = true
            
            self.view.addSubview(self.subView)
            subView.addSubview(mapView)
        }
    }
    
    func fun_mapMyLocation(){
        //현재 위치 가져오기
        locationManager = CLLocationManager()
        locationManager.delegate = self
        //위치 업데이트
        locationManager.startUpdatingLocation()
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
}
