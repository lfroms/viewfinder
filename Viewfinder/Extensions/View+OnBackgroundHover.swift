//
//  View+OnBackgroundHover.swift
//  Viewfinder
//
//  Created by Lukas Romsicki on 2022-03-05.
//

import SwiftUI

extension View {
    /// Adds an action to perform when the user moves the pointer over or away from the view’s frame, even if the window is in the background or is not the key window.
    /// - Parameter action: The action to perform whenever the pointer enters or exits this view’s frame. If the pointer is in the view’s frame, the action closure passes `true` as a parameter; otherwise, `false`.
    /// - Returns: A view that triggers `action` when the pointer enters or exits this view’s frame.
    func onBackgroundHover(perform action: @escaping (Bool) -> Void) -> some View {
        TrackingAreaView(onHover: action) { self }
    }
}

struct TrackingAreaView<Content>: View where Content: View {
    let onHover: (Bool) -> Void
    let content: () -> Content

    init(onHover: @escaping (Bool) -> Void, @ViewBuilder content: @escaping () -> Content) {
        self.onHover = onHover
        self.content = content
    }

    var body: some View {
        TrackingAreaRepresentable(onHover: onHover, content: self.content())
    }
}

struct TrackingAreaRepresentable<Content>: NSViewRepresentable where Content: View {
    let onHover: (Bool) -> Void
    let content: Content

    func makeNSView(context: Context) -> NSHostingView<Content> {
        return TrackingNSHostingView(onHover: self.onHover, rootView: self.content)
    }

    func updateNSView(_ nsView: NSHostingView<Content>, context: Context) {
        nsView.rootView = self.content
    }
}

class TrackingNSHostingView<Content>: NSHostingView<Content> where Content: View {
    private let onHover: (Bool) -> Void

    private var hovering: Bool = false {
        didSet {
            guard self.hovering != oldValue else {
                return
            }

            self.onHover(self.hovering)
        }
    }

    init(onHover: @escaping (Bool) -> Void, rootView: Content) {
        self.onHover = onHover

        super.init(rootView: rootView)

        self.setupTrackingArea()
    }

    required init(rootView: Content) {
        fatalError("init(rootView:) has not been implemented")
    }

    @available(*, unavailable)
    @objc dynamic required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupTrackingArea() {
        let options: NSTrackingArea.Options = [.mouseEnteredAndExited, .mouseMoved, .activeAlways, .inVisibleRect]
        self.addTrackingArea(NSTrackingArea(rect: .zero, options: options, owner: self, userInfo: nil))
    }

    override func mouseEntered(with event: NSEvent) {
        self.setHoveringState(for: event)
    }

    override func mouseExited(with event: NSEvent) {
        self.setHoveringState(for: event)
    }

    override func mouseMoved(with event: NSEvent) {
        self.setHoveringState(for: event)
    }

    private func setHoveringState(for event: NSEvent) {
        let point = self.convert(event.locationInWindow, from: nil)
        self.hovering = frame.contains(point)
    }
}
