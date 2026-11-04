.class public Lio/minio/messages/NoncurrentVersionExpiration;
.super Ljava/lang/Object;
.source "NoncurrentVersionExpiration.java"


# annotations
.annotation runtime Lorg/simpleframework/xml/Root;
    name = "NoncurrentVersionExpiration"
.end annotation


# instance fields
.field private noncurrentDays:I
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "NoncurrentDays"
    .end annotation
.end field


# direct methods
.method public constructor <init>(I)V
    .locals 0
    .param p1, "noncurrentDays"    # I
        .annotation runtime Lorg/simpleframework/xml/Element;
            name = "NoncurrentDays"
            required = false
        .end annotation
    .end param

    .line 29
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 30
    iput p1, p0, Lio/minio/messages/NoncurrentVersionExpiration;->noncurrentDays:I

    .line 31
    return-void
.end method


# virtual methods
.method public noncurrentDays()I
    .locals 1

    .line 34
    iget v0, p0, Lio/minio/messages/NoncurrentVersionExpiration;->noncurrentDays:I

    return v0
.end method
