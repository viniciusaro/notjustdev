import MapKit
import SwiftUI

struct RisksView: View {
    @Environment(GeoRisksStore.self) var store
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                RisksMapView()
                RisksListView()
            }
            .onViewDidLoad {
                store.onRisksDidLoad()
            }
            .toolbar(.hidden)
        }
    }
}

#Preview("Risks - Unauthorized Location") {
    let locationClient = ErrorLocationClient(error: .unauthorized)
    
    return RisksView()
        .environment(GeoRisksStore(locationClient: locationClient))
        .environment(EmergencyKitStore())
}

struct RisksMapView: View {
    @Environment(GeoRisksStore.self) var store
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        @Bindable var store = store
        
        ZStack(alignment: Alignment(horizontal: .trailing, vertical: .bottom)) {
            Map(position: $store.risksState.position)
                .onMapCameraChange { context in
                    store.onMapCameraCanged(context)
                }
            
            Spacer ()
            
            VStack {
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
                        .shadow(radius: 4)
                }
                .padding(.trailing, 16)
                .padding(.bottom, 112)
            }
            
            
            SearchBarView()
                .padding(.bottom, 16)
        }
        .alert(
            LocalizedStringKey("location_error"),
            isPresented: $store.risksState.showLocationAlert
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

struct RisksListView: View {
    @Environment(GeoRisksStore.self) var store
    
    var body: some View {
        @Bindable var store = store
        
        HStack() {
            VStack(alignment: .leading, spacing: -1) {
                Text(LocalizedStringKey("risk_title"))
                    .font(.title2)
                    .bold()
                Text(String(format: NSLocalizedString("risk_subtitle", comment: ""), store.totalOfRisks()))
                    .font(.callout)
                    .bold()
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            Text(store.risksState.risksDescription)
                .font(.footnote)
                .bold()
                .padding(.horizontal, 24)
                .padding(.vertical, 12)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.accent)
                        .opacity(0.2)
                )
                .foregroundStyle(.accent)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 6)
        
        VStack() {
            if store.risksState.risksError != nil {
                List {
                    HStack(spacing: 16) {
                        Image("risks_not_found")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 32, height: 32)
                        Text(LocalizedStringKey("not_found"))
                            .multilineTextAlignment(.leading)
                            .font(.subheadline)
                            .foregroundStyle(.accent)
                    }
                    .padding(.vertical, 8)
                }
            } else {
                RisksDetailView()
            }
        }
    }
}


struct SearchBarView: View {
    @Environment(GeoRisksStore.self) var store
    @Environment(\.colorScheme) var colorScheme
    @FocusState private var searchFieldIsFocused: Bool
    
    var body: some View {
        @Bindable var store = store
        
        HStack {
            if store.isEditing {
                TextField(
                    "",
                    text: $store.searchCityText,
                    prompt: Text(LocalizedStringKey("search_city_map"))
                        .foregroundStyle(colorScheme == .dark ? (.white.opacity(0.8)) :(.black.opacity(0.4)))
                )
                .focused($searchFieldIsFocused)
                .focusable(true)
                .foregroundStyle(colorScheme == .dark ? .white : .accent)
                .padding(.horizontal)
                .padding([.top, .bottom], 14)
                .background(colorScheme == .dark ? .black : .white)
                .clipShape(RoundedRectangle(cornerRadius:16))
                .frame(width: UIScreen.main.bounds.width/2.9 * 2, height: 22)
                .padding()
                .shadow(radius: 4)
                .submitLabel(.send)
                .autocorrectionDisabled(false)
                .animation(.easeInOut, value: store.isEditing)
                .transition(.move(edge: .trailing))
                .onSubmit {
                    withAnimation {
                        store.searchCity()
                        store.isEditing = false
                        store.searchCityText = ""
                    }
                }
                
                Button(action: {
                    withAnimation {
                        store.isEditing = false
                        store.searchCityText = ""
                    }
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .frame(width: 22, height: 22)
                        .foregroundStyle(.accent)
                        .padding(16)
                        .background(colorScheme == .dark ? .black : .white)
                        .cornerRadius(100)
                        .shadow(radius: 4)
                }
            } else {
                Button(action: {
                    withAnimation {
                        store.isEditing = true
                        searchFieldIsFocused = true
                    }
                }) {
                    Image(systemName: "magnifyingglass")
                        .resizable()
                        .frame(width: 22, height: 22)
                        .foregroundStyle(.accent)
                        .padding(16)
                        .background(colorScheme == .dark ? .black : .white)
                        .cornerRadius(100)
                        .shadow(radius: 4)
                }
            }
        }
        .padding()
        .onChange(of: store.isEditing) { oldValue, newValue in
            if oldValue {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    searchFieldIsFocused = true
                }
            }
        }
    }
}

