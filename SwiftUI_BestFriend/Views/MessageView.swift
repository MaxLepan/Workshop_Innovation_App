import SwiftUI

struct BubbleUp: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0, y: height))
        path.addLine(to: CGPoint(x: 0.99949*width, y: height))
        path.addCurve(to: CGPoint(x: 0.90672*width, y: 0), control1: CGPoint(x: 0.999*width, y: 0.44678*height), control2: CGPoint(x: 0.95766*width, y: 0))
        path.addLine(to: CGPoint(x: 0.09277*width, y: 0))
        path.addCurve(to: CGPoint(x: 0, y: height), control1: CGPoint(x: 0.04183*width, y: 0), control2: CGPoint(x: 0.00048*width, y: 0.44678*height))
        path.closeSubpath()
        return path
    }
}

struct BubbleDown: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.04435*width, y: 0))
        path.addCurve(to: CGPoint(x: 0.05661*width, y: 0.50259*height), control1: CGPoint(x: 0.0445*width, y: 0.18333*height), control2: CGPoint(x: 0.04896*width, y: 0.355*height))
        path.addCurve(to: CGPoint(x: 0, y: 0.95739*height), control1: CGPoint(x: 0.04309*width, y: 0.7208*height), control2: CGPoint(x: 0.0232*width, y: 0.8842*height))
        path.addCurve(to: CGPoint(x: 0.02754*width, y: 1.00017*height), control1: CGPoint(x: 0.00877*width, y: 0.98505*height), control2: CGPoint(x: 0.01801*width, y: 1.00017*height))
        path.addCurve(to: CGPoint(x: 0.08245*width, y: 0.81959*height), control1: CGPoint(x: 0.04774*width, y: 1.00017*height), control2: CGPoint(x: 0.06656*width, y: 0.93402*height))
        path.addCurve(to: CGPoint(x: 0.13304*width, y: 1.00017*height), control1: CGPoint(x: 0.09681*width, y: 0.93334*height), control2: CGPoint(x: 0.11424*width, y: 1.00017*height))
        path.addLine(to: CGPoint(x: 0.9113*width, y: 1.00017*height))
        path.addCurve(to: CGPoint(x: width, y: 0), control1: CGPoint(x: 0.96001*width, y: 1.00017*height), control2: CGPoint(x: 0.99954*width, y: 0.5533*height))
        path.addLine(to: CGPoint(x: 0.04435*width, y: 0))
        path.closeSubpath()
        return path
    }
}

struct BubbleCenter: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.00011*width, y: 0))
        path.addLine(to: CGPoint(x: 0.99939*width, y: 0))
        path.addCurve(to: CGPoint(x: 0.9995*width, y: 0.13823*height), control1: CGPoint(x: 0.99946*width, y: 0.0458*height), control2: CGPoint(x: 0.9995*width, y: 0.09188*height))
        path.addLine(to: CGPoint(x: 0.9995*width, y: 0.86225*height))
        path.addCurve(to: CGPoint(x: 0.99939*width, y: height), control1: CGPoint(x: 0.9995*width, y: 0.90843*height), control2: CGPoint(x: 0.99946*width, y: 0.95436*height))
        path.addLine(to: CGPoint(x: 0.00011*width, y: height))
        path.addCurve(to: CGPoint(x: 0, y: 0.86225*height), control1: CGPoint(x: 0.00004*width, y: 0.95436*height), control2: CGPoint(x: 0, y: 0.90843*height))
        path.addLine(to: CGPoint(x: 0, y: 0.13823*height))
        path.addCurve(to: CGPoint(x: 0.00011*width, y: 0), control1: CGPoint(x: 0, y: 0.09188*height), control2: CGPoint(x: 0.00004*width, y: 0.0458*height))
        path.closeSubpath()
        return path
    }
}


struct ChatBubble: View {
    let text: String
    let isFromCurrentUser: Bool
    private let purpleColor = Color(red: 29/255, green: 2/255, blue: 61/255)
    
    var body: some View {
        VStack(spacing: 0) {
            BubbleUp()
                .fill(isFromCurrentUser ? purpleColor : .white)
                .frame(height: 20) // Fixed height for the upper part
                .padding([isFromCurrentUser ? .trailing : .leading], 13)
            Text(text)
                .padding(.horizontal)
                .foregroundColor(isFromCurrentUser ? .white : purpleColor)
                .frame(maxWidth: .infinity, minHeight: 60, alignment: .leading)
                .background(isFromCurrentUser ? purpleColor : .white)
                .padding([isFromCurrentUser ? .trailing : .leading], 13)
            BubbleDown()
                .fill(isFromCurrentUser ? purpleColor : .white)
                .scaleEffect(x: isFromCurrentUser ? -1 : 1, y: 1, anchor: .center) // Flip the bubble down based on the user
                .frame(height: 20) // Fixed height for the lower part with the tail
        }
    }
}

struct MessageView: View {
    var message: Message
    
    var body: some View {
        // Conteneur extérieur pour l'alignement de l'image de profil
        HStack(alignment: .bottom, spacing: 0) {
            // Image de profil pour les autres utilisateurs
            if !message.userName.elementsEqual("Joyce") {
                Image("IA_pp") // Remplacez par votre nom d'image de profil réel
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 68, height: 68)
                    .clipShape(Circle()) // Ajoutez ceci pour une image de profil ronde
            }
            
            // Conteneur pour le message et la bulle de chat
            VStack(alignment: .leading, spacing: 5) {
                Text(message.userName)
                    .font(.caption)
                    .foregroundColor(.white)
                
                if let text = message.text {
                    ChatBubble(text: text, isFromCurrentUser: message.userName.elementsEqual("Joyce"))
                }
                
                if let image = message.image {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(15)
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color(.systemGray5), lineWidth: 2)
                        )
                }
            }
            .background(Color.clear)
            
            // Image de profil pour "Joyce"
            if message.userName.elementsEqual("Joyce") {
                Image("Me_pp") // Remplacez par votre nom d'image de profil réel
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 68, height: 68)
                    .clipShape(Circle()) // Ajoutez ceci pour une image de profil ronde
            }
        }
        .frame(maxWidth: .infinity)
        .background(Color.clear)
    }
}


// Utilisez votre structure de message existante pour la prévisualisation
#Preview {
    let message = Message.defaultMessage()
    return MessageView(message: message)
}
