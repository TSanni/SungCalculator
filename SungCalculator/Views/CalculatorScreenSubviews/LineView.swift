//
//  LineView.swift
//  SungCalculator
//
//  Created by Tomas Sanni on 12/28/22.
//

import SwiftUI

struct LineView: Shape {
    
    var lineHeight: CGFloat
    
    var animatableData: Double {
        get { lineHeight }
        set { lineHeight = newValue }
    }
    
    
    func path(in rect: CGRect) -> Path {
        
        let midCenter = CGPoint(x: rect.midX, y: rect.minY)

        var path = Path()
        
        path.move(to: midCenter)
        path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY * lineHeight))
//        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        
        
        return path
    }
    
    
}

struct LineView_Previews: PreviewProvider {
    static var previews: some View {
        LineView(lineHeight: 1)
            .stroke()
    }
}
