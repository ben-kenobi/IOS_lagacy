//
//  ViewController.swift
//  mapboxtest
//
//  Created by apple on 16/4/6.
//  Copyright © 2016年 apple. All rights reserved.
//

import Mapbox

class ViewController: UIViewController,MGLMapViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mapView = MGLMapView(frame: view.bounds)
        mapView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        
        // set the map's center coordinate
        mapView.setCenterCoordinate(CLLocationCoordinate2D(latitude: 40.7326808,
            longitude: -73.9843407),
                                    zoomLevel: 12, animated: false)
        view.addSubview(mapView)
        mapView.showsUserLocation=true
        mapView.styleURL=MGLStyle.streetsStyleURL()
        
    }


}

