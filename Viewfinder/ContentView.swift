//
//  ContentView.swift
//  Viewfinder
//
//  Created by Lukas Romsicki on 2022-02-03.
//

import SwiftUI

struct ContentView: View {
    @State var value: Double = 0

    var body: some View {
        VStack(spacing: 0) {
            PreviewPanel()
                .padding(12)

            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 12) {
                    Panel {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Shutter Speed")
                                .font(.body.bold())

                            HStack(spacing: 8) {
                                Toggle("", isOn: .constant(true))
                                    .toggleStyle(.switch)
                                    .labelsHidden()

                                StyledSlider(imageName: "clock", value: $value)
                            }
                        }
                        .padding(12)
                    }

                    Panel {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Exposure")
                                .font(.body.bold())

                            HStack(spacing: 8) {
                                Toggle("", isOn: .constant(true))
                                    .toggleStyle(.switch)
                                    .labelsHidden()

                                StyledSlider(imageName: "plusminus", value: $value)
                            }
                        }
                        .padding(12)
                    }

                    Panel {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("White Balance")
                                .font(.body.bold())

                            HStack(spacing: 8) {
                                Toggle("", isOn: .constant(true))
                                    .toggleStyle(.switch)
                                    .labelsHidden()

                                StyledSlider(imageName: "slider.horizontal.3", value: $value)
                            }
                        }
                        .padding(12)
                    }

                    Panel {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Brightness")
                                .font(.body.bold())

                            HStack(spacing: 8) {
                                Toggle("", isOn: .constant(true))
                                    .toggleStyle(.switch)
                                    .labelsHidden()

                                StyledSlider(imageName: "sun.max.fill", value: $value)
                            }
                        }
                        .padding(12)
                    }

                    Panel {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Contrast")
                                .font(.body.bold())

                            HStack(spacing: 8) {
                                Toggle("", isOn: .constant(true))
                                    .toggleStyle(.switch)
                                    .labelsHidden()

                                StyledSlider(imageName: "circle.lefthalf.filled", value: $value)
                            }
                        }
                        .padding(12)
                    }

                    Panel {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Saturation")
                                .font(.body.bold())

                            HStack(spacing: 8) {
                                Toggle("", isOn: .constant(true))
                                    .toggleStyle(.switch)
                                    .labelsHidden()

                                StyledSlider(imageName: "drop.fill", value: $value)
                            }
                        }
                        .padding(12)
                    }

                    Panel {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Sharpness")
                                .font(.body.bold())

                            HStack(spacing: 8) {
                                Toggle("", isOn: .constant(true))
                                    .toggleStyle(.switch)
                                    .labelsHidden()

                                StyledSlider(imageName: "triangle.fill", value: $value)
                            }
                        }
                        .padding(12)
                    }

                    Panel {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Focus")
                                .font(.body.bold())

                            HStack(spacing: 8) {
                                Toggle("", isOn: .constant(true))
                                    .toggleStyle(.switch)
                                    .labelsHidden()

                                StyledSlider(imageName: "plus.viewfinder", value: $value)
                            }
                        }
                        .padding(12)
                    }
                }
                .padding(12)
            }
        }
    }
}
