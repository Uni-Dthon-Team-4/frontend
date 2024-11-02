//
//  SearchTextField.swift
//  Frontend
//
//  Created by Jaeho Lee on 11/2/24.
//

import SwiftUI

struct SearchTextField: View {
    @Environment(SearchViewModel.self) private var viewmodel
    @FocusState private var isEditing
    @Binding var text: String
    
    var body: some View {
        HStack(spacing: 10) {
            TextField("궁금한 점을 물어보세요", text: $text)
                .focused($isEditing)
                .font(.Pretendard(size: 16, family: .Medium))
                .foregroundStyle(Color(.cOnSurface))
                .onSubmit(submit)
            HStack(spacing: 15) {
                if (!viewmodel.results.isEmpty) {
                    Button(action: viewmodel.resetMessages) {
                        Image(systemName: "plus.bubble.fill")
                    }
                    .tint(Color(.cPrimary))
                }
                Button(action: submit) {
                    Image(systemName: text.isEmpty ? "paperplane": "paperplane.fill")
                }
                .tint(Color(.cPrimary))
            }
        }
        .padding(EdgeInsets(top: 5, leading: 15, bottom: 5, trailing: 15))
        .frame(height: 55)
        .background()
        .disabled(viewmodel.results.last?.isLoading ?? false)
    }
    
    private func submit() {
        if isEditing {
            isEditing = false
        }
        viewmodel.search()
    }
}

#Preview {
    @Previewable @State var text = ""
    SearchTextField(text: $text)
        .environment(SearchViewModel())
}

