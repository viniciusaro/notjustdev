import MapKit
import SwiftUI

struct RisquesView: View {
    @Environment(GeoRisquesStore.self) var store
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                RisquesMapView()
                RisquesListView()
            }
            .onViewDidLoad {
                store.onRisquesDidLoad()
            }
            .toolbar(.hidden)
        }
    }
}

struct RisquesMapView: View {
    @Environment(GeoRisquesStore.self) var store
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        @Bindable var store = store
        
        ZStack(alignment: Alignment(horizontal: .trailing, vertical: .bottom)) {
            Map(position: $store.risquesState.position)
            Button {
                store.onLocationButtonTapped()
            } label: {
                Image(systemName: "location.fill")
                    .resizable()
                    .frame(width: 22, height: 22)
                    .padding(16)
                    .background(colorScheme == .dark ? .black : .white)
                    .cornerRadius(100)
            }
            .padding()
        }
    }
}

struct RisquesListView: View {
    @Environment(GeoRisquesStore.self) var store
    
    var body: some View {
        @Bindable var store = store
        
        HStack(alignment: .firstTextBaseline) {
            Text("Risques")
                .font(.title2)
            Spacer()
            Text("(\(store.risquesState.location.latitude), \(store.risquesState.location.longitude))")
                .font(.footnote)
        }
        .padding()
        VStack(alignment: .center) {
            if let locationError = store.risquesState.locationError {
                switch locationError {
                case .unauthorized:
                    List {
                        // TODO: add button to send user to settings.
                        Text("Location services are not authorized.")
                    }
                    .listStyle(.automatic)
                case .unavailable:
                    List {
                        Text("Location services are unavailable.")
                    }
                    .listStyle(.automatic)
                }
            } else if store.risquesState.risquesError != nil {
                List {
                    Text("No risques found")
                }
                .listStyle(.automatic)
            } else {
                List(store.risquesState.risques, id: \.self) { risque in
                    HStack {
                        Link(risque.name, destination: risque.reference)
                        Spacer()
                        HStack {
                            Image(systemName: risque.kind.image)
                            Image(systemName: "chevron.right")
                        }
                    }
                }
                .listStyle(.plain)
            }
        }
    }
}

#Preview {
    RisquesView()
        .environment(GeoRisquesStore())
        .environment(EmergencyKitStore())
}
