.class final Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;
.super Ljava/lang/Object;
.source "ContentCryptoMaterial.java"


# annotations
.annotation runtime Ljava/lang/Deprecated;
.end annotation


# instance fields
.field private final cipherLite:Lcom/amazonaws/services/s3/internal/crypto/CipherLite;

.field private final encryptedCEK:[B

.field private final kekMaterialsDescription:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private final keyWrappingAlgorithm:Ljava/lang/String;


# direct methods
.method constructor <init>(Ljava/util/Map;[BLjava/lang/String;Lcom/amazonaws/services/s3/internal/crypto/CipherLite;)V
    .locals 1
    .param p2, "encryptedCEK"    # [B
    .param p3, "keyWrappingAlgorithm"    # Ljava/lang/String;
    .param p4, "cipherLite"    # Lcom/amazonaws/services/s3/internal/crypto/CipherLite;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;[B",
            "Ljava/lang/String;",
            "Lcom/amazonaws/services/s3/internal/crypto/CipherLite;",
            ")V"
        }
    .end annotation

    .line 81
    .local p1, "kekMaterialsDescription":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 82
    iput-object p4, p0, Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;->cipherLite:Lcom/amazonaws/services/s3/internal/crypto/CipherLite;

    .line 83
    iput-object p3, p0, Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;->keyWrappingAlgorithm:Ljava/lang/String;

    .line 84
    invoke-virtual {p2}, [B->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [B

    iput-object v0, p0, Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;->encryptedCEK:[B

    .line 85
    iput-object p1, p0, Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;->kekMaterialsDescription:Ljava/util/Map;

    .line 86
    return-void
.end method

.method private static cek([BLjava/lang/String;Lcom/amazonaws/services/s3/model/EncryptionMaterials;Ljava/security/Provider;Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoScheme;Lcom/amazonaws/services/kms/AWSKMSClient;)Ljavax/crypto/SecretKey;
    .locals 5
    .param p0, "cekSecured"    # [B
    .param p1, "keyWrapAlgo"    # Ljava/lang/String;
    .param p2, "materials"    # Lcom/amazonaws/services/s3/model/EncryptionMaterials;
    .param p3, "securityProvider"    # Ljava/security/Provider;
    .param p4, "contentCryptoScheme"    # Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoScheme;
    .param p5, "kms"    # Lcom/amazonaws/services/kms/AWSKMSClient;

    .line 268
    invoke-static {p1}, Lcom/amazonaws/services/s3/internal/crypto/KMSSecuredCEK;->isKMSKeyWrapped(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 269
    invoke-static {p0, p1, p2, p4, p5}, Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;->cekByKMS([BLjava/lang/String;Lcom/amazonaws/services/s3/model/EncryptionMaterials;Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoScheme;Lcom/amazonaws/services/kms/AWSKMSClient;)Ljavax/crypto/SecretKey;

    move-result-object v0

    return-object v0

    .line 272
    :cond_0
    invoke-virtual {p2}, Lcom/amazonaws/services/s3/model/EncryptionMaterials;->getKeyPair()Ljava/security/KeyPair;

    move-result-object v0

    const-string v1, "Key encrypting key not available"

    if-eqz v0, :cond_2

    .line 274
    invoke-virtual {p2}, Lcom/amazonaws/services/s3/model/EncryptionMaterials;->getKeyPair()Ljava/security/KeyPair;

    move-result-object v0

    invoke-virtual {v0}, Ljava/security/KeyPair;->getPrivate()Ljava/security/PrivateKey;

    move-result-object v0

    .line 275
    .local v0, "kek":Ljava/security/Key;
    if-eqz v0, :cond_1

    goto :goto_0

    .line 276
    :cond_1
    new-instance v2, Lcom/amazonaws/AmazonClientException;

    invoke-direct {v2, v1}, Lcom/amazonaws/AmazonClientException;-><init>(Ljava/lang/String;)V

    throw v2

    .line 280
    .end local v0    # "kek":Ljava/security/Key;
    :cond_2
    invoke-virtual {p2}, Lcom/amazonaws/services/s3/model/EncryptionMaterials;->getSymmetricKey()Ljavax/crypto/SecretKey;

    move-result-object v0

    .line 281
    .restart local v0    # "kek":Ljava/security/Key;
    if-eqz v0, :cond_6

    .line 287
    :goto_0
    if-eqz p1, :cond_4

    .line 289
    if-nez p3, :cond_3

    .line 290
    :try_start_0
    invoke-static {p1}, Ljavax/crypto/Cipher;->getInstance(Ljava/lang/String;)Ljavax/crypto/Cipher;

    move-result-object v1

    goto :goto_1

    :cond_3
    invoke-static {p1, p3}, Ljavax/crypto/Cipher;->getInstance(Ljava/lang/String;Ljava/security/Provider;)Ljavax/crypto/Cipher;

    move-result-object v1

    .line 292
    .local v1, "cipher":Ljavax/crypto/Cipher;
    :goto_1
    const/4 v2, 0x4

    invoke-virtual {v1, v2, v0}, Ljavax/crypto/Cipher;->init(ILjava/security/Key;)V

    .line 293
    const/4 v2, 0x3

    invoke-virtual {v1, p0, p1, v2}, Ljavax/crypto/Cipher;->unwrap([BLjava/lang/String;I)Ljava/security/Key;

    move-result-object v2

    check-cast v2, Ljavax/crypto/SecretKey;

    return-object v2

    .line 298
    .end local v1    # "cipher":Ljavax/crypto/Cipher;
    :cond_4
    if-eqz p3, :cond_5

    .line 299
    invoke-interface {v0}, Ljava/security/Key;->getAlgorithm()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1, p3}, Ljavax/crypto/Cipher;->getInstance(Ljava/lang/String;Ljava/security/Provider;)Ljavax/crypto/Cipher;

    move-result-object v1

    .restart local v1    # "cipher":Ljavax/crypto/Cipher;
    goto :goto_2

    .line 302
    .end local v1    # "cipher":Ljavax/crypto/Cipher;
    :cond_5
    invoke-interface {v0}, Ljava/security/Key;->getAlgorithm()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Ljavax/crypto/Cipher;->getInstance(Ljava/lang/String;)Ljavax/crypto/Cipher;

    move-result-object v1

    .line 304
    .restart local v1    # "cipher":Ljavax/crypto/Cipher;
    :goto_2
    const/4 v2, 0x2

    invoke-virtual {v1, v2, v0}, Ljavax/crypto/Cipher;->init(ILjava/security/Key;)V

    .line 305
    invoke-virtual {v1, p0}, Ljavax/crypto/Cipher;->doFinal([B)[B

    move-result-object v2

    .line 306
    .local v2, "decryptedSymmetricKeyBytes":[B
    new-instance v3, Ljavax/crypto/spec/SecretKeySpec;

    const-string v4, "AES"

    invoke-direct {v3, v2, v4}, Ljavax/crypto/spec/SecretKeySpec;-><init>([BLjava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-object v3

    .line 308
    .end local v1    # "cipher":Ljavax/crypto/Cipher;
    .end local v2    # "decryptedSymmetricKeyBytes":[B
    :catch_0
    move-exception v1

    .line 309
    .local v1, "e":Ljava/lang/Exception;
    new-instance v2, Lcom/amazonaws/AmazonClientException;

    const-string v3, "Unable to decrypt symmetric key from object metadata"

    invoke-direct {v2, v3, v1}, Lcom/amazonaws/AmazonClientException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    throw v2

    .line 282
    .end local v1    # "e":Ljava/lang/Exception;
    :cond_6
    new-instance v2, Lcom/amazonaws/AmazonClientException;

    invoke-direct {v2, v1}, Lcom/amazonaws/AmazonClientException;-><init>(Ljava/lang/String;)V

    throw v2
.end method

.method private static cekByKMS([BLjava/lang/String;Lcom/amazonaws/services/s3/model/EncryptionMaterials;Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoScheme;Lcom/amazonaws/services/kms/AWSKMSClient;)Ljavax/crypto/SecretKey;
    .locals 5
    .param p0, "cekSecured"    # [B
    .param p1, "keyWrapAlgo"    # Ljava/lang/String;
    .param p2, "materials"    # Lcom/amazonaws/services/s3/model/EncryptionMaterials;
    .param p3, "contentCryptoScheme"    # Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoScheme;
    .param p4, "kms"    # Lcom/amazonaws/services/kms/AWSKMSClient;

    .line 322
    new-instance v0, Lcom/amazonaws/services/kms/model/DecryptRequest;

    invoke-direct {v0}, Lcom/amazonaws/services/kms/model/DecryptRequest;-><init>()V

    .line 323
    invoke-virtual {p2}, Lcom/amazonaws/services/s3/model/EncryptionMaterials;->getMaterialsDescription()Ljava/util/Map;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/amazonaws/services/kms/model/DecryptRequest;->withEncryptionContext(Ljava/util/Map;)Lcom/amazonaws/services/kms/model/DecryptRequest;

    move-result-object v0

    .line 324
    invoke-static {p0}, Ljava/nio/ByteBuffer;->wrap([B)Ljava/nio/ByteBuffer;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/amazonaws/services/kms/model/DecryptRequest;->withCiphertextBlob(Ljava/nio/ByteBuffer;)Lcom/amazonaws/services/kms/model/DecryptRequest;

    move-result-object v0

    .line 325
    .local v0, "kmsreq":Lcom/amazonaws/services/kms/model/DecryptRequest;
    invoke-virtual {p4, v0}, Lcom/amazonaws/services/kms/AWSKMSClient;->decrypt(Lcom/amazonaws/services/kms/model/DecryptRequest;)Lcom/amazonaws/services/kms/model/DecryptResult;

    move-result-object v1

    .line 326
    .local v1, "result":Lcom/amazonaws/services/kms/model/DecryptResult;
    new-instance v2, Ljavax/crypto/spec/SecretKeySpec;

    invoke-virtual {v1}, Lcom/amazonaws/services/kms/model/DecryptResult;->getPlaintext()Ljava/nio/ByteBuffer;

    move-result-object v3

    invoke-static {v3}, Lcom/amazonaws/util/BinaryUtils;->copyAllBytesFrom(Ljava/nio/ByteBuffer;)[B

    move-result-object v3

    .line 327
    invoke-virtual {p3}, Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoScheme;->getKeyGeneratorAlgorithm()Ljava/lang/String;

    move-result-object v4

    invoke-direct {v2, v3, v4}, Ljavax/crypto/spec/SecretKeySpec;-><init>([BLjava/lang/String;)V

    .line 326
    return-object v2
.end method

.method private static convertStreamToString(Ljava/io/InputStream;)Ljava/lang/String;
    .locals 4
    .param p0, "inputStream"    # Ljava/io/InputStream;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 580
    if-nez p0, :cond_0

    .line 581
    const-string v0, ""

    return-object v0

    .line 583
    :cond_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 586
    .local v0, "stringBuilder":Ljava/lang/StringBuilder;
    :try_start_0
    new-instance v1, Ljava/io/BufferedReader;

    new-instance v2, Ljava/io/InputStreamReader;

    sget-object v3, Lcom/amazonaws/util/StringUtils;->UTF8:Ljava/nio/charset/Charset;

    invoke-direct {v2, p0, v3}, Ljava/io/InputStreamReader;-><init>(Ljava/io/InputStream;Ljava/nio/charset/Charset;)V

    invoke-direct {v1, v2}, Ljava/io/BufferedReader;-><init>(Ljava/io/Reader;)V

    .line 589
    .local v1, "reader":Ljava/io/BufferedReader;
    :goto_0
    invoke-virtual {v1}, Ljava/io/BufferedReader;->readLine()Ljava/lang/String;

    move-result-object v2

    move-object v3, v2

    .local v3, "line":Ljava/lang/String;
    if-eqz v2, :cond_1

    .line 590
    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    .line 593
    .end local v1    # "reader":Ljava/io/BufferedReader;
    :cond_1
    invoke-virtual {p0}, Ljava/io/InputStream;->close()V

    .line 594
    nop

    .line 595
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    return-object v1

    .line 593
    .end local v3    # "line":Ljava/lang/String;
    :catchall_0
    move-exception v1

    invoke-virtual {p0}, Ljava/io/InputStream;->close()V

    .line 594
    throw v1
.end method

.method static create(Ljavax/crypto/SecretKey;[BLcom/amazonaws/services/s3/model/EncryptionMaterials;Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoScheme;Lcom/amazonaws/services/s3/internal/crypto/S3CryptoScheme;Ljava/security/Provider;Lcom/amazonaws/services/kms/AWSKMSClient;Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;
    .locals 1
    .param p0, "cek"    # Ljavax/crypto/SecretKey;
    .param p1, "iv"    # [B
    .param p2, "kekMaterials"    # Lcom/amazonaws/services/s3/model/EncryptionMaterials;
    .param p3, "contentCryptoScheme"    # Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoScheme;
    .param p4, "targetScheme"    # Lcom/amazonaws/services/s3/internal/crypto/S3CryptoScheme;
    .param p5, "provider"    # Ljava/security/Provider;
    .param p6, "kms"    # Lcom/amazonaws/services/kms/AWSKMSClient;
    .param p7, "req"    # Lcom/amazonaws/AmazonWebServiceRequest;

    .line 758
    invoke-static/range {p0 .. p7}, Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;->doCreate(Ljavax/crypto/SecretKey;[BLcom/amazonaws/services/s3/model/EncryptionMaterials;Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoScheme;Lcom/amazonaws/services/s3/internal/crypto/S3CryptoScheme;Ljava/security/Provider;Lcom/amazonaws/services/kms/AWSKMSClient;Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;

    move-result-object v0

    return-object v0
.end method

.method static create(Ljavax/crypto/SecretKey;[BLcom/amazonaws/services/s3/model/EncryptionMaterials;Lcom/amazonaws/services/s3/internal/crypto/S3CryptoScheme;Ljava/security/Provider;Lcom/amazonaws/services/kms/AWSKMSClient;Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;
    .locals 8
    .param p0, "cek"    # Ljavax/crypto/SecretKey;
    .param p1, "iv"    # [B
    .param p2, "kekMaterials"    # Lcom/amazonaws/services/s3/model/EncryptionMaterials;
    .param p3, "scheme"    # Lcom/amazonaws/services/s3/internal/crypto/S3CryptoScheme;
    .param p4, "provider"    # Ljava/security/Provider;
    .param p5, "kms"    # Lcom/amazonaws/services/kms/AWSKMSClient;
    .param p6, "req"    # Lcom/amazonaws/AmazonWebServiceRequest;

    .line 784
    invoke-virtual {p3}, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoScheme;->getContentCryptoScheme()Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoScheme;

    move-result-object v3

    move-object v0, p0

    move-object v1, p1

    move-object v2, p2

    move-object v4, p3

    move-object v5, p4

    move-object v6, p5

    move-object v7, p6

    invoke-static/range {v0 .. v7}, Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;->doCreate(Ljavax/crypto/SecretKey;[BLcom/amazonaws/services/s3/model/EncryptionMaterials;Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoScheme;Lcom/amazonaws/services/s3/internal/crypto/S3CryptoScheme;Ljava/security/Provider;Lcom/amazonaws/services/kms/AWSKMSClient;Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;

    move-result-object v0

    return-object v0
.end method

.method private static doCreate(Ljavax/crypto/SecretKey;[BLcom/amazonaws/services/s3/model/EncryptionMaterials;Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoScheme;Lcom/amazonaws/services/s3/internal/crypto/S3CryptoScheme;Ljava/security/Provider;Lcom/amazonaws/services/kms/AWSKMSClient;Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;
    .locals 7
    .param p0, "cek"    # Ljavax/crypto/SecretKey;
    .param p1, "iv"    # [B
    .param p2, "kekMaterials"    # Lcom/amazonaws/services/s3/model/EncryptionMaterials;
    .param p3, "contentCryptoScheme"    # Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoScheme;
    .param p4, "targetS3CryptoScheme"    # Lcom/amazonaws/services/s3/internal/crypto/S3CryptoScheme;
    .param p5, "provider"    # Ljava/security/Provider;
    .param p6, "kms"    # Lcom/amazonaws/services/kms/AWSKMSClient;
    .param p7, "req"    # Lcom/amazonaws/AmazonWebServiceRequest;

    .line 824
    nop

    .line 825
    invoke-virtual {p4}, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoScheme;->getKeyWrapScheme()Lcom/amazonaws/services/s3/internal/crypto/S3KeyWrapScheme;

    move-result-object v2

    .line 826
    invoke-virtual {p4}, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoScheme;->getSecureRandom()Ljava/security/SecureRandom;

    move-result-object v3

    .line 824
    move-object v0, p0

    move-object v1, p2

    move-object v4, p5

    move-object v5, p6

    move-object v6, p7

    invoke-static/range {v0 .. v6}, Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;->secureCEK(Ljavax/crypto/SecretKey;Lcom/amazonaws/services/s3/model/EncryptionMaterials;Lcom/amazonaws/services/s3/internal/crypto/S3KeyWrapScheme;Ljava/security/SecureRandom;Ljava/security/Provider;Lcom/amazonaws/services/kms/AWSKMSClient;Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/services/s3/internal/crypto/SecuredCEK;

    move-result-object v0

    .line 828
    .local v0, "cekSecured":Lcom/amazonaws/services/s3/internal/crypto/SecuredCEK;
    invoke-static {p0, p1, p3, p5, v0}, Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;->wrap(Ljavax/crypto/SecretKey;[BLcom/amazonaws/services/s3/internal/crypto/ContentCryptoScheme;Ljava/security/Provider;Lcom/amazonaws/services/s3/internal/crypto/SecuredCEK;)Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;

    move-result-object v1

    return-object v1
.end method

.method static fromInstructionFile(Ljava/util/Map;Lcom/amazonaws/services/s3/model/EncryptionMaterialsAccessor;Ljava/security/Provider;ZLcom/amazonaws/services/kms/AWSKMSClient;)Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;
    .locals 7
    .param p1, "kekMaterialAccessor"    # Lcom/amazonaws/services/s3/model/EncryptionMaterialsAccessor;
    .param p2, "securityProvider"    # Ljava/security/Provider;
    .param p3, "keyWrapExpected"    # Z
    .param p4, "kms"    # Lcom/amazonaws/services/kms/AWSKMSClient;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;",
            "Lcom/amazonaws/services/s3/model/EncryptionMaterialsAccessor;",
            "Ljava/security/Provider;",
            "Z",
            "Lcom/amazonaws/services/kms/AWSKMSClient;",
            ")",
            "Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;"
        }
    .end annotation

    .line 457
    .local p0, "instFile":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    const/4 v3, 0x0

    sget-object v4, Lcom/amazonaws/services/s3/model/ExtraMaterialsDescription;->NONE:Lcom/amazonaws/services/s3/model/ExtraMaterialsDescription;

    move-object v0, p0

    move-object v1, p1

    move-object v2, p2

    move v5, p3

    move-object v6, p4

    invoke-static/range {v0 .. v6}, Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;->fromInstructionFile0(Ljava/util/Map;Lcom/amazonaws/services/s3/model/EncryptionMaterialsAccessor;Ljava/security/Provider;[JLcom/amazonaws/services/s3/model/ExtraMaterialsDescription;ZLcom/amazonaws/services/kms/AWSKMSClient;)Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;

    move-result-object v0

    return-object v0
.end method

.method static fromInstructionFile(Ljava/util/Map;Lcom/amazonaws/services/s3/model/EncryptionMaterialsAccessor;Ljava/security/Provider;[JLcom/amazonaws/services/s3/model/ExtraMaterialsDescription;ZLcom/amazonaws/services/kms/AWSKMSClient;)Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;
    .locals 1
    .param p1, "kekMaterialAccessor"    # Lcom/amazonaws/services/s3/model/EncryptionMaterialsAccessor;
    .param p2, "securityProvider"    # Ljava/security/Provider;
    .param p3, "range"    # [J
    .param p4, "extra"    # Lcom/amazonaws/services/s3/model/ExtraMaterialsDescription;
    .param p5, "keyWrapExpected"    # Z
    .param p6, "kms"    # Lcom/amazonaws/services/kms/AWSKMSClient;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;",
            "Lcom/amazonaws/services/s3/model/EncryptionMaterialsAccessor;",
            "Ljava/security/Provider;",
            "[J",
            "Lcom/amazonaws/services/s3/model/ExtraMaterialsDescription;",
            "Z",
            "Lcom/amazonaws/services/kms/AWSKMSClient;",
            ")",
            "Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;"
        }
    .end annotation

    .line 476
    .local p0, "instFile":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    invoke-static/range {p0 .. p6}, Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;->fromInstructionFile0(Ljava/util/Map;Lcom/amazonaws/services/s3/model/EncryptionMaterialsAccessor;Ljava/security/Provider;[JLcom/amazonaws/services/s3/model/ExtraMaterialsDescription;ZLcom/amazonaws/services/kms/AWSKMSClient;)Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;

    move-result-object v0

    return-object v0
.end method

.method private static fromInstructionFile0(Ljava/util/Map;Lcom/amazonaws/services/s3/model/EncryptionMaterialsAccessor;Ljava/security/Provider;[JLcom/amazonaws/services/s3/model/ExtraMaterialsDescription;ZLcom/amazonaws/services/kms/AWSKMSClient;)Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;
    .locals 19
    .param p1, "kekMaterialAccessor"    # Lcom/amazonaws/services/s3/model/EncryptionMaterialsAccessor;
    .param p2, "securityProvider"    # Ljava/security/Provider;
    .param p3, "range"    # [J
    .param p4, "extra"    # Lcom/amazonaws/services/s3/model/ExtraMaterialsDescription;
    .param p5, "keyWrapExpected"    # Z
    .param p6, "kms"    # Lcom/amazonaws/services/kms/AWSKMSClient;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;",
            "Lcom/amazonaws/services/s3/model/EncryptionMaterialsAccessor;",
            "Ljava/security/Provider;",
            "[J",
            "Lcom/amazonaws/services/s3/model/ExtraMaterialsDescription;",
            "Z",
            "Lcom/amazonaws/services/kms/AWSKMSClient;",
            ")",
            "Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;"
        }
    .end annotation

    .line 492
    .local p0, "instFile":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    move-object/from16 v0, p0

    move-object/from16 v1, p1

    move-object/from16 v2, p4

    const-string/jumbo v3, "x-amz-key-v2"

    invoke-interface {v0, v3}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/String;

    .line 493
    .local v3, "b64key":Ljava/lang/String;
    if-nez v3, :cond_1

    .line 494
    const-string/jumbo v4, "x-amz-key"

    invoke-interface {v0, v4}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v4

    move-object v3, v4

    check-cast v3, Ljava/lang/String;

    .line 495
    if-eqz v3, :cond_0

    goto :goto_0

    .line 496
    :cond_0
    new-instance v4, Lcom/amazonaws/AmazonClientException;

    const-string v5, "Content encrypting key not found."

    invoke-direct {v4, v5}, Lcom/amazonaws/AmazonClientException;-><init>(Ljava/lang/String;)V

    throw v4

    .line 500
    :cond_1
    :goto_0
    invoke-static {v3}, Lcom/amazonaws/util/Base64;->decode(Ljava/lang/String;)[B

    move-result-object v10

    .line 501
    .local v10, "cekWrapped":[B
    const-string/jumbo v4, "x-amz-iv"

    invoke-interface {v0, v4}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/String;

    invoke-static {v4}, Lcom/amazonaws/util/Base64;->decode(Ljava/lang/String;)[B

    move-result-object v4

    .line 502
    .local v4, "iv":[B
    if-eqz v10, :cond_d

    if-eqz v4, :cond_d

    .line 507
    const-string/jumbo v5, "x-amz-wrap-alg"

    invoke-interface {v0, v5}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v5

    move-object v11, v5

    check-cast v11, Ljava/lang/String;

    .line 508
    .local v11, "keyWrapAlgo":Ljava/lang/String;
    invoke-static {v11}, Lcom/amazonaws/services/s3/internal/crypto/KMSSecuredCEK;->isKMSKeyWrapped(Ljava/lang/String;)Z

    move-result v12

    .line 510
    .local v12, "isKMS":Z
    const-string/jumbo v5, "x-amz-matdesc"

    invoke-interface {v0, v5}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v5

    move-object v13, v5

    check-cast v13, Ljava/lang/String;

    .line 511
    .local v13, "matdescStr":Ljava/lang/String;
    invoke-static {v13}, Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;->matdescFromJson(Ljava/lang/String;)Ljava/util/Map;

    move-result-object v14

    .line 512
    .local v14, "core":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    if-eqz v2, :cond_3

    if-eqz v12, :cond_2

    goto :goto_1

    .line 513
    :cond_2
    invoke-virtual {v2, v14}, Lcom/amazonaws/services/s3/model/ExtraMaterialsDescription;->mergeInto(Ljava/util/Map;)Ljava/util/Map;

    move-result-object v5

    goto :goto_2

    .line 512
    :cond_3
    :goto_1
    move-object v5, v14

    .line 513
    :goto_2
    move-object v15, v5

    .line 515
    .local v15, "merged":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    if-eqz v12, :cond_4

    .line 516
    new-instance v5, Lcom/amazonaws/services/s3/model/KMSEncryptionMaterials;

    .line 517
    const-string v6, "kms_cmk_id"

    invoke-interface {v14, v6}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Ljava/lang/String;

    invoke-direct {v5, v6}, Lcom/amazonaws/services/s3/model/KMSEncryptionMaterials;-><init>(Ljava/lang/String;)V

    .line 518
    .local v5, "materials":Lcom/amazonaws/services/s3/model/EncryptionMaterials;
    invoke-virtual {v5, v14}, Lcom/amazonaws/services/s3/model/EncryptionMaterials;->addDescriptions(Ljava/util/Map;)Lcom/amazonaws/services/s3/model/EncryptionMaterials;

    move-object/from16 v16, v5

    goto :goto_4

    .line 520
    .end local v5    # "materials":Lcom/amazonaws/services/s3/model/EncryptionMaterials;
    :cond_4
    if-nez v1, :cond_5

    const/4 v5, 0x0

    goto :goto_3

    .line 522
    :cond_5
    invoke-interface {v1, v15}, Lcom/amazonaws/services/s3/model/EncryptionMaterialsAccessor;->getEncryptionMaterials(Ljava/util/Map;)Lcom/amazonaws/services/s3/model/EncryptionMaterials;

    move-result-object v5

    :goto_3
    nop

    .line 523
    .restart local v5    # "materials":Lcom/amazonaws/services/s3/model/EncryptionMaterials;
    if-eqz v5, :cond_c

    move-object/from16 v16, v5

    .line 531
    .end local v5    # "materials":Lcom/amazonaws/services/s3/model/EncryptionMaterials;
    .local v16, "materials":Lcom/amazonaws/services/s3/model/EncryptionMaterials;
    :goto_4
    const-string/jumbo v5, "x-amz-cek-alg"

    invoke-interface {v0, v5}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v5

    move-object v9, v5

    check-cast v9, Ljava/lang/String;

    .line 532
    .local v9, "cekAlgo":Ljava/lang/String;
    const/4 v5, 0x0

    if-eqz p3, :cond_6

    const/4 v6, 0x1

    goto :goto_5

    :cond_6
    move v6, v5

    :goto_5
    move v8, v6

    .line 535
    .local v8, "isRangeGet":Z
    nop

    .line 536
    invoke-static {v9, v8}, Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoScheme;->fromCEKAlgo(Ljava/lang/String;Z)Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoScheme;

    move-result-object v7

    .line 537
    .local v7, "contentCryptoScheme":Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoScheme;
    if-eqz v8, :cond_7

    .line 539
    aget-wide v5, p3, v5

    invoke-virtual {v7, v4, v5, v6}, Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoScheme;->adjustIV([BJ)[B

    move-result-object v4

    move-object/from16 v17, v3

    move-object v1, v4

    goto :goto_7

    .line 542
    :cond_7
    invoke-virtual {v7}, Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoScheme;->getTagLengthInBits()I

    move-result v5

    .line 543
    .local v5, "tagLenExpected":I
    if-lez v5, :cond_9

    .line 544
    const-string/jumbo v6, "x-amz-tag-len"

    invoke-interface {v0, v6}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Ljava/lang/String;

    .line 545
    .local v6, "s":Ljava/lang/String;
    invoke-static {v6}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v1

    .line 546
    .local v1, "tagLenActual":I
    if-ne v5, v1, :cond_8

    move-object/from16 v17, v3

    move-object/from16 v18, v4

    goto :goto_6

    .line 547
    :cond_8
    new-instance v2, Lcom/amazonaws/AmazonClientException;

    move-object/from16 v17, v3

    .end local v3    # "b64key":Ljava/lang/String;
    .local v17, "b64key":Ljava/lang/String;
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    move-object/from16 v18, v4

    .end local v4    # "iv":[B
    .local v18, "iv":[B
    const-string v4, "Unsupported tag length: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, ", expected: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-direct {v2, v3}, Lcom/amazonaws/AmazonClientException;-><init>(Ljava/lang/String;)V

    throw v2

    .line 543
    .end local v1    # "tagLenActual":I
    .end local v6    # "s":Ljava/lang/String;
    .end local v17    # "b64key":Ljava/lang/String;
    .end local v18    # "iv":[B
    .restart local v3    # "b64key":Ljava/lang/String;
    .restart local v4    # "iv":[B
    :cond_9
    move-object/from16 v17, v3

    move-object/from16 v18, v4

    .line 553
    .end local v3    # "b64key":Ljava/lang/String;
    .end local v4    # "iv":[B
    .end local v5    # "tagLenExpected":I
    .restart local v17    # "b64key":Ljava/lang/String;
    .restart local v18    # "iv":[B
    :goto_6
    move-object/from16 v1, v18

    .end local v18    # "iv":[B
    .local v1, "iv":[B
    :goto_7
    if-eqz p5, :cond_b

    if-eqz v11, :cond_a

    goto :goto_8

    .line 554
    :cond_a
    invoke-static {}, Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;->newKeyWrapException()Lcom/amazonaws/services/s3/KeyWrapException;

    move-result-object v2

    throw v2

    .line 556
    :cond_b
    :goto_8
    move-object v4, v10

    move-object v5, v11

    move-object/from16 v6, v16

    move-object v2, v7

    .end local v7    # "contentCryptoScheme":Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoScheme;
    .local v2, "contentCryptoScheme":Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoScheme;
    move-object/from16 v7, p2

    move v3, v8

    .end local v8    # "isRangeGet":Z
    .local v3, "isRangeGet":Z
    move-object v8, v2

    move-object/from16 v18, v9

    .end local v9    # "cekAlgo":Ljava/lang/String;
    .local v18, "cekAlgo":Ljava/lang/String;
    move-object/from16 v9, p6

    invoke-static/range {v4 .. v9}, Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;->cek([BLjava/lang/String;Lcom/amazonaws/services/s3/model/EncryptionMaterials;Ljava/security/Provider;Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoScheme;Lcom/amazonaws/services/kms/AWSKMSClient;)Ljavax/crypto/SecretKey;

    move-result-object v4

    .line 558
    .local v4, "cek":Ljavax/crypto/SecretKey;
    new-instance v5, Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;

    .line 559
    const/4 v6, 0x2

    invoke-virtual {v2, v4, v1, v6, v7}, Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoScheme;->createCipherLite(Ljavax/crypto/SecretKey;[BILjava/security/Provider;)Lcom/amazonaws/services/s3/internal/crypto/CipherLite;

    move-result-object v6

    invoke-direct {v5, v15, v10, v11, v6}, Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;-><init>(Ljava/util/Map;[BLjava/lang/String;Lcom/amazonaws/services/s3/internal/crypto/CipherLite;)V

    .line 558
    return-object v5

    .line 524
    .end local v1    # "iv":[B
    .end local v2    # "contentCryptoScheme":Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoScheme;
    .end local v16    # "materials":Lcom/amazonaws/services/s3/model/EncryptionMaterials;
    .end local v17    # "b64key":Ljava/lang/String;
    .end local v18    # "cekAlgo":Ljava/lang/String;
    .local v3, "b64key":Ljava/lang/String;
    .local v4, "iv":[B
    .local v5, "materials":Lcom/amazonaws/services/s3/model/EncryptionMaterials;
    :cond_c
    move-object/from16 v17, v3

    .end local v3    # "b64key":Ljava/lang/String;
    .restart local v17    # "b64key":Ljava/lang/String;
    new-instance v1, Lcom/amazonaws/AmazonClientException;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Unable to retrieve the encryption materials that originally encrypted object corresponding to instruction file "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2}, Lcom/amazonaws/AmazonClientException;-><init>(Ljava/lang/String;)V

    throw v1

    .line 502
    .end local v5    # "materials":Lcom/amazonaws/services/s3/model/EncryptionMaterials;
    .end local v11    # "keyWrapAlgo":Ljava/lang/String;
    .end local v12    # "isKMS":Z
    .end local v13    # "matdescStr":Ljava/lang/String;
    .end local v14    # "core":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .end local v15    # "merged":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .end local v17    # "b64key":Ljava/lang/String;
    .restart local v3    # "b64key":Ljava/lang/String;
    :cond_d
    move-object/from16 v7, p2

    move-object/from16 v17, v3

    move-object/from16 v18, v4

    .line 503
    .end local v3    # "b64key":Ljava/lang/String;
    .end local v4    # "iv":[B
    .restart local v17    # "b64key":Ljava/lang/String;
    .local v18, "iv":[B
    new-instance v1, Lcom/amazonaws/AmazonClientException;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Necessary encryption info not found in the instruction file "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2}, Lcom/amazonaws/AmazonClientException;-><init>(Ljava/lang/String;)V

    throw v1
.end method

.method static fromObjectMetadata(Lcom/amazonaws/services/s3/model/ObjectMetadata;Lcom/amazonaws/services/s3/model/EncryptionMaterialsAccessor;Ljava/security/Provider;ZLcom/amazonaws/services/kms/AWSKMSClient;)Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;
    .locals 7
    .param p0, "metadata"    # Lcom/amazonaws/services/s3/model/ObjectMetadata;
    .param p1, "kekMaterialAccessor"    # Lcom/amazonaws/services/s3/model/EncryptionMaterialsAccessor;
    .param p2, "securityProvider"    # Ljava/security/Provider;
    .param p3, "keyWrapExpected"    # Z
    .param p4, "kms"    # Lcom/amazonaws/services/kms/AWSKMSClient;

    .line 339
    const/4 v3, 0x0

    sget-object v4, Lcom/amazonaws/services/s3/model/ExtraMaterialsDescription;->NONE:Lcom/amazonaws/services/s3/model/ExtraMaterialsDescription;

    move-object v0, p0

    move-object v1, p1

    move-object v2, p2

    move v5, p3

    move-object v6, p4

    invoke-static/range {v0 .. v6}, Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;->fromObjectMetadata0(Lcom/amazonaws/services/s3/model/ObjectMetadata;Lcom/amazonaws/services/s3/model/EncryptionMaterialsAccessor;Ljava/security/Provider;[JLcom/amazonaws/services/s3/model/ExtraMaterialsDescription;ZLcom/amazonaws/services/kms/AWSKMSClient;)Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;

    move-result-object v0

    return-object v0
.end method

.method static fromObjectMetadata(Lcom/amazonaws/services/s3/model/ObjectMetadata;Lcom/amazonaws/services/s3/model/EncryptionMaterialsAccessor;Ljava/security/Provider;[JLcom/amazonaws/services/s3/model/ExtraMaterialsDescription;ZLcom/amazonaws/services/kms/AWSKMSClient;)Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;
    .locals 1
    .param p0, "metadata"    # Lcom/amazonaws/services/s3/model/ObjectMetadata;
    .param p1, "kekMaterialAccessor"    # Lcom/amazonaws/services/s3/model/EncryptionMaterialsAccessor;
    .param p2, "securityProvider"    # Ljava/security/Provider;
    .param p3, "range"    # [J
    .param p4, "extra"    # Lcom/amazonaws/services/s3/model/ExtraMaterialsDescription;
    .param p5, "keyWrapExpected"    # Z
    .param p6, "kms"    # Lcom/amazonaws/services/kms/AWSKMSClient;

    .line 358
    invoke-static/range {p0 .. p6}, Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;->fromObjectMetadata0(Lcom/amazonaws/services/s3/model/ObjectMetadata;Lcom/amazonaws/services/s3/model/EncryptionMaterialsAccessor;Ljava/security/Provider;[JLcom/amazonaws/services/s3/model/ExtraMaterialsDescription;ZLcom/amazonaws/services/kms/AWSKMSClient;)Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;

    move-result-object v0

    return-object v0
.end method

.method private static fromObjectMetadata0(Lcom/amazonaws/services/s3/model/ObjectMetadata;Lcom/amazonaws/services/s3/model/EncryptionMaterialsAccessor;Ljava/security/Provider;[JLcom/amazonaws/services/s3/model/ExtraMaterialsDescription;ZLcom/amazonaws/services/kms/AWSKMSClient;)Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;
    .locals 19
    .param p0, "metadata"    # Lcom/amazonaws/services/s3/model/ObjectMetadata;
    .param p1, "kekMaterialAccessor"    # Lcom/amazonaws/services/s3/model/EncryptionMaterialsAccessor;
    .param p2, "securityProvider"    # Ljava/security/Provider;
    .param p3, "range"    # [J
    .param p4, "extra"    # Lcom/amazonaws/services/s3/model/ExtraMaterialsDescription;
    .param p5, "keyWrapExpected"    # Z
    .param p6, "kms"    # Lcom/amazonaws/services/kms/AWSKMSClient;

    .line 374
    move-object/from16 v0, p1

    move-object/from16 v1, p4

    invoke-virtual/range {p0 .. p0}, Lcom/amazonaws/services/s3/model/ObjectMetadata;->getUserMetadata()Ljava/util/Map;

    move-result-object v2

    .line 375
    .local v2, "userMeta":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    const-string/jumbo v3, "x-amz-key-v2"

    invoke-interface {v2, v3}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/String;

    .line 376
    .local v3, "b64key":Ljava/lang/String;
    if-nez v3, :cond_1

    .line 377
    const-string/jumbo v4, "x-amz-key"

    invoke-interface {v2, v4}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v4

    move-object v3, v4

    check-cast v3, Ljava/lang/String;

    .line 378
    if-eqz v3, :cond_0

    goto :goto_0

    .line 379
    :cond_0
    new-instance v4, Lcom/amazonaws/AmazonClientException;

    const-string v5, "Content encrypting key not found."

    invoke-direct {v4, v5}, Lcom/amazonaws/AmazonClientException;-><init>(Ljava/lang/String;)V

    throw v4

    .line 383
    :cond_1
    :goto_0
    invoke-static {v3}, Lcom/amazonaws/util/Base64;->decode(Ljava/lang/String;)[B

    move-result-object v10

    .line 384
    .local v10, "cekWrapped":[B
    const-string/jumbo v4, "x-amz-iv"

    invoke-interface {v2, v4}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/String;

    invoke-static {v4}, Lcom/amazonaws/util/Base64;->decode(Ljava/lang/String;)[B

    move-result-object v4

    .line 385
    .local v4, "iv":[B
    if-eqz v10, :cond_d

    if-eqz v4, :cond_d

    .line 390
    const-string/jumbo v5, "x-amz-matdesc"

    invoke-interface {v2, v5}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v5

    move-object v11, v5

    check-cast v11, Ljava/lang/String;

    .line 391
    .local v11, "matdescStr":Ljava/lang/String;
    const-string/jumbo v5, "x-amz-wrap-alg"

    invoke-interface {v2, v5}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v5

    move-object v12, v5

    check-cast v12, Ljava/lang/String;

    .line 392
    .local v12, "keyWrapAlgo":Ljava/lang/String;
    invoke-static {v12}, Lcom/amazonaws/services/s3/internal/crypto/KMSSecuredCEK;->isKMSKeyWrapped(Ljava/lang/String;)Z

    move-result v13

    .line 393
    .local v13, "isKMS":Z
    invoke-static {v11}, Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;->matdescFromJson(Ljava/lang/String;)Ljava/util/Map;

    move-result-object v14

    .line 394
    .local v14, "core":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    if-nez v13, :cond_3

    if-nez v1, :cond_2

    goto :goto_1

    .line 395
    :cond_2
    invoke-virtual {v1, v14}, Lcom/amazonaws/services/s3/model/ExtraMaterialsDescription;->mergeInto(Ljava/util/Map;)Ljava/util/Map;

    move-result-object v5

    goto :goto_2

    .line 394
    :cond_3
    :goto_1
    move-object v5, v14

    .line 395
    :goto_2
    move-object v15, v5

    .line 397
    .local v15, "merged":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    if-eqz v13, :cond_4

    .line 398
    new-instance v5, Lcom/amazonaws/services/s3/model/KMSEncryptionMaterials;

    .line 399
    const-string v6, "kms_cmk_id"

    invoke-interface {v14, v6}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Ljava/lang/String;

    invoke-direct {v5, v6}, Lcom/amazonaws/services/s3/model/KMSEncryptionMaterials;-><init>(Ljava/lang/String;)V

    .line 400
    .local v5, "materials":Lcom/amazonaws/services/s3/model/EncryptionMaterials;
    invoke-virtual {v5, v14}, Lcom/amazonaws/services/s3/model/EncryptionMaterials;->addDescriptions(Ljava/util/Map;)Lcom/amazonaws/services/s3/model/EncryptionMaterials;

    move-object/from16 v16, v5

    goto :goto_4

    .line 402
    .end local v5    # "materials":Lcom/amazonaws/services/s3/model/EncryptionMaterials;
    :cond_4
    if-nez v0, :cond_5

    const/4 v5, 0x0

    goto :goto_3

    .line 404
    :cond_5
    invoke-interface {v0, v15}, Lcom/amazonaws/services/s3/model/EncryptionMaterialsAccessor;->getEncryptionMaterials(Ljava/util/Map;)Lcom/amazonaws/services/s3/model/EncryptionMaterials;

    move-result-object v5

    :goto_3
    nop

    .line 405
    .restart local v5    # "materials":Lcom/amazonaws/services/s3/model/EncryptionMaterials;
    if-eqz v5, :cond_c

    move-object/from16 v16, v5

    .line 411
    .end local v5    # "materials":Lcom/amazonaws/services/s3/model/EncryptionMaterials;
    .local v16, "materials":Lcom/amazonaws/services/s3/model/EncryptionMaterials;
    :goto_4
    const-string/jumbo v5, "x-amz-cek-alg"

    invoke-interface {v2, v5}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v5

    move-object v9, v5

    check-cast v9, Ljava/lang/String;

    .line 412
    .local v9, "cekAlgo":Ljava/lang/String;
    const/4 v5, 0x0

    if-eqz p3, :cond_6

    const/4 v6, 0x1

    goto :goto_5

    :cond_6
    move v6, v5

    :goto_5
    move v8, v6

    .line 415
    .local v8, "isRangeGet":Z
    nop

    .line 416
    invoke-static {v9, v8}, Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoScheme;->fromCEKAlgo(Ljava/lang/String;Z)Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoScheme;

    move-result-object v7

    .line 417
    .local v7, "contentCryptoScheme":Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoScheme;
    if-eqz v8, :cond_7

    .line 419
    aget-wide v5, p3, v5

    invoke-virtual {v7, v4, v5, v6}, Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoScheme;->adjustIV([BJ)[B

    move-result-object v4

    move-object/from16 v17, v2

    move-object/from16 v18, v3

    move-object v0, v4

    goto :goto_7

    .line 422
    :cond_7
    invoke-virtual {v7}, Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoScheme;->getTagLengthInBits()I

    move-result v5

    .line 423
    .local v5, "tagLenExpected":I
    if-lez v5, :cond_9

    .line 424
    const-string/jumbo v6, "x-amz-tag-len"

    invoke-interface {v2, v6}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Ljava/lang/String;

    .line 425
    .local v6, "s":Ljava/lang/String;
    invoke-static {v6}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v0

    .line 426
    .local v0, "tagLenActual":I
    if-ne v5, v0, :cond_8

    move-object/from16 v17, v2

    move-object/from16 v18, v3

    goto :goto_6

    .line 427
    :cond_8
    new-instance v1, Lcom/amazonaws/AmazonClientException;

    move-object/from16 v17, v2

    .end local v2    # "userMeta":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .local v17, "userMeta":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    move-object/from16 v18, v3

    .end local v3    # "b64key":Ljava/lang/String;
    .local v18, "b64key":Ljava/lang/String;
    const-string v3, "Unsupported tag length: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ", expected: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2}, Lcom/amazonaws/AmazonClientException;-><init>(Ljava/lang/String;)V

    throw v1

    .line 423
    .end local v0    # "tagLenActual":I
    .end local v6    # "s":Ljava/lang/String;
    .end local v17    # "userMeta":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .end local v18    # "b64key":Ljava/lang/String;
    .restart local v2    # "userMeta":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .restart local v3    # "b64key":Ljava/lang/String;
    :cond_9
    move-object/from16 v17, v2

    move-object/from16 v18, v3

    .line 433
    .end local v2    # "userMeta":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .end local v3    # "b64key":Ljava/lang/String;
    .end local v5    # "tagLenExpected":I
    .restart local v17    # "userMeta":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .restart local v18    # "b64key":Ljava/lang/String;
    :goto_6
    move-object v0, v4

    .end local v4    # "iv":[B
    .local v0, "iv":[B
    :goto_7
    if-eqz p5, :cond_b

    if-eqz v12, :cond_a

    goto :goto_8

    .line 434
    :cond_a
    invoke-static {}, Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;->newKeyWrapException()Lcom/amazonaws/services/s3/KeyWrapException;

    move-result-object v1

    throw v1

    .line 436
    :cond_b
    :goto_8
    move-object v4, v10

    move-object v5, v12

    move-object/from16 v6, v16

    move-object v1, v7

    .end local v7    # "contentCryptoScheme":Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoScheme;
    .local v1, "contentCryptoScheme":Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoScheme;
    move-object/from16 v7, p2

    move v2, v8

    .end local v8    # "isRangeGet":Z
    .local v2, "isRangeGet":Z
    move-object v8, v1

    move-object v3, v9

    .end local v9    # "cekAlgo":Ljava/lang/String;
    .local v3, "cekAlgo":Ljava/lang/String;
    move-object/from16 v9, p6

    invoke-static/range {v4 .. v9}, Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;->cek([BLjava/lang/String;Lcom/amazonaws/services/s3/model/EncryptionMaterials;Ljava/security/Provider;Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoScheme;Lcom/amazonaws/services/kms/AWSKMSClient;)Ljavax/crypto/SecretKey;

    move-result-object v4

    .line 438
    .local v4, "cek":Ljavax/crypto/SecretKey;
    new-instance v5, Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;

    .line 439
    const/4 v6, 0x2

    invoke-virtual {v1, v4, v0, v6, v7}, Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoScheme;->createCipherLite(Ljavax/crypto/SecretKey;[BILjava/security/Provider;)Lcom/amazonaws/services/s3/internal/crypto/CipherLite;

    move-result-object v6

    invoke-direct {v5, v15, v10, v12, v6}, Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;-><init>(Ljava/util/Map;[BLjava/lang/String;Lcom/amazonaws/services/s3/internal/crypto/CipherLite;)V

    .line 438
    return-object v5

    .line 406
    .end local v0    # "iv":[B
    .end local v1    # "contentCryptoScheme":Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoScheme;
    .end local v16    # "materials":Lcom/amazonaws/services/s3/model/EncryptionMaterials;
    .end local v17    # "userMeta":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .end local v18    # "b64key":Ljava/lang/String;
    .local v2, "userMeta":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .local v3, "b64key":Ljava/lang/String;
    .local v4, "iv":[B
    .local v5, "materials":Lcom/amazonaws/services/s3/model/EncryptionMaterials;
    :cond_c
    new-instance v0, Lcom/amazonaws/AmazonClientException;

    const-string v1, "Unable to retrieve the client encryption materials"

    invoke-direct {v0, v1}, Lcom/amazonaws/AmazonClientException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 385
    .end local v5    # "materials":Lcom/amazonaws/services/s3/model/EncryptionMaterials;
    .end local v11    # "matdescStr":Ljava/lang/String;
    .end local v12    # "keyWrapAlgo":Ljava/lang/String;
    .end local v13    # "isKMS":Z
    .end local v14    # "core":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .end local v15    # "merged":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    :cond_d
    move-object/from16 v7, p2

    move-object/from16 v17, v2

    move-object/from16 v18, v3

    .line 386
    .end local v2    # "userMeta":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .end local v3    # "b64key":Ljava/lang/String;
    .restart local v17    # "userMeta":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .restart local v18    # "b64key":Ljava/lang/String;
    new-instance v0, Lcom/amazonaws/AmazonClientException;

    const-string v1, "Content encrypting key or IV not found."

    invoke-direct {v0, v1}, Lcom/amazonaws/AmazonClientException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method private kekMaterialDescAsJson()Ljava/lang/String;
    .locals 2

    .line 230
    invoke-virtual {p0}, Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;->getKEKMaterialsDescription()Ljava/util/Map;

    move-result-object v0

    .line 231
    .local v0, "kekMaterialDesc":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    if-nez v0, :cond_0

    .line 232
    invoke-static {}, Ljava/util/Collections;->emptyMap()Ljava/util/Map;

    move-result-object v0

    .line 234
    :cond_0
    invoke-static {v0}, Lcom/amazonaws/util/json/JsonUtils;->mapToString(Ljava/util/Map;)Ljava/lang/String;

    move-result-object v1

    return-object v1
.end method

.method private static matdescFromJson(Ljava/lang/String;)Ljava/util/Map;
    .locals 2
    .param p0, "json"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            ")",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .line 243
    invoke-static {p0}, Lcom/amazonaws/util/json/JsonUtils;->jsonToMap(Ljava/lang/String;)Ljava/util/Map;

    move-result-object v0

    .line 244
    .local v0, "map":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    if-nez v0, :cond_0

    const/4 v1, 0x0

    goto :goto_0

    :cond_0
    invoke-static {v0}, Ljava/util/Collections;->unmodifiableMap(Ljava/util/Map;)Ljava/util/Map;

    move-result-object v1

    :goto_0
    return-object v1
.end method

.method static mergeMaterialDescriptions(Lcom/amazonaws/services/s3/model/EncryptionMaterials;Lcom/amazonaws/AmazonWebServiceRequest;)Ljava/util/Map;
    .locals 4
    .param p0, "materials"    # Lcom/amazonaws/services/s3/model/EncryptionMaterials;
    .param p1, "req"    # Lcom/amazonaws/AmazonWebServiceRequest;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/amazonaws/services/s3/model/EncryptionMaterials;",
            "Lcom/amazonaws/AmazonWebServiceRequest;",
            ")",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .line 920
    invoke-virtual {p0}, Lcom/amazonaws/services/s3/model/EncryptionMaterials;->getMaterialsDescription()Ljava/util/Map;

    move-result-object v0

    .line 921
    .local v0, "matdesc":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    instance-of v1, p1, Lcom/amazonaws/services/s3/model/MaterialsDescriptionProvider;

    if-eqz v1, :cond_0

    .line 922
    move-object v1, p1

    check-cast v1, Lcom/amazonaws/services/s3/model/MaterialsDescriptionProvider;

    .line 923
    .local v1, "mdp":Lcom/amazonaws/services/s3/model/MaterialsDescriptionProvider;
    invoke-interface {v1}, Lcom/amazonaws/services/s3/model/MaterialsDescriptionProvider;->getMaterialsDescription()Ljava/util/Map;

    move-result-object v2

    .line 924
    .local v2, "matdescReq":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    if-eqz v2, :cond_0

    .line 925
    new-instance v3, Ljava/util/TreeMap;

    invoke-direct {v3, v0}, Ljava/util/TreeMap;-><init>(Ljava/util/Map;)V

    move-object v0, v3

    .line 926
    invoke-interface {v0, v2}, Ljava/util/Map;->putAll(Ljava/util/Map;)V

    .line 929
    .end local v1    # "mdp":Lcom/amazonaws/services/s3/model/MaterialsDescriptionProvider;
    .end local v2    # "matdescReq":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    :cond_0
    return-object v0
.end method

.method private static newKeyWrapException()Lcom/amazonaws/services/s3/KeyWrapException;
    .locals 2

    .line 444
    new-instance v0, Lcom/amazonaws/services/s3/KeyWrapException;

    const-string v1, "Missing key-wrap for the content-encrypting-key"

    invoke-direct {v0, v1}, Lcom/amazonaws/services/s3/KeyWrapException;-><init>(Ljava/lang/String;)V

    return-object v0
.end method

.method static parseInstructionFile(Lcom/amazonaws/services/s3/model/S3Object;)Ljava/lang/String;
    .locals 3
    .param p0, "instructionFile"    # Lcom/amazonaws/services/s3/model/S3Object;

    .line 569
    :try_start_0
    invoke-virtual {p0}, Lcom/amazonaws/services/s3/model/S3Object;->getObjectContent()Lcom/amazonaws/services/s3/model/S3ObjectInputStream;

    move-result-object v0

    invoke-static {v0}, Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;->convertStreamToString(Ljava/io/InputStream;)Ljava/lang/String;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    .line 570
    :catch_0
    move-exception v0

    .line 571
    .local v0, "e":Ljava/lang/Exception;
    new-instance v1, Lcom/amazonaws/AmazonClientException;

    const-string v2, "Error parsing JSON instruction file"

    invoke-direct {v1, v2, v0}, Lcom/amazonaws/AmazonClientException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    throw v1
.end method

.method private static secureCEK(Ljavax/crypto/SecretKey;Lcom/amazonaws/services/s3/model/EncryptionMaterials;Lcom/amazonaws/services/s3/internal/crypto/S3KeyWrapScheme;Ljava/security/SecureRandom;Ljava/security/Provider;Lcom/amazonaws/services/kms/AWSKMSClient;Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/services/s3/internal/crypto/SecuredCEK;
    .locals 9
    .param p0, "cek"    # Ljavax/crypto/SecretKey;
    .param p1, "materials"    # Lcom/amazonaws/services/s3/model/EncryptionMaterials;
    .param p2, "kwScheme"    # Lcom/amazonaws/services/s3/internal/crypto/S3KeyWrapScheme;
    .param p3, "srand"    # Ljava/security/SecureRandom;
    .param p4, "p"    # Ljava/security/Provider;
    .param p5, "kms"    # Lcom/amazonaws/services/kms/AWSKMSClient;
    .param p6, "req"    # Lcom/amazonaws/AmazonWebServiceRequest;

    .line 869
    invoke-virtual {p1}, Lcom/amazonaws/services/s3/model/EncryptionMaterials;->isKMSEnabled()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 870
    invoke-static {p1, p6}, Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;->mergeMaterialDescriptions(Lcom/amazonaws/services/s3/model/EncryptionMaterials;Lcom/amazonaws/AmazonWebServiceRequest;)Ljava/util/Map;

    move-result-object v0

    .line 871
    .local v0, "matdesc":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    new-instance v1, Lcom/amazonaws/services/kms/model/EncryptRequest;

    invoke-direct {v1}, Lcom/amazonaws/services/kms/model/EncryptRequest;-><init>()V

    .line 872
    invoke-virtual {v1, v0}, Lcom/amazonaws/services/kms/model/EncryptRequest;->withEncryptionContext(Ljava/util/Map;)Lcom/amazonaws/services/kms/model/EncryptRequest;

    move-result-object v1

    .line 873
    invoke-virtual {p1}, Lcom/amazonaws/services/s3/model/EncryptionMaterials;->getCustomerMasterKeyId()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Lcom/amazonaws/services/kms/model/EncryptRequest;->withKeyId(Ljava/lang/String;)Lcom/amazonaws/services/kms/model/EncryptRequest;

    move-result-object v1

    .line 874
    invoke-interface {p0}, Ljavax/crypto/SecretKey;->getEncoded()[B

    move-result-object v2

    invoke-static {v2}, Ljava/nio/ByteBuffer;->wrap([B)Ljava/nio/ByteBuffer;

    move-result-object v2

    invoke-virtual {v1, v2}, Lcom/amazonaws/services/kms/model/EncryptRequest;->withPlaintext(Ljava/nio/ByteBuffer;)Lcom/amazonaws/services/kms/model/EncryptRequest;

    move-result-object v1

    .line 875
    .local v1, "encryptRequest":Lcom/amazonaws/services/kms/model/EncryptRequest;
    nop

    .line 876
    invoke-virtual {p6}, Lcom/amazonaws/AmazonWebServiceRequest;->getGeneralProgressListener()Lcom/amazonaws/event/ProgressListener;

    move-result-object v2

    invoke-virtual {v1, v2}, Lcom/amazonaws/services/kms/model/EncryptRequest;->withGeneralProgressListener(Lcom/amazonaws/event/ProgressListener;)Lcom/amazonaws/AmazonWebServiceRequest;

    move-result-object v2

    .line 877
    invoke-virtual {p6}, Lcom/amazonaws/AmazonWebServiceRequest;->getRequestMetricCollector()Lcom/amazonaws/metrics/RequestMetricCollector;

    move-result-object v3

    invoke-virtual {v2, v3}, Lcom/amazonaws/AmazonWebServiceRequest;->withRequestMetricCollector(Lcom/amazonaws/metrics/RequestMetricCollector;)Lcom/amazonaws/AmazonWebServiceRequest;

    .line 878
    invoke-virtual {p5, v1}, Lcom/amazonaws/services/kms/AWSKMSClient;->encrypt(Lcom/amazonaws/services/kms/model/EncryptRequest;)Lcom/amazonaws/services/kms/model/EncryptResult;

    move-result-object v2

    .line 879
    .local v2, "encryptResult":Lcom/amazonaws/services/kms/model/EncryptResult;
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/EncryptResult;->getCiphertextBlob()Ljava/nio/ByteBuffer;

    move-result-object v3

    invoke-static {v3}, Lcom/amazonaws/util/BinaryUtils;->copyAllBytesFrom(Ljava/nio/ByteBuffer;)[B

    move-result-object v3

    .line 880
    .local v3, "keyBlob":[B
    new-instance v4, Lcom/amazonaws/services/s3/internal/crypto/KMSSecuredCEK;

    invoke-direct {v4, v3, v0}, Lcom/amazonaws/services/s3/internal/crypto/KMSSecuredCEK;-><init>([BLjava/util/Map;)V

    return-object v4

    .line 882
    .end local v0    # "matdesc":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .end local v1    # "encryptRequest":Lcom/amazonaws/services/kms/model/EncryptRequest;
    .end local v2    # "encryptResult":Lcom/amazonaws/services/kms/model/EncryptResult;
    .end local v3    # "keyBlob":[B
    :cond_0
    invoke-virtual {p1}, Lcom/amazonaws/services/s3/model/EncryptionMaterials;->getMaterialsDescription()Ljava/util/Map;

    move-result-object v0

    .line 885
    .restart local v0    # "matdesc":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    invoke-virtual {p1}, Lcom/amazonaws/services/s3/model/EncryptionMaterials;->getKeyPair()Ljava/security/KeyPair;

    move-result-object v1

    if-eqz v1, :cond_1

    .line 887
    invoke-virtual {p1}, Lcom/amazonaws/services/s3/model/EncryptionMaterials;->getKeyPair()Ljava/security/KeyPair;

    move-result-object v1

    invoke-virtual {v1}, Ljava/security/KeyPair;->getPublic()Ljava/security/PublicKey;

    move-result-object v1

    .local v1, "kek":Ljava/security/Key;
    goto :goto_0

    .line 890
    .end local v1    # "kek":Ljava/security/Key;
    :cond_1
    invoke-virtual {p1}, Lcom/amazonaws/services/s3/model/EncryptionMaterials;->getSymmetricKey()Ljavax/crypto/SecretKey;

    move-result-object v1

    .line 892
    .restart local v1    # "kek":Ljava/security/Key;
    :goto_0
    invoke-virtual {p2, v1, p4}, Lcom/amazonaws/services/s3/internal/crypto/S3KeyWrapScheme;->getKeyWrapAlgorithm(Ljava/security/Key;Ljava/security/Provider;)Ljava/lang/String;

    move-result-object v2

    .line 894
    .local v2, "keyWrapAlgo":Ljava/lang/String;
    if-eqz v2, :cond_3

    .line 895
    if-nez p4, :cond_2

    .line 896
    :try_start_0
    invoke-static {v2}, Ljavax/crypto/Cipher;->getInstance(Ljava/lang/String;)Ljavax/crypto/Cipher;

    move-result-object v3

    goto :goto_1

    :cond_2
    invoke-static {v2, p4}, Ljavax/crypto/Cipher;->getInstance(Ljava/lang/String;Ljava/security/Provider;)Ljavax/crypto/Cipher;

    move-result-object v3

    .line 898
    .local v3, "cipher":Ljavax/crypto/Cipher;
    :goto_1
    const/4 v4, 0x3

    invoke-virtual {v3, v4, v1, p3}, Ljavax/crypto/Cipher;->init(ILjava/security/Key;Ljava/security/SecureRandom;)V

    .line 899
    new-instance v4, Lcom/amazonaws/services/s3/internal/crypto/SecuredCEK;

    invoke-virtual {v3, p0}, Ljavax/crypto/Cipher;->wrap(Ljava/security/Key;)[B

    move-result-object v5

    invoke-direct {v4, v5, v2, v0}, Lcom/amazonaws/services/s3/internal/crypto/SecuredCEK;-><init>([BLjava/lang/String;Ljava/util/Map;)V

    return-object v4

    .line 903
    .end local v3    # "cipher":Ljavax/crypto/Cipher;
    :cond_3
    invoke-interface {p0}, Ljavax/crypto/SecretKey;->getEncoded()[B

    move-result-object v3

    .line 904
    .local v3, "toBeEncryptedBytes":[B
    invoke-interface {v1}, Ljava/security/Key;->getAlgorithm()Ljava/lang/String;

    move-result-object v4

    .line 905
    .local v4, "algo":Ljava/lang/String;
    if-eqz p4, :cond_4

    .line 906
    invoke-static {v4, p4}, Ljavax/crypto/Cipher;->getInstance(Ljava/lang/String;Ljava/security/Provider;)Ljavax/crypto/Cipher;

    move-result-object v5

    .local v5, "cipher":Ljavax/crypto/Cipher;
    goto :goto_2

    .line 908
    .end local v5    # "cipher":Ljavax/crypto/Cipher;
    :cond_4
    invoke-static {v4}, Ljavax/crypto/Cipher;->getInstance(Ljava/lang/String;)Ljavax/crypto/Cipher;

    move-result-object v5

    .line 910
    .restart local v5    # "cipher":Ljavax/crypto/Cipher;
    :goto_2
    const/4 v6, 0x1

    invoke-virtual {v5, v6, v1}, Ljavax/crypto/Cipher;->init(ILjava/security/Key;)V

    .line 911
    new-instance v6, Lcom/amazonaws/services/s3/internal/crypto/SecuredCEK;

    invoke-virtual {v5, v3}, Ljavax/crypto/Cipher;->doFinal([B)[B

    move-result-object v7

    const/4 v8, 0x0

    invoke-direct {v6, v7, v8, v0}, Lcom/amazonaws/services/s3/internal/crypto/SecuredCEK;-><init>([BLjava/lang/String;Ljava/util/Map;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-object v6

    .line 912
    .end local v3    # "toBeEncryptedBytes":[B
    .end local v4    # "algo":Ljava/lang/String;
    .end local v5    # "cipher":Ljavax/crypto/Cipher;
    :catch_0
    move-exception v3

    .line 913
    .local v3, "e":Ljava/lang/Exception;
    new-instance v4, Lcom/amazonaws/AmazonClientException;

    const-string v5, "Unable to encrypt symmetric key"

    invoke-direct {v4, v5, v3}, Lcom/amazonaws/AmazonClientException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    throw v4
.end method

.method private toJsonStringEO()Ljava/lang/String;
    .locals 5

    .line 217
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    .line 218
    .local v0, "map":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    invoke-virtual {p0}, Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;->getEncryptedCEK()[B

    move-result-object v1

    .line 219
    .local v1, "encryptedCEK":[B
    const-string/jumbo v2, "x-amz-key"

    invoke-static {v1}, Lcom/amazonaws/util/Base64;->encodeAsString([B)Ljava/lang/String;

    move-result-object v3

    invoke-interface {v0, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 220
    iget-object v2, p0, Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;->cipherLite:Lcom/amazonaws/services/s3/internal/crypto/CipherLite;

    invoke-virtual {v2}, Lcom/amazonaws/services/s3/internal/crypto/CipherLite;->getIV()[B

    move-result-object v2

    .line 221
    .local v2, "iv":[B
    const-string/jumbo v3, "x-amz-iv"

    invoke-static {v2}, Lcom/amazonaws/util/Base64;->encodeAsString([B)Ljava/lang/String;

    move-result-object v4

    invoke-interface {v0, v3, v4}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 222
    const-string/jumbo v3, "x-amz-matdesc"

    invoke-direct {p0}, Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;->kekMaterialDescAsJson()Ljava/lang/String;

    move-result-object v4

    invoke-interface {v0, v3, v4}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 223
    invoke-static {v0}, Lcom/amazonaws/util/json/JsonUtils;->mapToString(Ljava/util/Map;)Ljava/lang/String;

    move-result-object v3

    return-object v3
.end method

.method private toObjectMetadata(Lcom/amazonaws/services/s3/model/ObjectMetadata;)Lcom/amazonaws/services/s3/model/ObjectMetadata;
    .locals 6
    .param p1, "metadata"    # Lcom/amazonaws/services/s3/model/ObjectMetadata;

    .line 131
    invoke-virtual {p0}, Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;->getEncryptedCEK()[B

    move-result-object v0

    .line 132
    .local v0, "encryptedCEK":[B
    nop

    .line 133
    invoke-static {v0}, Lcom/amazonaws/util/Base64;->encodeAsString([B)Ljava/lang/String;

    move-result-object v1

    .line 132
    const-string/jumbo v2, "x-amz-key-v2"

    invoke-virtual {p1, v2, v1}, Lcom/amazonaws/services/s3/model/ObjectMetadata;->addUserMetadata(Ljava/lang/String;Ljava/lang/String;)V

    .line 135
    iget-object v1, p0, Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;->cipherLite:Lcom/amazonaws/services/s3/internal/crypto/CipherLite;

    invoke-virtual {v1}, Lcom/amazonaws/services/s3/internal/crypto/CipherLite;->getIV()[B

    move-result-object v1

    .line 136
    .local v1, "iv":[B
    const-string/jumbo v2, "x-amz-iv"

    invoke-static {v1}, Lcom/amazonaws/util/Base64;->encodeAsString([B)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p1, v2, v3}, Lcom/amazonaws/services/s3/model/ObjectMetadata;->addUserMetadata(Ljava/lang/String;Ljava/lang/String;)V

    .line 138
    nop

    .line 139
    invoke-direct {p0}, Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;->kekMaterialDescAsJson()Ljava/lang/String;

    move-result-object v2

    .line 138
    const-string/jumbo v3, "x-amz-matdesc"

    invoke-virtual {p1, v3, v2}, Lcom/amazonaws/services/s3/model/ObjectMetadata;->addUserMetadata(Ljava/lang/String;Ljava/lang/String;)V

    .line 143
    invoke-virtual {p0}, Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;->getContentCryptoScheme()Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoScheme;

    move-result-object v2

    .line 144
    .local v2, "scheme":Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoScheme;
    nop

    .line 145
    invoke-virtual {v2}, Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoScheme;->getCipherAlgorithm()Ljava/lang/String;

    move-result-object v3

    .line 144
    const-string/jumbo v4, "x-amz-cek-alg"

    invoke-virtual {p1, v4, v3}, Lcom/amazonaws/services/s3/model/ObjectMetadata;->addUserMetadata(Ljava/lang/String;Ljava/lang/String;)V

    .line 146
    invoke-virtual {v2}, Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoScheme;->getTagLengthInBits()I

    move-result v3

    .line 147
    .local v3, "tagLen":I
    if-lez v3, :cond_0

    .line 148
    nop

    .line 149
    invoke-static {v3}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v4

    .line 148
    const-string/jumbo v5, "x-amz-tag-len"

    invoke-virtual {p1, v5, v4}, Lcom/amazonaws/services/s3/model/ObjectMetadata;->addUserMetadata(Ljava/lang/String;Ljava/lang/String;)V

    .line 151
    :cond_0
    invoke-virtual {p0}, Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;->getKeyWrappingAlgorithm()Ljava/lang/String;

    move-result-object v4

    .line 152
    .local v4, "keyWrapAlgo":Ljava/lang/String;
    if-eqz v4, :cond_1

    .line 153
    const-string/jumbo v5, "x-amz-wrap-alg"

    invoke-virtual {p1, v5, v4}, Lcom/amazonaws/services/s3/model/ObjectMetadata;->addUserMetadata(Ljava/lang/String;Ljava/lang/String;)V

    .line 156
    :cond_1
    return-object p1
.end method

.method private toObjectMetadataEO(Lcom/amazonaws/services/s3/model/ObjectMetadata;)Lcom/amazonaws/services/s3/model/ObjectMetadata;
    .locals 4
    .param p1, "metadata"    # Lcom/amazonaws/services/s3/model/ObjectMetadata;

    .line 167
    invoke-virtual {p0}, Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;->getEncryptedCEK()[B

    move-result-object v0

    .line 168
    .local v0, "encryptedCEK":[B
    nop

    .line 169
    invoke-static {v0}, Lcom/amazonaws/util/Base64;->encodeAsString([B)Ljava/lang/String;

    move-result-object v1

    .line 168
    const-string/jumbo v2, "x-amz-key"

    invoke-virtual {p1, v2, v1}, Lcom/amazonaws/services/s3/model/ObjectMetadata;->addUserMetadata(Ljava/lang/String;Ljava/lang/String;)V

    .line 171
    iget-object v1, p0, Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;->cipherLite:Lcom/amazonaws/services/s3/internal/crypto/CipherLite;

    invoke-virtual {v1}, Lcom/amazonaws/services/s3/internal/crypto/CipherLite;->getIV()[B

    move-result-object v1

    .line 172
    .local v1, "iv":[B
    const-string/jumbo v2, "x-amz-iv"

    invoke-static {v1}, Lcom/amazonaws/util/Base64;->encodeAsString([B)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p1, v2, v3}, Lcom/amazonaws/services/s3/model/ObjectMetadata;->addUserMetadata(Ljava/lang/String;Ljava/lang/String;)V

    .line 174
    nop

    .line 175
    invoke-direct {p0}, Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;->kekMaterialDescAsJson()Ljava/lang/String;

    move-result-object v2

    .line 174
    const-string/jumbo v3, "x-amz-matdesc"

    invoke-virtual {p1, v3, v2}, Lcom/amazonaws/services/s3/model/ObjectMetadata;->addUserMetadata(Ljava/lang/String;Ljava/lang/String;)V

    .line 176
    return-object p1
.end method

.method private usesKMSKey()Z
    .locals 1

    .line 105
    iget-object v0, p0, Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;->keyWrappingAlgorithm:Ljava/lang/String;

    invoke-static {v0}, Lcom/amazonaws/services/s3/internal/crypto/KMSSecuredCEK;->isKMSKeyWrapped(Ljava/lang/String;)Z

    move-result v0

    return v0
.end method

.method public static wrap(Ljavax/crypto/SecretKey;[BLcom/amazonaws/services/s3/internal/crypto/ContentCryptoScheme;Ljava/security/Provider;Lcom/amazonaws/services/s3/internal/crypto/SecuredCEK;)Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;
    .locals 5
    .param p0, "cek"    # Ljavax/crypto/SecretKey;
    .param p1, "iv"    # [B
    .param p2, "contentCryptoScheme"    # Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoScheme;
    .param p3, "provider"    # Ljava/security/Provider;
    .param p4, "cekSecured"    # Lcom/amazonaws/services/s3/internal/crypto/SecuredCEK;

    .line 841
    new-instance v0, Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;

    .line 842
    invoke-virtual {p4}, Lcom/amazonaws/services/s3/internal/crypto/SecuredCEK;->getMaterialDescription()Ljava/util/Map;

    move-result-object v1

    .line 843
    invoke-virtual {p4}, Lcom/amazonaws/services/s3/internal/crypto/SecuredCEK;->getEncrypted()[B

    move-result-object v2

    .line 844
    invoke-virtual {p4}, Lcom/amazonaws/services/s3/internal/crypto/SecuredCEK;->getKeyWrapAlgorithm()Ljava/lang/String;

    move-result-object v3

    .line 845
    const/4 v4, 0x1

    invoke-virtual {p2, p0, p1, v4, p3}, Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoScheme;->createCipherLite(Ljavax/crypto/SecretKey;[BILjava/security/Provider;)Lcom/amazonaws/services/s3/internal/crypto/CipherLite;

    move-result-object v4

    invoke-direct {v0, v1, v2, v3, v4}, Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;-><init>(Ljava/util/Map;[BLjava/lang/String;Lcom/amazonaws/services/s3/internal/crypto/CipherLite;)V

    .line 841
    return-object v0
.end method


# virtual methods
.method getCipherLite()Lcom/amazonaws/services/s3/internal/crypto/CipherLite;
    .locals 1

    .line 603
    iget-object v0, p0, Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;->cipherLite:Lcom/amazonaws/services/s3/internal/crypto/CipherLite;

    return-object v0
.end method

.method getContentCryptoScheme()Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoScheme;
    .locals 1

    .line 112
    iget-object v0, p0, Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;->cipherLite:Lcom/amazonaws/services/s3/internal/crypto/CipherLite;

    invoke-virtual {v0}, Lcom/amazonaws/services/s3/internal/crypto/CipherLite;->getContentCryptoScheme()Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoScheme;

    move-result-object v0

    return-object v0
.end method

.method getEncryptedCEK()[B
    .locals 1

    .line 622
    iget-object v0, p0, Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;->encryptedCEK:[B

    invoke-virtual {v0}, [B->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [B

    return-object v0
.end method

.method getKEKMaterialsDescription()Ljava/util/Map;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .line 611
    iget-object v0, p0, Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;->kekMaterialsDescription:Ljava/util/Map;

    return-object v0
.end method

.method getKeyWrappingAlgorithm()Ljava/lang/String;
    .locals 1

    .line 97
    iget-object v0, p0, Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;->keyWrappingAlgorithm:Ljava/lang/String;

    return-object v0
.end method

.method recreate(Lcom/amazonaws/services/s3/model/EncryptionMaterials;Lcom/amazonaws/services/s3/model/EncryptionMaterialsAccessor;Lcom/amazonaws/services/s3/internal/crypto/S3CryptoScheme;Ljava/security/Provider;Lcom/amazonaws/services/kms/AWSKMSClient;Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;
    .locals 16
    .param p1, "newKEK"    # Lcom/amazonaws/services/s3/model/EncryptionMaterials;
    .param p2, "accessor"    # Lcom/amazonaws/services/s3/model/EncryptionMaterialsAccessor;
    .param p3, "targetScheme"    # Lcom/amazonaws/services/s3/internal/crypto/S3CryptoScheme;
    .param p4, "p"    # Ljava/security/Provider;
    .param p5, "kms"    # Lcom/amazonaws/services/kms/AWSKMSClient;
    .param p6, "req"    # Lcom/amazonaws/AmazonWebServiceRequest;

    .line 705
    move-object/from16 v0, p0

    invoke-direct/range {p0 .. p0}, Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;->usesKMSKey()Z

    move-result v1

    if-nez v1, :cond_1

    .line 706
    invoke-virtual/range {p1 .. p1}, Lcom/amazonaws/services/s3/model/EncryptionMaterials;->getMaterialsDescription()Ljava/util/Map;

    move-result-object v1

    iget-object v2, v0, Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;->kekMaterialsDescription:Ljava/util/Map;

    invoke-virtual {v1, v2}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_0

    goto :goto_0

    .line 707
    :cond_0
    new-instance v1, Ljava/lang/SecurityException;

    const-string v2, "Material description of the new KEK must differ from the current one"

    invoke-direct {v1, v2}, Ljava/lang/SecurityException;-><init>(Ljava/lang/String;)V

    throw v1

    .line 711
    :cond_1
    :goto_0
    invoke-direct/range {p0 .. p0}, Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;->usesKMSKey()Z

    move-result v1

    if-eqz v1, :cond_2

    .line 712
    new-instance v1, Lcom/amazonaws/services/s3/model/KMSEncryptionMaterials;

    iget-object v2, v0, Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;->kekMaterialsDescription:Ljava/util/Map;

    const-string v3, "kms_cmk_id"

    invoke-interface {v2, v3}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    invoke-direct {v1, v2}, Lcom/amazonaws/services/s3/model/KMSEncryptionMaterials;-><init>(Ljava/lang/String;)V

    move-object/from16 v2, p2

    .local v1, "origKEK":Lcom/amazonaws/services/s3/model/EncryptionMaterials;
    goto :goto_1

    .line 715
    .end local v1    # "origKEK":Lcom/amazonaws/services/s3/model/EncryptionMaterials;
    :cond_2
    iget-object v1, v0, Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;->kekMaterialsDescription:Ljava/util/Map;

    move-object/from16 v2, p2

    invoke-interface {v2, v1}, Lcom/amazonaws/services/s3/model/EncryptionMaterialsAccessor;->getEncryptionMaterials(Ljava/util/Map;)Lcom/amazonaws/services/s3/model/EncryptionMaterials;

    move-result-object v1

    .line 717
    .restart local v1    # "origKEK":Lcom/amazonaws/services/s3/model/EncryptionMaterials;
    :goto_1
    iget-object v3, v0, Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;->encryptedCEK:[B

    iget-object v4, v0, Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;->keyWrappingAlgorithm:Ljava/lang/String;

    .line 718
    invoke-virtual/range {p0 .. p0}, Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;->getContentCryptoScheme()Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoScheme;

    move-result-object v7

    .line 717
    move-object v5, v1

    move-object/from16 v6, p4

    move-object/from16 v8, p5

    invoke-static/range {v3 .. v8}, Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;->cek([BLjava/lang/String;Lcom/amazonaws/services/s3/model/EncryptionMaterials;Ljava/security/Provider;Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoScheme;Lcom/amazonaws/services/kms/AWSKMSClient;)Ljavax/crypto/SecretKey;

    move-result-object v3

    .line 719
    .local v3, "cek":Ljavax/crypto/SecretKey;
    iget-object v4, v0, Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;->cipherLite:Lcom/amazonaws/services/s3/internal/crypto/CipherLite;

    .line 720
    invoke-virtual {v4}, Lcom/amazonaws/services/s3/internal/crypto/CipherLite;->getIV()[B

    move-result-object v9

    .line 721
    invoke-virtual/range {p0 .. p0}, Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;->getContentCryptoScheme()Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoScheme;

    move-result-object v11

    .line 720
    move-object v8, v3

    move-object/from16 v10, p1

    move-object/from16 v12, p3

    move-object/from16 v13, p4

    move-object/from16 v14, p5

    move-object/from16 v15, p6

    invoke-static/range {v8 .. v15}, Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;->create(Ljavax/crypto/SecretKey;[BLcom/amazonaws/services/s3/model/EncryptionMaterials;Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoScheme;Lcom/amazonaws/services/s3/internal/crypto/S3CryptoScheme;Ljava/security/Provider;Lcom/amazonaws/services/kms/AWSKMSClient;Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;

    move-result-object v4

    .line 724
    .local v4, "output":Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;
    iget-object v5, v4, Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;->encryptedCEK:[B

    iget-object v6, v0, Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;->encryptedCEK:[B

    invoke-static {v5, v6}, Ljava/util/Arrays;->equals([B[B)Z

    move-result v5

    if-nez v5, :cond_3

    .line 728
    return-object v4

    .line 725
    :cond_3
    new-instance v5, Ljava/lang/SecurityException;

    const-string v6, "The new KEK must differ from the original"

    invoke-direct {v5, v6}, Ljava/lang/SecurityException;-><init>(Ljava/lang/String;)V

    throw v5
.end method

.method recreate(Ljava/util/Map;Lcom/amazonaws/services/s3/model/EncryptionMaterialsAccessor;Lcom/amazonaws/services/s3/internal/crypto/S3CryptoScheme;Ljava/security/Provider;Lcom/amazonaws/services/kms/AWSKMSClient;Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;
    .locals 14
    .param p2, "accessor"    # Lcom/amazonaws/services/s3/model/EncryptionMaterialsAccessor;
    .param p3, "targetScheme"    # Lcom/amazonaws/services/s3/internal/crypto/S3CryptoScheme;
    .param p4, "p"    # Ljava/security/Provider;
    .param p5, "kms"    # Lcom/amazonaws/services/kms/AWSKMSClient;
    .param p6, "req"    # Lcom/amazonaws/AmazonWebServiceRequest;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;",
            "Lcom/amazonaws/services/s3/model/EncryptionMaterialsAccessor;",
            "Lcom/amazonaws/services/s3/internal/crypto/S3CryptoScheme;",
            "Ljava/security/Provider;",
            "Lcom/amazonaws/services/kms/AWSKMSClient;",
            "Lcom/amazonaws/AmazonWebServiceRequest;",
            ")",
            "Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;"
        }
    .end annotation

    .line 649
    .local p1, "newKEKMatDesc":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    move-object v0, p0

    move-object v1, p1

    move-object/from16 v2, p2

    invoke-direct {p0}, Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;->usesKMSKey()Z

    move-result v3

    if-nez v3, :cond_1

    iget-object v3, v0, Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;->kekMaterialsDescription:Ljava/util/Map;

    invoke-virtual {p1, v3}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_0

    goto :goto_0

    .line 650
    :cond_0
    new-instance v3, Ljava/lang/SecurityException;

    const-string v4, "Material description of the new KEK must differ from the current one"

    invoke-direct {v3, v4}, Ljava/lang/SecurityException;-><init>(Ljava/lang/String;)V

    throw v3

    .line 654
    :cond_1
    :goto_0
    invoke-direct {p0}, Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;->usesKMSKey()Z

    move-result v3

    if-eqz v3, :cond_2

    .line 655
    new-instance v3, Lcom/amazonaws/services/s3/model/KMSEncryptionMaterials;

    iget-object v4, v0, Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;->kekMaterialsDescription:Ljava/util/Map;

    const-string v5, "kms_cmk_id"

    invoke-interface {v4, v5}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/String;

    invoke-direct {v3, v4}, Lcom/amazonaws/services/s3/model/KMSEncryptionMaterials;-><init>(Ljava/lang/String;)V

    .local v3, "origKEK":Lcom/amazonaws/services/s3/model/EncryptionMaterials;
    goto :goto_1

    .line 658
    .end local v3    # "origKEK":Lcom/amazonaws/services/s3/model/EncryptionMaterials;
    :cond_2
    iget-object v3, v0, Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;->kekMaterialsDescription:Ljava/util/Map;

    invoke-interface {v2, v3}, Lcom/amazonaws/services/s3/model/EncryptionMaterialsAccessor;->getEncryptionMaterials(Ljava/util/Map;)Lcom/amazonaws/services/s3/model/EncryptionMaterials;

    move-result-object v3

    .line 660
    .restart local v3    # "origKEK":Lcom/amazonaws/services/s3/model/EncryptionMaterials;
    :goto_1
    invoke-interface {v2, p1}, Lcom/amazonaws/services/s3/model/EncryptionMaterialsAccessor;->getEncryptionMaterials(Ljava/util/Map;)Lcom/amazonaws/services/s3/model/EncryptionMaterials;

    move-result-object v12

    .line 661
    .local v12, "newKEK":Lcom/amazonaws/services/s3/model/EncryptionMaterials;
    if-eqz v12, :cond_4

    .line 667
    iget-object v4, v0, Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;->encryptedCEK:[B

    iget-object v5, v0, Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;->keyWrappingAlgorithm:Ljava/lang/String;

    .line 668
    invoke-virtual {p0}, Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;->getContentCryptoScheme()Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoScheme;

    move-result-object v8

    .line 667
    move-object v6, v3

    move-object/from16 v7, p4

    move-object/from16 v9, p5

    invoke-static/range {v4 .. v9}, Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;->cek([BLjava/lang/String;Lcom/amazonaws/services/s3/model/EncryptionMaterials;Ljava/security/Provider;Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoScheme;Lcom/amazonaws/services/kms/AWSKMSClient;)Ljavax/crypto/SecretKey;

    move-result-object v13

    .line 669
    .local v13, "cek":Ljavax/crypto/SecretKey;
    iget-object v4, v0, Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;->cipherLite:Lcom/amazonaws/services/s3/internal/crypto/CipherLite;

    invoke-virtual {v4}, Lcom/amazonaws/services/s3/internal/crypto/CipherLite;->getIV()[B

    move-result-object v5

    .line 670
    invoke-virtual {p0}, Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;->getContentCryptoScheme()Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoScheme;

    move-result-object v7

    .line 669
    move-object v4, v13

    move-object v6, v12

    move-object/from16 v8, p3

    move-object/from16 v9, p4

    move-object/from16 v10, p5

    move-object/from16 v11, p6

    invoke-static/range {v4 .. v11}, Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;->create(Ljavax/crypto/SecretKey;[BLcom/amazonaws/services/s3/model/EncryptionMaterials;Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoScheme;Lcom/amazonaws/services/s3/internal/crypto/S3CryptoScheme;Ljava/security/Provider;Lcom/amazonaws/services/kms/AWSKMSClient;Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;

    move-result-object v4

    .line 673
    .local v4, "output":Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;
    iget-object v5, v4, Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;->encryptedCEK:[B

    iget-object v6, v0, Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;->encryptedCEK:[B

    invoke-static {v5, v6}, Ljava/util/Arrays;->equals([B[B)Z

    move-result v5

    if-nez v5, :cond_3

    .line 677
    return-object v4

    .line 674
    :cond_3
    new-instance v5, Ljava/lang/SecurityException;

    const-string v6, "The new KEK must differ from the original"

    invoke-direct {v5, v6}, Ljava/lang/SecurityException;-><init>(Ljava/lang/String;)V

    throw v5

    .line 662
    .end local v4    # "output":Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;
    .end local v13    # "cek":Ljavax/crypto/SecretKey;
    :cond_4
    new-instance v4, Lcom/amazonaws/AmazonClientException;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "No material available with the description "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, " from the encryption material provider"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-direct {v4, v5}, Lcom/amazonaws/AmazonClientException;-><init>(Ljava/lang/String;)V

    throw v4
.end method

.method toJsonString()Ljava/lang/String;
    .locals 7

    .line 193
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    .line 194
    .local v0, "map":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    invoke-virtual {p0}, Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;->getEncryptedCEK()[B

    move-result-object v1

    .line 195
    .local v1, "encryptedCEK":[B
    const-string/jumbo v2, "x-amz-key-v2"

    invoke-static {v1}, Lcom/amazonaws/util/Base64;->encodeAsString([B)Ljava/lang/String;

    move-result-object v3

    invoke-interface {v0, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 196
    iget-object v2, p0, Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;->cipherLite:Lcom/amazonaws/services/s3/internal/crypto/CipherLite;

    invoke-virtual {v2}, Lcom/amazonaws/services/s3/internal/crypto/CipherLite;->getIV()[B

    move-result-object v2

    .line 197
    .local v2, "iv":[B
    const-string/jumbo v3, "x-amz-iv"

    invoke-static {v2}, Lcom/amazonaws/util/Base64;->encodeAsString([B)Ljava/lang/String;

    move-result-object v4

    invoke-interface {v0, v3, v4}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 198
    const-string/jumbo v3, "x-amz-matdesc"

    invoke-direct {p0}, Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;->kekMaterialDescAsJson()Ljava/lang/String;

    move-result-object v4

    invoke-interface {v0, v3, v4}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 202
    invoke-virtual {p0}, Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;->getContentCryptoScheme()Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoScheme;

    move-result-object v3

    .line 203
    .local v3, "scheme":Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoScheme;
    const-string/jumbo v4, "x-amz-cek-alg"

    invoke-virtual {v3}, Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoScheme;->getCipherAlgorithm()Ljava/lang/String;

    move-result-object v5

    invoke-interface {v0, v4, v5}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 204
    invoke-virtual {v3}, Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoScheme;->getTagLengthInBits()I

    move-result v4

    .line 205
    .local v4, "tagLen":I
    if-lez v4, :cond_0

    .line 206
    const-string/jumbo v5, "x-amz-tag-len"

    invoke-static {v4}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v6

    invoke-interface {v0, v5, v6}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 208
    :cond_0
    invoke-virtual {p0}, Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;->getKeyWrappingAlgorithm()Ljava/lang/String;

    move-result-object v5

    .line 209
    .local v5, "keyWrapAlgo":Ljava/lang/String;
    if-eqz v5, :cond_1

    .line 210
    const-string/jumbo v6, "x-amz-wrap-alg"

    invoke-interface {v0, v6, v5}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 212
    :cond_1
    invoke-static {v0}, Lcom/amazonaws/util/json/JsonUtils;->mapToString(Ljava/util/Map;)Ljava/lang/String;

    move-result-object v6

    return-object v6
.end method

.method toJsonString(Lcom/amazonaws/services/s3/model/CryptoMode;)Ljava/lang/String;
    .locals 1
    .param p1, "mode"    # Lcom/amazonaws/services/s3/model/CryptoMode;

    .line 184
    sget-object v0, Lcom/amazonaws/services/s3/model/CryptoMode;->EncryptionOnly:Lcom/amazonaws/services/s3/model/CryptoMode;

    if-ne p1, v0, :cond_0

    invoke-direct {p0}, Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;->usesKMSKey()Z

    move-result v0

    if-nez v0, :cond_0

    .line 185
    invoke-direct {p0}, Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;->toJsonStringEO()Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    :cond_0
    invoke-virtual {p0}, Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;->toJsonString()Ljava/lang/String;

    move-result-object v0

    .line 184
    :goto_0
    return-object v0
.end method

.method toObjectMetadata(Lcom/amazonaws/services/s3/model/ObjectMetadata;Lcom/amazonaws/services/s3/model/CryptoMode;)Lcom/amazonaws/services/s3/model/ObjectMetadata;
    .locals 1
    .param p1, "metadata"    # Lcom/amazonaws/services/s3/model/ObjectMetadata;
    .param p2, "mode"    # Lcom/amazonaws/services/s3/model/CryptoMode;

    .line 119
    sget-object v0, Lcom/amazonaws/services/s3/model/CryptoMode;->EncryptionOnly:Lcom/amazonaws/services/s3/model/CryptoMode;

    if-ne p2, v0, :cond_0

    invoke-direct {p0}, Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;->usesKMSKey()Z

    move-result v0

    if-nez v0, :cond_0

    .line 120
    invoke-direct {p0, p1}, Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;->toObjectMetadataEO(Lcom/amazonaws/services/s3/model/ObjectMetadata;)Lcom/amazonaws/services/s3/model/ObjectMetadata;

    move-result-object v0

    goto :goto_0

    .line 121
    :cond_0
    invoke-direct {p0, p1}, Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;->toObjectMetadata(Lcom/amazonaws/services/s3/model/ObjectMetadata;)Lcom/amazonaws/services/s3/model/ObjectMetadata;

    move-result-object v0

    .line 119
    :goto_0
    return-object v0
.end method
