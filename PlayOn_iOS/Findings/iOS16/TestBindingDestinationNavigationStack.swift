    // BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
    // «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
    //
    // ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
    // If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

import Foundation

struct Food: Identifiable, Hashable {
    var id: String { "\(name)_\(title)" }
    var name: String
    var title: String
    var description: String
    var price: Int
}


#if canImport(Charts)
struct TestBindingDestinationNavigationStack: View {
    var body: some View {
        if #available(iOS 16.0, *) {
            ParentListView()
        } else {
            EmptyView()
        }
    }
    
    @available (iOS 16.0, *)
    struct ParentListView: View {
            //        @State private var numbers = [1, 2, 3, 4, 5]
        @State private var  foods: [Food] = [
            Food(name: "🌯",
                 title: "Burrito",
                 description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                 price: 7),
            Food(name: "🍜",
                 title: "Ramen",
                 description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                 price: 10),
            Food(name: "🍔",
                 title: "Burger",
                 description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                 price: 4),
            Food(name: "🍕",
                 title: "Pizza",
                 description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                 price: 1),
            Food(name: "🌭",
                 title: "Hotdog",
                 description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                 price: 1),
        ]
        var body: some View {
            NavigationStack {
                VStack {
                    Text("--")
                    List {
                      
                        ForEach($foods) { food in
                            NavigationLink(value: food) {
                                Text("\(food.title.wrappedValue) :  \(food.price.wrappedValue)")
                            }
                        }
                    }
                    .navigationDestination(for: Binding<Food>.self) { food in
                        ChildDetailViewD(food: food)
                    }
                }
                .navigationTitle("Bind and update it")
            }
        }

        struct ChildDetailViewD: View {
            @Binding var food: Food
            var body: some View {
                VStack {
                    Text("Add 10 will update the value in the main view")
                    Button {
                        food.price += 10
                    } label: {
                        Text("Add 10 to \(food.price)")
                    }
                }
            }
        }
    }
}

struct TestBindingDestinationNavigationStack_Previews: PreviewProvider {
    static var previews: some View {
        TestBindingDestinationNavigationStack()
    }
}
#endif

extension Binding: Equatable where Value: Equatable {
    public static func == (lhs: Binding<Value>, rhs: Binding<Value>) -> Bool {
        return lhs.wrappedValue == rhs.wrappedValue
    }
}

extension Binding: Hashable where Value: Hashable {
    public func hash(into hasher: inout Hasher) {
        self.wrappedValue.hash(into: &hasher)
    }
}

