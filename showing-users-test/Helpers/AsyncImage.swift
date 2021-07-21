//
//  AsyncImage.swift
//  showing-users-test
//
//  Created by Iiro Alhonen on 21.07.21.
//

import SwiftUI

/// Custom Async image, since iOS 14 support is needed.
struct AsyncImage<Placeholder: View>: View {
    @StateObject private var imageLoader: ImageLoader
    private let placeholder: Placeholder
    
    init(url: URL, placeholder: Placeholder) {
        self.placeholder = placeholder
        _imageLoader = StateObject(wrappedValue: ImageLoader(url: url))
    }
    
    var body: some View {
        image.onAppear(perform: imageLoader.load)
    }
    
    /// The async image being shown,
    private var image: some View {
        Group {
            if imageLoader.image != nil {
                Image(uiImage: imageLoader.image!)
                    .resizable()
            } else {
                placeholder
            }
        }
    }
}

