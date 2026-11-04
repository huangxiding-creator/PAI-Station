.class public Lcom/rokid/utils/HttpsCertUtils;
.super Ljava/lang/Object;
.source "HttpsCertUtils.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/rokid/utils/HttpsCertUtils$MyTrustManager;,
        Lcom/rokid/utils/HttpsCertUtils$UnSafeTrustManager;,
        Lcom/rokid/utils/HttpsCertUtils$Protocol;,
        Lcom/rokid/utils/HttpsCertUtils$SSLParams;
    }
.end annotation


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 26
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static synthetic access$100([Ljavax/net/ssl/TrustManager;)Ljavax/net/ssl/X509TrustManager;
    .locals 1
    .param p0, "x0"    # [Ljavax/net/ssl/TrustManager;

    .line 26
    invoke-static {p0}, Lcom/rokid/utils/HttpsCertUtils;->chooseTrustManager([Ljavax/net/ssl/TrustManager;)Ljavax/net/ssl/X509TrustManager;

    move-result-object v0

    return-object v0
.end method

.method private static chooseTrustManager([Ljavax/net/ssl/TrustManager;)Ljavax/net/ssl/X509TrustManager;
    .locals 4
    .param p0, "trustManagers"    # [Ljavax/net/ssl/TrustManager;

    .line 118
    array-length v0, p0

    const/4 v1, 0x0

    :goto_0
    if-ge v1, v0, :cond_1

    aget-object v2, p0, v1

    .line 119
    .local v2, "trustManager":Ljavax/net/ssl/TrustManager;
    instance-of v3, v2, Ljavax/net/ssl/X509TrustManager;

    if-eqz v3, :cond_0

    .line 120
    move-object v0, v2

    check-cast v0, Ljavax/net/ssl/X509TrustManager;

    return-object v0

    .line 118
    .end local v2    # "trustManager":Ljavax/net/ssl/TrustManager;
    :cond_0
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 123
    :cond_1
    const/4 v0, 0x0

    return-object v0
.end method

.method public static getSSLParams(Ljava/lang/String;[Ljava/io/InputStream;Ljava/io/InputStream;Ljava/lang/String;)Lcom/rokid/utils/HttpsCertUtils$SSLParams;
    .locals 8
    .param p0, "protocol"    # Ljava/lang/String;
    .param p1, "certificates"    # [Ljava/io/InputStream;
    .param p2, "localCert"    # Ljava/io/InputStream;
    .param p3, "password"    # Ljava/lang/String;

    .line 40
    invoke-static {p0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_0

    const-string v0, "SSL"

    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_1

    const-string v0, "TLS"

    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 41
    :cond_0
    const-string p0, "SSL"

    .line 44
    :cond_1
    new-instance v0, Lcom/rokid/utils/HttpsCertUtils$SSLParams;

    invoke-direct {v0}, Lcom/rokid/utils/HttpsCertUtils$SSLParams;-><init>()V

    .line 47
    .local v0, "sslParams":Lcom/rokid/utils/HttpsCertUtils$SSLParams;
    :try_start_0
    invoke-static {p1}, Lcom/rokid/utils/HttpsCertUtils;->prepareTrustManager([Ljava/io/InputStream;)[Ljavax/net/ssl/TrustManager;

    move-result-object v1

    .line 48
    .local v1, "trustManagers":[Ljavax/net/ssl/TrustManager;
    invoke-static {p2, p3}, Lcom/rokid/utils/HttpsCertUtils;->prepareKeyManager(Ljava/io/InputStream;Ljava/lang/String;)[Ljavax/net/ssl/KeyManager;

    move-result-object v2

    .line 49
    .local v2, "keyManagers":[Ljavax/net/ssl/KeyManager;
    invoke-static {p0}, Ljavax/net/ssl/SSLContext;->getInstance(Ljava/lang/String;)Ljavax/net/ssl/SSLContext;

    move-result-object v3

    .line 52
    .local v3, "sslContext":Ljavax/net/ssl/SSLContext;
    const/4 v4, 0x0

    if-eqz v1, :cond_2

    .line 53
    new-instance v5, Lcom/rokid/utils/HttpsCertUtils$MyTrustManager;

    invoke-static {v1}, Lcom/rokid/utils/HttpsCertUtils;->chooseTrustManager([Ljavax/net/ssl/TrustManager;)Ljavax/net/ssl/X509TrustManager;

    move-result-object v6

    invoke-direct {v5, v6}, Lcom/rokid/utils/HttpsCertUtils$MyTrustManager;-><init>(Ljavax/net/ssl/X509TrustManager;)V

    .local v5, "trustManager":Ljavax/net/ssl/X509TrustManager;
    goto :goto_0

    .line 55
    .end local v5    # "trustManager":Ljavax/net/ssl/X509TrustManager;
    :cond_2
    new-instance v5, Lcom/rokid/utils/HttpsCertUtils$UnSafeTrustManager;

    invoke-direct {v5, v4}, Lcom/rokid/utils/HttpsCertUtils$UnSafeTrustManager;-><init>(Lcom/rokid/utils/HttpsCertUtils$1;)V

    .line 57
    .restart local v5    # "trustManager":Ljavax/net/ssl/X509TrustManager;
    :goto_0
    const/4 v6, 0x1

    new-array v6, v6, [Ljavax/net/ssl/TrustManager;

    const/4 v7, 0x0

    aput-object v5, v6, v7

    invoke-virtual {v3, v2, v6, v4}, Ljavax/net/ssl/SSLContext;->init([Ljavax/net/ssl/KeyManager;[Ljavax/net/ssl/TrustManager;Ljava/security/SecureRandom;)V

    .line 58
    invoke-virtual {v3}, Ljavax/net/ssl/SSLContext;->getSocketFactory()Ljavax/net/ssl/SSLSocketFactory;

    move-result-object v4

    iput-object v4, v0, Lcom/rokid/utils/HttpsCertUtils$SSLParams;->sSLSocketFactory:Ljavax/net/ssl/SSLSocketFactory;

    .line 59
    iput-object v5, v0, Lcom/rokid/utils/HttpsCertUtils$SSLParams;->trustManager:Ljavax/net/ssl/X509TrustManager;
    :try_end_0
    .catch Ljava/security/NoSuchAlgorithmException; {:try_start_0 .. :try_end_0} :catch_2
    .catch Ljava/security/KeyManagementException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/security/KeyStoreException; {:try_start_0 .. :try_end_0} :catch_0

    .line 62
    .end local v1    # "trustManagers":[Ljavax/net/ssl/TrustManager;
    .end local v2    # "keyManagers":[Ljavax/net/ssl/KeyManager;
    .end local v3    # "sslContext":Ljavax/net/ssl/SSLContext;
    .end local v5    # "trustManager":Ljavax/net/ssl/X509TrustManager;
    goto :goto_2

    .line 60
    :catch_0
    move-exception v1

    goto :goto_1

    :catch_1
    move-exception v1

    goto :goto_1

    :catch_2
    move-exception v1

    .line 61
    .local v1, "e":Ljava/security/GeneralSecurityException;
    :goto_1
    invoke-virtual {v1}, Ljava/security/GeneralSecurityException;->printStackTrace()V

    .line 63
    .end local v1    # "e":Ljava/security/GeneralSecurityException;
    :goto_2
    return-object v0
.end method

.method private static prepareKeyManager(Ljava/io/InputStream;Ljava/lang/String;)[Ljavax/net/ssl/KeyManager;
    .locals 4
    .param p0, "localCert"    # Ljava/io/InputStream;
    .param p1, "password"    # Ljava/lang/String;

    .line 96
    const/4 v0, 0x0

    if-eqz p0, :cond_1

    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_0

    goto :goto_1

    .line 101
    :cond_0
    :try_start_0
    const-string v1, "BKS"

    invoke-static {v1}, Ljava/security/KeyStore;->getInstance(Ljava/lang/String;)Ljava/security/KeyStore;

    move-result-object v1

    .line 102
    .local v1, "clientKeyStore":Ljava/security/KeyStore;
    invoke-virtual {p1}, Ljava/lang/String;->toCharArray()[C

    move-result-object v2

    invoke-virtual {v1, p0, v2}, Ljava/security/KeyStore;->load(Ljava/io/InputStream;[C)V

    .line 104
    invoke-static {}, Ljavax/net/ssl/KeyManagerFactory;->getDefaultAlgorithm()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Ljavax/net/ssl/KeyManagerFactory;->getInstance(Ljava/lang/String;)Ljavax/net/ssl/KeyManagerFactory;

    move-result-object v2

    .line 105
    .local v2, "keyManagerFactory":Ljavax/net/ssl/KeyManagerFactory;
    invoke-virtual {p1}, Ljava/lang/String;->toCharArray()[C

    move-result-object v3

    invoke-virtual {v2, v1, v3}, Ljavax/net/ssl/KeyManagerFactory;->init(Ljava/security/KeyStore;[C)V

    .line 107
    invoke-virtual {v2}, Ljavax/net/ssl/KeyManagerFactory;->getKeyManagers()[Ljavax/net/ssl/KeyManager;

    move-result-object v0
    :try_end_0
    .catch Ljava/security/KeyStoreException; {:try_start_0 .. :try_end_0} :catch_4
    .catch Ljava/security/cert/CertificateException; {:try_start_0 .. :try_end_0} :catch_3
    .catch Ljava/security/UnrecoverableKeyException; {:try_start_0 .. :try_end_0} :catch_2
    .catch Ljava/security/NoSuchAlgorithmException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    .line 109
    .end local v1    # "clientKeyStore":Ljava/security/KeyStore;
    .end local v2    # "keyManagerFactory":Ljavax/net/ssl/KeyManagerFactory;
    :catch_0
    move-exception v1

    goto :goto_0

    :catch_1
    move-exception v1

    goto :goto_0

    :catch_2
    move-exception v1

    goto :goto_0

    :catch_3
    move-exception v1

    goto :goto_0

    :catch_4
    move-exception v1

    .line 111
    .local v1, "e":Ljava/lang/Exception;
    :goto_0
    invoke-virtual {v1}, Ljava/lang/Exception;->printStackTrace()V

    .line 114
    .end local v1    # "e":Ljava/lang/Exception;
    return-object v0

    .line 97
    :cond_1
    :goto_1
    return-object v0
.end method

.method private static varargs prepareTrustManager([Ljava/io/InputStream;)[Ljavax/net/ssl/TrustManager;
    .locals 9
    .param p0, "certificates"    # [Ljava/io/InputStream;

    .line 67
    const/4 v0, 0x0

    if-eqz p0, :cond_3

    array-length v1, p0

    const/4 v2, 0x1

    if-ge v1, v2, :cond_0

    goto :goto_2

    .line 72
    :cond_0
    :try_start_0
    const-string v1, "X.509"

    invoke-static {v1}, Ljava/security/cert/CertificateFactory;->getInstance(Ljava/lang/String;)Ljava/security/cert/CertificateFactory;

    move-result-object v1

    .line 73
    .local v1, "certificateFactory":Ljava/security/cert/CertificateFactory;
    invoke-static {}, Ljava/security/KeyStore;->getDefaultType()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Ljava/security/KeyStore;->getInstance(Ljava/lang/String;)Ljava/security/KeyStore;

    move-result-object v2

    .line 74
    .local v2, "keyStore":Ljava/security/KeyStore;
    invoke-virtual {v2, v0}, Ljava/security/KeyStore;->load(Ljava/security/KeyStore$LoadStoreParameter;)V

    .line 75
    const/4 v3, 0x0

    .line 76
    .local v3, "index":I
    array-length v4, p0

    const/4 v5, 0x0

    :goto_0
    if-ge v5, v4, :cond_2

    aget-object v6, p0, v5

    .line 77
    .local v6, "certificate":Ljava/io/InputStream;
    add-int/lit8 v7, v3, 0x1

    .end local v3    # "index":I
    .local v7, "index":I
    invoke-static {v3}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;

    move-result-object v3

    .line 78
    .local v3, "certificateAlias":Ljava/lang/String;
    invoke-virtual {v1, v6}, Ljava/security/cert/CertificateFactory;->generateCertificate(Ljava/io/InputStream;)Ljava/security/cert/Certificate;

    move-result-object v8

    invoke-virtual {v2, v3, v8}, Ljava/security/KeyStore;->setCertificateEntry(Ljava/lang/String;Ljava/security/cert/Certificate;)V

    .line 79
    if-eqz v6, :cond_1

    .line 80
    invoke-virtual {v6}, Ljava/io/InputStream;->close()V

    .line 76
    .end local v3    # "certificateAlias":Ljava/lang/String;
    .end local v6    # "certificate":Ljava/io/InputStream;
    :cond_1
    add-int/lit8 v5, v5, 0x1

    move v3, v7

    goto :goto_0

    .line 84
    .end local v7    # "index":I
    .local v3, "index":I
    :cond_2
    invoke-static {}, Ljavax/net/ssl/TrustManagerFactory;->getDefaultAlgorithm()Ljava/lang/String;

    move-result-object v4

    invoke-static {v4}, Ljavax/net/ssl/TrustManagerFactory;->getInstance(Ljava/lang/String;)Ljavax/net/ssl/TrustManagerFactory;

    move-result-object v4

    .line 85
    .local v4, "trustManagerFactory":Ljavax/net/ssl/TrustManagerFactory;
    invoke-virtual {v4, v2}, Ljavax/net/ssl/TrustManagerFactory;->init(Ljava/security/KeyStore;)V

    .line 87
    invoke-virtual {v4}, Ljavax/net/ssl/TrustManagerFactory;->getTrustManagers()[Ljavax/net/ssl/TrustManager;

    move-result-object v0
    :try_end_0
    .catch Ljava/security/cert/CertificateException; {:try_start_0 .. :try_end_0} :catch_3
    .catch Ljava/security/NoSuchAlgorithmException; {:try_start_0 .. :try_end_0} :catch_2
    .catch Ljava/security/KeyStoreException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    .line 88
    .end local v1    # "certificateFactory":Ljava/security/cert/CertificateFactory;
    .end local v2    # "keyStore":Ljava/security/KeyStore;
    .end local v3    # "index":I
    .end local v4    # "trustManagerFactory":Ljavax/net/ssl/TrustManagerFactory;
    :catch_0
    move-exception v1

    goto :goto_1

    :catch_1
    move-exception v1

    goto :goto_1

    :catch_2
    move-exception v1

    goto :goto_1

    :catch_3
    move-exception v1

    .line 89
    .local v1, "e":Ljava/lang/Exception;
    :goto_1
    invoke-virtual {v1}, Ljava/lang/Exception;->printStackTrace()V

    .line 92
    .end local v1    # "e":Ljava/lang/Exception;
    return-object v0

    .line 68
    :cond_3
    :goto_2
    return-object v0
.end method
