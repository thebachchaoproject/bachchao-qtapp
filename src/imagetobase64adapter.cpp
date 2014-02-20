#include "imagetobase64adapter.h"

#include <QtCore/QBuffer>
#include <QDebug>

ImageToBase64Adapter::ImageToBase64Adapter(QObject *parent) :
    QObject(parent)
{
}

QVariant ImageToBase64Adapter::pixmap() const
{
    return m_pixmap;
}

void ImageToBase64Adapter::setPixmap(QVariant pixmap)
{
    return;
    qDebug() << pixmap;
    m_pixmap = pixmap.value<QPixmap>();
    emit pixmapChanged();

    QByteArray bytes;
    QBuffer buffer(&bytes);
    buffer.open(QIODevice::WriteOnly);
    m_pixmap.save(&buffer, "PNG");

    m_base64Image = "data:image/png;base64," + QString(bytes.toBase64());
    emit base64ImageChanged();
}

QString ImageToBase64Adapter::base64Image() const
{
    return m_base64Image;
}
