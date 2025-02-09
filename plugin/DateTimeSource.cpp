/*
 * SPDX-FileCopyrightText: 2025 Sergey N Chursanov <masakra@masakra.su>
 *                ▄▄▄▄·       .▄▄ ·  ▄▄· ▄▄▌         ▄▄· ▄ •▄
 *                ▐█ ▀█▪▪     ▐█ ▀. ▐█ ▌▪██•  ▪     ▐█ ▌▪█▌▄▌▪
 * -------------- ▐█▀▀█▄ ▄█▀▄ ▄▀▀▀█▄██ ▄▄██▪   ▄█▀▄ ██ ▄▄▐▀▀▄· --------------
 *                ██▄▪▐█▐█▌.▐▌▐█▄▪▐█▐███▌▐█▌▐▌▐█▌.▐▌▐███▌▐█.█▌
 *                ·▀▀▀▀  ▀█▄▀▪ ▀▀▀▀ ·▀▀▀ .▀▀▀  ▀█▄▀▪·▀▀▀ ·▀  ▀
 * SPDX-License-Identifier: GPL-2.0-or-later
 */
#include "DateTimeSource.h"

#include <sys/syscall.h>
#include <sys/time.h>

#include <QDateTime>

DateTimeSource::DateTimeSource(QObject *parent/*= nullptr*/)
  : QTimer(parent)
{
  callOnTimeout(this, &DateTimeSource::everySecond);
  start(1'000);
}

void
DateTimeSource::everySecond() const
{
  struct timeval tv;
  struct timezone tz;

  if (gettimeofday(&tv, &tz)) {
    qCritical("gettimeofday syscall failed");
    return;
  }

  const auto dt = QDateTime::fromSecsSinceEpoch(tv.tv_sec);
  const auto t = dt.time();

  Q_EMIT timeChanged(t.hour(), t.minute(), t.second());
}

