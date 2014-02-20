#ifndef VIDEORECORDER_H
#define VIDEORECORDER_H

#include <QtDeclarative/QDeclarativeItem>

#include <QtMultimediaKit/QMediaRecorder>
#include <QtMultimediaKit/QCamera>
#include <QtMultimediaKit/QGraphicsVideoItem>

class VideoRecorder : public QDeclarativeItem
{
    Q_OBJECT
    Q_PROPERTY(QString outputFile READ outputFile WRITE setOutputFile NOTIFY outputFileChanged)
    Q_PROPERTY(qint64 duration READ duration NOTIFY durationChanged)
public:
    explicit VideoRecorder(QDeclarativeItem *parent = 0);

    QString outputFile() const;
    void setOutputFile(const QString &file);
    qint64 duration() const;
    
signals:
    void startedRecording();
    void stoppedRecording();

    void outputFileChanged();
    void durationChanged();
    
public slots:
    void startRecording();
    void stopRecording();

private slots:
    void cameraError(QCamera::Error e);
    void recorderError(QMediaRecorder::Error e);
    void cameraStateChanged(QCamera::State state);
    void cameraStatusChanged(QCamera::Status status);
    void recorderStateChanged(QMediaRecorder::State state);
    void videoDurationChanged(qint64 duration);

protected:
    void geometryChanged(const QRectF &newGeometry, const QRectF &oldGeometry);

private:
    QString m_outputFile;
    qint64 m_duration;
    QCamera *m_camera;
    QMediaRecorder *m_recorder;
    QGraphicsVideoItem *m_viewFinder;

    bool shouldContinueRecording(qint64 duration) const;
};

#endif // VIDEORECORDER_H
