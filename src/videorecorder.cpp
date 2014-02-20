#include "videorecorder.h"

#include <QtCore/QEvent>
#include <QtCore/QTimer>
#include <QtGui/QDesktopServices>
#include <QtCore/QCoreApplication>

VideoRecorder::VideoRecorder(QDeclarativeItem *parent) :
    QDeclarativeItem(parent)
{
    m_camera = new QCamera(this);
    connect(m_camera, SIGNAL(stateChanged(QCamera::State)), SLOT(cameraStateChanged(QCamera::State)));
    connect(m_camera, SIGNAL(statusChanged(QCamera::Status)), SLOT(cameraStatusChanged(QCamera::Status)));
    connect(m_camera, SIGNAL(error(QCamera::Error)), SLOT(cameraError(QCamera::Error)));

    m_viewFinder = new QGraphicsVideoItem(this);
    m_viewFinder->setAspectRatioMode(Qt::IgnoreAspectRatio);
    m_camera->setViewfinder(m_viewFinder);
    m_camera->setCaptureMode(QCamera::CaptureVideo);

    m_recorder = new QMediaRecorder(m_camera, this);
    connect(m_recorder, SIGNAL(stateChanged(QMediaRecorder::State)), SLOT(recorderStateChanged(QMediaRecorder::State)));
    connect(m_recorder, SIGNAL(error(QMediaRecorder::Error)), SLOT(recorderError(QMediaRecorder::Error)));
    connect(m_recorder, SIGNAL(durationChanged(qint64)), SLOT(videoDurationChanged(qint64)));
}

QString VideoRecorder::outputFile() const
{
    return m_outputFile;
}

void VideoRecorder::setOutputFile(const QString &file)
{
    m_outputFile = file;
    m_recorder->setOutputLocation(file);
    emit outputFileChanged();
}

void VideoRecorder::recorderError(QMediaRecorder::Error e)
{
    qDebug() << "Recording error " << e;
}

void VideoRecorder::cameraError(QCamera::Error e)
{
    qDebug() << "Camera error " << e;
}

void VideoRecorder::startRecording()
{
    qDebug() << "Preparing to start recording..";
    m_viewFinder->show();
    m_camera->start();
}

void VideoRecorder::stopRecording()
{
    qDebug() << "Stopping recording..";
    m_viewFinder->hide();
    m_recorder->stop();
    m_camera->stop();
}

void VideoRecorder::cameraStateChanged(QCamera::State state)
{
    qDebug() << "CAM STATE " << state;
}

void VideoRecorder::recorderStateChanged(QMediaRecorder::State state)
{
    qDebug() << "REC STATE " << state;
    switch (state) {
    case QMediaRecorder::StoppedState:
        emit stoppedRecording();
        break;
    case QMediaRecorder::RecordingState:
        emit startedRecording();
        break;
    }
}

void VideoRecorder::cameraStatusChanged(QCamera::Status status)
{
    qDebug() << "CAM STATUS " << status;
    if (status == QCamera::ActiveStatus) {
        qDebug() << "Start recording to " << m_recorder->outputLocation();
        m_recorder->record();
    }
}

void VideoRecorder::geometryChanged(const QRectF &newGeometry, const QRectF &oldGeometry)
{
    Q_UNUSED(oldGeometry);
    QSizeF size = newGeometry.size();
    size.transpose();
    m_viewFinder->setSize(size);

    m_viewFinder->setTransformOriginPoint(newGeometry.width()/2, m_viewFinder->size().height()/2);
    m_viewFinder->setRotation(90);
}

void VideoRecorder::videoDurationChanged(qint64 duration)
{
    if (!shouldContinueRecording(duration)) {
        stopRecording();
    }
    m_duration = duration/1000;
    emit durationChanged();
}

qint64 VideoRecorder::duration() const
{
    return m_duration;
}

bool VideoRecorder::shouldContinueRecording(qint64 duration) const
{
    return duration < 10 * 60 * 1000;
}
