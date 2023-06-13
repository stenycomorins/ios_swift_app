//
//  ImagPickerView.swift
//  FlowCustApp
//
//  Created by Thana Priya on 18/04/1944 Saka.
//  Copyright © 1944 comorins. All rights reserved.
//

import SwiftUI

struct ImagePicker: View {
    
        @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
        @State private var selectedImage: UIImage?
        @State private var isImagePickerDisplay = false
       
       func checkpermission() {
           if UIImagePickerController.isSourceTypeAvailable(.camera) {
               self.isImagePickerDisplay.toggle()
               return
           }else{
               print("There is no camera on this device")
           }
       }
           
           var body: some View {
                   VStack {
                       if selectedImage != nil {
                           Image(uiImage: selectedImage!)
                               .resizable()
                               .aspectRatio(contentMode: .fit)
                               .clipShape(Circle())
                               .frame(width: 300, height: 300)
                       } else {
                           Image(systemName: "snow")
                               .resizable()
                               .aspectRatio(contentMode: .fit)
                               .clipShape(Circle())
                               .frame(width: 300, height: 300)
                       }
                       Button("Camera") {
                           self.sourceType = .camera
                           self.checkpermission()
                       }.padding()
                       Button("photo") {
                           self.sourceType = .photoLibrary
                           self.isImagePickerDisplay.toggle()
                       }.padding()
                   }
                   .sheet(isPresented: self.$isImagePickerDisplay) {
                       ImagePickerView(selectedImage: self.$selectedImage, sourceType: self.sourceType)
                   }
                   
           }
}

struct ImagPickerView_Previews: PreviewProvider {
    static var previews: some View {
        ImagePicker()
    }
}
