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

#Preview("Risques - Unauthorized Location") {
    let locationClient = ErrorLocationClient(error: .unauthorized)
    
    return RisquesView()
        .environment(GeoRisquesStore(locationClient: locationClient))
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
        .alert(
            LocalizedStringKey("location_error"),
            isPresented: $store.risquesState.showLocationAlert
        ) {
                Button(LocalizedStringKey("settings")) {
                    UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                }
                Button(LocalizedStringKey("cancel"), role: .cancel) {
                    store.onLocationAlertDismisButtonTapped()
                }
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
        .padding(16)

        VStack(alignment: .center) {
            if store.risquesState.risquesError != nil {
                List {
                    Text(LocalizedStringKey("not_found"))
                }
                .listStyle(.automatic)
            } else {
                RisqueDetailView()
            }
        }
    }
}

