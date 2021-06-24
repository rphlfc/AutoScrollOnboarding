//
//  ContentView.swift
//  AutoScrollOnboarding
//
//  Created by Raphael Cerqueira on 23/06/21.
//

import SwiftUI

struct ContentView: View {
    @State var selectedIndex = 0
    @State var progress: CGFloat = 0
    @State var isOnboardingFinished = false
    
    var body: some View {
        ZStack {
            Color.red
                .ignoresSafeArea()
            
            if isOnboardingFinished {
                WelcomeView()
            } else {
                OnboardingView(selectedIndex: $selectedIndex, progress: $progress, isOnboardingFinished: $isOnboardingFinished)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                startCountdown()
            }
        }
    }
    
    func startCountdown() {
        if !isOnboardingFinished {
            if min(progress, 1) != 1 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    withAnimation {
                        progress += 0.01
                    }
                    startCountdown()
                }
            } else {
                if selectedIndex != data.count - 1 { // last page
                    progress = 0
                    withAnimation {
                        selectedIndex += 1
                    }
                    startCountdown()
                } else {
                    withAnimation {
                        isOnboardingFinished = true
                    }
                }
            }
        }
    }
}

struct WelcomeView: View {
    var body: some View {
        VStack {
            ItemView(item: welcomeItem)
            
            Spacer()
            
            HStack {
                Button(action: {}, label: {
                    Text("Começar")
                        .frame(maxWidth: .infinity)
                        .frame(height: 60)
                        .background(Capsule().stroke(lineWidth: 2))
                })
                
                Spacer()
                
                Button(action: {}, label: {
                    Text("Mais detalhes")
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                })
            }
            .foregroundColor(.white)
            .padding(30)
        }
    }
}

struct OnboardingView: View {
    @Binding var selectedIndex: Int
    @Namespace var namespace
    @Binding var progress: CGFloat
    @Binding var isOnboardingFinished: Bool
    
    var body: some View {
        ZStack {
            TabView(selection: $selectedIndex) {
                ForEach(0 ..< data.count) { i in
                    ItemView(item: data[i])
                }
            }
            .disabled(true)
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            
            ZStack {
                HStack(spacing: 6) {
                    ForEach(0 ..< data.count + 1) { i in
                        Circle()
                            .frame(width: 6, height: 6)
                    }
                }
                
                HStack(spacing: 6) {
                    ForEach(0 ..< data.count) { i in
                        if i == selectedIndex {
                            Capsule()
                                .matchedGeometryEffect(id: "selector", in: namespace)
                                .frame(width: 18, height: 6)
                                .animation(.easeIn)
                        } else {
                            Circle()
                                .frame(width: 6, height: 6)
                        }
                    }
                }
            }
            .foregroundColor(.white)
            
            VStack {
                Spacer()
                
                HStack {
                    Circle()
                        .trim(from: 0, to: 1 - progress)
                        .stroke(lineWidth: 2)
                        .frame(width: 80, height: 80)
                    
                    Spacer()
                    
                    Button(action: {
                        isOnboardingFinished = true
                    }, label: {
                        Text("Começar agora")
                            .fontWeight(.semibold)
                    })
                }
                .foregroundColor(.white)
            }
            .padding(30)
        }
    }
}

struct ItemView: View {
    var item: Item
    
    var body: some View {
        VStack(alignment: .leading, spacing: 30) {
            Image(systemName: item.image)
                .font(.system(size: 31, weight: .semibold))
                .padding(.leading)
            
            Text(item.title)
                .font(.title)
                .fontWeight(.semibold)
            
            Text(item.subtitle)
                .font(.title3)
                .fontWeight(.medium)
            
            Spacer()
        }
        .padding(30)
        .foregroundColor(.white)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
