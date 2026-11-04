.class public Lio/minio/credentials/AwsConfigProvider;
.super Lio/minio/credentials/EnvironmentProvider;
.source "AwsConfigProvider.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lio/minio/credentials/AwsConfigProvider$Ini;
    }
.end annotation


# instance fields
.field private final filename:Ljava/lang/String;

.field private final profile:Ljava/lang/String;


# direct methods
.method public constructor <init>(Ljava/lang/String;Ljava/lang/String;)V
    .locals 2
    .param p1, "filename"    # Ljava/lang/String;
        .annotation runtime Ljavax/annotation/Nullable;
        .end annotation
    .end param
    .param p2, "profile"    # Ljava/lang/String;
        .annotation runtime Ljavax/annotation/Nullable;
        .end annotation
    .end param

    .line 38
    invoke-direct {p0}, Lio/minio/credentials/EnvironmentProvider;-><init>()V

    .line 39
    if-eqz p1, :cond_1

    invoke-virtual {p1}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_0

    goto :goto_0

    .line 40
    :cond_0
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "Filename must not be empty"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 43
    :cond_1
    :goto_0
    if-eqz p2, :cond_3

    invoke-virtual {p2}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_2

    goto :goto_1

    .line 44
    :cond_2
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "Profile must not be empty"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 47
    :cond_3
    :goto_1
    iput-object p1, p0, Lio/minio/credentials/AwsConfigProvider;->filename:Ljava/lang/String;

    .line 48
    iput-object p2, p0, Lio/minio/credentials/AwsConfigProvider;->profile:Ljava/lang/String;

    .line 49
    return-void
.end method

.method private unmarshal(Ljava/io/Reader;)Ljava/util/Map;
    .locals 2
    .param p1, "reader"    # Ljava/io/Reader;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/io/Reader;",
            ")",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/util/Properties;",
            ">;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 103
    new-instance v0, Lio/minio/credentials/AwsConfigProvider$Ini;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Lio/minio/credentials/AwsConfigProvider$Ini;-><init>(Lio/minio/credentials/AwsConfigProvider$1;)V

    invoke-virtual {v0, p1}, Lio/minio/credentials/AwsConfigProvider$Ini;->unmarshal(Ljava/io/Reader;)Ljava/util/Map;

    move-result-object v0

    return-object v0
.end method


# virtual methods
.method public fetch()Lio/minio/credentials/Credentials;
    .locals 12

    .line 58
    iget-object v0, p0, Lio/minio/credentials/AwsConfigProvider;->filename:Ljava/lang/String;

    .line 59
    .local v0, "filename":Ljava/lang/String;
    if-nez v0, :cond_0

    .line 60
    const-string v1, "AWS_SHARED_CREDENTIALS_FILE"

    invoke-virtual {p0, v1}, Lio/minio/credentials/AwsConfigProvider;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 62
    :cond_0
    if-nez v0, :cond_1

    .line 63
    const-string/jumbo v1, "user.home"

    invoke-static {v1}, Ljava/lang/System;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x2

    new-array v2, v2, [Ljava/lang/String;

    const/4 v3, 0x0

    const-string v4, ".aws"

    aput-object v4, v2, v3

    const/4 v3, 0x1

    const-string v4, "credentials"

    aput-object v4, v2, v3

    invoke-static {v1, v2}, Ljava/nio/file/Paths;->get(Ljava/lang/String;[Ljava/lang/String;)Ljava/nio/file/Path;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0

    .line 66
    :cond_1
    iget-object v1, p0, Lio/minio/credentials/AwsConfigProvider;->profile:Ljava/lang/String;

    .line 67
    .local v1, "profile":Ljava/lang/String;
    if-nez v1, :cond_2

    .line 68
    const-string v2, "AWS_PROFILE"

    invoke-virtual {p0, v2}, Lio/minio/credentials/AwsConfigProvider;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 70
    :cond_2
    if-nez v1, :cond_3

    .line 71
    const-string v1, "default"

    .line 74
    :cond_3
    :try_start_0
    new-instance v2, Ljava/io/FileInputStream;

    invoke-direct {v2, v0}, Ljava/io/FileInputStream;-><init>(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 75
    .local v2, "is":Ljava/io/InputStream;
    :try_start_1
    new-instance v3, Ljava/io/InputStreamReader;

    sget-object v4, Ljava/nio/charset/StandardCharsets;->UTF_8:Ljava/nio/charset/Charset;

    invoke-direct {v3, v2, v4}, Ljava/io/InputStreamReader;-><init>(Ljava/io/InputStream;Ljava/nio/charset/Charset;)V

    invoke-direct {p0, v3}, Lio/minio/credentials/AwsConfigProvider;->unmarshal(Ljava/io/Reader;)Ljava/util/Map;

    move-result-object v3

    .line 76
    .local v3, "result":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/util/Properties;>;"
    invoke-interface {v3, v1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/util/Properties;

    .line 77
    .local v4, "values":Ljava/util/Properties;
    if-eqz v4, :cond_6

    .line 82
    const-string v5, "aws_access_key_id"

    invoke-virtual {v4, v5}, Ljava/util/Properties;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    .line 83
    .local v5, "accessKey":Ljava/lang/String;
    const-string v6, "aws_secret_access_key"

    invoke-virtual {v4, v6}, Ljava/util/Properties;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    .line 84
    .local v6, "secretKey":Ljava/lang/String;
    const-string v7, "aws_session_token"

    invoke-virtual {v4, v7}, Ljava/util/Properties;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 86
    .local v7, "sessionToken":Ljava/lang/String;
    const-string v8, " in AWS credential file"

    if-eqz v5, :cond_5

    .line 91
    if-eqz v6, :cond_4

    .line 96
    :try_start_2
    new-instance v8, Lio/minio/credentials/Credentials;

    const/4 v9, 0x0

    invoke-direct {v8, v5, v6, v7, v9}, Lio/minio/credentials/Credentials;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lio/minio/messages/ResponseDate;)V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 97
    :try_start_3
    invoke-virtual {v2}, Ljava/io/InputStream;->close()V
    :try_end_3
    .catch Ljava/io/IOException; {:try_start_3 .. :try_end_3} :catch_0

    .line 96
    return-object v8

    .line 92
    :cond_4
    :try_start_4
    new-instance v9, Ljava/security/ProviderException;

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "Secret key does not exist in profile "

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-direct {v9, v8}, Ljava/security/ProviderException;-><init>(Ljava/lang/String;)V

    .end local v0    # "filename":Ljava/lang/String;
    .end local v1    # "profile":Ljava/lang/String;
    .end local v2    # "is":Ljava/io/InputStream;
    throw v9

    .line 87
    .restart local v0    # "filename":Ljava/lang/String;
    .restart local v1    # "profile":Ljava/lang/String;
    .restart local v2    # "is":Ljava/io/InputStream;
    :cond_5
    new-instance v9, Ljava/security/ProviderException;

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "Access key does not exist in profile "

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-direct {v9, v8}, Ljava/security/ProviderException;-><init>(Ljava/lang/String;)V

    .end local v0    # "filename":Ljava/lang/String;
    .end local v1    # "profile":Ljava/lang/String;
    .end local v2    # "is":Ljava/io/InputStream;
    throw v9

    .line 78
    .end local v5    # "accessKey":Ljava/lang/String;
    .end local v6    # "secretKey":Ljava/lang/String;
    .end local v7    # "sessionToken":Ljava/lang/String;
    .restart local v0    # "filename":Ljava/lang/String;
    .restart local v1    # "profile":Ljava/lang/String;
    .restart local v2    # "is":Ljava/io/InputStream;
    :cond_6
    new-instance v5, Ljava/security/ProviderException;

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "Profile "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, " does not exist in AWS credential file"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-direct {v5, v6}, Ljava/security/ProviderException;-><init>(Ljava/lang/String;)V

    .end local v0    # "filename":Ljava/lang/String;
    .end local v1    # "profile":Ljava/lang/String;
    .end local v2    # "is":Ljava/io/InputStream;
    throw v5
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    .line 74
    .end local v3    # "result":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/util/Properties;>;"
    .end local v4    # "values":Ljava/util/Properties;
    .restart local v0    # "filename":Ljava/lang/String;
    .restart local v1    # "profile":Ljava/lang/String;
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
    .end local v1    # "profile":Ljava/lang/String;
    :goto_0
    throw v3
    :try_end_6
    .catch Ljava/io/IOException; {:try_start_6 .. :try_end_6} :catch_0

    .line 97
    .end local v2    # "is":Ljava/io/InputStream;
    .restart local v0    # "filename":Ljava/lang/String;
    .restart local v1    # "profile":Ljava/lang/String;
    :catch_0
    move-exception v2

    .line 98
    .local v2, "e":Ljava/io/IOException;
    new-instance v3, Ljava/security/ProviderException;

    const-string v4, "Unable to read AWS credential file"

    invoke-direct {v3, v4, v2}, Ljava/security/ProviderException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    throw v3
.end method
