//
//  OrderView.swift
//  iDine
//
//  Created by Erik Krietsch on 10/14/19.
//  Copyright © 2019 Totally Radical Software, Inc. All rights reserved.
//

import SwiftUI

struct OrderView: View {
    @EnvironmentObject var order: Order

    func deleteItems(at offsets: IndexSet) {
        order.items.remove(atOffsets: offsets)
    }

    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Items")) {
                    ForEach(order.items) { item in
                        HStack {
                            Text(item.name)
                            Spacer()
                            Text("$\(item.price)")
                        }
                    }.onDelete(perform: deleteItems)
                }
                Section {
                    HStack {
                        Text("Total")
                            .font(.headline)
                        Spacer()
                        Text("$\(order.total)")
                            .font(.headline)
                    }
                }
                Section {
                    NavigationLink(destination: CheckoutView()) {
                        Text("Place order")
                    }
                }.disabled(order.items.isEmpty)
            }
            .navigationBarTitle("Order")
            .listStyle(GroupedListStyle())
            .navigationBarItems(trailing: EditButton())
        }
    }
}

struct OrderView_Previews: PreviewProvider {
    static var order = Order()
    static var previews: some View {
        OrderView().environmentObject(order)
    }
}
