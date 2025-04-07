import SwiftUI

struct EmergencyKit: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 24) {
                VStack(alignment: .center , spacing: 16) {
                    Text("Mon kit d’urgence 72h")
                        .font(.largeTitle)
                        .bold()
                    Text("Préparez-vous à toute éventualité")
                        .font(.headline)
                        .bold()
                }
                .padding(.top, 48)

                Spacer()

                VStack(spacing: 16) {
                    Text("En cas de crise, les consignes des autorités peuvent être de quitter immédiatement votre domicile, ou de rester chez vous jusqu’à l’arrivée des secours. Dans les deux cas, il est recommandé d’avoir préparé un sac contenant de quoi vivre pendant 3 jours en autonomie.")
                        .multilineTextAlignment(.leading)
                        .foregroundColor(.gray)
                    Text("Voici la liste des objets et équipements essentiels à mettre dans ce kit d’urgence, qui doit rester facilement accessible. Constituez-le sans attendre et vérifier régulièrement son contenu, c’est important.")
                        .multilineTextAlignment(.leading)
                        .foregroundColor(.gray)

                    Spacer()

                    NavigationLink {
                        FamilyMembers()
                    } label: {
                        Text("Préparer le kit d’urgence")
                            .font(.headline)
                            .frame(width: 240)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(40)
                    }
                    .padding(.bottom, 24)
                }
            }
            .padding(.horizontal, 16)
        }
    }
}









