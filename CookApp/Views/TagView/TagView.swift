//
//  Tag.swift
//  CookApp
//
//  Created by Kim Nordin on 2021-08-13.
//

import SwiftUI


struct TagView: View {
    var tags: [String]
    
    var callback : (Tag) -> ()
    
    @State private var totalHeight
        // = CGFloat.zero       // << variant for ScrollView/List
        = CGFloat.infinity   // << variant for VStack

    var body: some View {
        VStack {
            GeometryReader { geometry in
                self.generateContent(in: geometry)
            }
        }
        //.frame(height: totalHeight)// << variant for ScrollView/List
        .frame(maxHeight: totalHeight) // << variant for VStack
    }

    private func generateContent(in g: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero

        return ZStack(alignment: .topLeading) {
            ForEach(self.tags, id: \.self) { tag in
                self.item(for: tag)
                    .padding([.horizontal, .vertical], 4)
                    .alignmentGuide(.leading, computeValue: { d in
                        if (abs(width - d.width) > g.size.width)
                        {
                            width = 0
                            height -= d.height
                        }
                        let result = width
                        if tag == self.tags.last! {
                            width = 0 //last item
                        } else {
                            width -= d.width
                        }
                        return result
                    })
                    .alignmentGuide(.top, computeValue: {d in
                        let result = height
                        if tag == self.tags.last! {
                            height = 0 // last item
                        }
                        return result
                    })
            }
        }
        .background(viewHeightReader($totalHeight))
    }
    
    func setTextReference() {
        
    }

    private func item(for text: String) -> Tag {
        Tag(ingredient: Ingredient(description: text), callback: { tag in
            callback(tag)
        })
    }

    private func viewHeightReader(_ binding: Binding<CGFloat>) -> some View {
        return GeometryReader { geometry -> Color in
            let rect = geometry.frame(in: .local)
            DispatchQueue.main.async {
                binding.wrappedValue = rect.size.height
            }
            return .clear
        }
    }
}

struct Tag: View {
    var ingredient: Ingredient
    var selected: Bool = false
    
    var callback : (Tag) -> ()
    
    var body: some View {
        Text(ingredient.description)
            .onTapGesture {
                callback(self)
            }
            .padding(8)
            .font(.body)
            .background(RoundedRectangle(cornerRadius: 8)
                    .fill(Color.gray.opacity(0.2)))
            .foregroundColor(Color.white)
    }
}
