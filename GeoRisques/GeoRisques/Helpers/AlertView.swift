//
//  AlertView.swift
//  GeoRisques
//
//  Created by Cris Messias on 26/04/25.
//

import SwiftUI

struct AlertView: View {
    let icon: String
    let text: LocalizedStringKey
    let frameSize: CGFloat
    let iconSize: CGFloat
    
    var body: some View {
        VStack(spacing: 12) {
            Image(icon)
                .resizable()
                .scaledToFit()
                .frame(width: iconSize, height: iconSize)
            Text(text)
                .multilineTextAlignment(.center)
                .font(.subheadline)
                .foregroundStyle(.accent)
        }
        .padding()
        .frame(width: frameSize, height: frameSize)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(.accent)
                .opacity(0.2)
        )
        .foregroundStyle(.accent)
    }
}

#Preview {
    let emergencyKitStore = EmergencyKitStore()

    AlertView(icon: "empty_backpack", text: "Label", frameSize: 120, iconSize: 30)
        .environment(emergencyKitStore)
}
