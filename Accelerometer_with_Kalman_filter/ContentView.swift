//
//  ContentView.swift
//  Accelerometer_with_Kalman_filter
//
//  Created by Marek Forys on 09/08/2021.
//

import SwiftUI

struct ContentView: View {

    @ObservedObject var dataController = DataController()
    @State var useKalmanFilter = false

    var body: some View {
        VStack {
        Text("MF Accelerator Kalman")
            .padding()
    
            Group {
                Text("Acceleration").bold()
                Text("X = \(dataController.accelerationX)")
                Text("Y = \(dataController.accelerationY)")
                Text("Z = \(dataController.accelerationZ)")
            }

            Group {
                Text("Gyroscope").bold()
                Text("X = \(dataController.rotationRateX)")
                Text("Y = \(dataController.rotationRateY)")
                Text("Z = \(dataController.rotationRateZ)")
            }

            Spacer()

            Circle()
                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .offset(x: CGFloat(dataController.accelerationX) * 200, y: CGFloat(dataController.accelerationY) * 200)
                .padding()

            Spacer()

            Button{
                useKalmanFilter.toggle()
            }
            label: {
                Text(useKalmanFilter ? "Kalman Filter ON" : "Kalman Filter OFF")
                    .bold()
                    .padding(20)
            }
            .contentShape(Rectangle())
            .padding()
            .background(Color(red: 0.1, green: 0.1, blue: 0))
            .clipShape(Capsule())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
