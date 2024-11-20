
import SwiftUI

struct CustomAlertOfOptions: View {
    var optionOne: String
    var optionSecond: String
    @SwiftUI.State private var optionOneSelected: Bool = true
    @SwiftUI.State private var optionSecondSelected: Bool = false
    var completionHander: (_ optionSelected: Int) -> Void
    @Binding var showAlert: Bool
    
    var body: some View {
        ZStack{
            SwiftUI.Color(.black)
                .opacity(0.3)
            
            VStack(alignment: .leading){
                VStack(alignment: .leading, spacing: 30){
                    Button{
                        optionOneSelected = true
                        optionSecondSelected = false
                    } label: {
                        HStack{
                            Image(systemName: optionOneSelected ? "record.circle" : "circle")
                                .foregroundStyle(optionOneSelected ? .blue : .gray)
                                .font(.title3)
                            Text(optionOne)
                                .foregroundStyle(.black)
                        }
                    }
                    
                    Button{
                        optionSecondSelected = true
                        optionOneSelected = false
                    } label: {
                        HStack{
                            Image(systemName: optionSecondSelected ? "record.circle" : "circle")
                                .font(.title3)
                                .foregroundStyle(optionSecondSelected ? .blue : .gray)
                            Text(optionSecond)
                                .foregroundStyle(.black)
                        }
                    }
                }
                .padding(.horizontal, 30)
                .padding(.vertical, 30)
                
                HStack{
                    Spacer()
                    
                    Button("Cancel"){
                        withAnimation{
                            showAlert = false
                        }
                    }
                    .foregroundStyle(.gray)
                    .padding()
                    
                    Button("Apply"){
                        withAnimation{
                            showAlert = false
                        }
                        completionHander(optionOneSelected ? 1 : 2)
                    }
                    
                }
                .padding(.trailing, 30)
                .padding(.bottom, 20)
                
            }
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 28))
            .shadow(radius: 20)
            .padding(.horizontal, 40)
        }
        .ignoresSafeArea(.all)
    }
}


struct CustomAlertOfTextView: View {
    @SwiftUI.State private var text: String = ""
    @Binding var showAlert: Bool
    @FocusState private var isFocused: Bool
    
    var completionHandler: (String) -> Void
    
    var body: some View {
        ZStack{
            SwiftUI.Color(.black)
                .opacity(0.3)
                .onTapGesture {
                    isFocused = false
                }
            
            VStack(alignment: .leading){
                Text("Remarks")
                    .padding()
                
                TextField("Comment", text: $text, prompt: Text("Write your comment here..."), axis: .vertical)
                    .focused($isFocused)
                    .lineLimit(6...6)
                    .frame(maxWidth: .infinity, maxHeight: 150)
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                    .overlay {
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(SwiftUI.Color.gray.opacity(0.5), lineWidth: 0.5)
                    }
                    .foregroundStyle(.secondary)
                    .background(.gray.opacity(0.05))
                    .padding(.horizontal)
                
                HStack(spacing: 20){
                    Button("Go Back"){
                        withAnimation{
                            showAlert = false
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(EdgeInsets(top: 13, leading: 0, bottom: 13, trailing: 0))
                    .background(.gray.opacity(0.2))
                    .foregroundStyle(.black)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                    Button("Cancel Visit"){
                        withAnimation{
                            showAlert = false
                        }
                        completionHandler(text)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(EdgeInsets(top: 13, leading: 0, bottom: 13, trailing: 0))
                    .background(.red)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                .frame(maxWidth: .infinity)
                .padding()
                
            }
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(radius: 20)
            .padding(.horizontal, 40)
            .onTapGesture {
                isFocused = false
            }
        }
        .ignoresSafeArea()
    }
}
