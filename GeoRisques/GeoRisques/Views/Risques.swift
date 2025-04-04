import MapKit
import SwiftUI

struct RisquesView: View {
    @Environment(GeoRisquesStore.self) var store
    
    var body: some View {
        VStack(alignment: .leading) {
            RisquesMapView()
            RisquesListView()
        }
        .onViewDidLoad {
            store.onRisquesDidLoad()
        }
    }
}

struct RisquesMapView: View {
    @Environment(GeoRisquesStore.self) var store
    
    var body: some View {
        @Bindable var store = store
        
        ZStack(alignment: Alignment(horizontal: .trailing, vertical: .bottom)) {
            Map(position: $store.risquestState.position)
                .edgesIgnoringSafeArea(.all)
            Button {
                store.onLocationButtonTapped()
            } label: {
                Image(systemName: "location.fill")
                    .foregroundColor(.blue)
            }
            .padding(8)
            .background(Color.white)
            .padding()
        }
    }
}

struct RisquesListView: View {
    @Environment(GeoRisquesStore.self) var store
    
    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            Text("Risques")
                .font(.title2)
            Spacer()
            Text("(\(store.risquestState.location.latitude), \(store.risquestState.location.longitude))")
                .font(.footnote)
        }
        .padding()
        List(store.risquestState.risques, id: \.self) { risque in
            Button {
                store.onRisqueButtonTapped(risque)
            } label: {
                HStack {
                    Text(risque.name)
                    Spacer()
                    HStack {
                        Image(systemName: risque.kind.image)
                        Image(systemName: "chevron.right")
                                            .foregroundColor(.gray)
                    }
                }
            }

        }
        .listStyle(.plain)
    }
}

#Preview {
    RisquesView()
        .environment(GeoRisquesStore())
}
