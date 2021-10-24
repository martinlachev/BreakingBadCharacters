//
//  CharactersCarouselView.swift
//  BreakingBadCharacters
//
//  Created by Martin Lachev on 24.10.21.
//

import SwiftUI

struct CharactersView: View {
    @ObservedObject var viewModel = CharactersViewModel()
    @State var columns: Int = 2
    @State var searchText: String = ""
    @Namespace var animation
    
    var body: some View {
        
        NavigationView {
            
            StaggeredGrid(columns: columns, list: viewModel.characters, content: { character in
                CharactersCardView(character: character)
                    .matchedGeometryEffect(id: character.id, in: animation)
            })
                .padding(.horizontal)
                .navigationTitle("Characters")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            columns += 1
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            columns = max(columns - 1, 1)
                        } label: {
                            Image(systemName: "minus")
                        }
                    }
                }
                .animation(.easeInOut, value: columns)
                .searchable(text: $searchText)
        }
        .onAppear {
            viewModel.fetchCharacters()
        }
    }
}

struct CharactersCardView: View{
    var character: Character
    
    var body: some View{
        VStack {
            AsyncImage(
                url: URL(string: character.imageUrl)!,
                placeholder: { Text("Loading ...") },
                image: { Image(uiImage: $0).resizable() }
            )
                .aspectRatio(contentMode: .fit)
                .cornerRadius(10)
            
            Text(character.name).font(.system(.headline))
        }
    }
}
