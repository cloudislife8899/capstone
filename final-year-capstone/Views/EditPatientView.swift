//
//  EditPatientView.swift
//  final-year-capstone
//
//  Created by Michael Wang on 2023-03-09.
//

import SwiftUI

struct EditPatientView: View {
    @Environment (\.managedObjectContext) var managedObjContext
    @Environment (\.dismiss) var dismiss
    
    var patient: FetchedResults<Patient>.Element
    
    @State private var first_name = ""
    @State private var last_name = ""
    @State private var notes = ""
    
    var body: some View {
        Form {
            Section(header: Text("First Name")) {
                TextField("Enter First Name", text: $first_name)
                    .onAppear {
                        first_name = patient.first_name!
                    }
            }
            
            Section(header: Text("Last Name")) {
                TextField("Enter First Name", text: $last_name)
                    .onAppear {
                        last_name = patient.last_name!
                    }
            }
            
            Section(header: Text("Notes")) {
                TextEditor(text: $notes)
                    .frame(height: 100)
                    .onAppear {
                        notes = patient.notes ?? ""
                    }
            }
            
            Section() {
                HStack {
                    Spacer()
                    Button("Submit") {
                        DataController().editPatient(patient: patient, first_name: first_name, last_name: last_name, notes: notes, context: managedObjContext)
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

