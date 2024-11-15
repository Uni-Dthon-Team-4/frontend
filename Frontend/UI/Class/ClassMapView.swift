//
//  ClassMapView.swift
//  Frontend
//
//  Created by Jaeho Lee on 11/3/24.
//

import SwiftUI
import MapKit

struct ClassMapView: View {
    @State private var region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 37.5665, longitude: 126.9780), // 서울의 중심 좌표
            span: MKCoordinateSpan(latitudeDelta: 0, longitudeDelta: 0) // 지도 확대/축소 수준
        )
    @State var selection: ClassLocation?
    
    var body: some View {
        Map(bounds: MapCameraBounds(centerCoordinateBounds: region, minimumDistance: 13000, maximumDistance: 15000)) {
            ForEach(ClassLocation.examples) { location in
                Annotation(location.title, coordinate: location.cooridnator, anchor: .bottom) {
                    ClassPin(location: location)
                        .onTapGesture {
                            selectLocation(location)
                        }
                }
            }
        }
        .mapControlVisibility(.visible)
        .overlay(alignment: .bottom) {
            if let selection {
                ClassDetailView(location: selection)
                    .id(selection.id)
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                    .padding(EdgeInsets(top: 5, leading: 15, bottom: 15, trailing: 15))
            }
        }
        .safeAreaInset(edge: .top) {
            Label("내 주변 클래스를 확인해보세요", systemImage: "location.fill")
                .font(.Pretendard(size: 12, family: .Medium))
                .foregroundStyle(Color(.cOnSecondary))
                .padding(EdgeInsets(top: 7, leading: 13, bottom: 7, trailing: 13))
                .background(Color(.cSecondary), in: Capsule())
        }
    }
    
    private func selectLocation(_ location: ClassLocation) {
        withAnimation {
            selection = selection?.id == location.id ? nil : location
        }
    }
}

#Preview {
    ClassMapView()
}
