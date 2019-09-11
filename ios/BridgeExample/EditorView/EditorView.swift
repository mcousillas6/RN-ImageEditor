//
//  EditorView.swift
//  BridgeExample
//
//  Created by Mauricio Cousillas on 9/11/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

import UIKit
import PixelEditor
import PixelEngine

class EditorView: UIView {

  @objc var onImageChange: RCTDirectEventBlock?

  let originalImage = UIImage(named: "sample.jpg")!

  var editorStack: UINavigationController?

  lazy var imageView: UIImageView = {
    let image = UIImageView(image: originalImage)
    image.translatesAutoresizingMaskIntoConstraints = false
    image.contentMode = .scaleAspectFit
    return image
  }()

  lazy var editButton: UIButton = {
    let button = UIButton(type: .system)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle("Edit Image", for: .normal)
    button.addTarget(self, action: #selector(editTapped), for: .touchDown)
    return button
  }()

  lazy var resetButton: UIButton = {
    let button = UIButton(type: .system)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle("Reset Image", for: .normal)
    button.addTarget(self, action: #selector(resetTapped), for: .touchDown)
    return button
  }()

  lazy var buttonStack: UIStackView = {
    let stack = UIStackView()
    stack.translatesAutoresizingMaskIntoConstraints = false
    stack.axis = .horizontal
    stack.alignment = .top
    stack.distribution = .fillEqually
    return stack
  }()

  private lazy var stack = SquareEditingStack.init(
    source: ImageSource(source: UIImage(named: "sample.jpg")!),
    previewSize: CGSize(width: 300, height: 300),
    colorCubeStorage: ColorCubeStorage.default
  )

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setupViews() {
    addSubview(imageView)
    addSubview(buttonStack)
    buttonStack.addArrangedSubview(editButton)
    buttonStack.addArrangedSubview(resetButton)
    NSLayoutConstraint.activate([
      imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
      imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
      imageView.topAnchor.constraint(equalTo: topAnchor),
      imageView.bottomAnchor.constraint(equalTo: buttonStack.topAnchor),
      buttonStack.leadingAnchor.constraint(equalTo: leadingAnchor),
      buttonStack.trailingAnchor.constraint(equalTo: trailingAnchor),
      buttonStack.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor),
    ])
  }

  @objc
  func editTapped() {
    let editor = PixelEditViewController(image: originalImage)
    editor.delegate = self
    let navigationStack = UINavigationController(rootViewController: editor)
    editorStack = navigationStack
    UIApplication.shared.keyWindow?.rootViewController?.present(navigationStack, animated: true, completion: nil)
  }

  @objc
  func resetTapped() {
    imageView.image = originalImage
  }
}

extension EditorView: PixelEditViewControllerDelegate {
  func pixelEditViewController(_ controller: PixelEditViewController, didEndEditing editingStack: SquareEditingStack) {

    editorStack?.dismiss(animated: true, completion: { [weak self] in
      let image = editingStack.makeRenderer().render(resolution: .full)
      self?.imageView.image = image
      self?.onImageChange?(["image": image.pngData()?.base64EncodedString() ?? ""])
      self?.editorStack = nil
    })
  }

  func pixelEditViewControllerDidCancelEditing(in controller: PixelEditViewController) {

    editorStack?.dismiss(animated: true, completion: { [weak self] in
      self?.editorStack = nil
    })
  }
}
