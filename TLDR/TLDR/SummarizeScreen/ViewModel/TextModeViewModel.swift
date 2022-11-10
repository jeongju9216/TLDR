//
//  TextViewModel.swift
//  TLDR
//
//  Created by 유정주 on 2022/09/29.
//

import Foundation

struct TextModeViewModel {
    
    //MARK: - Properties
    let textMode: Observable<TextMode> = Observable(.summarize)

    init() { }
    
    //MARK: - Methods
    func toggleTextMode() {
        let textMode = self.textMode.value
        self.textMode.value = (textMode == .original) ? .summarize : .original
    }
}

enum TextMode: Int {
    case original
    case summarize
}
