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
    @Environment (\.managedObjectContext) var managedObjContext
    @Environment (\.dismiss) var dismiss
    
    @State private var openFile = false
    
    @State private var first_name = ""
    @State private var last_name = ""
    @State private var notes = ""
    @State private var file = ""

    var body: some View {
        Form {
            Section(header: Text("First Name")) {
                TextField("Enter First Name", text: $first_name)
            }
            
            Section(header: Text("Last Name")) {
                TextField("Enter Last Name", text: $last_name)
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
            
            Section() {
                HStack {
                    Spacer()
                    Button("Submit") {
                        DataController().addPatient(first_name: first_name, last_name: last_name, notes: notes, context: managedObjContext)
                        dismiss()
                    }
                    Spacer()
                }
            }
            
            Section() {
                HStack {
                    Spacer()
                    Button("Cancel") {
                        dismiss()
                    }
                    Spacer()
                }
            }
        }
    }
}

struct AddPatientView_Previews: PreviewProvider {
    static var previews: some View {
        AddPatientView()
    }
}
