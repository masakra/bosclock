#  SPDX-FileCopyrightText: 2025 Sergey N Chursanov <masakra@masakra.su>
#                 ▄▄▄▄·       .▄▄ ·  ▄▄· ▄▄▌         ▄▄· ▄ •▄
#                 ▐█ ▀█▪▪     ▐█ ▀. ▐█ ▌▪██•  ▪     ▐█ ▌▪█▌▄▌▪
#  -------------- ▐█▀▀█▄ ▄█▀▄ ▄▀▀▀█▄██ ▄▄██▪   ▄█▀▄ ██ ▄▄▐▀▀▄· --------------
#                 ██▄▪▐█▐█▌.▐▌▐█▄▪▐█▐███▌▐█▌▐▌▐█▌.▐▌▐███▌▐█.█▌
#                 ·▀▀▀▀  ▀█▄▀▪ ▀▀▀▀ ·▀▀▀ .▀▀▀  ▀█▄▀▪·▀▀▀ ·▀  ▀
#  SPDX-License-Identifier: GPL-2.0-or-later
add_library(bosclock SHARED
  BosClock.cpp
  DateTimeSource.cpp
)

target_link_libraries(bosclock
  Qt6::Gui
  Qt6::Qml
)

install(TARGETS bosclock DESTINATION ${KDE_INSTALL_QMLDIR}/su/masakra/plasmoid/bosclock)
install(FILES qmldir DESTINATION ${KDE_INSTALL_QMLDIR}/su/masakra/plasmoid/bosclock)

