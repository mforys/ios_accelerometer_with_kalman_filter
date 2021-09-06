//
//  KalmanFilter.swift
//  Accelerometer_with_Kalman_filter
//
//  Created by Marek Forys on 09/08/2021.
//

import Foundation

class KalmanFilter {
    static let updateInterval = 0.1

    static func angleRadiansFromGyro(previousAngleRadians:Double,
                                     gyroReadingRadiansPerSec:Double) -> Double {
        var angleRadians = previousAngleRadians
        angleRadians += gyroReadingRadiansPerSec * updateInterval
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
