.class public Lio/minio/credentials/LdapIdentityProvider$LdapIdentityResponse;
.super Ljava/lang/Object;
.source "LdapIdentityProvider.java"

# interfaces
.implements Lio/minio/credentials/AssumeRoleBaseProvider$Response;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lio/minio/credentials/LdapIdentityProvider;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "LdapIdentityResponse"
.end annotation

.annotation runtime Lorg/simpleframework/xml/Namespace;
    reference = "https://sts.amazonaws.com/doc/2011-06-15/"
.end annotation

.annotation runtime Lorg/simpleframework/xml/Root;
    name = "AssumeRoleWithLDAPIdentityResponse"
    strict = false
.end annotation


# instance fields
.field private credentials:Lio/minio/credentials/Credentials;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "Credentials"
    .end annotation

    .annotation runtime Lorg/simpleframework/xml/Path;
        value = "AssumeRoleWithLDAPIdentityResult"
    .end annotation
.end field


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 98
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public getCredentials()Lio/minio/credentials/Credentials;
    .locals 1

    .line 104
    iget-object v0, p0, Lio/minio/credentials/LdapIdentityProvider$LdapIdentityResponse;->credentials:Lio/minio/credentials/Credentials;

    return-object v0
.end method
