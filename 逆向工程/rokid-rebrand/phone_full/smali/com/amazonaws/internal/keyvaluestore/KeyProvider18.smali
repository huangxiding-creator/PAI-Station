.class public Lcom/amazonaws/internal/keyvaluestore/KeyProvider18;
.super Ljava/lang/Object;
.source "KeyProvider18.java"

# interfaces
.implements Lcom/amazonaws/internal/keyvaluestore/KeyProvider;


# static fields
.field static final ANDROID_KEY_STORE_NAME:Ljava/lang/String; = "AndroidKeyStore"

.field static final AWS_KEY_VALUE_STORE_VERSION_1_KEY_STORE_ALIAS_FOR_RSA_SUFFIX:Ljava/lang/String; = ".rsaKeyStoreAlias"

.field static final CIPHER_AES_GCM_NOPADDING_KEY_LENGTH_IN_BITS:I = 0x100

.field static final CIPHER_PROVIDER_NAME_FOR_RSA:Ljava/lang/String; = "AndroidOpenSSL"

.field static final CIPHER_RSA_MODE:Ljava/lang/String; = "RSA/ECB/PKCS1Padding"

.field static final ENCRYPTED_AES_KEY:Ljava/lang/String; = "AesGcmNoPadding18-encrypted-encryption-key"

.field static final KEY_ALGORITHM_AES:Ljava/lang/String; = "AES"

.field static final KEY_ALGORITHM_RSA:Ljava/lang/String; = "RSA"

.field private static final logger:Lcom/amazonaws/logging/Log;


# instance fields
.field private context:Landroid/content/Context;

.field private secureRandom:Ljava/security/SecureRandom;

.field private sharedPreferences:Landroid/content/SharedPreferences;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 60
    const-class v0, Lcom/amazonaws/internal/keyvaluestore/KeyProvider18;

    invoke-static {v0}, Lcom/amazonaws/logging/LogFactory;->getLog(Ljava/lang/Class;)Lcom/amazonaws/logging/Log;

    move-result-object v0

    sput-object v0, Lcom/amazonaws/internal/keyvaluestore/KeyProvider18;->logger:Lcom/amazonaws/logging/Log;

    return-void
.end method

.method constructor <init>(Landroid/content/Context;Landroid/content/SharedPreferences;)V
    .locals 0
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "sharedPreferences"    # Landroid/content/SharedPreferences;

    .line 92
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 93
    iput-object p1, p0, Lcom/amazonaws/internal/keyvaluestore/KeyProvider18;->context:Landroid/content/Context;

    .line 94
    iput-object p2, p0, Lcom/amazonaws/internal/keyvaluestore/KeyProvider18;->sharedPreferences:Landroid/content/SharedPreferences;

    .line 95
    return-void
.end method

.method private rsaDecrypt(Ljava/lang/String;[B)[B
    .locals 6
    .param p1, "keyAlias"    # Ljava/lang/String;
    .param p2, "encryptedData"    # [B

    .line 118
    const/4 v0, 0x0

    :try_start_0
    const-string v1, "AndroidKeyStore"

    invoke-static {v1}, Ljava/security/KeyStore;->getInstance(Ljava/lang/String;)Ljava/security/KeyStore;

    move-result-object v1

    .line 119
    .local v1, "keyStore":Ljava/security/KeyStore;
    invoke-virtual {v1, v0}, Ljava/security/KeyStore;->load(Ljava/security/KeyStore$LoadStoreParameter;)V

    .line 121
    invoke-virtual {v1, p1, v0}, Ljava/security/KeyStore;->getEntry(Ljava/lang/String;Ljava/security/KeyStore$ProtectionParameter;)Ljava/security/KeyStore$Entry;

    move-result-object v2

    check-cast v2, Ljava/security/KeyStore$PrivateKeyEntry;

    .line 124
    .local v2, "privateKeyEntry":Ljava/security/KeyStore$PrivateKeyEntry;
    const-string v3, "RSA/ECB/PKCS1Padding"

    const-string v4, "AndroidOpenSSL"

    invoke-static {v3, v4}, Ljavax/crypto/Cipher;->getInstance(Ljava/lang/String;Ljava/lang/String;)Ljavax/crypto/Cipher;

    move-result-object v3

    .line 125
    .local v3, "decryptCipher":Ljavax/crypto/Cipher;
    nop

    .line 126
    invoke-virtual {v2}, Ljava/security/KeyStore$PrivateKeyEntry;->getPrivateKey()Ljava/security/PrivateKey;

    move-result-object v4

    .line 125
    const/4 v5, 0x2

    invoke-virtual {v3, v5, v4}, Ljavax/crypto/Cipher;->init(ILjava/security/Key;)V

    .line 128
    invoke-virtual {v3, p2}, Ljavax/crypto/Cipher;->doFinal([B)[B

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    .line 129
    .end local v1    # "keyStore":Ljava/security/KeyStore;
    .end local v2    # "privateKeyEntry":Ljava/security/KeyStore$PrivateKeyEntry;
    .end local v3    # "decryptCipher":Ljavax/crypto/Cipher;
    :catch_0
    move-exception v1

    .line 130
    .local v1, "ex":Ljava/lang/Exception;
    sget-object v2, Lcom/amazonaws/internal/keyvaluestore/KeyProvider18;->logger:Lcom/amazonaws/logging/Log;

    const-string v3, "Exception occurred while decrypting the encrypted AES key. "

    invoke-interface {v2, v3, v1}, Lcom/amazonaws/logging/Log;->error(Ljava/lang/Object;Ljava/lang/Throwable;)V

    .line 131
    return-object v0
.end method

.method private rsaEncrypt(Ljava/lang/String;[B)[B
    .locals 6
    .param p1, "keyAlias"    # Ljava/lang/String;
    .param p2, "rawData"    # [B

    .line 99
    const/4 v0, 0x0

    :try_start_0
    const-string v1, "AndroidKeyStore"

    invoke-static {v1}, Ljava/security/KeyStore;->getInstance(Ljava/lang/String;)Ljava/security/KeyStore;

    move-result-object v1

    .line 100
    .local v1, "keyStore":Ljava/security/KeyStore;
    invoke-virtual {v1, v0}, Ljava/security/KeyStore;->load(Ljava/security/KeyStore$LoadStoreParameter;)V

    .line 102
    invoke-virtual {v1, p1, v0}, Ljava/security/KeyStore;->getEntry(Ljava/lang/String;Ljava/security/KeyStore$ProtectionParameter;)Ljava/security/KeyStore$Entry;

    move-result-object v2

    check-cast v2, Ljava/security/KeyStore$PrivateKeyEntry;

    .line 105
    .local v2, "privateKeyEntry":Ljava/security/KeyStore$PrivateKeyEntry;
    const-string v3, "RSA/ECB/PKCS1Padding"

    const-string v4, "AndroidOpenSSL"

    invoke-static {v3, v4}, Ljavax/crypto/Cipher;->getInstance(Ljava/lang/String;Ljava/lang/String;)Ljavax/crypto/Cipher;

    move-result-object v3

    .line 106
    .local v3, "encryptCipher":Ljavax/crypto/Cipher;
    nop

    .line 107
    invoke-virtual {v2}, Ljava/security/KeyStore$PrivateKeyEntry;->getCertificate()Ljava/security/cert/Certificate;

    move-result-object v4

    invoke-virtual {v4}, Ljava/security/cert/Certificate;->getPublicKey()Ljava/security/PublicKey;

    move-result-object v4

    .line 106
    const/4 v5, 0x1

    invoke-virtual {v3, v5, v4}, Ljavax/crypto/Cipher;->init(ILjava/security/Key;)V

    .line 109
    invoke-virtual {v3, p2}, Ljavax/crypto/Cipher;->doFinal([B)[B

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    .line 110
    .end local v1    # "keyStore":Ljava/security/KeyStore;
    .end local v2    # "privateKeyEntry":Ljava/security/KeyStore$PrivateKeyEntry;
    .end local v3    # "encryptCipher":Ljavax/crypto/Cipher;
    :catch_0
    move-exception v1

    .line 111
    .local v1, "ex":Ljava/lang/Exception;
    sget-object v2, Lcom/amazonaws/internal/keyvaluestore/KeyProvider18;->logger:Lcom/amazonaws/logging/Log;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "Exception occurred while encrypting data. "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v1}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-interface {v2, v3}, Lcom/amazonaws/logging/Log;->error(Ljava/lang/Object;)V

    .line 112
    return-object v0
.end method


# virtual methods
.method public declared-synchronized deleteKey(Ljava/lang/String;)V
    .locals 4
    .param p1, "keyAlias"    # Ljava/lang/String;

    monitor-enter p0

    .line 259
    :try_start_0
    iget-object v0, p0, Lcom/amazonaws/internal/keyvaluestore/KeyProvider18;->sharedPreferences:Landroid/content/SharedPreferences;

    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v1, "AesGcmNoPadding18-encrypted-encryption-key"

    .line 260
    invoke-interface {v0, v1}, Landroid/content/SharedPreferences$Editor;->remove(Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    .line 261
    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 265
    goto :goto_0

    .line 258
    .end local p0    # "this":Lcom/amazonaws/internal/keyvaluestore/KeyProvider18;
    .end local p1    # "keyAlias":Ljava/lang/String;
    :catchall_0
    move-exception p1

    goto :goto_2

    .line 262
    .restart local p1    # "keyAlias":Ljava/lang/String;
    :catch_0
    move-exception v0

    .line 263
    .local v0, "ex":Ljava/lang/Exception;
    :try_start_1
    sget-object v1, Lcom/amazonaws/internal/keyvaluestore/KeyProvider18;->logger:Lcom/amazonaws/logging/Log;

    const-string v2, "Error in deleting the encrypted AES key identified by AesGcmNoPadding18-encrypted-encryption-key from SharedPreferences."

    invoke-interface {v1, v2, v0}, Lcom/amazonaws/logging/Log;->error(Ljava/lang/Object;Ljava/lang/Throwable;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 269
    .end local v0    # "ex":Ljava/lang/Exception;
    :goto_0
    :try_start_2
    const-string v0, "AndroidKeyStore"

    invoke-static {v0}, Ljava/security/KeyStore;->getInstance(Ljava/lang/String;)Ljava/security/KeyStore;

    move-result-object v0

    .line 270
    .local v0, "keyStore":Ljava/security/KeyStore;
    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Ljava/security/KeyStore;->load(Ljava/security/KeyStore$LoadStoreParameter;)V

    .line 272
    invoke-virtual {v0, p1}, Ljava/security/KeyStore;->deleteEntry(Ljava/lang/String;)V
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_1
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 276
    .end local v0    # "keyStore":Ljava/security/KeyStore;
    goto :goto_1

    .line 273
    :catch_1
    move-exception v0

    .line 274
    .local v0, "ex":Ljava/lang/Exception;
    :try_start_3
    sget-object v1, Lcom/amazonaws/internal/keyvaluestore/KeyProvider18;->logger:Lcom/amazonaws/logging/Log;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Error in deleting the RSA Key identified by the keyAlias: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " from "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "AndroidKeyStore"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-interface {v1, v2, v0}, Lcom/amazonaws/logging/Log;->error(Ljava/lang/Object;Ljava/lang/Throwable;)V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    .line 277
    .end local v0    # "ex":Ljava/lang/Exception;
    :goto_1
    monitor-exit p0

    return-void

    .line 258
    .end local p1    # "keyAlias":Ljava/lang/String;
    :goto_2
    monitor-exit p0

    throw p1
.end method

.method public declared-synchronized generateKey(Ljava/lang/String;)Ljava/security/Key;
    .locals 8
    .param p1, "rsaKeyAlias"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/internal/keyvaluestore/KeyNotGeneratedException;
        }
    .end annotation

    monitor-enter p0

    .line 139
    :try_start_0
    const-string v0, "AndroidKeyStore"

    invoke-static {v0}, Ljava/security/KeyStore;->getInstance(Ljava/lang/String;)Ljava/security/KeyStore;

    move-result-object v0

    .line 140
    .local v0, "keyStore":Ljava/security/KeyStore;
    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Ljava/security/KeyStore;->load(Ljava/security/KeyStore$LoadStoreParameter;)V

    .line 142
    invoke-static {}, Ljava/util/Calendar;->getInstance()Ljava/util/Calendar;

    move-result-object v1

    .line 143
    .local v1, "start":Ljava/util/Calendar;
    invoke-static {}, Ljava/util/Calendar;->getInstance()Ljava/util/Calendar;

    move-result-object v2

    .line 144
    .local v2, "end":Ljava/util/Calendar;
    const/4 v3, 0x1

    const/16 v4, 0x1e

    invoke-virtual {v2, v3, v4}, Ljava/util/Calendar;->add(II)V

    .line 145
    new-instance v3, Landroid/security/KeyPairGeneratorSpec$Builder;

    iget-object v4, p0, Lcom/amazonaws/internal/keyvaluestore/KeyProvider18;->context:Landroid/content/Context;

    invoke-direct {v3, v4}, Landroid/security/KeyPairGeneratorSpec$Builder;-><init>(Landroid/content/Context;)V

    .line 146
    invoke-virtual {v3, p1}, Landroid/security/KeyPairGeneratorSpec$Builder;->setAlias(Ljava/lang/String;)Landroid/security/KeyPairGeneratorSpec$Builder;

    move-result-object v3

    new-instance v4, Ljavax/security/auth/x500/X500Principal;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "CN="

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-direct {v4, v5}, Ljavax/security/auth/x500/X500Principal;-><init>(Ljava/lang/String;)V

    .line 147
    invoke-virtual {v3, v4}, Landroid/security/KeyPairGeneratorSpec$Builder;->setSubject(Ljavax/security/auth/x500/X500Principal;)Landroid/security/KeyPairGeneratorSpec$Builder;

    move-result-object v3

    sget-object v4, Ljava/math/BigInteger;->TEN:Ljava/math/BigInteger;

    .line 148
    invoke-virtual {v3, v4}, Landroid/security/KeyPairGeneratorSpec$Builder;->setSerialNumber(Ljava/math/BigInteger;)Landroid/security/KeyPairGeneratorSpec$Builder;

    move-result-object v3

    .line 149
    invoke-virtual {v1}, Ljava/util/Calendar;->getTime()Ljava/util/Date;

    move-result-object v4

    invoke-virtual {v3, v4}, Landroid/security/KeyPairGeneratorSpec$Builder;->setStartDate(Ljava/util/Date;)Landroid/security/KeyPairGeneratorSpec$Builder;

    move-result-object v3

    .line 150
    invoke-virtual {v2}, Ljava/util/Calendar;->getTime()Ljava/util/Date;

    move-result-object v4

    invoke-virtual {v3, v4}, Landroid/security/KeyPairGeneratorSpec$Builder;->setEndDate(Ljava/util/Date;)Landroid/security/KeyPairGeneratorSpec$Builder;

    move-result-object v3

    .line 151
    invoke-virtual {v3}, Landroid/security/KeyPairGeneratorSpec$Builder;->build()Landroid/security/KeyPairGeneratorSpec;

    move-result-object v3

    .line 152
    .local v3, "spec":Landroid/security/KeyPairGeneratorSpec;
    const-string v4, "RSA"

    const-string v5, "AndroidKeyStore"

    invoke-static {v4, v5}, Ljava/security/KeyPairGenerator;->getInstance(Ljava/lang/String;Ljava/lang/String;)Ljava/security/KeyPairGenerator;

    move-result-object v4

    .line 155
    .local v4, "kpg":Ljava/security/KeyPairGenerator;
    invoke-virtual {v4, v3}, Ljava/security/KeyPairGenerator;->initialize(Ljava/security/spec/AlgorithmParameterSpec;)V

    .line 156
    invoke-virtual {v4}, Ljava/security/KeyPairGenerator;->generateKeyPair()Ljava/security/KeyPair;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_1
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 160
    .end local v0    # "keyStore":Ljava/security/KeyStore;
    .end local v1    # "start":Ljava/util/Calendar;
    .end local v2    # "end":Ljava/util/Calendar;
    .end local v3    # "spec":Landroid/security/KeyPairGeneratorSpec;
    .end local v4    # "kpg":Ljava/security/KeyPairGenerator;
    nop

    .line 164
    :try_start_1
    new-instance v0, Ljava/security/SecureRandom;

    invoke-direct {v0}, Ljava/security/SecureRandom;-><init>()V

    iput-object v0, p0, Lcom/amazonaws/internal/keyvaluestore/KeyProvider18;->secureRandom:Ljava/security/SecureRandom;

    .line 165
    const-string v0, "AES"

    invoke-static {v0}, Ljavax/crypto/KeyGenerator;->getInstance(Ljava/lang/String;)Ljavax/crypto/KeyGenerator;

    move-result-object v0

    .line 166
    .local v0, "generator":Ljavax/crypto/KeyGenerator;
    iget-object v1, p0, Lcom/amazonaws/internal/keyvaluestore/KeyProvider18;->secureRandom:Ljava/security/SecureRandom;

    const/16 v2, 0x100

    invoke-virtual {v0, v2, v1}, Ljavax/crypto/KeyGenerator;->init(ILjava/security/SecureRandom;)V

    .line 167
    invoke-virtual {v0}, Ljavax/crypto/KeyGenerator;->generateKey()Ljavax/crypto/SecretKey;

    move-result-object v1

    .line 168
    .local v1, "aesEncryptionKey":Ljavax/crypto/SecretKey;
    if-eqz v1, :cond_3

    .line 174
    invoke-interface {v1}, Ljavax/crypto/SecretKey;->getEncoded()[B

    move-result-object v2

    .line 175
    .local v2, "aesEncryptionKeyInBytes":[B
    if-eqz v2, :cond_2

    array-length v3, v2

    if-eqz v3, :cond_2

    .line 180
    invoke-direct {p0, p1, v2}, Lcom/amazonaws/internal/keyvaluestore/KeyProvider18;->rsaEncrypt(Ljava/lang/String;[B)[B

    move-result-object v3

    .line 181
    .local v3, "rsaEncryptedAESKeyInBytes":[B
    if-eqz v3, :cond_1

    array-length v4, v3

    if-eqz v4, :cond_1

    .line 187
    invoke-static {v3}, Lcom/amazonaws/util/Base64;->encodeAsString([B)Ljava/lang/String;

    move-result-object v4

    .line 188
    .local v4, "base64EncodedStringOfEncryptedAESKey":Ljava/lang/String;
    if-eqz v4, :cond_0

    .line 194
    iget-object v5, p0, Lcom/amazonaws/internal/keyvaluestore/KeyProvider18;->sharedPreferences:Landroid/content/SharedPreferences;

    invoke-interface {v5}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v5

    const-string v6, "AesGcmNoPadding18-encrypted-encryption-key"

    .line 195
    invoke-interface {v5, v6, v4}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v5

    .line 197
    invoke-interface {v5}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 199
    sget-object v5, Lcom/amazonaws/internal/keyvaluestore/KeyProvider18;->logger:Lcom/amazonaws/logging/Log;

    const-string v6, "Generated and saved the Encrypted AES encryption key for the AES keyAlias: AesGcmNoPadding18-encrypted-encryption-key to SharedPreferences."

    invoke-interface {v5, v6}, Lcom/amazonaws/logging/Log;->info(Ljava/lang/Object;)V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 201
    monitor-exit p0

    return-object v1

    .line 189
    .end local p0    # "this":Lcom/amazonaws/internal/keyvaluestore/KeyProvider18;
    :cond_0
    :try_start_2
    new-instance v5, Lcom/amazonaws/internal/keyvaluestore/KeyNotGeneratedException;

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "Error in Base64 encoding of the Encrypted AES key for the AES keyAlias: AesGcmNoPadding18-encrypted-encryption-key using the rsaKeyAlias: "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-direct {v5, v6}, Lcom/amazonaws/internal/keyvaluestore/KeyNotGeneratedException;-><init>(Ljava/lang/String;)V

    .end local p1    # "rsaKeyAlias":Ljava/lang/String;
    throw v5

    .line 182
    .end local v4    # "base64EncodedStringOfEncryptedAESKey":Ljava/lang/String;
    .restart local p1    # "rsaKeyAlias":Ljava/lang/String;
    :cond_1
    new-instance v4, Lcom/amazonaws/internal/keyvaluestore/KeyNotGeneratedException;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "Error in RSA encrypting the AES encryption key for the AES keyAlias: AesGcmNoPadding18-encrypted-encryption-key using the rsaKeyAlias: "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-direct {v4, v5}, Lcom/amazonaws/internal/keyvaluestore/KeyNotGeneratedException;-><init>(Ljava/lang/String;)V

    .end local p1    # "rsaKeyAlias":Ljava/lang/String;
    throw v4

    .line 176
    .end local v3    # "rsaEncryptedAESKeyInBytes":[B
    .restart local p1    # "rsaKeyAlias":Ljava/lang/String;
    :cond_2
    new-instance v3, Lcom/amazonaws/internal/keyvaluestore/KeyNotGeneratedException;

    const-string v4, "Error in generating the AES encryption key for the alias: AesGcmNoPadding18-encrypted-encryption-key"

    invoke-direct {v3, v4}, Lcom/amazonaws/internal/keyvaluestore/KeyNotGeneratedException;-><init>(Ljava/lang/String;)V

    .end local p1    # "rsaKeyAlias":Ljava/lang/String;
    throw v3

    .line 169
    .end local v2    # "aesEncryptionKeyInBytes":[B
    .restart local p1    # "rsaKeyAlias":Ljava/lang/String;
    :cond_3
    new-instance v2, Lcom/amazonaws/internal/keyvaluestore/KeyNotGeneratedException;

    const-string v3, "Error in generating the AES encryption key for the alias: AesGcmNoPadding18-encrypted-encryption-key"

    invoke-direct {v2, v3}, Lcom/amazonaws/internal/keyvaluestore/KeyNotGeneratedException;-><init>(Ljava/lang/String;)V

    .end local p1    # "rsaKeyAlias":Ljava/lang/String;
    throw v2
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_0
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 202
    .end local v0    # "generator":Ljavax/crypto/KeyGenerator;
    .end local v1    # "aesEncryptionKey":Ljavax/crypto/SecretKey;
    .restart local p1    # "rsaKeyAlias":Ljava/lang/String;
    :catch_0
    move-exception v0

    .line 203
    .local v0, "ex":Ljava/lang/Exception;
    :try_start_3
    new-instance v1, Lcom/amazonaws/internal/keyvaluestore/KeyNotGeneratedException;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Error in generating the AES key and RSA encrypting the AES key using the rsaKeyAlias: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " in "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "AndroidKeyStore"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2, v0}, Lcom/amazonaws/internal/keyvaluestore/KeyNotGeneratedException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    throw v1

    .line 138
    .end local v0    # "ex":Ljava/lang/Exception;
    .end local p1    # "rsaKeyAlias":Ljava/lang/String;
    :catchall_0
    move-exception p1

    goto :goto_0

    .line 157
    .restart local p1    # "rsaKeyAlias":Ljava/lang/String;
    :catch_1
    move-exception v0

    .line 158
    .restart local v0    # "ex":Ljava/lang/Exception;
    new-instance v1, Lcom/amazonaws/internal/keyvaluestore/KeyNotGeneratedException;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Error in generating the RSA Encryption key for the rsaKeyAlias: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " in "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "AndroidKeyStore"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2, v0}, Lcom/amazonaws/internal/keyvaluestore/KeyNotGeneratedException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    throw v1
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    .line 138
    .end local v0    # "ex":Ljava/lang/Exception;
    .end local p1    # "rsaKeyAlias":Ljava/lang/String;
    :goto_0
    monitor-exit p0

    throw p1
.end method

.method public declared-synchronized retrieveKey(Ljava/lang/String;)Ljava/security/Key;
    .locals 7
    .param p1, "keyAlias"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/internal/keyvaluestore/KeyNotFoundException;
        }
    .end annotation

    monitor-enter p0

    .line 212
    :try_start_0
    const-string v0, "AndroidKeyStore"

    invoke-static {v0}, Ljava/security/KeyStore;->getInstance(Ljava/lang/String;)Ljava/security/KeyStore;

    move-result-object v0

    .line 213
    .local v0, "keyStore":Ljava/security/KeyStore;
    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Ljava/security/KeyStore;->load(Ljava/security/KeyStore$LoadStoreParameter;)V

    .line 216
    invoke-virtual {v0, p1}, Ljava/security/KeyStore;->containsAlias(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_4

    .line 222
    iget-object v2, p0, Lcom/amazonaws/internal/keyvaluestore/KeyProvider18;->sharedPreferences:Landroid/content/SharedPreferences;

    const-string v3, "AesGcmNoPadding18-encrypted-encryption-key"

    invoke-interface {v2, v3}, Landroid/content/SharedPreferences;->contains(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_3

    .line 223
    sget-object v2, Lcom/amazonaws/internal/keyvaluestore/KeyProvider18;->logger:Lcom/amazonaws/logging/Log;

    const-string v3, "Loading the encryption key from SharedPreferences"

    invoke-interface {v2, v3}, Lcom/amazonaws/logging/Log;->debug(Ljava/lang/Object;)V

    .line 224
    iget-object v2, p0, Lcom/amazonaws/internal/keyvaluestore/KeyProvider18;->sharedPreferences:Landroid/content/SharedPreferences;

    const-string v3, "AesGcmNoPadding18-encrypted-encryption-key"

    .line 225
    invoke-interface {v2, v3, v1}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 226
    .local v1, "encryptedAesEncryptionKey":Ljava/lang/String;
    if-eqz v1, :cond_2

    .line 231
    invoke-static {v1}, Lcom/amazonaws/util/Base64;->decode(Ljava/lang/String;)[B

    move-result-object v2

    .line 232
    .local v2, "base64DecodedKey":[B
    if-eqz v2, :cond_1

    array-length v3, v2

    if-eqz v3, :cond_1

    .line 237
    invoke-direct {p0, p1, v2}, Lcom/amazonaws/internal/keyvaluestore/KeyProvider18;->rsaDecrypt(Ljava/lang/String;[B)[B

    move-result-object v3

    .line 238
    .local v3, "aesKey":[B
    if-eqz v3, :cond_0

    array-length v4, v3

    if-eqz v4, :cond_0

    .line 244
    new-instance v4, Ljavax/crypto/spec/SecretKeySpec;

    const-string v5, "AES"

    invoke-direct {v4, v3, v5}, Ljavax/crypto/spec/SecretKeySpec;-><init>([BLjava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return-object v4

    .line 239
    .end local p0    # "this":Lcom/amazonaws/internal/keyvaluestore/KeyProvider18;
    :cond_0
    :try_start_1
    new-instance v4, Lcom/amazonaws/internal/keyvaluestore/KeyNotFoundException;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "Unable to RSA decrypt the encrypted AES key identified by: AesGcmNoPadding18-encrypted-encryption-key using the RSA key identified by keyAlias: "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-direct {v4, v5}, Lcom/amazonaws/internal/keyvaluestore/KeyNotFoundException;-><init>(Ljava/lang/String;)V

    .end local p1    # "keyAlias":Ljava/lang/String;
    throw v4

    .line 233
    .end local v3    # "aesKey":[B
    .restart local p1    # "keyAlias":Ljava/lang/String;
    :cond_1
    new-instance v3, Lcom/amazonaws/internal/keyvaluestore/KeyNotFoundException;

    const-string v4, "Unable to Base64 decode the encrypted AES key identified by: AesGcmNoPadding18-encrypted-encryption-key"

    invoke-direct {v3, v4}, Lcom/amazonaws/internal/keyvaluestore/KeyNotFoundException;-><init>(Ljava/lang/String;)V

    .end local p1    # "keyAlias":Ljava/lang/String;
    throw v3

    .line 227
    .end local v2    # "base64DecodedKey":[B
    .restart local p1    # "keyAlias":Ljava/lang/String;
    :cond_2
    new-instance v2, Lcom/amazonaws/internal/keyvaluestore/KeyNotFoundException;

    const-string v3, "Unable to retrieve the encrypted AES Key identified by AesGcmNoPadding18-encrypted-encryption-key from the SharedPreferences."

    invoke-direct {v2, v3}, Lcom/amazonaws/internal/keyvaluestore/KeyNotFoundException;-><init>(Ljava/lang/String;)V

    .end local p1    # "keyAlias":Ljava/lang/String;
    throw v2

    .line 246
    .end local v1    # "encryptedAesEncryptionKey":Ljava/lang/String;
    .restart local p1    # "keyAlias":Ljava/lang/String;
    :cond_3
    new-instance v1, Lcom/amazonaws/internal/keyvaluestore/KeyNotFoundException;

    const-string v2, "SharedPreferences does not have the key for keyAlias: AesGcmNoPadding18-encrypted-encryption-key"

    invoke-direct {v1, v2}, Lcom/amazonaws/internal/keyvaluestore/KeyNotFoundException;-><init>(Ljava/lang/String;)V

    .end local p1    # "keyAlias":Ljava/lang/String;
    throw v1

    .line 217
    .restart local p1    # "keyAlias":Ljava/lang/String;
    :cond_4
    new-instance v1, Lcom/amazonaws/internal/keyvaluestore/KeyNotFoundException;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "The RSA Key identified by the alias: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " cannot be found in "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "AndroidKeyStore"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2}, Lcom/amazonaws/internal/keyvaluestore/KeyNotFoundException;-><init>(Ljava/lang/String;)V

    .end local p1    # "keyAlias":Ljava/lang/String;
    throw v1
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 211
    .end local v0    # "keyStore":Ljava/security/KeyStore;
    :catchall_0
    move-exception p1

    goto :goto_0

    .line 249
    .restart local p1    # "keyAlias":Ljava/lang/String;
    :catch_0
    move-exception v0

    .line 250
    .local v0, "ex":Ljava/lang/Exception;
    :try_start_2
    new-instance v1, Lcom/amazonaws/internal/keyvaluestore/KeyNotFoundException;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Error occurred while accessing AndroidKeyStore to retrieve the key for keyAlias: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2, v0}, Lcom/amazonaws/internal/keyvaluestore/KeyNotFoundException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    throw v1
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 211
    .end local v0    # "ex":Ljava/lang/Exception;
    .end local p1    # "keyAlias":Ljava/lang/String;
    :goto_0
    monitor-exit p0

    throw p1
.end method
