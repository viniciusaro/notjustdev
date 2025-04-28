import SwiftUI

struct RiskoLogo: View {
    var rotationAngle: Double

    var body: some View {
        Image("risko")
            .resizable()
            .scaledToFit()
            .frame(width: 200, height: 200)
            .rotation3DEffect(
                .degrees(rotationAngle),
                axis: (x: 0, y: 1, z: 0)
            )
    }
}

#Preview {
    RiskoLogo(rotationAngle: 0)
        .environment(GeoRisksStore())
        .environment(EmergencyKitStore())
}
