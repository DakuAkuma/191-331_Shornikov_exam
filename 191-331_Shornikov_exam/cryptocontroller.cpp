#include "cryptocontroller.h"
#include <QString>
#include <openssl/evp.h>
#include <QFile>
#include <QByteArray>
#include <QIODevice>
#include <QObject>
#include <QTemporaryFile>
#include <openssl/conf.h>
#include <openssl/err.h>
#include <openssl/aes.h>
#include <QBuffer>
#include <QDebug>

cryptoController::cryptoController(QObject *parent) : proto(parent)
{
}

bool cryptoController::encryptFile(const QString & mkey, const QString & in_file){
    //qDebug() << mkey.length();
    EVP_CIPHER_CTX *ctx;
    if(!(ctx = EVP_CIPHER_CTX_new())){
        return false;
    }

    if (mkey.length() == 32){
        m_iv = (unsigned char*) mkey.constData();

        if(1 != EVP_EncryptInit_ex(ctx, EVP_aes_256_cfb(), NULL, reinterpret_cast<unsigned char *>(mkey.toUtf8().data()), m_iv)) //шифр
        {
            return false;
        }
    }
    else{
        psevdoKey = "31711230123454219878904547898765";

        if(1 != EVP_EncryptInit_ex(ctx, EVP_aes_256_cfb(), NULL, reinterpret_cast<unsigned char *>(psevdoKey.toUtf8().data()), m_iv))
        {
            return false;
        }
    }

    unsigned char ciphertext[256] = {0};
    unsigned char plaintexttext[256] = {0};
    int len = 0, plaintext_len = 0;

    soursefile = in_file.mid(8);
    QFile sourse_file(soursefile);
    sourse_file.open(QIODevice::ReadOnly);

    int position = soursefile.lastIndexOf(".");
    QString file_extension = soursefile.mid(position);
    QString soursefile_enc = soursefile.left(position) + "_crypted" + file_extension; //Для создания нового файла


    QFile file_modificate(soursefile_enc);
    file_modificate.open(QIODevice::ReadWrite | QIODevice::Truncate);
    plaintext_len = sourse_file.read((char *)plaintexttext, 256);

    while(plaintext_len > 0){
        if(1 != EVP_EncryptUpdate(ctx, ciphertext, &len, plaintexttext, plaintext_len))
        {
            return false;
        }

        //Запись ciphertext в файл шифрованных данных
        file_modificate.write((char *)ciphertext, len);
        plaintext_len = sourse_file.read((char *)plaintexttext, 256); //Считывание каждого блока по 256 символов и запись в файл
    }

    if(1 != EVP_EncryptFinal_ex(ctx, ciphertext + len, &len))
    {
        return false;
    }

    file_modificate.write((char*)ciphertext, len);
    EVP_CIPHER_CTX_free(ctx);

    //Закрытие файлов
    sourse_file.close();
    file_modificate.close();

    return true;
}

bool cryptoController::decryptFile(const QString & mkey, const QString & in_file){
    EVP_CIPHER_CTX *ctx;
    if(!(ctx = EVP_CIPHER_CTX_new())){
        return false;
    }

    if (mkey.length() == 32){
        m_iv = (unsigned char*) mkey.data();

        if(1 != EVP_DecryptInit_ex(ctx, EVP_aes_256_cfb(), NULL, reinterpret_cast<unsigned char *>(mkey.toUtf8().data()), m_iv)) //дешифр
        {
            return false;
        }
    }
    else{
        psevdoKey = "31711230123454219878904547898765";

        if(1 != EVP_DecryptInit_ex(ctx, EVP_aes_256_cfb(), NULL, reinterpret_cast<unsigned char *>(psevdoKey.toUtf8().data()), m_iv))
        {
            return false;
        }
    }

    unsigned char ciphertext[256] = {0};
    unsigned char plaintexttext[256] = {0};
    int len = 0, plaintext_len = 0;

    soursefile = in_file.mid(8);
    QFile sourse_file(soursefile);
    sourse_file.open(QIODevice::ReadOnly);

    int position = soursefile.indexOf("_crypted");
    QString file_extension = soursefile.right(soursefile.lastIndexOf("."));
    QString soursefile_dec = soursefile.left(position) + file_extension;

    QFile file_modificate(soursefile_dec);
    file_modificate.open(QIODevice::ReadWrite | QIODevice::Truncate);
    plaintext_len = sourse_file.read((char *)plaintexttext, 256);

    while(plaintext_len > 0){
        if(1 != EVP_DecryptUpdate(ctx, ciphertext, &len, plaintexttext, plaintext_len))
        {
            return false;
        }

        file_modificate.write((char *)ciphertext, len);
        plaintext_len = sourse_file.read((char *)plaintexttext, 256);

    }

    if(!EVP_DecryptFinal_ex(ctx, ciphertext + len, &len))
        return false;

    file_modificate.write((char*)ciphertext, len);
    EVP_CIPHER_CTX_free(ctx);

    sourse_file.close();
    file_modificate.close();

    return true;
}
