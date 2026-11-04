.class public Lcom/rokid/security/phone/sdk/base/utils/net/utils/HttpsUtils;
.super Ljava/lang/Object;
.source "HttpsUtils.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/rokid/security/phone/sdk/base/utils/net/utils/HttpsUtils$SSLParams;
    }
.end annotation


# static fields
.field public static UnSafeHostnameVerifier:Ljavax/net/ssl/HostnameVerifier;

.field public static UnSafeTrustManager:Ljavax/net/ssl/X509TrustManager;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 178
    new-instance v0, Lcom/rokid/security/phone/sdk/base/utils/net/utils/HttpsUtils$2;

    invoke-direct {v0}, Lcom/rokid/security/phone/sdk/base/utils/net/utils/HttpsUtils$2;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/sdk/base/utils/net/utils/HttpsUtils;->UnSafeTrustManager:Ljavax/net/ssl/X509TrustManager;

    .line 198
    new-instance v0, Lcom/rokid/security/phone/sdk/base/utils/net/utils/HttpsUtils$3;

    invoke-direct {v0}, Lcom/rokid/security/phone/sdk/base/utils/net/utils/HttpsUtils$3;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/sdk/base/utils/net/utils/HttpsUtils;->UnSafeHostnameVerifier:Ljavax/net/ssl/HostnameVerifier;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .line 30
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static chooseTrustManager([Ljavax/net/ssl/TrustManager;)Ljavax/net/ssl/X509TrustManager;
    .locals 4
    .param p0, "trustManagers"    # [Ljavax/net/ssl/TrustManager;

    .line 166
    array-length v0, p0

    const/4 v1, 0x0

    :goto_0
    if-ge v1, v0, :cond_1

    aget-object v2, p0, v1

    .line 167
    .local v2, "trustManager":Ljavax/net/ssl/TrustManager;
    instance-of v3, v2, Ljavax/net/ssl/X509TrustManager;

    if-eqz v3, :cond_0

    .line 168
    move-object v0, v2

    check-cast v0, Ljavax/net/ssl/X509TrustManager;

    return-object v0

    .line 166
    .end local v2    # "trustManager":Ljavax/net/ssl/TrustManager;
    :cond_0
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 171
    :cond_1
    const/4 v0, 0x0

    return-object v0
.end method

.method public static getHostnameVerifier()Ljavax/net/ssl/HostnameVerifier;
    .locals 1

    .line 110
    new-instance v0, Lcom/rokid/security/phone/sdk/base/utils/net/utils/HttpsUtils$1;

    invoke-direct {v0}, Lcom/rokid/security/phone/sdk/base/utils/net/utils/HttpsUtils$1;-><init>()V

    .line 116
    .local v0, "hostnameVerifier":Ljavax/net/ssl/HostnameVerifier;
    return-object v0
.end method

.method public static getSSLOkHttpClient()Lokhttp3/OkHttpClient;
    .locals 5
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 212
    new-instance v0, Lcom/rokid/security/phone/sdk/base/utils/net/utils/HttpsUtils$4;

    invoke-direct {v0}, Lcom/rokid/security/phone/sdk/base/utils/net/utils/HttpsUtils$4;-><init>()V

    .line 229
    .local v0, "trustManager":Ljavax/net/ssl/X509TrustManager;
    const-string v1, "SSL"

    invoke-static {v1}, Ljavax/net/ssl/SSLContext;->getInstance(Ljava/lang/String;)Ljavax/net/ssl/SSLContext;

    move-result-object v1

    .line 230
    .local v1, "sslContext":Ljavax/net/ssl/SSLContext;
    const/4 v2, 0x1

    new-array v2, v2, [Ljavax/net/ssl/TrustManager;

    const/4 v3, 0x0

    aput-object v0, v2, v3

    new-instance v3, Ljava/security/SecureRandom;

    invoke-direct {v3}, Ljava/security/SecureRandom;-><init>()V

    const/4 v4, 0x0

    invoke-virtual {v1, v4, v2, v3}, Ljavax/net/ssl/SSLContext;->init([Ljavax/net/ssl/KeyManager;[Ljavax/net/ssl/TrustManager;Ljava/security/SecureRandom;)V

    .line 231
    invoke-virtual {v1}, Ljavax/net/ssl/SSLContext;->getSocketFactory()Ljavax/net/ssl/SSLSocketFactory;

    move-result-object v2

    .line 233
    .local v2, "sslSocketFactory":Ljavax/net/ssl/SSLSocketFactory;
    new-instance v3, Lokhttp3/OkHttpClient$Builder;

    invoke-direct {v3}, Lokhttp3/OkHttpClient$Builder;-><init>()V

    .line 234
    invoke-virtual {v3, v2, v0}, Lokhttp3/OkHttpClient$Builder;->sslSocketFactory(Ljavax/net/ssl/SSLSocketFactory;Ljavax/net/ssl/X509TrustManager;)Lokhttp3/OkHttpClient$Builder;

    move-result-object v3

    new-instance v4, Lcom/rokid/security/phone/sdk/base/utils/net/utils/HttpsUtils$5;

    invoke-direct {v4}, Lcom/rokid/security/phone/sdk/base/utils/net/utils/HttpsUtils$5;-><init>()V

    .line 235
    invoke-virtual {v3, v4}, Lokhttp3/OkHttpClient$Builder;->hostnameVerifier(Ljavax/net/ssl/HostnameVerifier;)Lokhttp3/OkHttpClient$Builder;

    move-result-object v3

    .line 241
    invoke-virtual {v3}, Lokhttp3/OkHttpClient$Builder;->build()Lokhttp3/OkHttpClient;

    move-result-object v3

    .line 233
    return-object v3
.end method

.method public static getSslSocketFactory()Lcom/rokid/security/phone/sdk/base/utils/net/utils/HttpsUtils$SSLParams;
    .locals 2

    .line 38
    const/4 v0, 0x0

    new-array v0, v0, [Ljava/io/InputStream;

    const/4 v1, 0x0

    invoke-static {v1, v1, v1, v0}, Lcom/rokid/security/phone/sdk/base/utils/net/utils/HttpsUtils;->getSslSocketFactoryBase(Ljavax/net/ssl/X509TrustManager;Ljava/io/InputStream;Ljava/lang/String;[Ljava/io/InputStream;)Lcom/rokid/security/phone/sdk/base/utils/net/utils/HttpsUtils$SSLParams;

    move-result-object v0

    return-object v0
.end method

.method public static getSslSocketFactory(Ljava/io/InputStream;Ljava/lang/String;Ljavax/net/ssl/X509TrustManager;)Lcom/rokid/security/phone/sdk/base/utils/net/utils/HttpsUtils$SSLParams;
    .locals 1
    .param p0, "bksFile"    # Ljava/io/InputStream;
    .param p1, "password"    # Ljava/lang/String;
    .param p2, "trustManager"    # Ljavax/net/ssl/X509TrustManager;

    .line 72
    const/4 v0, 0x0

    new-array v0, v0, [Ljava/io/InputStream;

    invoke-static {p2, p0, p1, v0}, Lcom/rokid/security/phone/sdk/base/utils/net/utils/HttpsUtils;->getSslSocketFactoryBase(Ljavax/net/ssl/X509TrustManager;Ljava/io/InputStream;Ljava/lang/String;[Ljava/io/InputStream;)Lcom/rokid/security/phone/sdk/base/utils/net/utils/HttpsUtils$SSLParams;

    move-result-object v0

    return-object v0
.end method

.method public static varargs getSslSocketFactory(Ljava/io/InputStream;Ljava/lang/String;[Ljava/io/InputStream;)Lcom/rokid/security/phone/sdk/base/utils/net/utils/HttpsUtils$SSLParams;
    .locals 1
    .param p0, "bksFile"    # Ljava/io/InputStream;
    .param p1, "password"    # Ljava/lang/String;
    .param p2, "certificates"    # [Ljava/io/InputStream;

    .line 63
    const/4 v0, 0x0

    invoke-static {v0, p0, p1, p2}, Lcom/rokid/security/phone/sdk/base/utils/net/utils/HttpsUtils;->getSslSocketFactoryBase(Ljavax/net/ssl/X509TrustManager;Ljava/io/InputStream;Ljava/lang/String;[Ljava/io/InputStream;)Lcom/rokid/security/phone/sdk/base/utils/net/utils/HttpsUtils$SSLParams;

    move-result-object v0

    return-object v0
.end method

.method public static getSslSocketFactory(Ljavax/net/ssl/X509TrustManager;)Lcom/rokid/security/phone/sdk/base/utils/net/utils/HttpsUtils$SSLParams;
    .locals 2
    .param p0, "trustManager"    # Ljavax/net/ssl/X509TrustManager;

    .line 46
    const/4 v0, 0x0

    new-array v0, v0, [Ljava/io/InputStream;

    const/4 v1, 0x0

    invoke-static {p0, v1, v1, v0}, Lcom/rokid/security/phone/sdk/base/utils/net/utils/HttpsUtils;->getSslSocketFactoryBase(Ljavax/net/ssl/X509TrustManager;Ljava/io/InputStream;Ljava/lang/String;[Ljava/io/InputStream;)Lcom/rokid/security/phone/sdk/base/utils/net/utils/HttpsUtils$SSLParams;

    move-result-object v0

    return-object v0
.end method

.method public static varargs getSslSocketFactory([Ljava/io/InputStream;)Lcom/rokid/security/phone/sdk/base/utils/net/utils/HttpsUtils$SSLParams;
    .locals 1
    .param p0, "certificates"    # [Ljava/io/InputStream;

    .line 54
    const/4 v0, 0x0

    invoke-static {v0, v0, v0, p0}, Lcom/rokid/security/phone/sdk/base/utils/net/utils/HttpsUtils;->getSslSocketFactoryBase(Ljavax/net/ssl/X509TrustManager;Ljava/io/InputStream;Ljava/lang/String;[Ljava/io/InputStream;)Lcom/rokid/security/phone/sdk/base/utils/net/utils/HttpsUtils$SSLParams;

    move-result-object v0

    return-object v0
.end method

.method private static varargs getSslSocketFactoryBase(Ljavax/net/ssl/X509TrustManager;Ljava/io/InputStream;Ljava/lang/String;[Ljava/io/InputStream;)Lcom/rokid/security/phone/sdk/base/utils/net/utils/HttpsUtils$SSLParams;
    .locals 7
    .param p0, "trustManager"    # Ljavax/net/ssl/X509TrustManager;
    .param p1, "bksFile"    # Ljava/io/InputStream;
    .param p2, "password"    # Ljava/lang/String;
    .param p3, "certificates"    # [Ljava/io/InputStream;

    .line 76
    new-instance v0, Lcom/rokid/security/phone/sdk/base/utils/net/utils/HttpsUtils$SSLParams;

    invoke-direct {v0}, Lcom/rokid/security/phone/sdk/base/utils/net/utils/HttpsUtils$SSLParams;-><init>()V

    .line 78
    .local v0, "sslParams":Lcom/rokid/security/phone/sdk/base/utils/net/utils/HttpsUtils$SSLParams;
    :try_start_0
    invoke-static {p1, p2}, Lcom/rokid/security/phone/sdk/base/utils/net/utils/HttpsUtils;->prepareKeyManager(Ljava/io/InputStream;Ljava/lang/String;)[Ljavax/net/ssl/KeyManager;

    move-result-object v1

    .line 79
    .local v1, "keyManagers":[Ljavax/net/ssl/KeyManager;
    invoke-static {p3}, Lcom/rokid/security/phone/sdk/base/utils/net/utils/HttpsUtils;->prepareTrustManager([Ljava/io/InputStream;)[Ljavax/net/ssl/TrustManager;

    move-result-object v2

    .line 81
    .local v2, "trustManagers":[Ljavax/net/ssl/TrustManager;
    if-eqz p0, :cond_0

    .line 83
    move-object v3, p0

    .local v3, "manager":Ljavax/net/ssl/X509TrustManager;
    goto :goto_0

    .line 84
    .end local v3    # "manager":Ljavax/net/ssl/X509TrustManager;
    :cond_0
    if-eqz v2, :cond_1

    .line 86
    invoke-static {v2}, Lcom/rokid/security/phone/sdk/base/utils/net/utils/HttpsUtils;->chooseTrustManager([Ljavax/net/ssl/TrustManager;)Ljavax/net/ssl/X509TrustManager;

    move-result-object v3

    .restart local v3    # "manager":Ljavax/net/ssl/X509TrustManager;
    goto :goto_0

    .line 89
    .end local v3    # "manager":Ljavax/net/ssl/X509TrustManager;
    :cond_1
    sget-object v3, Lcom/rokid/security/phone/sdk/base/utils/net/utils/HttpsUtils;->UnSafeTrustManager:Ljavax/net/ssl/X509TrustManager;

    .line 92
    .restart local v3    # "manager":Ljavax/net/ssl/X509TrustManager;
    :goto_0
    const-string v4, "TLS"

    invoke-static {v4}, Ljavax/net/ssl/SSLContext;->getInstance(Ljava/lang/String;)Ljavax/net/ssl/SSLContext;

    move-result-object v4

    .line 95
    .local v4, "sslContext":Ljavax/net/ssl/SSLContext;
    const/4 v5, 0x1

    new-array v5, v5, [Ljavax/net/ssl/TrustManager;

    const/4 v6, 0x0

    aput-object v3, v5, v6

    const/4 v6, 0x0

    invoke-virtual {v4, v1, v5, v6}, Ljavax/net/ssl/SSLContext;->init([Ljavax/net/ssl/KeyManager;[Ljavax/net/ssl/TrustManager;Ljava/security/SecureRandom;)V

    .line 97
    invoke-virtual {v4}, Ljavax/net/ssl/SSLContext;->getSocketFactory()Ljavax/net/ssl/SSLSocketFactory;

    move-result-object v5

    iput-object v5, v0, Lcom/rokid/security/phone/sdk/base/utils/net/utils/HttpsUtils$SSLParams;->sSLSocketFactory:Ljavax/net/ssl/SSLSocketFactory;

    .line 98
    iput-object v3, v0, Lcom/rokid/security/phone/sdk/base/utils/net/utils/HttpsUtils$SSLParams;->trustManager:Ljavax/net/ssl/X509TrustManager;
    :try_end_0
    .catch Ljava/security/NoSuchAlgorithmException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/security/KeyManagementException; {:try_start_0 .. :try_end_0} :catch_0

    .line 99
    return-object v0

    .line 102
    .end local v1    # "keyManagers":[Ljavax/net/ssl/KeyManager;
    .end local v2    # "trustManagers":[Ljavax/net/ssl/TrustManager;
    .end local v3    # "manager":Ljavax/net/ssl/X509TrustManager;
    .end local v4    # "sslContext":Ljavax/net/ssl/SSLContext;
    :catch_0
    move-exception v1

    .line 103
    .local v1, "e":Ljava/security/KeyManagementException;
    new-instance v2, Ljava/lang/AssertionError;

    invoke-direct {v2, v1}, Ljava/lang/AssertionError;-><init>(Ljava/lang/Object;)V

    throw v2

    .line 100
    .end local v1    # "e":Ljava/security/KeyManagementException;
    :catch_1
    move-exception v1

    .line 101
    .local v1, "e":Ljava/security/NoSuchAlgorithmException;
    new-instance v2, Ljava/lang/AssertionError;

    invoke-direct {v2, v1}, Ljava/lang/AssertionError;-><init>(Ljava/lang/Object;)V

    throw v2
.end method

.method private static prepareKeyManager(Ljava/io/InputStream;Ljava/lang/String;)[Ljavax/net/ssl/KeyManager;
    .locals 4
    .param p0, "bksFile"    # Ljava/io/InputStream;
    .param p1, "password"    # Ljava/lang/String;

    .line 121
    const/4 v0, 0x0

    if-eqz p0, :cond_1

    if-nez p1, :cond_0

    goto :goto_0

    .line 122
    :cond_0
    :try_start_0
    const-string v1, "BKS"

    invoke-static {v1}, Ljava/security/KeyStore;->getInstance(Ljava/lang/String;)Ljava/security/KeyStore;

    move-result-object v1

    .line 123
    .local v1, "clientKeyStore":Ljava/security/KeyStore;
    invoke-virtual {p1}, Ljava/lang/String;->toCharArray()[C

    move-result-object v2

    invoke-virtual {v1, p0, v2}, Ljava/security/KeyStore;->load(Ljava/io/InputStream;[C)V

    .line 124
    invoke-static {}, Ljavax/net/ssl/KeyManagerFactory;->getDefaultAlgorithm()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Ljavax/net/ssl/KeyManagerFactory;->getInstance(Ljava/lang/String;)Ljavax/net/ssl/KeyManagerFactory;

    move-result-object v2

    .line 125
    .local v2, "kmf":Ljavax/net/ssl/KeyManagerFactory;
    invoke-virtual {p1}, Ljava/lang/String;->toCharArray()[C

    move-result-object v3

    invoke-virtual {v2, v1, v3}, Ljavax/net/ssl/KeyManagerFactory;->init(Ljava/security/KeyStore;[C)V

    .line 126
    invoke-virtual {v2}, Ljavax/net/ssl/KeyManagerFactory;->getKeyManagers()[Ljavax/net/ssl/KeyManager;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    .line 127
    .end local v1    # "clientKeyStore":Ljava/security/KeyStore;
    .end local v2    # "kmf":Ljavax/net/ssl/KeyManagerFactory;
    :catch_0
    move-exception v1

    .line 128
    .local v1, "e":Ljava/lang/Exception;
    invoke-virtual {v1}, Ljava/lang/Exception;->printStackTrace()V

    .line 130
    .end local v1    # "e":Ljava/lang/Exception;
    return-object v0

    .line 121
    :cond_1
    :goto_0
    return-object v0
.end method

.method private static varargs prepareTrustManager([Ljava/io/InputStream;)[Ljavax/net/ssl/TrustManager;
    .locals 10
    .param p0, "certificates"    # [Ljava/io/InputStream;

    .line 134
    const/4 v0, 0x0

    if-eqz p0, :cond_3

    array-length v1, p0

    if-gtz v1, :cond_0

    goto :goto_3

    .line 136
    :cond_0
    :try_start_0
    const-string v1, "X.509"

    invoke-static {v1}, Ljava/security/cert/CertificateFactory;->getInstance(Ljava/lang/String;)Ljava/security/cert/CertificateFactory;

    move-result-object v1

    .line 138
    .local v1, "certificateFactory":Ljava/security/cert/CertificateFactory;
    invoke-static {}, Ljava/security/KeyStore;->getDefaultType()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Ljava/security/KeyStore;->getInstance(Ljava/lang/String;)Ljava/security/KeyStore;

    move-result-object v2

    .line 139
    .local v2, "keyStore":Ljava/security/KeyStore;
    invoke-virtual {v2, v0}, Ljava/security/KeyStore;->load(Ljava/security/KeyStore$LoadStoreParameter;)V

    .line 140
    const/4 v3, 0x0

    .line 141
    .local v3, "index":I
    array-length v4, p0

    const/4 v5, 0x0

    :goto_0
    if-ge v5, v4, :cond_2

    aget-object v6, p0, v5

    .line 142
    .local v6, "certStream":Ljava/io/InputStream;
    add-int/lit8 v7, v3, 0x1

    .end local v3    # "index":I
    .local v7, "index":I
    invoke-static {v3}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;

    move-result-object v3

    .line 144
    .local v3, "certificateAlias":Ljava/lang/String;
    invoke-virtual {v1, v6}, Ljava/security/cert/CertificateFactory;->generateCertificate(Ljava/io/InputStream;)Ljava/security/cert/Certificate;

    move-result-object v8

    .line 146
    .local v8, "cert":Ljava/security/cert/Certificate;
    invoke-virtual {v2, v3, v8}, Ljava/security/KeyStore;->setCertificateEntry(Ljava/lang/String;Ljava/security/cert/Certificate;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_1

    .line 148
    if-eqz v6, :cond_1

    :try_start_1
    invoke-virtual {v6}, Ljava/io/InputStream;->close()V
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_0
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_1

    goto :goto_1

    .line 149
    :catch_0
    move-exception v9

    .line 150
    .local v9, "e":Ljava/io/IOException;
    :try_start_2
    invoke-virtual {v9}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_2

    .line 151
    .end local v9    # "e":Ljava/io/IOException;
    :cond_1
    :goto_1
    nop

    .line 141
    .end local v3    # "certificateAlias":Ljava/lang/String;
    .end local v6    # "certStream":Ljava/io/InputStream;
    .end local v8    # "cert":Ljava/security/cert/Certificate;
    :goto_2
    add-int/lit8 v5, v5, 0x1

    move v3, v7

    goto :goto_0

    .line 154
    .end local v7    # "index":I
    .local v3, "index":I
    :cond_2
    invoke-static {}, Ljavax/net/ssl/TrustManagerFactory;->getDefaultAlgorithm()Ljava/lang/String;

    move-result-object v4

    invoke-static {v4}, Ljavax/net/ssl/TrustManagerFactory;->getInstance(Ljava/lang/String;)Ljavax/net/ssl/TrustManagerFactory;

    move-result-object v4

    .line 156
    .local v4, "tmf":Ljavax/net/ssl/TrustManagerFactory;
    invoke-virtual {v4, v2}, Ljavax/net/ssl/TrustManagerFactory;->init(Ljava/security/KeyStore;)V

    .line 158
    invoke-virtual {v4}, Ljavax/net/ssl/TrustManagerFactory;->getTrustManagers()[Ljavax/net/ssl/TrustManager;

    move-result-object v0
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_1

    return-object v0

    .line 159
    .end local v1    # "certificateFactory":Ljava/security/cert/CertificateFactory;
    .end local v2    # "keyStore":Ljava/security/KeyStore;
    .end local v3    # "index":I
    .end local v4    # "tmf":Ljavax/net/ssl/TrustManagerFactory;
    :catch_1
    move-exception v1

    .line 160
    .local v1, "e":Ljava/lang/Exception;
    invoke-virtual {v1}, Ljava/lang/Exception;->printStackTrace()V

    .line 162
    .end local v1    # "e":Ljava/lang/Exception;
    return-object v0

    .line 134
    :cond_3
    :goto_3
    return-object v0
.end method
