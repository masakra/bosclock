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
import org.kde.plasma.plasmoid

import su.masakra.plasmoid.bosclock as BosClock

PlasmoidItem {
  id: root

  readonly property real mrg: 5
  readonly property real rad: Math.min(width, height) / 2 - mrg
  readonly property real cx: width / 2
  readonly property real cy: height / 2
  readonly property real ang_30: Math.PI / 6

  readonly property color semiGrayColor: "#60000000"
  readonly property color semiWhiteColor: "#60ffffff"

  BosClock.DateTimeSource {
    onTimeChanged: (hour, minute, second) => {
      hourHand.angle = hour * 30 + minute / 2
      minuteHand.angle = minute * 6
      secondHand.angle = second * 6
    }
  }

  // around dots
  Repeater {
    model: 12

    Rectangle {
      width: 14
      height: 14
      radius: 7
      x: Math.sin(model.index * ang_30) * rad + cx - width / 2
      y: Math.cos(model.index * ang_30) * rad + cy - height / 2
      color: semiGrayColor
      border {
        width: 1
        color: semiWhiteColor
      }
    }
  }

  // hour hand
  Hand {
    id: hourHand
    width: 9
    height: rad * .65
    x: cx - width / 2
    y: cy - height
    color: semiGrayColor
    border {
      width: 1
      color: semiWhiteColor
    }
  }

  // minute hand
  Hand {
    id: minuteHand
    width: 5
    height: rad * .9
    x: cx - width / 2
    y: cy - height
    color: semiGrayColor
    border {
      width: 1
      color: semiWhiteColor
    }
  }

  // second hand
  Hand {
    id: secondHand
    width: 2.5
    height: rad * .96
    x: cx - width / 2
    y: cy - height
    color: "#ad2929"
  }

  // center dot
  Rectangle {
    width: 16
    height: 16
    x: cx - width / 2
    y: cy - height / 2
    radius: 8
    color: "#4d4d4d"
    border {
      width: 1
      color: semiWhiteColor
    }
  }

  //Plasmoid.preferredRepresentation: Plasmoid.fullRepresentation
}

