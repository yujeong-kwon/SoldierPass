//
//  MapViewController.swift
//  SoldierPass
//
//  Created by 권유정 on 2022/08/13.
//

import UIKit

class MapViewController: UIViewController, MTMapViewDelegate {
    
    @IBOutlet var subView: UIView!
    var mapView: MTMapView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
