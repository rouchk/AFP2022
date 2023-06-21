import SwiftUI

struct LogoView: View {
    
    @State var currentProgress: CGFloat = 0.0
    
    var body: some View {
        VStack {
            ZStack(alignment:.bottom){
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(.red)
                    .frame(width:96, height:195*currentProgress)
                    .padding(.bottom, 379.0)
                
                Image("logo2")
                    .padding(.leading, 44.0)
                    .onAppear {
                        startLoading()
                    }
                Text("Cook'in")
                    .bold()
                    .font(.system(size:40))
                    .position(x:620, y:450)
            }
        }
    }
    
    func startLoading() {
        _ = Timer.scheduledTimer(withTimeInterval: 0.02, repeats: true) { timer in
            withAnimation() {
                self.currentProgress += 0.01
                if self.currentProgress >= 1.0 {
                    timer.invalidate()
                }
            }
        }
    }
}

struct LogoView_Previews: PreviewProvider {
    static var previews: some View {
        LogoView()
    }
}
