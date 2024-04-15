//
//  RangeBeacon.swift
//  test
//
//  Created by 林京緯 on 2024/4/14.
//

import SwiftUI
import CoreLocation

struct RangeBeaconView: View {
    @State private var defaultUUID = "E2C56DB5-DFFB-48D2-B060-D0F5A71096E0"
    @ObservedObject private var locationManager = LocationManager()
    @State private var beacons = [CLProximity: [CLBeacon]]()
    @State private var isAddingBeacon = false
    @State private var enteredUUID = ""
    @State private var beaconsArray: [(proximity: CLProximity, beacons: [CLBeacon])] = []
    
    var body: some View {
            VStack {
                Button("Add Beacon", action: {
                    isAddingBeacon = true
                })
                .padding()
                .sheet(isPresented: $isAddingBeacon) {
                    AddBeaconView(defaultUUID: $defaultUUID, locationManager: locationManager)
                }
                
                List {
                    ForEach(beaconsArray, id: \.proximity) { beaconData in
                        Section(header: Text(proximityDescription(beaconData.proximity))) {
                            ForEach(beaconData.beacons, id: \.self) { beacon in
                                VStack(alignment: .leading) {
                                    Text("UUID: \(beacon.uuid.uuidString)")
                                    Text("Major: \(beacon.major) Minor: \(beacon.minor)")
                                }
                            }
                        }
                    }
                }
            }
            .onReceive(locationManager.$beacons) { rangedBeacons in
                updateBeacons(beacons: rangedBeacons)
        }
    }
    
    private func updateBeacons(beacons: [CLBeacon]) {
        let updatedBeaconsArray = calculateBeaconsArray(beacons: beacons)
        beaconsArray = updatedBeaconsArray
    }
    
    private func calculateBeaconsArray(beacons: [CLBeacon]) -> [(CLProximity, [CLBeacon])] {
        var updatedBeaconsArray = [(CLProximity, [CLBeacon])]()
        
        for beacon in beacons {
            let proximity = beacon.proximity
            if let index = updatedBeaconsArray.firstIndex(where: { $0.0 == proximity }) {
                updatedBeaconsArray[index].1.append(beacon)
            } else {
                updatedBeaconsArray.append((proximity, [beacon]))
            }
        }
        
        return updatedBeaconsArray
    }
    
    private func proximityDescription(_ proximity: CLProximity) -> String {
        switch proximity {
        case .unknown:
            return "Unknown"
        case .immediate:
            return "Immediate"
        case .near:
            return "Near"
        case .far:
            return "Far"
        @unknown default:
            return "Unknown"
        }
    }
}

struct AddBeaconView: View {
    @Binding var defaultUUID: String
    @ObservedObject var locationManager: LocationManager
    @State private var uuidString = ""
    //@State private var isbackBeacon = false
    var body: some View {
        NavigationView {
            VStack {
                TextField("XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX", text: $uuidString)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Button("Add", action: {
                    if let uuid = UUID(uuidString: uuidString) {
                        locationManager.requestAuthorization()
                        let constraint = CLBeaconIdentityConstraint(uuid: uuid)
                        locationManager.startMonitoring(for: constraint)
                                      }
                    //isbackBeacon.toggle()
                })
                /*
                .sheet(isPresented:$isbackBeacon) {
                    AddBeaconView(defaultUUID: $defaultUUID, locationManager: locationManager)
                }*/

                .padding()
            }
            .navigationTitle("Add Beacon Region")
            .navigationBarItems(trailing: Button("Cancel") {
                locationManager.stopMonitoringAllRegions()
            })
        }
    }
}

struct RangeBeaconView_Previews: PreviewProvider {
    static var previews: some View {
        RangeBeaconView()
    }
}

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private var locationManager = CLLocationManager()
    @Published var beacons = [CLBeacon]()
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
    
    func requestAuthorization() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    func startMonitoring(for constraint: CLBeaconIdentityConstraint) {
        let beaconRegion = CLBeaconRegion(beaconIdentityConstraint: constraint, identifier: constraint.uuid.uuidString)
        locationManager.startMonitoring(for: beaconRegion)
    }
    
    func stopMonitoringAllRegions() {
        for region in locationManager.monitoredRegions {
            locationManager.stopMonitoring(for: region)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didRange beacons: [CLBeacon], satisfying beaconConstraint: CLBeaconIdentityConstraint) {
        self.beacons = beacons
    }
}

