//
//  RangeBeacon.swift
//  test
//
//  Created by 林京緯 on 2024/4/14.
//

import SwiftUI
import CoreLocation

struct RangeBeaconView: View {
    @EnvironmentObject var data : data_link
    @StateObject private var beacons = BeaconDetector()
    @State private var enteredUUIDs: [UUID] = []
    @State private var EnterUUID = ""

    var body: some View {
        VStack{
            
            Text("ADD BEACON")
                .font(.title)
            List{
                ForEach(Array(beacons.beaconData.keys), id: \.self) { key in
                    let value = beacons.beaconData[key, default: []]
                    ForEach(value.indices, id: \.self) { index in
                        let (uuid, major, minor, distance) = value[index]
                        Text("\(uuid)").fixedSize()
                        Text("Major: \(major), Minor: \(minor), 距離: \(distance)")
                    }
                }
            }
            /*TextField("    xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx", text: $EnterUUID)
                .frame(width: 370)
                .textFieldStyle(.roundedBorder)*/
            Button("Check"){
                data.loadData_Beacon{ beacon_uuid in
                    for uuid in beacon_uuid{
                        if let uuids = UUID(uuidString : uuid){
                            enteredUUIDs.append(uuids)
                        }
                    }
                    beacons.StartMonitor(for: enteredUUIDs)
                    
                }
            }
        }
    }
}

class BeaconDetector: NSObject, ObservableObject{
    @Published var beaconData: [UUID: [(UUID, NSNumber, NSNumber, String)]] = [:]
    var locationManager = CLLocationManager()
    var EnterUUID = UUID()
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
    
    func StartMonitor(for uuids: [UUID]){
        
        locationManager.requestWhenInUseAuthorization()
        for uuid_1 in uuids{
            print(uuid_1)
            let region = CLBeaconRegion(uuid: uuid_1, identifier: "")
            EnterUUID = uuid_1
            locationManager.startMonitoring(for: region)
        }
    }
}

extension BeaconDetector: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print("Location manager did fail: \(error.localizedDescription)")
    }
    func locationManager(_ manager: CLLocationManager, monitoringDidFailFor region: CLRegion?, withError error: Error) {
        print("\(EnterUUID) monitoring did fail: \(error.localizedDescription)")
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        guard region is CLBeaconRegion else { return }
        // 在這裡做一些進入 region 的處理，例如提供一些提示
        guard CLLocationManager.isRangingAvailable() else { return }
        manager.startRangingBeacons(satisfying: CLBeaconIdentityConstraint(uuid: EnterUUID))//偵測跟裝置的距離
    }

    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        guard region is CLBeaconRegion else { return }
        // 在這裡做一些離開 region 的處理，例如提供一些提示
        guard CLLocationManager.isRangingAvailable() else { return }
        manager.stopRangingBeacons(satisfying: CLBeaconIdentityConstraint(uuid: EnterUUID))//停止偵測跟裝置的距離
    }
    
    func locationManager(_ manager: CLLocationManager, didStartMonitoringFor region: CLRegion) {
        // 開始偵測範圍之後，就先檢查目前的 state 是否在範圍內
        manager.requestState(for: region)
    }
    
    func locationManager(_ manager: CLLocationManager, didDetermineState state: CLRegionState, for region: CLRegion) {
        guard region is CLBeaconRegion else { return }

        if state == .inside { // 在範圍內
            if CLLocationManager.isRangingAvailable() {
                manager.startRangingBeacons(satisfying: CLBeaconIdentityConstraint(uuid: EnterUUID))
            }
        } else if state == .outside { // 在範圍外
            if CLLocationManager.isRangingAvailable() {
                manager.stopRangingBeacons(satisfying: CLBeaconIdentityConstraint(uuid: EnterUUID))
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, rangingBeaconsDidFailFor region: CLBeaconRegion, withError error: Error) {
        print("Location manager ranging beacons did fail: \(error.localizedDescription)")
    }

    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        var beaconArray: [(UUID, NSNumber, NSNumber, String)] = []
        for beacon in beacons {
            var distance = "Unknown"
            switch beacon.proximity {
            case .immediate:
                distance = "Immediately"
            case .near:
                distance = "Near"
            case .far:
                distance = "Far"
            default:
                distance = "Unknown"
            }
            beaconArray.append((beacon.uuid, beacon.major, beacon.minor, distance))
        }
        beaconData[region.uuid] = beaconArray
        print(beaconData)
    }
}

struct RangeBeaconView_Previews: PreviewProvider {
    static var previews: some View {
        RangeBeaconView()
    }
}
