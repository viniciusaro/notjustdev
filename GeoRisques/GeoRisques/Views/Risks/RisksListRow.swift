import SwiftUI

struct RisksListRow: View {
    @Environment(GeoRisksStore.self) var store
    @Environment(\.colorScheme) var colorScheme
    let iconName: String
    let riskName: String
    let isArrowShowing: Bool
    
    var body: some View {
        HStack {
            Circle()
                .foregroundStyle(colorScheme == .dark ? .accent : .accent)
                .opacity(colorScheme == .dark ? 0.9 : 0.7)
                .frame(width: 50, height: 50)
                .overlay(
                    Image(iconName)
                        .resizable()
                        .scaledToFit()
                        .padding(12)
                )
            
            Text(riskName)
                .foregroundStyle(colorScheme == .dark ? .white : .black)
                .font(.headline)
            Spacer()
            if isArrowShowing {
                Image(systemName: "chevron.right" )
                    .padding(.horizontal, 16)
            }
        }
    }
}
