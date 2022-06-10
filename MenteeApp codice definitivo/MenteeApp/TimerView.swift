//
//  TimerView.swift
//  Progetto Try
//
//  Created by Antonio Emanuele Cutarella on 15/11/21.
//

import SwiftUI

struct TimerView: View {
    
    @State var BreakTime: Bool = false
    @State var showDetail: Bool = false
    @State private var isBreakViewPresented = false
    
    @ObservedObject var timerManager = TimerManager()
    
    @State var selectedPickerIndex = 0
    
    let availableMinutes = Array(1...59)
    
    var body: some View {
        NavigationView {
            VStack {
                if timerManager.timerMode == .running  && !timerManager.timeIsUp {
                    Image("Book2")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width:350,height:250)
                        .padding(.top)
                }
                else if !timerManager.timeIsUp {
                    Image("Book")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width:350,height:250)
                        .padding(.top,80)
                }  else if timerManager.timeIsUp {
                    Image("Book3")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width:350,height:250)
                        .padding(.top)
                }
                Text(secondsToMinutesAndSeconds(seconds: timerManager.secondsLeft))
                    .font(.system(size: 80))
                    .padding(.bottom)
                HStack(spacing:80) {
                    Image(systemName: timerManager.timerMode == .running ? "pause.circle.fill" : "play.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 180)
                        .foregroundColor(.orange)
                        .onTapGesture(perform: {
                            if self.timerManager.timerMode == .initial {
                                self.timerManager.setTimerLength(minutes: self.availableMinutes[self.selectedPickerIndex]*60)
                            }
                            
                            if self.timerManager.timerMode == .running {
                                self.timerManager.pause()
                            } else {
                                self.timerManager.start()
                            }
                        })
                    
                    if timerManager.timerMode == .paused {
                        Image(systemName: "gobackward")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 40, height: 40)
                            .padding(.top)
                            .onTapGesture(perform: {
                                self.timerManager.reset()
                            })
                    }
                    
                }
                
                if timerManager.timerMode == .initial {
                    Picker(selection: $selectedPickerIndex, label: Text(""))
                    {
                        ForEach(0 ..< availableMinutes.count) {
                            Text("\(self.availableMinutes[$0]) minute(s)")
                        }
                        .font(.system(size: 100))
                        Spacer(minLength: 100)
                    }
                    .labelsHidden()
                    .padding(.top)
                }
                
                Spacer()
                Button(action:{}){
                    NavigationLink(destination: BreakView()){
                        Text("Take a Break")
                    }}
                
                .font(.system(size: 14))
                Spacer(minLength: 100)
            }
            .navigationBarTitle("Timer")
        }
        .fullScreenCover(isPresented: $isBreakViewPresented){
            BreakView()
        }
    }
}



struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}
