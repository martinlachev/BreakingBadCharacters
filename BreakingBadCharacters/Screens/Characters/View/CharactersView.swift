//
//  CharactersView.swift
//  BreakingBadCharacters
//
//  Created by Cognitven on 21.10.21.
//

import SwiftUI

struct CharactersView: View {
    @State var currentIndex: Int = 0
    @State private var searchText = ""
    @ObservedObject var viewModel = CharactersViewModel()

    var body: some View {

        NavigationView {
            ZStack{
                TabView(selection: $currentIndex){
                    ForEach(viewModel.characters.indices,id: \.self){index in
                        GeometryReader{ proxy in
                            AsyncImage(
                                url: URL(string: viewModel.characters[index].imageUrl),
                                content: { image in
                                    image.resizable()
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: proxy.size.width,height: proxy.size.height)
                                        .cornerRadius(1)
                                },
                                placeholder: {
                                    ProgressView()
                                }
                            )

                        }
                        .ignoresSafeArea()
                        .offset(y: -100)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .animation(.easeInOut, value: currentIndex)
                .overlay(

                    LinearGradient(colors: [

                        Color.clear,
                        Color.black.opacity(0.2),
                        Color.white.opacity(0.4),
                        Color.white,
                        Color.white,
                        Color.white,

                    ], startPoint: .top, endPoint: .bottom)
                        .background(

                            Color.black
                                .opacity(0.15)
                        )
                )
                .ignoresSafeArea()

                SnapCarousel(
                    spacing: getRect().height < 750 ? 15 : 20,trailingSpace: getRect().height < 750 ? 100 : 150,index: $currentIndex, items: viewModel.characters
                ) { character in
                    CardView(character: character)
                }
                .offset(y: getRect().height / 3.5)
            }
            .onAppear(perform: {viewModel.fetchCharacters()})
        }
        .navigationTitle("Searchable Example")
        .searchable(text: $searchText)
    }

    @ViewBuilder
    func CardView(character: Character)->some View{
        VStack(spacing: 10){
            GeometryReader{proxy in

                AsyncImage(
                    url: URL(string: character.imageUrl),
                    content: { image in
                        image.resizable()
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: proxy.size.width,height: proxy.size.height)
                            .cornerRadius(1)
                    },
                    placeholder: {
                        ProgressView()
                    }
                )
            }
            .padding(15)
            .background(Color.white)
            .cornerRadius(25)
            .frame(height: getRect().height / 2.5)
            .padding(.bottom,15)

            Text(character.name)
                .font(.title2.bold())
        }
    }
}

struct _Previews: PreviewProvider {
    static var previews: some View {
        CharactersView()
            .previewDevice("iPhone 11")
    }
}

extension View{
    func getRect()->CGRect{
        return UIScreen.main.bounds
    }
}


struct CharactersView_Previews: PreviewProvider {
    static var previews: some View {
        CharactersView()
    }
}
