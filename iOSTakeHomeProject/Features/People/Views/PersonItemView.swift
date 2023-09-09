//
//  PersonItemView.swift
//  iOSTakeHomeProject
//
//  Created by Muhammad Saeed on 30/08/2023.
//

import SwiftUI

struct PersonItemView: View {
    
    let user: User
    
    var body: some View {
        VStack(spacing: .zero) {
            AsyncImage(url: .init(string: user.avatar)) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(height: 130)
                    .clipped()
            } placeholder: {
                Rectangle()
                    .foregroundColor(.gray.opacity(0.1))
                    .background {
                        ProgressView()
                    }
                    .frame(height: 130)
                
            }

            
            VStack(alignment: .leading) {
                
                PillView(id: user.id )
                
                Text("\(user.firstName) \(user.lastName)")
                    .foregroundColor(Theme.text)
                    .font(
                        .system(.body, design: .rounded)
                    )
                
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 8)
            .padding(.vertical, 5)
            .background(Theme.detailBackground)
            
        }
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .shadow(color: Theme.text.opacity(0.1),
                radius: 2,
                x: 0,
                y: 1)
    }
}

struct PersonItemView_Previews: PreviewProvider {
    
    static var previewUser: User {
        let users = try! StaticJSONMapper.decode(file: "UsersStaticData", type: UsersResponse.self)
        return users.data.first!
    }
    
    static var previews: some View {
        PersonItemView(user: previewUser)
            .frame(width: 220)
    }
}
