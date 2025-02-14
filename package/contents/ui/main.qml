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
import QtQuick.Layouts
import org.kde.plasma.plasmoid

import su.masakra.plasmoid.bosclock as BosClock

PlasmoidItem {
  id: root

  switchHeight: 100
  switchWidth: 100

  readonly property real mrg: 5
  readonly property real rad: Math.min(width, height) / 2 - mrg
  readonly property real cx: width / 2
  readonly property real cy: height / 2
  readonly property real ang_30: Math.PI / 6

  readonly property color semiGrayColor: "#60000000"
  readonly property color semiWhiteColor: "#60ffffff"

  BosClock.DateTimeSource {
    id: dateTime
  }

  fullRepresentation: Item {
    anchors.fill: parent

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
      angle: dateTime.hourAngle
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
      angle: dateTime.minuteAngle
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
      angle: dateTime.secondAngle
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
  } // fullRepresentation

  compactRepresentation: RowLayout {
    anchors.fill: parent

    Text {
      Layout.fillWidth: true
      Layout.leftMargin: 30
      Layout.rightMargin: 30

      text: dateTime.text
      horizontalAlignment: Text.AlignHCenter
      color: "white"
    }
  }

  preferredRepresentation: fullRepresentation
}

