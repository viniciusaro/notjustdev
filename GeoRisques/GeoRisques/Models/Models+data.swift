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


//MARK: - Emergency Kit

extension EmergencyKitInformation {
    static let infos: [EmergencyKitInformation] = [
        EmergencyKitInformation(
            title: "Mon kit d’urgence 72h",
            description: "En cas de crise, les autorités peuvent vous demander de quitter immédiatement votre domicile ou de rester chez vous jusqu'à l'arrivée des secours. Il est recommandé d'avoir préparé un sac contenant de quoi vivre pendant 3 jours en autonomie.",
            image: "emergencyKit",
            tag: 0
        ),

        EmergencyKitInformation(
            title: "Les besoins de votre famille",
            description: " Identifiez les besoins de chaque membre de votre famille (adultes, enfants, animaux). Une fois cela fait, vous serez prêt à déterminer exactement ce qui doit être inclus dans votre kit.",
            image: "preparer",
            tag: 1
        ),

        EmergencyKitInformation(
            title: "Collecter tous les objets essentiels",
            description: "En fonction de votre checklist, commencez à collecter tous les objets essentiels pour passer 72h en autonomie.",
            image: "equiper",
            tag: 2
        ),

        EmergencyKitInformation(
            title: "Vérifiez le contenu de votre kit",
            description: "Tous les 6 mois pour vous assurer que rien n'est périmé et que les besoins de votre famille n'ont pas changé.",
            image: "verifier",
            tag: 3
        ),

    ]
}
