import SwiftUI

struct RisqueDetailView: View {
    let state: GeoRisquesStore.RisqueDetailState
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top, spacing: 16) {
                Image(systemName: state.risque.kind.image)
                    .resizable()
                    .frame(width: 48, height: 48)
                VStack(alignment: .leading) {
                    Text(state.risque.name)
                    Link("Info détaillées", destination: state.risque.reference)
                        .italic()
                }
            }
            .padding([.leading, .trailing])
            ScrollView {
                Text(state.risque.description)
                    .padding(16)
            }
            Spacer()
        }
        .navigationTitle(state.risque.name)
        .navigationBarTitleDisplayMode(.large)
    }
}

#Preview {
    RisqueDetailView(state: GeoRisquesStore.RisqueDetailState(risque: .earthquakes))
}
