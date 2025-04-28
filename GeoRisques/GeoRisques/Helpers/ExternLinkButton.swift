//
//  LinkExternButtonView.swift
//  GeoRisques
//
//  Created by Cris Messias on 28/04/25.
//

import SwiftUI

struct ExternLinkButton: View {
    @Environment(\.colorScheme) var colorScheme
    let frameHeight: CGFloat
    let image: String
    let text: LocalizedStringKey
    let onTap: () -> Void
    
    var body: some View {
        RoundedRectangle(cornerRadius: 12)
            .fill(colorScheme == .light ? Color(.systemGray6) : Color(.systemGray5))
            .frame(height: frameHeight)
            .overlay(HStack {
                    Button(action: {
                        onTap()
                    }) {
                        HStack {
                            Image(image)
                                .resizable()
                                .scaledToFit()
                                .clipShape(Circle())
                                .frame(width: 42, height: 42)
                                .padding(.trailing, 12)
                            
                            Text(text)
                                .foregroundStyle(colorScheme == .light ? .black: .white)
                                .multilineTextAlignment(.leading)
                                .font(.subheadline)
                                .bold()
                        }
                        Spacer()
                        Image(systemName: "chevron.right" )
                    }
                    .padding(.horizontal, 16)
                })
    }
}

#Preview {
    ExternLinkButton(
        frameHeight: 72,
        image: "FrenchGov",
        text: LocalizedStringKey("linkExtern"),
        onTap: {}
    )
    .preferredColorScheme(.dark)
}
