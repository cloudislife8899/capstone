//  EditPatientView.swift
//  final-year-capstone
//
//  Created by Michael Wang on 2023-03-09.
//

import SwiftUI
import UniformTypeIdentifiers
import SceneKit

struct EditPatientView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @Environment(\.dismiss) var dismiss
    
    var patient: FetchedResults<Patient>.Element
    
    @State private var showingConfirmationAlert = false
    @State private var openFile = false
    
    @State private var first_name = ""
    @State private var last_name = ""
    @State private var notes = ""
    @State private var isEditing = false
    
    @State private var file = URL(filePath: "")
    
    var body: some View {
        VStack {
            Form {
                Section(header: Text("First Name")) {
                    if isEditing {
                        TextField("First Name", text: $first_name)
                            .onAppear {
                                first_name = patient.first_name!
                            }
                    } else {
                        Text(patient.first_name ?? "")
                    }
                }
                
                Section(header: Text("Last Name")) {
                    if isEditing {
                        TextField("Last Name", text: $last_name)
                            .onAppear {
                                last_name = patient.last_name!
                            }
                    } else {
                        Text(patient.last_name ?? "")
                    }
                }
                
                Section(header: Text("File")) {
                    let stored_file = patient.file_url ?? URL(filePath: "")
                    
                    
                    if(stored_file.relativePath.count > 1) {
                        let scene = try! SCNScene(url: stored_file, options: nil)
                        HStack {
                            SceneView(scene: scene, options: [.autoenablesDefaultLighting, .allowsCameraControl])
                                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 2)
                                .background(Color.black)
                        }
                    } else {
                        HStack {
                            Spacer()
                            Button("Select STL file") {
                                self.openFile = true
                            }.fileImporter(isPresented: $openFile, allowedContentTypes: [UTType(filenameExtension: "stl")!]) { (res) in
                                do {
                                    file = try res.get()
                                    print(file)
                                    
                                } catch {
                                    print("Error loading file")
                                }
                            }
                            
                            Spacer()
                        }
                    }
                }
                
                Section(header: Text("Notes")) {
                    if isEditing {
                        TextEditor(text: $notes)
                            .frame(height: 100)
                            .onAppear {
                                notes = patient.notes ?? ""
                            }
                    } else {
                        Text(patient.notes ?? "")
                    }
                }
                
            }
            
            if isEditing {
                HStack(spacing: 10) {
                    Button(action: {
                        dismiss()
                    }) {
                        Text("Cancel")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding()
                            .background(Color.gray)
                            .cornerRadius(10)
                    }
                    .padding([.top, .leading])
                    .frame(maxWidth: .infinity / 2)
                    
                    Button(action: {
                        showingConfirmationAlert = true
                    }) {
                        Text("Save")

                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    .padding([.top, .trailing])
                    .frame(maxWidth: .infinity / 2)
                }
                .alert(isPresented: $showingConfirmationAlert) {
                    Alert(
                        title: Text("Save Changes?"),
                        message: Text("Are you sure you want to save these changes?"),
                        primaryButton: .default(Text("Save")) {
                            DataController().editPatient(patient: patient, first_name: first_name, last_name: last_name, notes: notes, context: managedObjContext)
                            dismiss()
                        },
                        secondaryButton: .cancel(Text("Cancel"))
                    )
                }
                .navigationBarBackButtonHidden(true)
            } else {
                Button(action: {
                    isEditing = true
                }) {
                    Text("Edit")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding([.top, .leading, .trailing])
            }
        }
        .navigationTitle("Edit Patient")
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
    }
}
