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

#Preview {
    RisquesView()
        .environment(GeoRisquesStore())
        .environment(EmergencyKitStore())
}

struct RisquesMapView: View {
    @Environment(GeoRisquesStore.self) var store
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        @Bindable var store = store
        
        ZStack(alignment: Alignment(horizontal: .trailing, vertical: .bottom)) {
            Map(position: $store.risquesState.position)
                .onMapCameraChange { context in
                    store.onMapCameraCanged(context)
                }
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

        HStack() {
            Text(LocalizedStringKey("risk_title"))
                .font(.title2)
                .bold()

            Spacer()

            RoundedRectangle(cornerRadius: 20)
                .fill(.accent)
                .opacity(0.8)
                .frame(width: 230, height: 24)
                .overlay(
                        Text(store.risquesState.risquesDescription)
                            .foregroundStyle(.black)
                            .font(.footnote)
                )
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
                        Circle()
                            .fill(.accent)
                            .opacity(0.8)
                            .frame(width: 50, height: 50)
                            .overlay {
                                Image(risque.kind.imageName)
                                    .resizable()
                                    .scaledToFit()
                                    .padding(12)
                            }

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


