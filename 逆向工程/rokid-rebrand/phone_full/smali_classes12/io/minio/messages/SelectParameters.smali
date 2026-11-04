.class public Lio/minio/messages/SelectParameters;
.super Lio/minio/messages/SelectObjectContentRequestBase;
.source "SelectParameters.java"


# annotations
.annotation runtime Lorg/simpleframework/xml/Root;
    name = "SelectParameters"
.end annotation


# direct methods
.method public constructor <init>(Ljava/lang/String;Lio/minio/messages/InputSerialization;Lio/minio/messages/OutputSerialization;)V
    .locals 0
    .param p1, "expression"    # Ljava/lang/String;
        .annotation runtime Ljavax/annotation/Nonnull;
        .end annotation
    .end param
    .param p2, "is"    # Lio/minio/messages/InputSerialization;
        .annotation runtime Ljavax/annotation/Nonnull;
        .end annotation
    .end param
    .param p3, "os"    # Lio/minio/messages/OutputSerialization;
        .annotation runtime Ljavax/annotation/Nonnull;
        .end annotation
    .end param

    .line 31
    invoke-direct {p0, p1, p2, p3}, Lio/minio/messages/SelectObjectContentRequestBase;-><init>(Ljava/lang/String;Lio/minio/messages/InputSerialization;Lio/minio/messages/OutputSerialization;)V

    .line 32
    return-void
.end method
