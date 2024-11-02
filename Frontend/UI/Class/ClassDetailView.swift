//
//  ClassDetailView.swift
//  Frontend
//
//  Created by Jaeho Lee on 11/3/24.
//

import SwiftUI

struct ClassDetailView: View {
    var location: ClassLocation
    
    var body: some View {
        HStack(spacing: 6) {
            AsyncImage(url: URL(string: location.imageURL)) { content in
                content.resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
            } placeholder: {
                RoundedRectangle(cornerRadius: 15)
            }
            .frame(width: 100, height: 100)
            VStack(alignment: .leading, spacing: 4) {
                Text(location.title)
                    .foregroundStyle(Color(.cOnSurface))
                    .font(.Pretendard(size: 20, family: .SemiBold))
                Text(location.description)
                    .foregroundStyle(Color(.cOnSurface))
                    .font(.Pretendard(size: 16, family: .Medium))
                Label(location.location, systemImage: "location")
                    .foregroundStyle(Color(.cPrimary))
                    .font(.Pretendard(size: 14, family: .Medium))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(EdgeInsets(top: 8, leading: 15, bottom: 8, trailing: 15))
        }
        .background {
            RoundedRectangle(cornerRadius: 15)
                .foregroundStyle( Color(.cSurfaceContainer))
                .shadow(radius: 20)
        }
    }
}

#Preview {
    ClassMapView()
}
