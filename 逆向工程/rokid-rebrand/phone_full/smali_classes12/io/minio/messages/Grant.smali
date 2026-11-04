.class public Lio/minio/messages/Grant;
.super Ljava/lang/Object;
.source "Grant.java"


# annotations
.annotation runtime Lorg/simpleframework/xml/Root;
    name = "Grant"
.end annotation


# instance fields
.field private grantee:Lio/minio/messages/Grantee;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "Grantee"
        required = false
    .end annotation
.end field

.field private permission:Lio/minio/messages/Permission;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "Permission"
        required = false
    .end annotation
.end field


# direct methods
.method public constructor <init>(Lio/minio/messages/Grantee;Lio/minio/messages/Permission;)V
    .locals 2
    .param p1, "grantee"    # Lio/minio/messages/Grantee;
        .annotation runtime Ljavax/annotation/Nullable;
        .end annotation
    .end param
    .param p2, "permission"    # Lio/minio/messages/Permission;
        .annotation runtime Ljavax/annotation/Nullable;
        .end annotation
    .end param

    .line 34
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 35
    if-nez p1, :cond_1

    if-eqz p2, :cond_0

    goto :goto_0

    .line 36
    :cond_0
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "Either Grantee or Permission must be provided"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 38
    :cond_1
    :goto_0
    iput-object p1, p0, Lio/minio/messages/Grant;->grantee:Lio/minio/messages/Grantee;

    .line 39
    iput-object p2, p0, Lio/minio/messages/Grant;->permission:Lio/minio/messages/Permission;

    .line 40
    return-void
.end method
