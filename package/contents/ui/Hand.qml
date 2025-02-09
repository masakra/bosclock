/*
 * SPDX-FileCopyrightText: 2025 Sergey N Chursanov <masakra@masakra.su>
 *                ▄▄▄▄·       .▄▄ ·  ▄▄· ▄▄▌         ▄▄· ▄ •▄
 *                ▐█ ▀█▪▪     ▐█ ▀. ▐█ ▌▪██•  ▪     ▐█ ▌▪█▌▄▌▪
 * -------------- ▐█▀▀█▄ ▄█▀▄ ▄▀▀▀█▄██ ▄▄██▪   ▄█▀▄ ██ ▄▄▐▀▀▄· --------------
 *                ██▄▪▐█▐█▌.▐▌▐█▄▪▐█▐███▌▐█▌▐▌▐█▌.▐▌▐███▌▐█.█▌
 *                ·▀▀▀▀  ▀█▄▀▪ ▀▀▀▀ ·▀▀▀ .▀▀▀  ▀█▄▀▪·▀▀▀ ·▀  ▀
 * SPDX-License-Identifier: GPL-2.0-or-later
 */
import QtQuick

Rectangle {
  id: hand

  property real angle: 0

  onAngleChanged: {
    animation.to = hand.angle
    animation.start()
  }

  antialiasing: true

  transform: Rotation {
    id: rotation
    origin.x: hand.width / 2
    origin.y: hand.height
    RotationAnimation on angle {
      id: animation
      duration: 200
      direction: RotationAnimation.Shortest
      easing.type: Easing.OutElastic
    }
  }
}
