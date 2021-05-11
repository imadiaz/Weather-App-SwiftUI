//
//  WeatherView.swift
//  weather
//
//  Created by Ancient on 06/05/21.
//

import Foundation
import SwiftUI
import Kingfisher
struct WeatherView: View {
    @EnvironmentObject var viewModel: WeatherViewModel
    @State private var selectedTab: Int = 0
    @State private var hasLocations: Bool = true
    @State private var presentSheet: Bool = false
     var body: some View{
        Group {
            if self.viewModel.isLoading {
               ProgressView()
                .padding()
            }else if self.viewModel.cities.isEmpty{
                Button(action:{
                    self.presentSheet.toggle()
                }){
                    Text("Start looking for a city now!")
                }.padding()
                .sheet(isPresented:self.$presentSheet){
                    SearchCityView(hasLocations: .constant(true), fromScreen: "home")
                        .environmentObject(self.viewModel)
                        .onDisappear{
                            self.viewModel.refreshCities()
                        }
                }
            }else{
                    ZStack {
                        TabView {
                                ForEach(self.viewModel.cities,id:\.self){ city in
                                    withAnimation {
                                        WeatherViewItem(city: city)
                                    }
                                }
                            
                        }.tabViewStyle(PageTabViewStyle())
                       
                        VStack{
                            HStack{
                                Spacer()
                                        Image(systemName: "gear")
                                            .foregroundColor(.white)
                                            .padding()
                                            .onTapGesture {
                                                self.presentSheet.toggle()
                                            }
                            }.padding(.top,UIApplication.shared.windows.first?.safeAreaInsets.top)
                            Spacer()
                        }
                    }.edgesIgnoringSafeArea(.all)
                    .sheet(isPresented:self.$presentSheet){
                        SearchCityView(hasLocations: .constant(true), fromScreen: "home")
                            .environmentObject(self.viewModel)
                            .onDisappear{
                                self.viewModel.refreshCities()
                            }
                    }
                
            }
        }
        
     }
}

struct WeatherViewItem: View{
    @State var city: City
    var body: some View{
        ZStack {
            KFImage(URL(string: self.city.getImage() ))
                .ignoresSafeArea()
            Color.black
                .opacity(0.3)
                .ignoresSafeArea()
            VStack{
                Text(self.city.name )
                    .font(.system(size: 40))
                    .foregroundColor(.white)
                    .fontWeight(.medium)
                    
                Text(self.city.getDescription() )
                    .font(.system(size: 25))
                    .foregroundColor(.white)
                    .padding(.vertical,10)
                Image(systemName: self.city.getIcon() )
                    .font(.system(size: 70))
                    .foregroundColor(.white)
                    .padding(.top,20)
                Text(self.self.city.getTemp() )
                    .font(.system(size: 70))
                    .foregroundColor(.white)
                HStack{
                    Text("\(self.city.getMaxTemp() ) / \(self.city.getMinTemp() )")
                        .foregroundColor(.white)
                }
                HStack{
                    Spacer()
                    Text("\(Date())")
                        .font(.system(size: 10))
                        .foregroundColor(.white)
                }.padding()
                Spacer().frame(height:50)
                
                        HStack{
                            SectionView(title: "Humidity", value: self.city.getHumidity() , icon: "thermometer")
                            
                            SectionView(title: "Clouds", value: self.city.getClouds() , icon: "cloud.fill")
                            SectionView(title: "Visibility", value: self.city.getVisibility() , icon: "eye",showDivider: false)
                        }
                        HStack{
                            SectionView(title: "Wind", value: self.city.getWind() , icon: "wind")
                            SectionView(title: "Pressure", value: self.city.getPressure() , icon: "aqi.medium",showDivider: false)
                        }
                Spacer().frame(height:50)

            }
        }
    }
}
