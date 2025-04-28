import SwiftUI

struct EmergencyNumbers: View {
    let twoColumns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        ScrollView {
            VStack {
                VStack(spacing: 8) {
                    Text(LocalizedStringKey("emergency-numbers-title"))
                        .font(.title)
                        .bold()
                    Text(LocalizedStringKey("emergency-numbers-subtitle"))
                        .font(.headline)
                        .foregroundStyle(.secondary)
                }
                .padding(.vertical, 24)
                
                LazyVGrid(columns: twoColumns, spacing: 8) {
                    EmergencyContactRow(number: "112", description: LocalizedStringKey("112-text"), iconName: "phone.circle.fill")
                    EmergencyContactRow(number: "114", description: LocalizedStringKey("114-text"), iconName: "phone.circle.fill")
                    EmergencyContactRow(number: "15", description: LocalizedStringKey("samu-text"), iconName: "cross.circle.fill")
                    EmergencyContactRow(number: "17", description: LocalizedStringKey("police-text"), iconName: "shield.lefthalf.fill")
                    EmergencyContactRow(number: "18", description: LocalizedStringKey("pompiers-text"), iconName: "flame.fill")
                }
            }
            .padding(.horizontal, 16)
            Spacer()
        }
        .scrollIndicators(.hidden)
    }
}

struct EmergencyContactRow: View {
    @Environment(EmergencyKitStore.self) var store
    @Environment(\.colorScheme) var colorScheme
    let number: String
    let description: LocalizedStringKey
    let iconName: String
    
    var body: some View {
        VStack(alignment: .center) {
            Image(systemName: iconName)
                .foregroundColor(.accent)
                .font(.system(size: 32))
                .padding(.top, 16)
            
            VStack(alignment: .center, spacing: 4) {
                Text(number)
                    .font(.title2)
                    .bold()
                
                Text(description)
                    .multilineTextAlignment(.center)
                    .font(.headline)
                    .foregroundStyle(colorScheme == .dark ? (.white.opacity(0.8)) : (.black.opacity(0.6)))
            }
            .padding(16)
            
            Button(action: {
                store.callNumber(number)
            }) {
                Label("Call", systemImage: "phone.fill")
                    .font(.headline)
                    .foregroundColor(colorScheme == .dark ? .white : .black)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .cornerRadius(12)
            }
            .padding(.horizontal, 8)
            .padding(.bottom, 16)
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(
            colorScheme == .light ? .accent.opacity(0.2) : .accent.opacity(0.13)
        )
        .cornerRadius(16)
    }
}


#Preview {
    EmergencyNumbers()
        .environment(EmergencyKitStore())
}
