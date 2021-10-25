//
//  CharactersCarouselView.swift
//  BreakingBadCharacters
//
//  Created by Martin Lachev on 24.10.21.
//

import SwiftUI

struct CharactersView: View {
    @ObservedObject var viewModel = CharactersViewModel()
    @State var columns: Int = 3
    @State var searchText: String = ""
    @Namespace var animation
    
    var body: some View {
        
        NavigationView {
            ZStack {
                if viewModel.isLoading {
                    ZStack {
                        ProgressView()
                    }
                }
                VStack {
                    VStack {
                        HStack {
                            Text("Season Appearnce Filter")
                                .font(.system(.headline))
                            Spacer()
                        }
                        .padding(.leading, 15)
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 20) {
                                ForEach(viewModel.seasonFilters) { filter in
                                    Filter(title: filter.name, isSelected: viewModel.selectedSeasonFilters.contains(filter), action: {
                                        if viewModel.selectedSeasonFilters.contains(filter) {
                                            viewModel.selectedSeasonFilters.removeAll(where: { $0 == filter })
                                        }
                                        else {
                                            viewModel.selectedSeasonFilters.append(filter)
                                        }
                                    })
                                }
                            }.padding(.leading, 15)
                        }
                    }
                    StaggeredGrid(
                        columns: columns,
                        list: viewModel.filterCharacters(searchText: searchText),
                        content: { character in
                            CharactersCardView(character: character)
                                .matchedGeometryEffect(id: character.id, in: animation)
                        }
                    ).padding(.horizontal)
                }
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
        }
        .alert(
            isPresented: $viewModel.showAlert
        ) {
            Alert(
                title: Text("Something went wrong"),
                message: Text(viewModel.errorMessage),
                dismissButton: .default(Text("Got it!"))
            )
        }
        .onAppear {
            viewModel.fetchCharacters()
            viewModel.createSeasonFilters()
        }
    }
}

struct CharactersCardView: View{
    var character: Character
    @Environment(\.colorScheme) var colorScheme

    var body: some View{
        NavigationLink(destination: {CharacterView(character: character)}) {
            VStack {
                AsyncImage(
                    url: URL(string: character.imageUrl)!,
                    placeholder: { ProgressView() },
                    image: { Image(uiImage: $0).resizable() }
                )
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)

                Text(character.name)
                    .font(.system(.headline))
                    .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
            }
        }
    }
}

struct Filter: View {
    var title: String
    var isSelected: Bool
    var action: () -> Void
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        Button(action: self.action) {
            if self.isSelected {
                Text(self.title)
                    .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                    .font(.headline)
                    .frame(width: 110, height: 40)
                    .background(Color.blue).cornerRadius(10)
            } else {
                Text(self.title)
                    .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                    .font(.headline)
                    .frame(width: 110, height: 40)
                    .background(Color.init(uiColor: .systemGray2))
                    .cornerRadius(10)
            }

        }
    }
}
