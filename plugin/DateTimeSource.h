/*
 * SPDX-FileCopyrightText: 2025 Sergey N Chursanov <masakra@masakra.su>
 *                ▄▄▄▄·       .▄▄ ·  ▄▄· ▄▄▌         ▄▄· ▄ •▄
 *                ▐█ ▀█▪▪     ▐█ ▀. ▐█ ▌▪██•  ▪     ▐█ ▌▪█▌▄▌▪
 * -------------- ▐█▀▀█▄ ▄█▀▄ ▄▀▀▀█▄██ ▄▄██▪   ▄█▀▄ ██ ▄▄▐▀▀▄· --------------
 *                ██▄▪▐█▐█▌.▐▌▐█▄▪▐█▐███▌▐█▌▐▌▐█▌.▐▌▐███▌▐█.█▌
 *                ·▀▀▀▀  ▀█▄▀▪ ▀▀▀▀ ·▀▀▀ .▀▀▀  ▀█▄▀▪·▀▀▀ ·▀  ▀
 * SPDX-License-Identifier: GPL-2.0-or-later
 */
#pragma once

#include <QTimer>

class DateTimeSource : public QTimer
{
  Q_OBJECT

  Q_PROPERTY(qreal hourAngle READ hourAngle NOTIFY hourAngleChanged)
  Q_PROPERTY(qreal minuteAngle READ minuteAngle NOTIFY minuteAngleChanged)
  Q_PROPERTY(qreal secondAngle READ secondAngle NOTIFY secondAngleChanged)
  Q_PROPERTY(QString text READ text NOTIFY textChanged)

  public:
    explicit DateTimeSource(QObject *parent = nullptr);

    qreal hourAngle() const;
    qreal minuteAngle() const;
    qreal secondAngle() const;
    QString text() const;

  Q_SIGNALS:
    void hourAngleChanged(int hour);
    void minuteAngleChanged(int minute);
    void secondAngleChanged(int second);
    void textChanged(const QString &text);

  private:
    void everySecond();

    int m_hour,
        m_minute,
        m_second;
};

