//
//  CitiesView.swift
//  weather
//
//  Created by Ancient on 07/05/21.
//

import Foundation
import SwiftUI
struct SearchCityView: View {
    @EnvironmentObject var viewModel: WeatherViewModel
    @State var city: String = ""
    @Binding var hasLocations: Bool
    @State var fromScreen: String = "splash"
    var body: some View {
        ScrollView{
            VStack(alignment:.leading){
                SearchBarView(text: self.$city)
                    .padding()
                    .onChange(of: self.city, perform: { value in
                        if value.count > 3 {
                            self.viewModel.searchCity(city: value)
                        }else{
                            self.viewModel.cityResult = nil
                        }
                    })
                if self.viewModel.isSearching {
                    ProgressView()
                        .padding()
                }
                if self.viewModel.cityResult != nil {
                    VStack{
                        Text("Results for \(self.city)")
                            .font(.title2)
                            .padding()
                        CityResultView(name: self.viewModel.cityResult?.name ?? "", action: {
                            withAnimation{
                                self.viewModel.addToList(city: self.viewModel.cityResult!)
                                self.city = ""
                            }
                        })
                    }
                }
                if !self.viewModel.citiesResult.isEmpty{
                    Text("My cities")
                        .font(.title2)
                        .padding()
                }else{
                    Text("Start looking for a city!")
                        .font(.title2)
                        .padding()
                   
                }
                
                ForEach(self.viewModel.citiesResult,id:\.self){ city in
                    CityResultView(name: city.name, action: {
                        self.viewModel.deleteCity(city: city)
                    },showIcon: false)
                }
                Spacer()
                if self.fromScreen == "splash"{
                    Button(action: {
                        self.hasLocations = self.viewModel.isLocationsEmpty()
                    }){
                        HStack{
                            Spacer()
                            Text("Continue")
                            Spacer()
                        }
                            
                    }.padding(.vertical,40)
                }
             
            }.onAppear{
                self.viewModel.loadCities()
            }
        }
    }
}
struct SearchBarView: View {
    @Binding var text: String
    @State var isEditing: Bool = false
    var body: some View {
            HStack {
                TextField("Search city...", text: $text)
                    .padding(7)
                    .padding(.horizontal, 25)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .overlay(
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 8)
                            
                            if isEditing {
                                Button(action: {
                                    self.text = ""
                                }) {
                                    Image(systemName: "multiply.circle.fill")
                                        .foregroundColor(.gray)
                                        .padding(.trailing, 8)
                                }
                            }
                        }
                    )
                
                    .onTapGesture {
                        self.isEditing = true
                    }
                
                if isEditing {
                    Button(action: {
                        self.isEditing = false
                        self.text = ""
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }) {
                        Text("Cancel")
                            .foregroundColor(Color.blue)
                    }
                    .padding(.trailing, 10)
                    .transition(.move(edge: .trailing))
                    .animation(.default)
                }
            }
        }
}

struct CityResultView: View {
    var name: String = ""
    var action: () -> Void
    var showIcon: Bool = true
    var body: some View {
        VStack(alignment:.leading){
            HStack{
                Image(systemName: "cloud.fill")
                    .font(self.showIcon ? .title2 : .title3)
                    .foregroundColor(self.showIcon ? .yellow : .blue)
                Text(self.name)
                    .font(self.showIcon ? .title2 : .title3)
                Spacer()
                if self.showIcon {
                    Image(systemName: "plus.circle")
                        .font(.title2)
                        .onTapGesture {
                            self.action()
                        }
                }else{
                    Image(systemName: "minus.circle")
                        .font(.title3)
                        .foregroundColor(.red)
                        .onTapGesture {
                            self.action()
                        }
                }
            }.padding(.horizontal,20)
            .padding(.vertical,5)
            Divider()
        }
    }
}

