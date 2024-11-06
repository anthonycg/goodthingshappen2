import SwiftData
import SwiftUI
import FirebaseAuth

struct FeedNoteView: View {
    var note: NoteRetrieved
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.champagnePink).ignoresSafeArea()
                ScrollView {
                    VStack {
                        Text(note.posttitle)
                            .scrollContentBackground(.hidden)
                            .foregroundColor(.black)
                            .textInputAutocapitalization(.sentences)
                            .font(.custom("HelveticaNeue", size: 48))
                            .frame(maxHeight: 200, alignment: .topLeading)
                            .padding()
                            .disabled(true)
                        
//                        if let imageData = note.imageUrl,
//                           let uiImage = UIImage(data: imageData) {
//                            Image(uiImage: uiImage)
//                                .resizable()
//                                .scaledToFill()
//                                .frame(maxWidth: .infinity, minHeight: 225, maxHeight: 225)
//                                .clipped()
//                                .cornerRadius(30)
//                                .padding(.bottom)
//                        }
                        Spacer()
                        
                        Text(note.postbody)
                            .scrollContentBackground(.hidden)
                            .foregroundColor(.black)
                            .textInputAutocapitalization(.sentences)
                            .font(.custom("HelveticaNeue", size: 20))
                            .frame(maxHeight: .infinity, alignment: .topLeading)
                            .padding(.horizontal)
                            .disabled(true)
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "xmark")
                            .foregroundColor(.black)
                    }
                }
            }
        }
    }
}
#Preview {
    // Create an example note
    let example = NoteRetrieved(id: "4242", posttitle: "Sample Title that has a bunch of text and this is eve", postbody: "Lorem ipsum odor amet, consectetuer adipiscing elit. Commodo maecenas maecenas pulvinar neque id dapibus sapien phasellus. Vulputate in erat conubia faucibus eu laoreet. Ligula justo diam facilisis congue, parturient tempor penatibus. Congue vel varius consectetur nisl urna lectus ipsum ultrices. Viverra eros mi eget vivamus nisi leo iaculis. Elementum id dui aliquam dignissim non quisque leo praesent.Ultricies parturient fusce; finibus et lacus vel malesuada ultrices. Eget gravida elementum ultricies, phasellus pulvinar lobortis. Mus egestas facilisis aliquet condimentum etiam vulputate diam. Cubilia adipiscing blandit cras, eleifend arcu volutpat ultrices venenatis praesent. Nullam volutpat viverra varius magnis mi. Facilisis elementum erat sociosqu in, habitant inceptos ultricies. Et facilisi at arcu elit ad, conubia eu at.", imageurl: "", publicpost: false, ownerid: UUID().uuidString, likes: [], createdat: "100", updatedat: "20", username: "Hello")
    
    // Configure the model container
    FeedNoteView(note: example)
        .modelContainer(for: [Note6.self], inMemory: true)
}
