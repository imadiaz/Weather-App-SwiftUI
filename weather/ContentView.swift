//
//  ContentView.swift
//  weather
//
//  Created by Ancient on 06/05/21.
//

import SwiftUI
import Kingfisher
struct ContentView: View {
    @ObservedObject var viewModel: WeatherViewModel = WeatherViewModel()

    var body: some View {
        SplashView()
            .environmentObject(self.viewModel)
    }
}





struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
