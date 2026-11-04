.class public Lio/minio/credentials/ClientGrantsProvider$ClientGrantsResponse;
.super Ljava/lang/Object;
.source "ClientGrantsProvider.java"

# interfaces
.implements Lio/minio/credentials/AssumeRoleBaseProvider$Response;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lio/minio/credentials/ClientGrantsProvider;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "ClientGrantsResponse"
.end annotation

.annotation runtime Lorg/simpleframework/xml/Namespace;
    reference = "https://sts.amazonaws.com/doc/2011-06-15/"
.end annotation

.annotation runtime Lorg/simpleframework/xml/Root;
    name = "AssumeRoleWithClientGrantsResponse"
    strict = false
.end annotation


# instance fields
.field private credentials:Lio/minio/credentials/Credentials;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "Credentials"
    .end annotation

    .annotation runtime Lorg/simpleframework/xml/Path;
        value = "AssumeRoleWithClientGrantsResult"
    .end annotation
.end field


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 68
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public getCredentials()Lio/minio/credentials/Credentials;
    .locals 1

    .line 74
    iget-object v0, p0, Lio/minio/credentials/ClientGrantsProvider$ClientGrantsResponse;->credentials:Lio/minio/credentials/Credentials;

    return-object v0
.end method
