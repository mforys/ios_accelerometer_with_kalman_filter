//
//  KalmanFilter.swift
//  Accelerometer_with_Kalman_filter
//
//  Created by Marek Forys on 09/08/2021.
//

import Foundation

class KalmanFilter {
    static let gyroUpdateInterval = 0.3

    static func angleRadiansFromGyro(previousAngleRadians:Double,
                                     gyroReadingRadiansPerSec:Double) -> Double {
        var angleRadians = previousAngleRadians
        angleRadians += gyroReadingRadiansPerSec * gyroUpdateInterval
        return angleRadians
    }

    static func angleRadiansWithKalmanFilter(previousAngleRadians:Double,
                                             accelerometerReadingRadians:Double,
                                             kalmanGain:Double) -> Double {
        var angleRadians = previousAngleRadians
        angleRadians += kalmanGain * (accelerometerReadingRadians - angleRadians)
        return angleRadians
    }
}
