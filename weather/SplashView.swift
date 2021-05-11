//
//  SplashView.swift
//  weather
//
//  Created by Ancient on 07/05/21.
//

import Foundation
import SwiftUI
struct SplashView: View {
    @EnvironmentObject var viewModel: WeatherViewModel
    @State private var hasLocations: Bool = false
    @State private var showSplash: Bool = true
    var body: some View {
        Group {
            if self.showSplash {
                ProgressView()
                    .padding()
//                    Color.blue
//                        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
//                    VStack {
//                        Image(systemName: "cloud")
//                            .font(.system(size: 50))
//                            .foregroundColor(.white)
//                        Text("Weather app")
//                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
//                            .foregroundColor(.white)
//                            .padding()
//                        ProgressView()
//                            .padding()
//                    }
                .onAppear{
                    withAnimation {
                        self.hasLocations = self.viewModel.isLocationsEmpty()
                        self.showSplash = false
                    }
                }
            }else{
                if self.hasLocations {
                    WeatherView()
                }else{
                    SearchCityView(hasLocations: self.$hasLocations)
                }
            }
           
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
