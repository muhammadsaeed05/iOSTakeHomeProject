//
//  CheckmarkPopoverView.swift
//  iOSTakeHomeProject
//
//  Created by Muhammad Saeed on 01/09/2023.
//

import SwiftUI

struct CheckmarkPopoverView: View {
    var body: some View {
        Symbols.checkmark
            .font(.system(.largeTitle, design: .rounded).bold())
            .padding()
            .background(.thinMaterial,
                        in: RoundedRectangle(cornerRadius: 16, style: .circular))
    }
}

struct CheckmarkPopoverView_Previews: PreviewProvider {
    static var previews: some View {
        CheckmarkPopoverView()
            .previewLayout(.sizeThatFits)
            .padding()
            .background(.blue)
    }
}
