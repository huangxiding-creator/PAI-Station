.class public Lio/minio/credentials/MinioEnvironmentProvider;
.super Lio/minio/credentials/EnvironmentProvider;
.source "MinioEnvironmentProvider.java"


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 20
    invoke-direct {p0}, Lio/minio/credentials/EnvironmentProvider;-><init>()V

    return-void
.end method


# virtual methods
.method public fetch()Lio/minio/credentials/Credentials;
    .locals 4

    .line 23
    new-instance v0, Lio/minio/credentials/Credentials;

    .line 24
    const-string v1, "MINIO_ACCESS_KEY"

    invoke-virtual {p0, v1}, Lio/minio/credentials/MinioEnvironmentProvider;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    const-string v2, "MINIO_SECRET_KEY"

    invoke-virtual {p0, v2}, Lio/minio/credentials/MinioEnvironmentProvider;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    const/4 v3, 0x0

    invoke-direct {v0, v1, v2, v3, v3}, Lio/minio/credentials/Credentials;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lio/minio/messages/ResponseDate;)V

    .line 23
    return-object v0
.end method
