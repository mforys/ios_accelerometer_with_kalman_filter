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
    
    @Published var angleX = 0.0
    @Published var angleY = 0.0
    @Published var angleZ = 0.0
    
    var enableKalmanFilter = false
    var kalmanGain = 0.0

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
        //print("updateAccelerometerValue: \(accX), \(accY), \(accZ)")
        self.accelerationX = accX
        self.accelerationY = accY
        self.accelerationZ = accZ

        if enableKalmanFilter {
            updateAnglesAfterAccelerometerMeasurement()
        }
        else
        {
            convertAccelerationOnAngles()
        }
    }

    func updateGyroscopeValue(rotationX: Double, rotationY: Double, rotationZ: Double)
    {
        //print("updateGyroscopeValue: \(rotationX), \(rotationY), \(rotationZ)")
        self.rotationRateX = rotationX
        self.rotationRateY = rotationY
        self.rotationRateZ = rotationZ
        
        if enableKalmanFilter {
            updateAnglesAfterGyroscopeMeasurement()
        }
    }

    func convertAccelerationOnAngles() {
        angleX = atan2(accelerationX, sqrt((accelerationY * accelerationY + accelerationZ * accelerationZ)))
        angleY = atan2(accelerationY, sqrt((accelerationX * accelerationX + accelerationZ * accelerationZ)))
        angleZ = atan2(accelerationZ, sqrt((accelerationX * accelerationX + accelerationY * accelerationY)))
    }

    func updateAnglesAfterAccelerometerMeasurement() {
        
        let currentAngleX = atan2(accelerationX, sqrt((accelerationY * accelerationY + accelerationZ * accelerationZ)))
        let currentAngleY = atan2(accelerationY, sqrt((accelerationX * accelerationX + accelerationZ * accelerationZ)))
        let currentAngleZ = atan2(accelerationZ, sqrt((accelerationX * accelerationX + accelerationY * accelerationY)))
    
        angleX = KalmanFilter.angleRadiansWithKalmanFilter(previousAngleRadians: angleX,
                                                           accelerometerReadingRadians: currentAngleX,
                                                           kalmanGain:kalmanGain)
        angleY = KalmanFilter.angleRadiansWithKalmanFilter(previousAngleRadians: angleY,
                                                           accelerometerReadingRadians: currentAngleY,
                                                           kalmanGain:kalmanGain)
        angleZ = KalmanFilter.angleRadiansWithKalmanFilter(previousAngleRadians: angleZ,
                                                           accelerometerReadingRadians: currentAngleZ,
                                                           kalmanGain:kalmanGain)
    }

    func updateAnglesAfterGyroscopeMeasurement() {
        angleX = KalmanFilter.angleRadiansFromGyro(previousAngleRadians: angleX, gyroReadingRadiansPerSec: rotationRateX)
        angleY = KalmanFilter.angleRadiansFromGyro(previousAngleRadians: angleY, gyroReadingRadiansPerSec: rotationRateY)
        angleZ = KalmanFilter.angleRadiansFromGyro(previousAngleRadians: angleZ, gyroReadingRadiansPerSec: rotationRateZ)
    }
}
