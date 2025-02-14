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
  , m_hour(-1)
  , m_minute(m_hour)
  , m_second(m_hour)
{
  callOnTimeout(this, &DateTimeSource::everySecond);
  start(1'000);
}

qreal
DateTimeSource::hourAngle() const
{
  return m_hour * 30 + m_minute / 2.;
}

qreal
DateTimeSource::minuteAngle() const
{
  return m_minute * 6;
}

qreal
DateTimeSource::secondAngle() const
{
  return m_second * 6;
}

QString
DateTimeSource::text() const
{
  auto toStr = [](int num) -> QString
  {
    return ~ num
              ? QStringLiteral("%1").arg(num, 2, 10, QLatin1Char('0'))
              : QStringLiteral("--");
  };

  return QStringLiteral("%1:%2:%3")
                        .arg(toStr(m_hour))
                        .arg(toStr(m_minute))
                        .arg(toStr(m_second));
}

void
DateTimeSource::everySecond()
{
  struct timeval tv;
  struct timezone tz;

  if (gettimeofday(&tv, &tz)) {
    qCritical("gettimeofday syscall failed");
    return;
  }

  const auto dt = QDateTime::fromSecsSinceEpoch(tv.tv_sec);
  const auto t = dt.time();

  m_second = t.second();
  Q_EMIT secondAngleChanged(secondAngle());
  Q_EMIT textChanged(text());

  const auto hour = t.hour(),
             minute = t.minute();

  if (m_minute != minute) {
    m_minute = minute;
    Q_EMIT minuteAngleChanged(minuteAngle());
    Q_EMIT hourAngleChanged(hourAngle());
  }
  else if (m_hour != hour) {
    m_hour = hour;
    Q_EMIT hourAngleChanged(hourAngle());
  }
}

