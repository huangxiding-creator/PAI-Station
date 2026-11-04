.class public Lio/minio/messages/AbortIncompleteMultipartUpload;
.super Ljava/lang/Object;
.source "AbortIncompleteMultipartUpload.java"


# annotations
.annotation runtime Lorg/simpleframework/xml/Root;
    name = "AbortIncompleteMultipartUpload"
.end annotation


# instance fields
.field private daysAfterInitiation:I
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "DaysAfterInitiation"
    .end annotation
.end field


# direct methods
.method public constructor <init>(I)V
    .locals 0
    .param p1, "daysAfterInitiation"    # I
        .annotation runtime Lorg/simpleframework/xml/Element;
            name = "DaysAfterInitiation"
        .end annotation
    .end param

    .line 31
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 32
    iput p1, p0, Lio/minio/messages/AbortIncompleteMultipartUpload;->daysAfterInitiation:I

    .line 33
    return-void
.end method


# virtual methods
.method public daysAfterInitiation()I
    .locals 1

    .line 36
    iget v0, p0, Lio/minio/messages/AbortIncompleteMultipartUpload;->daysAfterInitiation:I

    return v0
.end method
