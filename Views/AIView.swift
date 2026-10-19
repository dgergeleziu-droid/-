import SwiftUI

struct AIView: View {
    var articleTitle: String? = nil
    @EnvironmentObject var store: ProgressStore
    @EnvironmentObject var content: ContentLoader
    @Environment(\.dismiss) private var dismiss

    @State private var messages: [AIMessage] = []
    @State private var input = ""
    @State private var loading = false
    @State private var errorText: String?
    @State private var showPrivacy = false
    @State private var agreed = false

    private let service: AIService = MockAIService()   // позже: RemoteAIService(endpoint: URL(...)!)

    var body: some View {
        NavigationStack {
            VStack {
                if !agreed {
                    privacyPanel
                } else {
                    chatPanel
                }
            }
            .navigationTitle("ИИ-помощник")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Закрыть") { dismiss() }
                }
            }
        }
    }

    private var privacyPanel: some View {
        VStack(spacing: 16) {
            Image(system
