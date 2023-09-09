//
//  SettingsView.swift
//  iOSTakeHomeProject
//
//  Created by Muhammad Saeed on 02/09/2023.
//

import SwiftUI

struct SettingsView: View {
    
    @AppStorage(UserDefaultsKeys.hapticsEnabled) private var isHapticsEnabled = true
    
    var body: some View {
        NavigationStack {
            Form {
                toggle
            }
            .navigationTitle("Settings")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

private extension SettingsView {
    var toggle: some View {
        Toggle("Enable Haptics", isOn: $isHapticsEnabled)
    }
}
