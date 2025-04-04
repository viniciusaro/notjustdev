extension Location {
    static let grenoble = Location(
        latitude: 45.171547,
        longitude: 5.722387
    )
}

extension Risque {
    static let naturalDisasters = [
        Risque(name: "Earthquakes", kind: .natural),
        Risque(name: "Tsunamis", kind: .natural),
        Risque(name: "Wildfires", kind: .natural),
        Risque(name: "Floods", kind: .natural),
    ]
}
