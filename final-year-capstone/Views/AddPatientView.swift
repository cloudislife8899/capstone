//
//  AddPatientView.swift
//  final-year-capstone
//
//  Created by Michael Wang on 2023-02-16.
//

import SwiftUI

struct AddPatientView: View {
    @Environment (\.managedObjectContext) var managedObjContext
    @Environment (\.dismiss) var dismiss
    
    @State private var first_name = ""
    @State private var last_name = ""
    @State private var notes = ""

    var body: some View {
        Form {
            Section(header: Text("First Name")) {
                TextField("Enter First Name", text: $first_name)
            }
            
            Section(header: Text("Last Name")) {
                TextField("Enter First Name", text: $last_name)
            }
            
            Section(header: Text("Notes")) {
                TextEditor(text: $notes)
                    .frame(height: 100)
            }
            
            HStack {
                Spacer()
                Button("Submit") {
                    
                }
                Spacer()
            }
        }
    }
}

struct AddPatientView_Previews: PreviewProvider {
    static var previews: some View {
        AddPatientView()
    }
}
