import Foundation

extension Location {
    static let zero = Location(
        latitude: 0,
        longitude: 0
    )
    
    static let grenoble = Location(
        latitude: 45.171547,
        longitude: 5.722387
    )
    
    static let france = Location(
        latitude: 46.2276,
        longitude: 2.2137,
        delta: 0.5
    )
}

extension Risque {
    static let all = deseases + naturalDisasters
    
    static let naturalDisasters = [
        earthquakes,
        tsunami,
        wildfires,
        floods
    ]
    
    static let tsunami = Risque(
        name: "Tsunamis",
        description: lipsumDescription,
        reference: reference,
        kind: .natural
    )
    
    static let earthquakes = Risque(
        name: "Earthquakes",
        description: lipsumDescription,
        reference: reference,
        kind: .natural
    )
    
    static let wildfires = Risque(
        name: "Wildfires",
        description: lipsumDescription,
        reference: reference,
        kind: .natural
    )
    
    static let floods = Risque(
        name: "Floods",
        description: lipsumDescription,
        reference: reference,
        kind: .natural
    )
    
    static let deseases = [
        dengue,
        yellowFever
    ]
    
    static let dengue = Risque(
        name: "Dengue Fever",
        description: lipsumDescription,
        reference: reference,
        kind: .desease
    )
    
    static let yellowFever = Risque(
        name: "Yellow Fever",
        description: lipsumDescription,
        reference: reference,
        kind: .desease
    )
    
    static let lipsumDescription = """
        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam non mauris a velit imperdiet efficitur. Praesent ex augue, vehicula vel sapien scelerisque, feugiat interdum purus. Ut nec dapibus leo, vel pulvinar mauris. Nunc neque dolor, dignissim lacinia sapien eget, suscipit egestas lorem. Nulla vehicula ipsum at leo porta, sed hendrerit dui molestie. Etiam in placerat mauris, ut tincidunt ex. Integer eu sapien sodales, facilisis leo sed, laoreet lacus.

        Praesent tempor mi ut purus gravida semper. Donec eu magna massa. Aenean placerat in ex ac interdum. Donec in tempus est. Sed consequat scelerisque egestas. Vestibulum ut feugiat tellus. Pellentesque suscipit bibendum augue ut bibendum. Etiam varius rhoncus sapien, facilisis mollis ipsum interdum eu. Nunc eu mauris in sapien dapibus bibendum. Ut placerat urna nisl, ut porta elit vehicula bibendum. Sed non magna sit amet orci aliquam lacinia quis sed est. Vestibulum condimentum eleifend ligula ac condimentum. Maecenas vitae ipsum ac nisi eleifend aliquam. Praesent convallis ligula sed aliquam ultricies. Aenean commodo tincidunt metus in fermentum. Proin eu erat neque.

        Quisque feugiat tempor porta. Quisque viverra diam ac eros accumsan auctor. Nam vulputate massa vitae maximus dapibus. Etiam blandit libero in lacus fermentum faucibus. Ut quam neque, vestibulum sit amet massa sed, aliquet sollicitudin erat. Cras semper magna euismod, aliquam erat eu, gravida mauris. Maecenas quis massa nec eros interdum cursus at eget nulla. Sed molestie commodo nunc. Curabitur aliquam metus urna, id lobortis dui lacinia ac. Suspendisse vulputate, magna scelerisque euismod blandit, nisi sem sodales nisi, non mattis purus leo ac felis. Quisque accumsan ut lacus at semper. Duis turpis mi, dictum aliquam augue id, maximus feugiat elit. Quisque neque purus, ornare nec sapien at, fringilla mollis nisl. Donec condimentum odio ac elit aliquet, tempor volutpat urna hendrerit.

        Nulla pharetra lobortis nisl, non blandit libero pulvinar eu. Vivamus vulputate, sapien in facilisis ultricies, ex nunc gravida augue, vel accumsan purus eros et felis. Aliquam erat volutpat. Morbi molestie malesuada orci, ut sodales purus convallis quis. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Proin auctor tempor sodales. Sed fermentum, dolor vel dapibus sollicitudin, quam nulla consectetur libero, et luctus tellus dui vitae eros. Aenean sit amet cursus ante. Maecenas sed felis ligula. Donec feugiat laoreet lectus. Fusce vitae dictum massa, nec lacinia turpis.
        """
    
    static let reference = URL(string: "https://www.georisques.gouv.fr")!
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
            description: " Identifiez les besoins de chaque membre de votre famille (adultes, enfants, bébés et animaux). Une fois cela fait, vous serez prêt à déterminer exactement ce qui doit être inclus dans votre kit.",
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


extension KitEssentialItem {
    static let items: [KitEssentialItem] = [
        KitEssentialItem(
            type: .water,
        ),
        KitEssentialItem(
            type: .food,
        ),
        KitEssentialItem(
            type: .radio,
        ),
        KitEssentialItem(
            type: .flashlight,
        ),
        ]
}

extension KitBabyItem {
    static let items: [KitBabyItem] = [
        KitBabyItem(
            type: .food,
        ),
        KitBabyItem(
            type: .diapers,
        ),
    ]
}

extension KitPetItem {
    static let items: [KitPetItem] = [
        KitPetItem(
            type: .food,
        ),
        KitPetItem(
            type: .blanket,
        ),
    ]
}
