.class public Lio/minio/messages/SelectObjectContentRequest;
.super Lio/minio/messages/SelectObjectContentRequestBase;
.source "SelectObjectContentRequest.java"


# annotations
.annotation runtime Lorg/simpleframework/xml/Namespace;
    reference = "http://s3.amazonaws.com/doc/2006-03-01/"
.end annotation

.annotation runtime Lorg/simpleframework/xml/Root;
    name = "SelectObjectContentRequest"
.end annotation


# instance fields
.field private requestProgress:Lio/minio/messages/RequestProgress;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "RequestProgress"
        required = false
    .end annotation
.end field

.field private scanRange:Lio/minio/messages/ScanRange;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "ScanRange"
        required = false
    .end annotation
.end field


# direct methods
.method public constructor <init>(Ljava/lang/String;ZLio/minio/messages/InputSerialization;Lio/minio/messages/OutputSerialization;Ljava/lang/Long;Ljava/lang/Long;)V
    .locals 1
    .param p1, "expression"    # Ljava/lang/String;
        .annotation runtime Ljavax/annotation/Nonnull;
        .end annotation
    .end param
    .param p2, "requestProgress"    # Z
    .param p3, "is"    # Lio/minio/messages/InputSerialization;
        .annotation runtime Ljavax/annotation/Nonnull;
        .end annotation
    .end param
    .param p4, "os"    # Lio/minio/messages/OutputSerialization;
        .annotation runtime Ljavax/annotation/Nonnull;
        .end annotation
    .end param
    .param p5, "scanStartRange"    # Ljava/lang/Long;
        .annotation runtime Ljavax/annotation/Nullable;
        .end annotation
    .end param
    .param p6, "scanEndRange"    # Ljava/lang/Long;
        .annotation runtime Ljavax/annotation/Nullable;
        .end annotation
    .end param

    .line 48
    invoke-direct {p0, p1, p3, p4}, Lio/minio/messages/SelectObjectContentRequestBase;-><init>(Ljava/lang/String;Lio/minio/messages/InputSerialization;Lio/minio/messages/OutputSerialization;)V

    .line 49
    if-eqz p2, :cond_0

    .line 50
    new-instance v0, Lio/minio/messages/RequestProgress;

    invoke-direct {v0}, Lio/minio/messages/RequestProgress;-><init>()V

    iput-object v0, p0, Lio/minio/messages/SelectObjectContentRequest;->requestProgress:Lio/minio/messages/RequestProgress;

    .line 52
    :cond_0
    if-nez p5, :cond_1

    if-eqz p6, :cond_2

    .line 53
    :cond_1
    new-instance v0, Lio/minio/messages/ScanRange;

    invoke-direct {v0, p5, p6}, Lio/minio/messages/ScanRange;-><init>(Ljava/lang/Long;Ljava/lang/Long;)V

    iput-object v0, p0, Lio/minio/messages/SelectObjectContentRequest;->scanRange:Lio/minio/messages/ScanRange;

    .line 55
    :cond_2
    return-void
.end method
