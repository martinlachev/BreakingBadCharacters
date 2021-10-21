//
//  CharactersViewModel.swift
//  BreakingBadCharacters
//
//  Created by Cognitven on 20.10.21.
//

import Foundation
import Combine

class CharactersViewModel: ObservableObject {
    @Published var errorMessage: String = ""
    @Published var isLoading: Bool = false
    @Published var showAlert: Bool = false
    @Published var showDeleteAlert: Bool = false
    @Published var characters: [Character] = []
    private var disposables = Set<AnyCancellable>()

    private let portfolioEndpoint = CharacterEndpoint()

    func fetchCharacters() {
        isLoading = true
        portfolioEndpoint.get()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] value in
                guard let self = self else { return }
                switch value {
                case .failure(let error):
                    self.isLoading = false
                    self.errorMessage = error.errorDescription!
                    self.showAlert = true
                    break
                case .finished:
                    self.isLoading = false
                    break
                }
            }, receiveValue: { [weak self] value in
                guard let self = self else { return }
                self.isLoading = false
                if let data = try? JSONDecoder().decode([Character].self, from: value) {
                    self.characters = data
                }
            })
            .store(in: &disposables)
    }
}
