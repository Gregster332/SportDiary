import SwiftUI

struct BackgroundRounded: ViewModifier {
    
    let cornerRadius: CGFloat
    let strokeColor: Color
    let strokeLineWidth: CGFloat
    let padding: CGFloat
    
    init(
        cornerRadius: CGFloat = 5,
        strokeColor: Color = .black,
        strokeLineWidth: CGFloat = 1,
        padding: CGFloat = 8
    ) {
        self.cornerRadius = cornerRadius
        self.strokeColor = strokeColor
        self.strokeLineWidth = strokeLineWidth
        self.padding = padding
    }
    
    func body(content: Content) -> some View {
        content
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(strokeColor, lineWidth: strokeLineWidth)
            )
            .padding(.bottom, padding)
    }
}
