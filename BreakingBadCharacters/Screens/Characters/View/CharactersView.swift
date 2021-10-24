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
    @State var seasonFilters: [SeasonFilters] = []
    @State var selectedSeasonFilters: [SeasonFilters] = []
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
                            Text("Season Appearnce Filter:")
                                .font(.system(.headline))
                            Spacer()
                        }
                        .padding(.leading, 15)
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 20) {
                                ForEach(seasonFilters) { filter in
                                    Filter(title: filter.name, isSelected: self.selectedSeasonFilters.contains(filter), action: {
                                        if self.selectedSeasonFilters.contains(filter) {
                                            self.selectedSeasonFilters.removeAll(where: { $0 == filter })
                                        }
                                        else {
                                            self.selectedSeasonFilters.append(filter)
                                        }
                                    })
                                }
                            }.padding(.leading, 15)
                        }
                    }
                    StaggeredGrid(
                        columns: columns,
                        list: viewModel.characters,
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
            seasonFilters = viewModel.seasonFilters
            selectedSeasonFilters = viewModel.selectedSeasonFilters
        }
    }
}

struct CharactersCardView: View{
    var character: Character
    
    var body: some View{
        NavigationLink(destination: {Text("")}) {
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
                    .background(Color.gray).cornerRadius(10)
            }

        }
    }
}
