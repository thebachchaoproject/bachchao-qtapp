#ifndef IMAGETOBASE64ADAPTER_H
#define IMAGETOBASE64ADAPTER_H

#include <QObject>
#include <QtCore/QVariant>

#include <QtGui/QPixmap>

class ImageToBase64Adapter : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QVariant pixmap READ pixmap WRITE setPixmap NOTIFY pixmapChanged)
    Q_PROPERTY(QString base64Image READ base64Image NOTIFY base64ImageChanged)

public:
    explicit ImageToBase64Adapter(QObject *parent = 0);

    QVariant pixmap() const;
    void setPixmap(QVariant pixmap);

    QString base64Image() const;
    
signals:
    void pixmapChanged();
    void base64ImageChanged();

private:
    QPixmap m_pixmap;
    QString m_base64Image;
};

#endif // IMAGETOBASE64ADAPTER_H
