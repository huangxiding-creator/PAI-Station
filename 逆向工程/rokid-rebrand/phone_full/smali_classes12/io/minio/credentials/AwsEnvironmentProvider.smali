.class public Lio/minio/credentials/AwsEnvironmentProvider;
.super Lio/minio/credentials/EnvironmentProvider;
.source "AwsEnvironmentProvider.java"


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 21
    invoke-direct {p0}, Lio/minio/credentials/EnvironmentProvider;-><init>()V

    return-void
.end method

.method private final getAccessKey()Ljava/lang/String;
    .locals 2

    .line 24
    const-string v0, "AWS_ACCESS_KEY_ID"

    invoke-virtual {p0, v0}, Lio/minio/credentials/AwsEnvironmentProvider;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 25
    .local v0, "value":Ljava/lang/String;
    if-eqz v0, :cond_0

    move-object v1, v0

    goto :goto_0

    :cond_0
    const-string v1, "AWS_ACCESS_KEY"

    invoke-virtual {p0, v1}, Lio/minio/credentials/AwsEnvironmentProvider;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    :goto_0
    return-object v1
.end method

.method private final getSecretKey()Ljava/lang/String;
    .locals 2

    .line 29
    const-string v0, "AWS_SECRET_ACCESS_KEY"

    invoke-virtual {p0, v0}, Lio/minio/credentials/AwsEnvironmentProvider;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 30
    .local v0, "value":Ljava/lang/String;
    if-eqz v0, :cond_0

    move-object v1, v0

    goto :goto_0

    :cond_0
    const-string v1, "AWS_SECRET_KEY"

    invoke-virtual {p0, v1}, Lio/minio/credentials/AwsEnvironmentProvider;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    :goto_0
    return-object v1
.end method


# virtual methods
.method public fetch()Lio/minio/credentials/Credentials;
    .locals 5

    .line 35
    new-instance v0, Lio/minio/credentials/Credentials;

    invoke-direct {p0}, Lio/minio/credentials/AwsEnvironmentProvider;->getAccessKey()Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0}, Lio/minio/credentials/AwsEnvironmentProvider;->getSecretKey()Ljava/lang/String;

    move-result-object v2

    const-string v3, "AWS_SESSION_TOKEN"

    invoke-virtual {p0, v3}, Lio/minio/credentials/AwsEnvironmentProvider;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    const/4 v4, 0x0

    invoke-direct {v0, v1, v2, v3, v4}, Lio/minio/credentials/Credentials;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lio/minio/messages/ResponseDate;)V

    return-object v0
.end method
