//
//  AddPatientView.swift
//  final-year-capstone
//
//  Created by Michael Wang on 2023-02-16.
//

import SwiftUI
import UniformTypeIdentifiers
import SceneKit

struct AddPatientView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @Environment(\.dismiss) var dismiss
    
    @State private var openFile = false
    
    @State private var first_name = ""
    @State private var last_name = ""
    @State private var notes = ""
    @State private var file = ""
    
    @State private var showingConfirmationAlert = false
    
    var body: some View {
        NavigationView {
            VStack {
                HStack(spacing: 10) {
                    Image("logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30)
                    Text("NaSYM Surgical")
                        .font(.title3)
                        .foregroundColor(.primary)
                        .padding(.vertical)
                }
                
                Form {
                    
                    Section(header: Text("First Name")) {
                        TextField("First Name", text: $first_name)
                    }
                    
                    Section(header: Text("Last Name")) {
                        TextField("Last Name", text: $last_name)
                    }
                    
                    Section(header: Text("File")) {
                        HStack {
                            Spacer()
                            Button("Select STL file") {
                                self.openFile = true
                            }.fileImporter(isPresented: $openFile, allowedContentTypes: [UTType(filenameExtension: "stl")!]) { (res) in
                                do {
                                    let fileUrl = try res.get()
                                    print(fileUrl)
                                    
                                } catch {
                                    print("Error loading file")
                                }
                            }
                            
                            Spacer()
                        }
                    }
                    
                    Section(header: Text("Notes")) {
                        TextEditor(text: $notes)
                            .frame(height: 100)
                    }
                }
                
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
                    .alert(isPresented: $showingConfirmationAlert) {
                        Alert(
                            title: Text("New Patient Created!"),
                            message: Text("A new patient has been created. You can now view their nasal symmetry."),
                            primaryButton: .default(Text("Home")) {
                                DataController().addPatient(first_name: first_name, last_name: last_name, notes: notes, context: managedObjContext)
                                dismiss()
                            },
                            secondaryButton: .default(Text("View")) {
                                DataController().addPatient(first_name: first_name, last_name: last_name, notes: notes, context: managedObjContext)
                                dismiss()
                            }
                        )
                    }
                }
                .navigationBarTitle("", displayMode: .inline)
            }
        }
    }
    
    struct AddPatientView_Previews: PreviewProvider {
        static var previews: some View {
            AddPatientView()
        }
    }
}
