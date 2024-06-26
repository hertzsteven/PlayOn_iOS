// 🔥BOYCOTT on russia - terrorist must be punished!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

#if canImport(Charts)
@available (iOS 16, *)
struct TestTwoLinksInRowNavigationStack: View {
    struct Tweet: Identifiable, Hashable {
        var id: String { userID }
        let userID = "1"
        let text = "Stop russia NOW!"
    }
    struct User: Identifiable, Hashable {
        let id = "1"
        let name = "Asperi"
        let color = Color.red
    }
    let tweets: [Tweet] = [Tweet()]
    let users: [User] = [User()]
    
    @State var path = NavigationPath()
    var body: some View {
        NavigationStack(path: $path) {
            List(tweets) { tweet in
                let user = users.first { $0.id == tweet.userID }!
                
                HStack {
                    Image(systemName: "flame")
                        .foregroundStyle(user.color)
                        .padding(8)
                        .border(.red)
                        .highPriorityGesture(TapGesture().onEnded {
                            path.append(user)
                        })
                    Spacer()
                    VStack(alignment: .trailing) {
                        Text("@\(user.name)")
                        Text(tweet.text)
                    }
                }
//                .contentShape(Ellipse())
                .onTapGesture {
                    path.append(tweet)
                }
                .swipeActions(edge: .leading) {
                    Button("Like") { }
                }
            }
            .navigationDestination(for: Tweet.self) { tweet in
                Text("TweetDetailView(tweet: \(tweet.text))")
            }
            .navigationDestination(for: User.self) { user in
                Text("UserDetailView(user: \(user.name))")
            }
        }
    }
}

@available (iOS 16, *)
struct TestTwoLinksInRowNavigationStack_Previews: PreviewProvider {
    static var previews: some View {
        TestTwoLinksInRowNavigationStack()
    }
}

#endif
