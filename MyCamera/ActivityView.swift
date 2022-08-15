//
//  ActivityView.swift
//  MyCamera
//
//  Created by 財津賢一郎 on 2022/08/15.
//

import SwiftUI

struct ActivityView: UIViewControllerRepresentable {
    
    //UIActivityViewContoroller(シェア機能）でシェアする写真
    let shareItems : [Any]
    //表示するViewを生成するときに実行
    func makeUIViewController(context: Context) ->
    UIActivityViewController{
        
        //UIACtivityViewControllerでシャアする機能を生成
        let controller = UIActivityViewController(activityItems: shareItems, applicationActivities: nil)
        //UIActivityControllerを返す
        return controller
    }
    //Viewが更新された時に実行
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: UIViewControllerRepresentableContext<ActivityView>)
    {
        
    }
   
}

