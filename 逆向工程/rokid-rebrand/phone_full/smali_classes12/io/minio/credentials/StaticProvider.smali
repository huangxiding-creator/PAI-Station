.class public Lio/minio/credentials/StaticProvider;
.super Ljava/lang/Object;
.source "StaticProvider.java"

# interfaces
.implements Lio/minio/credentials/Provider;


# instance fields
.field private final credentials:Lio/minio/credentials/Credentials;


# direct methods
.method public constructor <init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 2
    .param p1, "accessKey"    # Ljava/lang/String;
        .annotation runtime Ljavax/annotation/Nonnull;
        .end annotation
    .end param
    .param p2, "secretKey"    # Ljava/lang/String;
        .annotation runtime Ljavax/annotation/Nonnull;
        .end annotation
    .end param
    .param p3, "sessionToken"    # Ljava/lang/String;
        .annotation runtime Ljavax/annotation/Nullable;
        .end annotation
    .end param

    .line 27
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 28
    new-instance v0, Lio/minio/credentials/Credentials;

    const/4 v1, 0x0

    invoke-direct {v0, p1, p2, p3, v1}, Lio/minio/credentials/Credentials;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lio/minio/messages/ResponseDate;)V

    iput-object v0, p0, Lio/minio/credentials/StaticProvider;->credentials:Lio/minio/credentials/Credentials;

    .line 29
    return-void
.end method


# virtual methods
.method public fetch()Lio/minio/credentials/Credentials;
    .locals 1

    .line 33
    iget-object v0, p0, Lio/minio/credentials/StaticProvider;->credentials:Lio/minio/credentials/Credentials;

    return-object v0
.end method
