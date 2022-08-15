//
//  ContentView.swift
//  MyCamera
//
//  Created by 財津賢一郎 on 2022/08/13.
//

import SwiftUI

struct ContentView: View {
    
    //撮影した写真を保持する状態変数
    @State var captureImage : UIImage? = nil
    //撮影　フォトライブラリー画面（sheet）の開閉状態を管理
    @State var isShowSheet = false
    //シェア画面の(sheet）の開閉状態を管理
    @State var isShowActivity = false
    //フォトラブラリーがカメラかを保持する状態状態変数
    @State var isPhotolibrary = false
    //選択画面(actionSheet) のsheet開閉状態を管理
    @State var isShowAction = false
    
    var body: some View {
        VStack {
            Spacer()
            if let unwrapCaptureImage = captureImage{
                Image(uiImage: unwrapCaptureImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
            }
            Spacer()
            //カメラを起動するボタン
            Button(action: {
                //ボタンをタップした時のアクション
                isShowAction = true
                
            }){
                Text("カメラを起動する")
                    .frame(maxWidth:.infinity)
                    .frame(height: 50)
                    .multilineTextAlignment(.center)
                    .background(Color.blue)
                    .foregroundColor(Color.white)
            }
            .padding()
            //sheetを表示
            //isPresentedで指定した状態変数がtrueのとき実行
            .sheet(isPresented: $isShowSheet){
                
                if isPhotolibrary{
                    //フォトライブラリーが選択された場合は、フォトライブラリーを表示
                    PHPickerView(isShowSheet: $isShowSheet,
                                 captureImage: $captureImage)
                }else {
                    //写真撮影が選択された場合は、写真選択を表示
                    ImagePickerView(isShowSheet: $isShowSheet,
                                    captureImage: $captureImage)
                }
            }//カメラを起動する　ボタンのsheetはここまで
            
            //状態変数：isShowActionに変化があったら実行
            .actionSheet(isPresented: $isShowAction) {
                ActionSheet(title: Text("確認"),
                            message: Text("選択して下さい"),
                            buttons: [
                                .default(Text("カメラ"), action: {
                                    //カメラを選択
                                    isPhotolibrary = false
                                    //カメラが利用可能かチェック
                                    if UIImagePickerController.isSourceTypeAvailable(.camera){
                                        print("カメラは利用できます")
                                        //カメラが使えるなら、isShowSheetをtrue
                                        isShowSheet = true
                                    }else {
                                        print("カメラは利用できません")
                                    }
                                }),
                                .default(Text("フォトラブラリー"),action: {
                                    //フォトライブラリーを選択
                                    isPhotolibrary = true
                                    //isShowSheetをtrue
                                    isShowSheet = true
                                }),
                                .cancel(),
                            ])
            }//actionシートはここまで
    
            
            //SNSに投稿するボタン
            Button(action:{
                //撮影した写真がある時だけ
                //UActivityViewController（シェア機能）を表示
                if let _ = captureImage {
                    isShowActivity = true
                }
                
            }){
                Text("SNSに投稿する")
                    .frame(maxWidth:.infinity)
                    .frame(height: 50)
                    .multilineTextAlignment(.center)
                    .background(Color.blue)
                    .foregroundColor(Color.white)
            }//SNSを投稿するボタン　ここまで
            .padding()
            //sheetを表示
            //isPresentedでして下状態変数がtrueのとき実行
            .sheet(isPresented: $isShowActivity){
                ActivityView(shareItems: [captureImage!])
            }
            
        }//VStackここまで
    }//bodyここまで
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
