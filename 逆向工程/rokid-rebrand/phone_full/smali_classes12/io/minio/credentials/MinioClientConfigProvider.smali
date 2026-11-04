.class public Lio/minio/credentials/MinioClientConfigProvider;
.super Lio/minio/credentials/EnvironmentProvider;
.source "MinioClientConfigProvider.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lio/minio/credentials/MinioClientConfigProvider$McConfig;
    }
.end annotation


# instance fields
.field private final alias:Ljava/lang/String;

.field private final filename:Ljava/lang/String;

.field private final mapper:Lcom/fasterxml/jackson/databind/ObjectMapper;


# direct methods
.method public constructor <init>(Ljava/lang/String;Ljava/lang/String;)V
    .locals 3
    .param p1, "filename"    # Ljava/lang/String;
        .annotation runtime Ljavax/annotation/Nullable;
        .end annotation
    .end param
    .param p2, "alias"    # Ljava/lang/String;
        .annotation runtime Ljavax/annotation/Nullable;
        .end annotation
    .end param

    .line 42
    invoke-direct {p0}, Lio/minio/credentials/EnvironmentProvider;-><init>()V

    .line 43
    if-eqz p1, :cond_1

    invoke-virtual {p1}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_0

    goto :goto_0

    .line 44
    :cond_0
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "Filename must not be empty"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 47
    :cond_1
    :goto_0
    if-eqz p2, :cond_3

    invoke-virtual {p2}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_2

    goto :goto_1

    .line 48
    :cond_2
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "Alias must not be empty"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 51
    :cond_3
    :goto_1
    iput-object p1, p0, Lio/minio/credentials/MinioClientConfigProvider;->filename:Ljava/lang/String;

    .line 52
    iput-object p2, p0, Lio/minio/credentials/MinioClientConfigProvider;->alias:Ljava/lang/String;

    .line 53
    nop

    .line 54
    invoke-static {}, Lcom/fasterxml/jackson/databind/json/JsonMapper;->builder()Lcom/fasterxml/jackson/databind/json/JsonMapper$Builder;

    move-result-object v0

    sget-object v1, Lcom/fasterxml/jackson/databind/DeserializationFeature;->FAIL_ON_UNKNOWN_PROPERTIES:Lcom/fasterxml/jackson/databind/DeserializationFeature;

    .line 55
    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Lcom/fasterxml/jackson/databind/json/JsonMapper$Builder;->configure(Lcom/fasterxml/jackson/databind/DeserializationFeature;Z)Lcom/fasterxml/jackson/databind/cfg/MapperBuilder;

    move-result-object v0

    check-cast v0, Lcom/fasterxml/jackson/databind/json/JsonMapper$Builder;

    sget-object v1, Lcom/fasterxml/jackson/databind/MapperFeature;->ACCEPT_CASE_INSENSITIVE_PROPERTIES:Lcom/fasterxml/jackson/databind/MapperFeature;

    .line 56
    const/4 v2, 0x1

    invoke-virtual {v0, v1, v2}, Lcom/fasterxml/jackson/databind/json/JsonMapper$Builder;->configure(Lcom/fasterxml/jackson/databind/MapperFeature;Z)Lcom/fasterxml/jackson/databind/cfg/MapperBuilder;

    move-result-object v0

    check-cast v0, Lcom/fasterxml/jackson/databind/json/JsonMapper$Builder;

    .line 57
    invoke-virtual {v0}, Lcom/fasterxml/jackson/databind/json/JsonMapper$Builder;->build()Lcom/fasterxml/jackson/databind/ObjectMapper;

    move-result-object v0

    iput-object v0, p0, Lio/minio/credentials/MinioClientConfigProvider;->mapper:Lcom/fasterxml/jackson/databind/ObjectMapper;

    .line 58
    return-void
.end method


# virtual methods
.method public fetch()Lio/minio/credentials/Credentials;
    .locals 11

    .line 67
    iget-object v0, p0, Lio/minio/credentials/MinioClientConfigProvider;->filename:Ljava/lang/String;

    .line 68
    .local v0, "filename":Ljava/lang/String;
    if-nez v0, :cond_0

    .line 69
    const-string v1, "MINIO_SHARED_CREDENTIALS_FILE"

    invoke-virtual {p0, v1}, Lio/minio/credentials/MinioClientConfigProvider;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 71
    :cond_0
    if-nez v0, :cond_2

    .line 72
    const-string v1, ".mc"

    .line 73
    .local v1, "mcDir":Ljava/lang/String;
    const-string v2, "os.name"

    invoke-static {v2}, Ljava/lang/System;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    sget-object v3, Ljava/util/Locale;->US:Ljava/util/Locale;

    invoke-virtual {v2, v3}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v2

    const-string/jumbo v3, "windows"

    invoke-virtual {v2, v3}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v2

    if-eqz v2, :cond_1

    .line 74
    const-string v1, "mc"

    .line 77
    :cond_1
    const-string/jumbo v2, "user.home"

    invoke-static {v2}, Ljava/lang/System;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    const/4 v3, 0x2

    new-array v3, v3, [Ljava/lang/String;

    const/4 v4, 0x0

    aput-object v1, v3, v4

    const/4 v4, 0x1

    const-string v5, "config.json"

    aput-object v5, v3, v4

    invoke-static {v2, v3}, Ljava/nio/file/Paths;->get(Ljava/lang/String;[Ljava/lang/String;)Ljava/nio/file/Path;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0

    .line 80
    .end local v1    # "mcDir":Ljava/lang/String;
    :cond_2
    iget-object v1, p0, Lio/minio/credentials/MinioClientConfigProvider;->alias:Ljava/lang/String;

    .line 81
    .local v1, "alias":Ljava/lang/String;
    if-nez v1, :cond_3

    .line 82
    const-string v2, "MINIO_ALIAS"

    invoke-virtual {p0, v2}, Lio/minio/credentials/MinioClientConfigProvider;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 84
    :cond_3
    if-nez v1, :cond_4

    .line 85
    const-string/jumbo v1, "s3"

    .line 88
    :cond_4
    :try_start_0
    new-instance v2, Ljava/io/FileInputStream;

    invoke-direct {v2, v0}, Ljava/io/FileInputStream;-><init>(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 89
    .local v2, "is":Ljava/io/InputStream;
    :try_start_1
    iget-object v3, p0, Lio/minio/credentials/MinioClientConfigProvider;->mapper:Lcom/fasterxml/jackson/databind/ObjectMapper;

    new-instance v4, Ljava/io/InputStreamReader;

    sget-object v5, Ljava/nio/charset/StandardCharsets;->UTF_8:Ljava/nio/charset/Charset;

    invoke-direct {v4, v2, v5}, Ljava/io/InputStreamReader;-><init>(Ljava/io/InputStream;Ljava/nio/charset/Charset;)V

    const-class v5, Lio/minio/credentials/MinioClientConfigProvider$McConfig;

    .line 90
    invoke-virtual {v3, v4, v5}, Lcom/fasterxml/jackson/databind/ObjectMapper;->readValue(Ljava/io/Reader;Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lio/minio/credentials/MinioClientConfigProvider$McConfig;

    .line 91
    .local v3, "config":Lio/minio/credentials/MinioClientConfigProvider$McConfig;
    invoke-virtual {v3, v1}, Lio/minio/credentials/MinioClientConfigProvider$McConfig;->get(Ljava/lang/String;)Ljava/util/Map;

    move-result-object v4

    .line 92
    .local v4, "values":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    if-eqz v4, :cond_7

    .line 97
    const-string v5, "accessKey"

    invoke-interface {v4, v5}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/lang/String;

    .line 98
    .local v5, "accessKey":Ljava/lang/String;
    const-string/jumbo v6, "secretKey"

    invoke-interface {v4, v6}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Ljava/lang/String;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 100
    .local v6, "secretKey":Ljava/lang/String;
    const-string v7, " in MinioClient configuration file"

    if-eqz v5, :cond_6

    .line 105
    if-eqz v6, :cond_5

    .line 110
    :try_start_2
    new-instance v7, Lio/minio/credentials/Credentials;

    const/4 v8, 0x0

    invoke-direct {v7, v5, v6, v8, v8}, Lio/minio/credentials/Credentials;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lio/minio/messages/ResponseDate;)V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 111
    :try_start_3
    invoke-virtual {v2}, Ljava/io/InputStream;->close()V
    :try_end_3
    .catch Ljava/io/IOException; {:try_start_3 .. :try_end_3} :catch_0

    .line 110
    return-object v7

    .line 106
    :cond_5
    :try_start_4
    new-instance v8, Ljava/security/ProviderException;

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, "Secret key does not exist in alias "

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-direct {v8, v7}, Ljava/security/ProviderException;-><init>(Ljava/lang/String;)V

    .end local v0    # "filename":Ljava/lang/String;
    .end local v1    # "alias":Ljava/lang/String;
    .end local v2    # "is":Ljava/io/InputStream;
    throw v8

    .line 101
    .restart local v0    # "filename":Ljava/lang/String;
    .restart local v1    # "alias":Ljava/lang/String;
    .restart local v2    # "is":Ljava/io/InputStream;
    :cond_6
    new-instance v8, Ljava/security/ProviderException;

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, "Access key does not exist in alias "

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-direct {v8, v7}, Ljava/security/ProviderException;-><init>(Ljava/lang/String;)V

    .end local v0    # "filename":Ljava/lang/String;
    .end local v1    # "alias":Ljava/lang/String;
    .end local v2    # "is":Ljava/io/InputStream;
    throw v8

    .line 93
    .end local v5    # "accessKey":Ljava/lang/String;
    .end local v6    # "secretKey":Ljava/lang/String;
    .restart local v0    # "filename":Ljava/lang/String;
    .restart local v1    # "alias":Ljava/lang/String;
    .restart local v2    # "is":Ljava/io/InputStream;
    :cond_7
    new-instance v5, Ljava/security/ProviderException;

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "Alias "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, " does not exist in MinioClient configuration file"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-direct {v5, v6}, Ljava/security/ProviderException;-><init>(Ljava/lang/String;)V

    .end local v0    # "filename":Ljava/lang/String;
    .end local v1    # "alias":Ljava/lang/String;
    .end local v2    # "is":Ljava/io/InputStream;
    throw v5
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    .line 88
    .end local v3    # "config":Lio/minio/credentials/MinioClientConfigProvider$McConfig;
    .end local v4    # "values":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .restart local v0    # "filename":Ljava/lang/String;
    .restart local v1    # "alias":Ljava/lang/String;
    .restart local v2    # "is":Ljava/io/InputStream;
    :catchall_0
    move-exception v3

    :try_start_5
    invoke-virtual {v2}, Ljava/io/InputStream;->close()V
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_1

    goto :goto_0

    :catchall_1
    move-exception v4

    :try_start_6
    invoke-virtual {v3, v4}, Ljava/lang/Throwable;->addSuppressed(Ljava/lang/Throwable;)V

    .end local v0    # "filename":Ljava/lang/String;
    .end local v1    # "alias":Ljava/lang/String;
    :goto_0
    throw v3
    :try_end_6
    .catch Ljava/io/IOException; {:try_start_6 .. :try_end_6} :catch_0

    .line 111
    .end local v2    # "is":Ljava/io/InputStream;
    .restart local v0    # "filename":Ljava/lang/String;
    .restart local v1    # "alias":Ljava/lang/String;
    :catch_0
    move-exception v2

    .line 112
    .local v2, "e":Ljava/io/IOException;
    new-instance v3, Ljava/security/ProviderException;

    const-string v4, "Unable to read MinioClient configuration file"

    invoke-direct {v3, v4, v2}, Ljava/security/ProviderException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    throw v3
.end method
