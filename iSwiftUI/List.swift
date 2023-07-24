//
//  List.swift
//  iSwiftUI
//
//  Created by admin on 2023/7/8.
//

import Foundation
import SwiftUI

struct StudentClass : Identifiable, Hashable {
    let id = UUID()
    let name: String
}

struct StudentModel : Identifiable,  Hashable {
    let id = UUID()
    let name: String
    let age: String
    let avatar: String
    
}

struct StudentRegion: Identifiable, Hashable {
    let id = UUID()
    let studentClass:StudentClass
    let students:[StudentModel]
}

var dataSourceWithClass:[StudentRegion] = [
    StudentRegion(studentClass: StudentClass(name: "一班"),
                  students:[StudentModel(name:"李雷",age:"8",avatar:"lilei"),
                            StudentModel(name:"露西",age:"7",avatar: "luc"),
                            StudentModel(name:"小明",age:"7",avatar:"xiaom")]),
    StudentRegion(studentClass: StudentClass(name: "二班"),
                  students:[StudentModel(name:"上官",age:"8",avatar:"sg"),
                            StudentModel(name:"大乔",age:"7",avatar: "luc"),
                            StudentModel(name:"亚瑟",age:"7",avatar:"dy")])
]


struct ListHeader : View {
    let className : String
    var body: some View {
        VStack {
            Text("三年\(className)").position(x:60, y:150).font(.system(size: 24, weight: .bold))
                .foregroundColor(.white)
        }
        .background(
            Image("head").resizable().frame(width: UIScreen.main.bounds.width, height: 180)
        ).frame(width: UIScreen.main.bounds.width, height: 180)
        
    }
}

struct ListRow:View {
    var student:StudentModel
    var body: some View {
        HStack(spacing: 15, content: { 
            Image(student.avatar)
                .resizable()
                .frame(width: 50, height: 50)
                .cornerRadius(CGFloat(5))
            VStack(alignment: .leading, spacing: 10, content: { 
                let name = "姓名" + student.name
                Text(name)
                
                let age = "年龄" + student.age
                Text(age)
                    .foregroundColor(.gray)
                    .font(.system(size: 16))
                Spacer()
            }).frame(height: 60)
        })
    }
}


struct ListTest : View {
    @State private var multiSelection = Set<UUID>()
    @State private var _showAlert = false
    @State private var tapVal = ""
    var body: some View {
        NavigationView { 
            VStack{
                List {
                    ForEach(dataSourceWithClass) { region in
                        
                        Section(header:ListHeader(className: region.studentClass.name)) { 
                                ForEach(region.students) { student in
                                    HStack{
                                        ListRow(student: student)
//                                        Spacer()
                                    }//make 
                                    .contentShape(Rectangle())
                                    .frame(maxWidth:.infinity, minHeight:64, alignment:.leading)
                                    .onTapGesture {
                                        self._showAlert = true
                                        self.tapVal = student.name
                                    }.alert(isPresented: $_showAlert, content: {
                                        Alert(title: Text(self.tapVal))
                                    })
                                    
//                                    .listRowInsets(EdgeInsets())
//                                    .background(Color.white)
//                                    .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 0))
                                }
                            }
                    }
                }
                .navigationTitle("人员管理")
//                .toolbar { 
//                    EditButton()
//                }
//                .onSubmit {
//                    
//                }
                
                Text("\(multiSelection.count) selections" )
                let _ = print("selctions: \(multiSelection)")
            }
        }
        
        
    } 
}

struct ListTest_Previews: PreviewProvider {
    static var previews: some View {
        ListTest()
    }
}
