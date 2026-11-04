.class public Lio/minio/credentials/WebIdentityProvider$WebIdentityResponse;
.super Ljava/lang/Object;
.source "WebIdentityProvider.java"

# interfaces
.implements Lio/minio/credentials/AssumeRoleBaseProvider$Response;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lio/minio/credentials/WebIdentityProvider;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "WebIdentityResponse"
.end annotation

.annotation runtime Lorg/simpleframework/xml/Namespace;
    reference = "https://sts.amazonaws.com/doc/2011-06-15/"
.end annotation

.annotation runtime Lorg/simpleframework/xml/Root;
    name = "AssumeRoleWithWebIdentityResponse"
    strict = false
.end annotation


# instance fields
.field private credentials:Lio/minio/credentials/Credentials;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "Credentials"
    .end annotation

    .annotation runtime Lorg/simpleframework/xml/Path;
        value = "AssumeRoleWithWebIdentityResult"
    .end annotation
.end field


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 73
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public getCredentials()Lio/minio/credentials/Credentials;
    .locals 1

    .line 79
    iget-object v0, p0, Lio/minio/credentials/WebIdentityProvider$WebIdentityResponse;->credentials:Lio/minio/credentials/Credentials;

    return-object v0
.end method
