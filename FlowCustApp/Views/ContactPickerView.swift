//
//  ContactPickerView.swift
//  FlowCustApp
//
//  Created by Thana Priya on 18/04/1944 Saka.
//  Copyright © 1944 comorins. All rights reserved.
//

import SwiftUI
import Contacts

struct ContactPickerView: View {
    @State var contactList = [String]()
        var body: some View {
            VStack {
                if self.contactList.count > 0 {
                    ForEach(contactList, id: \.self){name in
                        Text(name)
                    }
                }
            }
            .onAppear {
                self.fetchAllContacts()
            }
        }
        
        func fetchSpecificContacts() {
            let store = CNContactStore()
            let keys = [CNContactGivenNameKey, CNContactPhoneNumbersKey] as [CNKeyDescriptor]
            let predicate = CNContact.predicateForContacts(matchingName: "Kate")
            do {
                let contact = try store.unifiedContacts(matching: predicate, keysToFetch: keys)
                print(contact)
            } catch {
                
            }
        }
        
        func fetchAllContacts() {
            let store = CNContactStore()
            let keys = [CNContactGivenNameKey, CNContactPhoneNumbersKey] as [CNKeyDescriptor]
            let fetchRequest = CNContactFetchRequest(keysToFetch: keys)
            do {
                try store.enumerateContacts(with: fetchRequest, usingBlock: {contact, result in
                    self.contactList.append(contact.givenName)
                    print(contact.givenName)
                    for number in contact.phoneNumbers {
                        switch number.label {
                        case CNLabelPhoneNumberMobile:
                            print("Mobile - \(number.value.stringValue)")
                        case CNLabelPhoneNumberMain:
                            print("Main - \(number.value.stringValue)")
                        default:
                            print("Other - \(number.value.stringValue)")
                        }
                    }
                })
            } catch {
                print("error")
            }
        }
}

struct ContactPickerView_Previews: PreviewProvider {
    static var previews: some View {
        ContactPickerView()
    }
}
