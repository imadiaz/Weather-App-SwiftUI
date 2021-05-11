//
//  SectionView.swift
//  weather
//
//  Created by Ancient on 06/05/21.
//

import Foundation
import SwiftUI
struct SectionView: View{
    var title: String = ""
    var value: String = ""
    var icon: String = ""
    var showDivider: Bool = true
    var body: some View{
        HStack{
            Image(systemName: self.icon)
                    .font(.system(size: 20))
                    .foregroundColor(.white)
            VStack(alignment:.leading){
                Text(self.title)
                    .font(.system(size: 15))
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
                Text(self.value)
                    .font(.system(size: 13))
                    .foregroundColor(.white)
            }
            if self.showDivider {
                HStack {
                Divider()
                    .frame(maxWidth:2)
                    .background(Color.white)
                    
                }.frame(height: 100)
            }
        }
    }
}
