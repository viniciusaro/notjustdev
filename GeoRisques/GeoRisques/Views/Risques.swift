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
                    .foregroundStyle(.accent)
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
            Text(LocalizedStringKey("risk_title"))
                .font(.title2)
                .bold()
            Spacer()
            Text("(Lat \(store.risquesState.location.latitude), Long \(store.risquesState.location.longitude))")
                .font(.footnote)
        }
        .padding()
        VStack(alignment: .center) {
            if let locationError = store.risquesState.locationError {
                switch locationError {
                case .unauthorized:
                    List {
                        // TODO: add button to send user to settings.
                        Text(LocalizedStringKey("unauthorized"))
                    }
                    .listStyle(.automatic)
                case .unavailable:
                    List {
                        Text(LocalizedStringKey("unavailable"))
                    }
                    .listStyle(.automatic)
                }
            } else if store.risquesState.risquesError != nil {
                List {
                    Text(LocalizedStringKey("not_found"))
                }
                .listStyle(.automatic)
            } else {
               ListView()
            }
        }
    }
}

struct ListView: View {
    @Environment(GeoRisquesStore.self) var store

    var body: some View {
        List(store.risquesState.risques, id: \.self) { risque in
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(.systemGray6))
                .frame(minHeight: 60)
                .overlay(
                    HStack {
                        Image(systemName: risque.kind.image)
                            .font(.title2)
                            .foregroundStyle(.accent)
                        Link(risque.name, destination: risque.reference)
                            .font(.headline)
                            .bold()
                        Spacer()
                        Image(systemName: "chevron.right")
                    }
                        .padding(.horizontal, 16)
                )
                .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
    }
}

#Preview {
    RisquesView()
        .environment(GeoRisquesStore())
        .environment(EmergencyKitStore())
}
