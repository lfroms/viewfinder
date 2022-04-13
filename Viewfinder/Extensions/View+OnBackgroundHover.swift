//
//  View+OnBackgroundHover.swift
//  Viewfinder
//
//  Created by Lukas Romsicki on 2022-03-05.
//  Copyright © 2022 Lukas Romsicki. All rights reserved.
//

import SwiftUI

extension View {
    /// Adds an action to perform when the user moves the pointer over or away from the view’s frame, even if the window is in the background or is not the key window.
    /// - Parameter action: The action to perform whenever the pointer enters or exits this view’s frame. If the pointer is in the view’s frame, the action closure passes `true` as a parameter; otherwise, `false`.
    /// - Returns: A view that triggers `action` when the pointer enters or exits this view’s frame.
    func onBackgroundHover(perform action: @escaping (Bool) -> Void) -> some View {
        self.background(TrackingAreaRepresentable(onHover: action))
    }
}

struct TrackingAreaRepresentable: NSViewRepresentable {
    let onHover: (Bool) -> Void

    func makeNSView(context: Context) -> TrackingAreaView {
        return TrackingAreaView(onHover: self.onHover)
    }

    func updateNSView(_ nsView: TrackingAreaView, context: Context) {}
}

class TrackingAreaView: NSView {
    private let onHover: (Bool) -> Void

    private var hovering: Bool = false {
        didSet {
            guard self.hovering != oldValue else {
                return
            }

            self.onHover(self.hovering)
        }
    }

    init(onHover: @escaping (Bool) -> Void) {
        self.onHover = onHover

        super.init(frame: .zero)

        self.setupTrackingArea()
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
