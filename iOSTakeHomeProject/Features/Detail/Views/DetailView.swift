//
//  DetailView.swift
//  iOSTakeHomeProject
//
//  Created by Muhammad Saeed on 31/08/2023.
//

import SwiftUI

struct DetailView: View {
    
    let userId: Int
    
    @StateObject private var vm: DetailViewModel = DetailViewModel()
    
    var body: some View {
            ZStack {
                background
                
                if vm.isLoading {
                    ProgressView()
                } else {
                    ScrollView {
                        
                        VStack(alignment: .leading, spacing: 18) {
                            
                            avatar
                            
                            Group {
                                general
                                
                                link
                            }
                            .padding(.horizontal, 8)
                            .padding(.vertical, 18)
                            .background(Theme.detailBackground, in: RoundedRectangle(cornerRadius: 16))
                            
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Details")
            .task {
                await vm.fetchDetails(userId: userId)
            }
            .alert(isPresented: $vm.hasError, error: vm.error) { }
        }
}

struct DetailView_Previews: PreviewProvider {
    static var previewUserId: Int {
        let user = try! StaticJSONMapper.decode(file: "UsersStaticData", type: UsersResponse.self)
        
        return user.data.first!.id
    }
    
    static var previews: some View {
        DetailView(userId: previewUserId)
    }
}

private extension DetailView {
    var background: some View {
        Theme.background
            .ignoresSafeArea(edges: .top)
    }
    
    @ViewBuilder
    var avatar: some View {
        if
            let avatarAbsoluteString = vm.userInfo?.data.avatar,
            let avatarURL = URL(string: avatarAbsoluteString) {
            AsyncImage(url: avatarURL) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(height: 250)
                    .clipped()
            } placeholder: {
                Rectangle()
                    .foregroundColor(Color.gray.opacity(0.1))
                    .frame(height: 250)
                    .background {
                        ProgressView()
                    }
            }
            .clipShape(RoundedRectangle(cornerRadius: 16))

        }
    }
    
    @ViewBuilder
    var link: some View {
        if
            let supportAbsoluteString = vm.userInfo?.support.url,
            let supportURL = URL(string: supportAbsoluteString),
            let supportText = vm.userInfo?.support.text {
            
            Link(destination: supportURL) {
                VStack(alignment: .leading, spacing: 8) {
                    
                    Text(supportText)
                        .foregroundColor(Theme.text)
                        .font(
                            .system(.body, design: .rounded)
                            .weight(.semibold)
                        )
                        .multilineTextAlignment(.leading)
                    
                    Text(supportAbsoluteString)
                    
                }
                
                Spacer()
                
                Symbols.link
                    .font(.system(.title3,design: .rounded))
            }
            
        }
    }
}

private extension DetailView {
    
    var general: some View {
        VStack(alignment: .leading, spacing: 8) {
            PillView(id: vm.userInfo?.data.id ?? 0 )
            
            Group {
                firstName
                
                lastName
                
                email
            }
            .foregroundColor(Theme.text)
            
        }
    }
    
    @ViewBuilder
    var firstName: some View {
        Text("First Name")
            .font(
                .system(.body, design: .rounded)
                .weight(.semibold)
            )
        
        Text(vm.userInfo?.data.firstName ?? "-")
            .font(
                .system(.subheadline, design: .rounded)
            )
        
        Divider()
    }
    
    @ViewBuilder
    var lastName: some View {
        Text("Last Name")
            .font(
                .system(.body, design: .rounded)
                .weight(.semibold)
            )
        
        Text(vm.userInfo?.data.lastName ?? "-")
            .font(
                .system(.subheadline, design: .rounded)
            )
        
        Divider()
    }
    
    @ViewBuilder
    var email: some View {
        Text("Email")
            .font(
                .system(.body, design: .rounded)
                .weight(.semibold)
            )
        
        Text(vm.userInfo?.data.email ?? "-")
            .font(
                .system(.subheadline, design: .rounded)
            )
    }
}
