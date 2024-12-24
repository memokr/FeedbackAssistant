//
//  StoreView.swift
//  FeedbackAssistant
//
//  Created by Guillermo Kramsky on 09/12/24.
//

import SwiftUI
import StoreKit

enum LoadState {
    case loading
    case loaded
    case error
}

struct StoreView: View {
    @EnvironmentObject var dataController: DataController
    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) var colorScheme

    @State private var loadState = LoadState.loading
    @State private var showErrorAlert = false

    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                VStack(spacing: 0) {
                    VStack {
                            ZStack {
                                LinearGradient(gradient: Gradient(
                                    colors: [
                                        colorScheme == .dark ? .black.opacity(0.5) : .white, .purple
                                    ]), startPoint: .bottom, endPoint: .top
                                )
                                Image(systemName: "lock.open.rotation")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: geometry.size.width * 0.4, height: geometry.size.height * 0.4)
                                    .symbolRenderingMode(.hierarchical)
                                    .foregroundStyle(
                                        .linearGradient(
                                            colors: [.purple, .primary], startPoint: .top, endPoint: .bottomTrailing
                                        )
                                    )
                            }
                        }

                    ScrollView {

                        VStack {
                            switch loadState {
                            case .loading:
                                HStack {
                                    Text("Loading")

                                    ProgressView()
                                }
                                .padding()
                                Spacer()
                            case .loaded:
                                ForEach(dataController.products) { product in
                                    VStack {
                                        Text(product.displayName)
                                            .font(.largeTitle.bold())
                                        Text(product.description)
                                            .font(.headline)
                                        Text(product.displayPrice)
                                            .font(.title.bold())
                                            .padding(.top)

                                    }
                                    .padding()

                                    Button("Buy Now") {
                                        purchase(product)
                                    }
                                    .font(.title2)
                                    .buttonStyle(.borderedProminent)
                                    .tint(.purple)
                                }

                                Button("Restore Purchases") {
                                    restore()
                                }
                                .font(.caption)
                                .padding(.top, 5)
                                .foregroundStyle(.purple)

                                Spacer()

                            case .error:
                                Text("Sorry there was an error loading our store.")
                                    .padding()
                                Button("Try again") {
                                    Task {
                                        await load()
                                    }
                                }
                                .padding()
                                .buttonStyle(.borderedProminent)
                                .tint(.purple)
                                Spacer()
                            }
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                    Spacer()
                }
            }
            .ignoresSafeArea()
            .alert("In-app purchases are disabled", isPresented: $showErrorAlert) {

            } message: {
                Text("""
                You can't purchase the premium unlock because in-app purchases are disabled on this device.
                """)
            }
            .onChange(of: dataController.fullVersionUnlocked) {
                checkForPurchase()
            }
            .task {
                await load()
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundStyle(colorScheme == .dark ? .white : .black)
                            .opacity(0.5)
                    }
                }
            }
        }
    }
    func checkForPurchase() {
        if dataController.fullVersionUnlocked {
            dismiss()
        }
    }
    func purchase(_ product: Product) {
        guard AppStore.canMakePayments else {
            showErrorAlert.toggle()
            return
        }

        Task { @MainActor in
            try await dataController.purchase(product)
        }
    }
    func load() async {
        loadState = .loading

        do {
            try await dataController.loadProducts()

            if dataController.products.isEmpty {
                loadState = .error
            } else {
                loadState = .loaded
            }
        } catch {
            loadState = .error
        }
    }

    func restore() {
        Task {
            try await AppStore.sync()
        }
    }
}

#Preview {
    StoreView()
        .environmentObject(DataController.preview)
}
