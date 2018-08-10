//
//  ViewController.swift
//  MapApp
//
//  Created by Aoyagi Naoto on 2018/08/10.
//  Copyright © 2018年 vertex. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    let userDefName = "pins"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func longTapMapView(_ sender: UILongPressGestureRecognizer) {
        if sender.state != UIGestureRecognizerState.began{
            return
        }
        
        let point = sender.location(in: mapView)
        let geo = mapView.convert(point, toCoordinateFrom: mapView)
        
        let alert = UIAlertController(title: "スポット登録", message: "この場所に残すメッセージを入力してください。", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "キャンセル", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "登録", style: .default, handler: { (action: UIAlertAction) -> Void in
            
                let pin = Pin(geo: geo, text: alert.textFields?.first?.text)
                self.mapView.addAnnotation(pin)
            
        }))
        
        alert.addTextField(configurationHandler: {(textField: UITextField) in
            textField.placeholder = "メッセージ"
        })
        
        present(alert, animated: true, completion: nil)
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

func savePin(_ pin: Pin) {
    let userDefaults = UserDefaults.standard
    
    // 保存するピンをUserDefaults用に変換します。
    let pinInfo = pin.toDictionary()
    
    if var savedPins = userDefaults.object(forKey: userDefName) as? [[String: Any]] {
        // すでにピン保存データがある場合、それに追加する形で保存します。
        savedPins.append(pinInfo)
        userDefaults.set(savedPins, forKey: userDefName)
        
    } else {
        // まだピン保存データがない場合、新しい配列として保存します。
        let newSavedPins: [[String: Any]] = [pinInfo]
        userDefaults.set(newSavedPins, forKey: userDefName)
    }
}

