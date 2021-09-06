import CoreMotion

extension CMMotionManager {
    static var shared = CMMotionManager()
    
    func startAccelerometer(completion: @escaping (CMAcceleration) -> Void) {
        print("Start Accelerometer")
        if isAccelerometerAvailable {
            accelerometerUpdateInterval = KalmanFilter.updateInterval
            startAccelerometerUpdates(to: .main) { (data, error) in
                if let error = error { debugPrint(error.localizedDescription )} else {
                    guard let rate = data?.acceleration else { return }
                    completion(rate)
                }
            }
        }
    }
    
    func startGyroscope(completion: @escaping (CMRotationRate) -> Void) {
        print("Start Gyroscope")
        if isGyroAvailable {
            gyroUpdateInterval = KalmanFilter.updateInterval
            startGyroUpdates(to: .main) { (data, error) in
                if let error = error { debugPrint(error.localizedDescription )} else {
                    guard let rate = data?.rotationRate else { return }
                    completion(rate)
                }
            }
        }
    }
}
