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
    
    var dataController:BenefitsDataController = BenefitsDataController()
    var data:[[String]]=[]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fun_mapDisplay()
        //fun_mapMyLocation()
        data = dataList
        for item in data{
            fun_adressToPoint(address: item[10], name: item[2])
        }
        
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
    
    func fun_adressToPoint(address: String, name: String){
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address){ [self](placemark, error)in
            guard error == nil else {return print(error!.localizedDescription)}//에러코드가 없으면 아래코드 실행
            guard let location = placemark?.first?.location else {
                return print("데이터가 없습니다")
            }
            self.fun_createPin(itemName: name, getla: location.coordinate.latitude, getlo: location.coordinate.longitude, markerType: .redPin)
        }
    }
    
    func fun_createPin(itemName:String, getla: Double, getlo: Double, markerType:MTMapPOIItemMarkerType){
        let poiItem = MTMapPOIItem()
        poiItem.itemName = "\(itemName)"
        poiItem.mapPoint = MTMapPoint(geoCoord: MTMapPointGeo(latitude: getla, longitude: getlo))
        poiItem.markerType = markerType
        
        mapView?.addPOIItems([poiItem])
       
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        //mapView의 모든 poiItem 제거
        for item in mapView!.poiItems{
            mapView!.remove(item as! MTMapPOIItem)
        }
    }
    
    func mapView(_ mapView: MTMapView!, touchedCalloutBalloonOf poiItem: MTMapPOIItem!) {
        //itemNAME으로 데이터에서 조회
        //-> 조회하고 팝업창 상세페이지
    }

    /*
    func fun_mapMyLocation(){
        //현재 위치 가져오기
        locationManager = CLLocationManager()
        locationManager.delegate = self
        //위치 업데이트
        locationManager.startUpdatingLocation()
        
    }
*/
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
}
