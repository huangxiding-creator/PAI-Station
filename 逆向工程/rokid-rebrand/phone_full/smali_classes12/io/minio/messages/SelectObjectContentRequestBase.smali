.class public abstract Lio/minio/messages/SelectObjectContentRequestBase;
.super Ljava/lang/Object;
.source "SelectObjectContentRequestBase.java"


# instance fields
.field private expression:Ljava/lang/String;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "Expression"
    .end annotation
.end field

.field private expressionType:Ljava/lang/String;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "ExpressionType"
    .end annotation
.end field

.field private inputSerialization:Lio/minio/messages/InputSerialization;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "InputSerialization"
    .end annotation
.end field

.field private outputSerialization:Lio/minio/messages/OutputSerialization;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "OutputSerialization"
    .end annotation
.end field


# direct methods
.method public constructor <init>(Ljava/lang/String;Lio/minio/messages/InputSerialization;Lio/minio/messages/OutputSerialization;)V
    .locals 1
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

    .line 39
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 29
    const-string v0, "SQL"

    iput-object v0, p0, Lio/minio/messages/SelectObjectContentRequestBase;->expressionType:Ljava/lang/String;

    .line 40
    const-string v0, "Expression must not be null"

    invoke-static {p1, v0}, Ljava/util/Objects;->requireNonNull(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    iput-object v0, p0, Lio/minio/messages/SelectObjectContentRequestBase;->expression:Ljava/lang/String;

    .line 41
    const-string v0, "InputSerialization must not be null"

    invoke-static {p2, v0}, Ljava/util/Objects;->requireNonNull(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lio/minio/messages/InputSerialization;

    iput-object v0, p0, Lio/minio/messages/SelectObjectContentRequestBase;->inputSerialization:Lio/minio/messages/InputSerialization;

    .line 42
    const-string v0, "OutputSerialization must not be null"

    invoke-static {p3, v0}, Ljava/util/Objects;->requireNonNull(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lio/minio/messages/OutputSerialization;

    iput-object v0, p0, Lio/minio/messages/SelectObjectContentRequestBase;->outputSerialization:Lio/minio/messages/OutputSerialization;

    .line 43
    return-void
.end method
