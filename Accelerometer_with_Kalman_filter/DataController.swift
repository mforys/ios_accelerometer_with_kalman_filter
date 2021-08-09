//
//  DataController.swift
//  MF_Accel_Gyro_Kalman
//
//  Created by Marek Forys on 09/08/2021.
//

import Foundation
import CoreMotion

class DataController: ObservableObject {
    @Published var accelerationX = 0.0
    @Published var accelerationY = 0.0
    @Published var accelerationZ = 0.0
    
    @Published var rotationRateX = 0.0
    @Published var rotationRateY = 0.0
    @Published var rotationRateZ = 0.0

    init() {
        print("DataController initialised")
        CMMotionManager.shared.startAccelerometer { data in
            self.updateAccelerometerValue(accX: data.x, accY: data.y, accZ: data.z)
        }
        CMMotionManager.shared.startGyroscope { data in
            self.updateGyroscopeValue(rotationX: data.x, rotationY: data.y, rotationZ: data.z)
        }
    }

    func updateAccelerometerValue(accX: Double, accY: Double, accZ: Double)
    {
        print("updateAccelerometerValue: \(accX), \(accY), \(accZ)")
        self.accelerationX = accX
        self.accelerationY = accY
        self.accelerationZ = accZ
    }
    
    func updateGyroscopeValue(rotationX: Double, rotationY: Double, rotationZ: Double)
    {
        print("updateGyroscopeValue: \(rotationX), \(rotationY), \(rotationZ)")
        self.rotationRateX = rotationX
        self.rotationRateY = rotationY
        self.rotationRateZ = rotationZ
    }
}
