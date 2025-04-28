import SwiftUI
import Foundation

struct PlusInfos: View {
    @Environment(EmergencyKitStore.self) var store
    
    var body: some View {
        NavigationView {
            List(PlusInfoShowCase.allCases) { info in
                NavigationLink {
                    info.view
                } label: {
                    Label(info.localizedTitle, systemImage: info.icon)
                        .font(.headline)
                }
                .listRowSpacing(32)
                .listRowSeparator(.hidden)
                
            }
            .padding(.top,16)
            .listStyle(.plain)
            .navigationTitle("Plus")
        }
    }
}

#Preview {
    PlusInfos()
        .environment(EmergencyKitStore())
}





