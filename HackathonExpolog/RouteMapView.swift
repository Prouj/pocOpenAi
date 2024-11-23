//import SwiftUI
//import MapKit
//
//struct RouteMapView: UIViewRepresentable {
//    var departure: String
//    var addresses: [String]
//    
//    class Coordinator: NSObject, MKMapViewDelegate {
//        var parent: RouteMapView
//        var mapView: MKMapView
//        
//        init(parent: RouteMapView) {
//            self.parent = parent
//            self.mapView = MKMapView()
//        }
//        
//        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
//            if let polyline = overlay as? MKPolyline {
//                let renderer = MKPolylineRenderer(polyline: polyline)
//                renderer.strokeColor = .blue
//                renderer.lineWidth = 4.0
//                return renderer
//            }
//            return MKOverlayRenderer(overlay: overlay)
//        }
//        
//        func plotRoute(with coordinates: [CLLocationCoordinate2D]) {
//            guard coordinates.count > 1 else { return }
//            
//            let request = MKDirections.Request()
//            request.source = MKMapItem(placemark: MKPlacemark(coordinate: coordinates.first!))
//            request.destination = MKMapItem(placemark: MKPlacemark(coordinate: coordinates.last!))
//            request.transportType = .automobile
//            
//            // Adicionar pontos intermediários
//            let waypoints = coordinates.dropFirst().dropLast().map {
//                MKMapItem(placemark: MKPlacemark(coordinate: $0))
//            }
//            request.requestsAlternateRoutes = false
//            
//            // Configura rota
//            let directions = MKDirections(request: request)
//            directions.calculate { response, error in
//                if let route = response?.routes.first {
//                    DispatchQueue.main.async {
//                        self.mapView.addOverlay(route.polyline)
//                        self.mapView.setVisibleMapRect(route.polyline.boundingMapRect, edgePadding: UIEdgeInsets(top: 50, left: 50, bottom: 50, right: 50), animated: true)
//                    }
//                } else if let error = error {
//                    print("Erro ao calcular rota: \(error.localizedDescription)")
//                }
//            }
//        }
//        
//        func addAnnotations(for coordinates: [CLLocationCoordinate2D]) {
//            mapView.removeAnnotations(mapView.annotations)
//            for (index, coordinate) in coordinates.enumerated() {
//                let annotation = MKPointAnnotation()
//                annotation.coordinate = coordinate
//                annotation.title = index == 0 ? "Partida" : (index == coordinates.count - 1 ? "Destino" : "Parada \(index)")
//                mapView.addAnnotation(annotation)
//            }
//        }
//    }
//    
//    func makeCoordinator() -> Coordinator {
//        Coordinator(parent: self)
//    }
//    
//    func makeUIView(context: Context) -> MKMapView {
//        let mapView = context.coordinator.mapView
//        mapView.delegate = context.coordinator
//        
//        calculateCoordinates { coordinates in
//            context.coordinator.addAnnotations(for: coordinates)
//            context.coordinator.plotRoute(with: coordinates)
//        }
//        
//        return mapView
//    }
//    
//    func updateUIView(_ uiView: MKMapView, context: Context) {}
//    
//    private func calculateCoordinates(completion: @escaping ([CLLocationCoordinate2D]) -> Void) {
//        let geocoder = CLGeocoder()
//        var results: [CLLocationCoordinate2D] = []
//        let group = DispatchGroup()
//        
//        let allAddresses = [departure] + addresses
//        
//        for address in allAddresses {
//            group.enter()
//            geocoder.geocodeAddressString(address) { placemarks, error in
//                if let location = placemarks?.first?.location {
//                    results.append(location.coordinate)
//                }
//                group.leave()
//            }
//        }
//        
//        group.notify(queue: .main) {
//            completion(results)
//        }
//    }
//}
//
//struct RouteScreen: View {
//    @Environment(\.presentationMode) var presentationMode
//    var departure: String
//    var addresses: [String]
//    
//    var body: some View {
//        VStack {
//            RouteMapView(departure: departure, addresses: addresses)
//                .edgesIgnoringSafeArea(.all)
//            
//            HStack {
//                Button("Voltar") {
//                    presentationMode.wrappedValue.dismiss()
//                }
//                .padding()
//                .background(Color.blue)
//                .foregroundColor(.white)
//                .cornerRadius(10)
//                
//                Spacer()
//                
//                Button("Compartilhar") {
//                    shareRoute()
//                }
//                .padding()
//                .background(Color.green)
//                .foregroundColor(.white)
//                .cornerRadius(10)
//            }
//            .padding()
//        }
//    }
//    
//    private func shareRoute() {
//        // Compartilhar rota implementado aqui
//    }
//}
