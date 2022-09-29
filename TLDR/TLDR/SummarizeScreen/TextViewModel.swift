//
//  TextViewModel.swift
//  TLDR
//
//  Created by 유정주 on 2022/09/29.
//

import Foundation

struct TextModeViewModel {
    var textMode: Observable<TextMode> = Observable(.summarize)
    
    init() { }
    
    func setTextMode(_ textMode: TextMode) {
        switch textMode {
        case .summarize:
            Logger.debug("Summarize Mode")
        case .original:
            Logger.debug("Original Mode")
        default: break
        }
        
        self.textMode.value = textMode
    }
}

enum TextMode: Int {
    case original
    case summarize
}
