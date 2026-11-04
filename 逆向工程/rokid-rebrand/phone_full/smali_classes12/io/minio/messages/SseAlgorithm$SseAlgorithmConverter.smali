.class public Lio/minio/messages/SseAlgorithm$SseAlgorithmConverter;
.super Ljava/lang/Object;
.source "SseAlgorithm.java"

# interfaces
.implements Lorg/simpleframework/xml/convert/Converter;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lio/minio/messages/SseAlgorithm;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "SseAlgorithmConverter"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Object;",
        "Lorg/simpleframework/xml/convert/Converter<",
        "Lio/minio/messages/SseAlgorithm;",
        ">;"
    }
.end annotation


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 57
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public read(Lorg/simpleframework/xml/stream/InputNode;)Lio/minio/messages/SseAlgorithm;
    .locals 1
    .param p1, "node"    # Lorg/simpleframework/xml/stream/InputNode;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 60
    invoke-interface {p1}, Lorg/simpleframework/xml/stream/InputNode;->getValue()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lio/minio/messages/SseAlgorithm;->fromString(Ljava/lang/String;)Lio/minio/messages/SseAlgorithm;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic read(Lorg/simpleframework/xml/stream/InputNode;)Ljava/lang/Object;
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 57
    invoke-virtual {p0, p1}, Lio/minio/messages/SseAlgorithm$SseAlgorithmConverter;->read(Lorg/simpleframework/xml/stream/InputNode;)Lio/minio/messages/SseAlgorithm;

    move-result-object p1

    return-object p1
.end method

.method public write(Lorg/simpleframework/xml/stream/OutputNode;Lio/minio/messages/SseAlgorithm;)V
    .locals 1
    .param p1, "node"    # Lorg/simpleframework/xml/stream/OutputNode;
    .param p2, "sseAlgorithm"    # Lio/minio/messages/SseAlgorithm;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 65
    invoke-virtual {p2}, Lio/minio/messages/SseAlgorithm;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-interface {p1, v0}, Lorg/simpleframework/xml/stream/OutputNode;->setValue(Ljava/lang/String;)V

    .line 66
    return-void
.end method

.method public bridge synthetic write(Lorg/simpleframework/xml/stream/OutputNode;Ljava/lang/Object;)V
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 57
    check-cast p2, Lio/minio/messages/SseAlgorithm;

    invoke-virtual {p0, p1, p2}, Lio/minio/messages/SseAlgorithm$SseAlgorithmConverter;->write(Lorg/simpleframework/xml/stream/OutputNode;Lio/minio/messages/SseAlgorithm;)V

    return-void
.end method
