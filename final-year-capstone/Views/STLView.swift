//
//  STLView.swift
//  final-year-capstone
//
//  Created by Elizabeth Lin on 2023-04-17.
//

import SwiftUI
import SceneKit

struct STLView: View {
    let file: URL
    
    @State private var selection = 0
    
    var body: some View {
        
        
        do {
            let scene = try SCNScene(url: file, options: nil)
            
            let sceneView = SceneView(scene: scene, options: [.autoenablesDefaultLighting, .allowsCameraControl])
                .frame(width: UIScreen.main.bounds.width, height: 2 * UIScreen.main.bounds.height / 3)
                .background(Color.white)
            
            var prev = SCNVector3(4.17225966, 20.1632412, -15.0000000)
            let splinePoints = [
                
                SCNVector3(1.62172415, 18.4681970, -14.0000000),
                SCNVector3(1.20844561, 17.5518858, -13.0000000),
                SCNVector3(0.46379353, 16.3351962, -12.0000000),
                SCNVector3(-0.0155074, 13.4352227, -11.0000000),
                SCNVector3(-0.4751215, 8.40532763, -10.0000000),
                SCNVector3(-0.1569978, 4.75498275, -9.0000000),
                SCNVector3(-0.2306814, 3.26393936, -8.0000000),
                SCNVector3(-0.2249139, 2.46430989, -7.0000000),
                SCNVector3(0.09850481, 1.80702241, -6.0000000),
                SCNVector3(0.39308064, 1.27782494, -5.0000000),
                SCNVector3(0.43053679, 0.81857001, -4.0000000),
                SCNVector3(0.84142952, 0.43370895, -3.0000000),
                SCNVector3(0.65858874, 0.19021775, -2.0000000),
                SCNVector3(0.52274005, 0.08343779, -1.0000000),
                SCNVector3(0.56891627, 0.03375823, 0.0000000),
                SCNVector3(0.06616280, 0.06158132, 1.0000000),
                SCNVector3(0.38449042, 0.19288681, 2.0000000),
                SCNVector3(0.10876176, 0.37709126, 3.0000000),
                SCNVector3(0.15072638, 0.59026930, 4.0000000),
                SCNVector3(-0.0791984, 0.84273433, 5.0000000),
                SCNVector3(-0.3182004, 1.19288462, 6.0000000),
                SCNVector3(0.36934354, 1.60997639, 7.0000000),
                SCNVector3(0.40578376, 2.06334673, 8.0000000),
                SCNVector3(0.48919168, 2.54976299, 9.0000000),
                SCNVector3(0.64060665, 3.14200571, 10.0000000),
                SCNVector3(0.35780794, 3.85147585, 11.0000000),
                SCNVector3(0.66874151, 4.61747175, 12.0000000),
                SCNVector3(0.61753725, 5.44059855, 13.0000000),
                SCNVector3(1.11020080, 6.38181511, 14.0000000),
                SCNVector3(1.24229491, 7.38701016, 15.0000000),
                SCNVector3(0.92948318, 8.37228403, 16.0000000),
                SCNVector3(1.05620564, 9.33572528, 17.0000000),
                SCNVector3(1.21585459, 10.2355550, 18.0000000),
                SCNVector3(1.38030090, 11.1261166, 19.0000000),
                SCNVector3(1.50522973, 11.9924895, 20.0000000),
                SCNVector3(1.61023910, 12.8466698, 21.0000000),
                SCNVector3(1.45524666, 13.6616489, 22.0000000),
                SCNVector3(1.59990021, 14.4441189, 23.0000000),
                SCNVector3(1.71831492, 15.2239397, 24.0000000),
                SCNVector3(2.15337577, 16.0261913, 25.0000000),
                SCNVector3(2.22566082, 16.8883223, 26.0000000),
                SCNVector3(2.33476427, 17.8080775, 27.0000000),
                SCNVector3(2.26033448, 18.7442524, 28.0000000),
                SCNVector3(2.31407105, 19.7192068, 29.0000000),
                SCNVector3(2.36952151, 20.7455675, 30.0000000),
                SCNVector3(2.60736189, 21.7421945, 31.0000000),
                SCNVector3(2.75168920, 22.5981015, 32.0000000),
                SCNVector3(2.80055147, 23.3307061, 33.0000000),
                SCNVector3(2.75962829, 23.9546737, 34.0000000),
                SCNVector3(2.89229742, 24.4890599, 35.0000000),
                SCNVector3(2.89366025, 24.9534182, 36.0000000),
                SCNVector3(2.37971758, 25.3170113, 37.0000000),
                SCNVector3(2.58483852, 25.5488267, 38.0000000),
                SCNVector3(2.38937898, 25.7022502, 39.0000000),
                SCNVector3(2.22526901, 25.8004665, 40.0000000),
                SCNVector3(2.16797598, 25.8288446, 41.0000000)
            ]

            for val in splinePoints {
                let vertices: [SCNVector3] = [prev, val]
                let vertexSource = SCNGeometrySource(vertices: vertices)
                prev = val
                let indices: [Int32] = [0, 1]
                let element = SCNGeometryElement(indices: indices, primitiveType: .line)
                let line = SCNGeometry(sources: [vertexSource], elements: [element])
                let lineNode = SCNNode(geometry: line)
                scene.rootNode.addChildNode(lineNode)
        
                let boxGeometry = SCNBox(width: 0.2, height: 0.2, length: 0.2, chamferRadius: 0)

                let mat = SCNMaterial()
                mat.diffuse.contents = UIColor.blue
                boxGeometry.firstMaterial = mat

                let boxNode = SCNNode(geometry: boxGeometry)

                boxNode.position = SCNVector3Make(val.x,val.y,val.z)

                scene.rootNode.addChildNode(boxNode)
            }
            
            return AnyView(
                VStack {
                    Text("Patient Nasal Symmetry")
                    .font(.headline)
                    .padding(.vertical)
                    sceneView
                    HStack {
                        Picker(selection: $selection, label: Text("Select a view")) {
                            Text("Face").tag(0)
                            Text("Nose").tag(1)
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .padding(.horizontal)
                    }
                    Spacer()
                }
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        HStack {
                            Image("logo")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30, height: 30)
                            Text("NaSYM Surgical")
                                .font(.headline)
                                .foregroundColor(.primary)
                        }
                    }
                }
            )
        } catch {
            return AnyView(Text("Error: \(error.localizedDescription)"))
        }
    }
}
