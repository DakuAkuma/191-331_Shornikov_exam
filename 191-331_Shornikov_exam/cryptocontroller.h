#ifndef CRYPTOCONTROLLER_H
#define CRYPTOCONTROLLER_H
#include <QString>
#include <QObject>

class cryptoController : public QObject
{
    Q_OBJECT

public:
    //cryptoController();
    explicit cryptoController(QObject *parent = nullptr); // constructor
    ~cryptoController() {
        delete proto;
        delete m_iv;
    }
    QString soursefile; // choosen file
public slots:
    bool encryptFile(const QString & mkey, const QString &in_file);
    bool decryptFile(const QString & mkey, const QString &in_file);
protected:
    QObject *proto;
private: // они все начинаются с m_
    unsigned char * m_iv = (unsigned char *)("32111230141456789873614547987765"); //32 символа
    QString psevdoKey;
};

#endif // CRYPTOCONTROLLER_H
