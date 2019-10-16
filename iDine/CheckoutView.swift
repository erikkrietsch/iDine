//
//  CheckoutView.swift
//  iDine
//
//  Created by Erik Krietsch on 10/14/19.
//  Copyright © 2019 Totally Radical Software, Inc. All rights reserved.
//

import SwiftUI

struct CheckoutView: View {
    @EnvironmentObject var order: Order

    @State private var paymentType = 0
    @State private var addLoyaltyDetails = false
    @State private var loyaltyNumber = ""
    @State private var tipAmount = 1

    static let paymentTypes = ["Cash", "Credit", "iDine Points"]
    static let tipAmounts = [10, 15, 20, 25, 0]

    private static var totalFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
    }()

    var totalPrice: String {
        let total = Double(order.total)
        let tipValue = total / 100 * Double(Self.tipAmounts[tipAmount])
        return Self.totalFormatter.string(for: total + tipValue) ?? ""

    }

    var body: some View {
        Form {
            Section {
                Picker("How do you want to pay?", selection: $paymentType) {
                    ForEach(0..<Self.paymentTypes.count) {
                        Text(Self.paymentTypes[$0])
                    }
                }
                Toggle(isOn: $addLoyaltyDetails.animation()) {
                    Text("Add iDine loyalty card")
                }
                if addLoyaltyDetails {
                    TextField("Enter your iDine ID", text: $loyaltyNumber)
                }
            }
            Section(header: Text("Add a tip?")) {
                Picker("Percentage:", selection: $tipAmount) {
                    ForEach(0..<Self.tipAmounts.count) {
                        Text("\(Self.tipAmounts[$0])%")
                    }
                }.pickerStyle(SegmentedPickerStyle())
            }
            Section(header: Text("Total: \(totalPrice)")) {
                Button("Confirm order") {
                    
                }
            }
        }
        .navigationBarTitle(Text("Payment"), displayMode: .inline)

    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var order = Order()
    static var previews: some View {
        CheckoutView().environmentObject(order)
    }
}
