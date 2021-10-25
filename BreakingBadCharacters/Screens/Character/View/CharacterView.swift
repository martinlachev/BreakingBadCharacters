//
//  SwiftUIView.swift
//  BreakingBadCharacters
//
//  Created by Cognitven on 25.10.21.
//

import SwiftUI

struct CharacterView : View {

    @Environment(\.colorScheme) var colorScheme
    var character: Character
    var backgroundColor: Color {
        return colorScheme == .dark ? .black : .white
    }

    var body: some View {
        ScrollView(.vertical, showsIndicators: false, content: {
            GeometryReader{reader in
                if reader.frame(in: .global).minY > -480 {
                    AsyncImage(
                        url: URL(string: character.imageUrl)!,
                        placeholder: { ProgressView() },
                        image: { Image(uiImage: $0).resizable() }
                    )
                        .aspectRatio(contentMode: .fill)
                        .offset(y: -reader.frame(in: .global).minY)
                        .frame(
                            width: UIScreen.main.bounds.width,
                            height: reader.frame(in: .global).minY > 0 ? reader.frame(in: .global).minY + 480 : 480
                        )

                }
            }
            .frame(height: 480)

            VStack(alignment: .leading, spacing: 15) {
                Text("\(character.name) (\(character.nickname))")
                    .font(.system(size: 35, weight: .bold))
                    .padding(.leading, 10)

                Text("Status: \(character.status)")
                    .font(.system(.headline))
                    .padding(.leading, 10)

                VStack {
                    HStack {
                        Text("Seasson Appearance")
                            .font(.system(.headline))
                        Spacer()
                    }.padding(.leading, 10)

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            ForEach(0..<character.seasonAppearance.count) {index in
                                Text("Season \(index + 1)")
                                    .foregroundColor(.white)
                                    .font(.headline)
                                    .frame(width: 110, height: 40)
                                    .background(Color.gray).cornerRadius(10)
                            }
                        }.padding(.leading, 10)
                    }
                }

                VStack {
                    HStack {
                        Text("Occupations")
                            .font(.system(.headline))
                        Spacer()
                    }.padding(.leading, 10)

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            ForEach(0..<character.occupation.count) {index in
                                Text(character.occupation[index])
                                    .foregroundColor(.white)
                                    .font(.headline)
                                    .padding(7)
                                    .background(Color.gray).cornerRadius(10)
                            }
                        }.padding(.leading, 10)
                    }
                }
                Spacer()
            }
            .padding(.top, 25)
            .background(backgroundColor)
            .cornerRadius(20)
            .offset(y: -35)
        })
            .edgesIgnoringSafeArea(.all)
            .background(backgroundColor.edgesIgnoringSafeArea(.all))
    }
}

struct CharacterView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterView(character: Character(id: 1, imageUrl: "https://pbs.twimg.com/profile_images/1341861558427774976/m7mENJkV_400x400.jpg", name: "Gosho", occupation: ["Pichaga", "Picddddddddddddddddddhaga"], seasonAppearance: [1,2,3], status: "Drunk", nickname: "Pichaga"))
    }
}
