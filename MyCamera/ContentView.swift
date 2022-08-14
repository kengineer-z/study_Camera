//
//  ContentView.swift
//  MyCamera
//
//  Created by 財津賢一郎 on 2022/08/13.
//

import SwiftUI

struct ContentView: View {
    
    @State var captureImage : UIImage? = nil
    @State var isShowSheet = false
    
    var body: some View {
        VStack {
            Spacer()
            if let unwrapCaptureImage = captureImage{
                Image(uiImage: unwrapCaptureImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
            }
            Button(action: {
                
                //カメラ利用可能かチェック
                if UIImagePickerController.isSourceTypeAvailable(.camera)
                {
                    print("カメラは利用可能")
                    //カメラが使えるなら、isShowSheetをtrue
                    isShowSheet = true
                } else {
                    print("カメラは利用不可")
                }
                
            }){
                Text("カメラを起動する")
                    .frame(maxWidth:.infinity)
                    .frame(height: 50)
                    .multilineTextAlignment(.center)
                    .background(Color.blue)
                    .foregroundColor(Color.white)
            }
            .padding()
            //isPresentedで指定した状態変数がtrueのとき実行
            .sheet(isPresented: $isShowSheet){
                //UIImagePickerController(写真撮影）を表示
                ImagePickerView(isShowSheet: $isShowSheet, captureImage: $captureImage)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
