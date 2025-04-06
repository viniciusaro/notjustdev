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
                        FamilyMemberView()
                    } label: {
                        Text("Préparer le kit d’urgence")
                            .font(.headline)
                            .frame(maxWidth: 240)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(40)
                    }

                    Spacer()
                }
            }
            .padding(.horizontal, 16)
        }
    }
}

struct FamilyMemberView: View {
    @Environment(EmergencyKitStore.self) var store

    var body: some View {
        VStack() {
            Text("Membres de la famille")
                .font(.title)
                .bold()

            Text("Créez votre kit d’urgence en fonction du nombre de membres de votre famille")
                .font(.body)

            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                ForEach(store.memberTypes, id: \.self) { label in
                    MemberView(
                        label: label,
                        count: store.memberCount[label] ?? 0,
                        isSelected: store.selectedMember == label,
                        onTap: {
                            withAnimation {
                                store.selectedMember = (store.selectedMember == label ? nil : label)
                            }
                        }
                    )
                }
            }

            if let selectedLabel = store.selectedMember {
                CounterView(
                    onIncrement: { store.increment(selectedLabel) },
                    onDecrement: { store.decrement(selectedLabel) }
                )
            }

            Spacer()

            if store.memberCount.values.contains(where: { $0 > 0 }) {
                ChecklistKitButton {
                    store.save()
                }
            }
        }
        .padding(.top)
        .padding(.horizontal)
    }
}

struct CounterView: View {
    let onIncrement: () -> Void
    let onDecrement: () -> Void

    var body: some View {
        HStack(spacing: 40) {
            Button(action: onDecrement) {
                Image(systemName: "minus")
                    .font(.title)
                    .frame(width: 50, height: 40)
            }

            Divider().frame(height: 30)

            Button(action: onIncrement) {
                Image(systemName: "plus")
                    .font(.title)
                    .frame(width: 50, height: 40)
            }
        }
        .padding()
        .background(Color(UIColor.systemGray6))
        .cornerRadius(12)
        .padding(.top, 30)
    }
}


struct MemberView: View {
    let label: String
    let count: Int
    let isSelected: Bool
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            RoundedRectangle(cornerRadius: 20)
                .fill(
                    count == 0 ? Color(.systemGray6) : (isSelected ? .blue : Color(.systemGray6))
                )
                .frame(height: 120)
                .overlay(
                    VStack {
                        Text("\(count)")
                            .font(.system(size: 40))
                            .fontWeight(.bold)
                            .foregroundColor(
                                count == 0 ? .gray :
                                    (isSelected ? .white : .blue)
                            )
                        Text(label)
                            .font(.body)
                            .foregroundColor(
                                count == 0 ? .gray :
                                    (isSelected ? .white : .blue)
                            )
                    }
                )
        }
    }
}

struct ChecklistKitButton: View {
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            Text("Générer la liste")
                .fontWeight(.bold)
                .frame(maxWidth: 200)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(50)
        }
        .padding(.bottom, 24)
    }
}
