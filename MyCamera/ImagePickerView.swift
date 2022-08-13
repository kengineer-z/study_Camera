//
//  ImagePickerView.swift
//  MyCamera
//
//  Created by 財津賢一郎 on 2022/08/13.
//

import SwiftUI

struct ImagePickerView: UIViewControllerRepresentable {
    
    //写真撮影が表示されているかを管理
    //Binding は双方向にデータ連動ができるようにする構造体
    @Binding var isShowSheet : Bool
    //撮影した写真を格納する変数
    @Binding var captureImage : UIImage?
    
    class Coordinator : NSObject,
    UINavigationControllerDelegate,
                        UIImagePickerControllerDelegate{
        //ImagePickerView型の定数を用意
        let parent : ImagePickerView
        
        //イニシャライザ
        init(_ parent: ImagePickerView){
            self.parent = parent
        }
        //撮影が終わっときに呼ばれるdelegateメソッド,必ず必要
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            //撮影した写真をcaptureImageに保存
            if let originalImage =
                info[UIImagePickerController.InfoKey.originalImage]
                as? UIImage{
                parent.captureImage = originalImage
            }
            //sheetを閉じる
            parent.isShowSheet = false
        }
        
        //キャンセルボタンが選択されたときに呼ばれる
        //delegateメソッド、必ず必要
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            //sheetを閉じる
            parent.isShowSheet = false
        }
    }//Cordinator はここまで
    
    //Coordinatorを生成、SwiftUIによって自動的に呼び出し
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    //Viewを生成するときに実行
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePickerView>) -> UIImagePickerController {
        //UIImagePickerControllerのインスタンスを生成
        let myImagePickerCOntroller = UIImagePickerController()
        
        //sourceTypeにcameraを設定
        myImagePickerCOntroller.sourceType = .camera
        //delegate設定
        myImagePickerCOntroller.delegate = context.coordinator
        
        //UIImagePickerCOntrollerを返す
        return myImagePickerCOntroller
    }
    
    //Viewが更新されたときに実行
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePickerView>) {
        //処理なし
    }
    
}



