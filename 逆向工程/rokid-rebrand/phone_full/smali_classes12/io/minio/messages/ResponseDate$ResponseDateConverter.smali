.class public Lio/minio/messages/ResponseDate$ResponseDateConverter;
.super Ljava/lang/Object;
.source "ResponseDate.java"

# interfaces
.implements Lorg/simpleframework/xml/convert/Converter;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lio/minio/messages/ResponseDate;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "ResponseDateConverter"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Object;",
        "Lorg/simpleframework/xml/convert/Converter<",
        "Lio/minio/messages/ResponseDate;",
        ">;"
    }
.end annotation


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 67
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public read(Lorg/simpleframework/xml/stream/InputNode;)Lio/minio/messages/ResponseDate;
    .locals 1
    .param p1, "node"    # Lorg/simpleframework/xml/stream/InputNode;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 70
    invoke-interface {p1}, Lorg/simpleframework/xml/stream/InputNode;->getValue()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lio/minio/messages/ResponseDate;->fromString(Ljava/lang/String;)Lio/minio/messages/ResponseDate;

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

    .line 67
    invoke-virtual {p0, p1}, Lio/minio/messages/ResponseDate$ResponseDateConverter;->read(Lorg/simpleframework/xml/stream/InputNode;)Lio/minio/messages/ResponseDate;

    move-result-object p1

    return-object p1
.end method

.method public write(Lorg/simpleframework/xml/stream/OutputNode;Lio/minio/messages/ResponseDate;)V
    .locals 1
    .param p1, "node"    # Lorg/simpleframework/xml/stream/OutputNode;
    .param p2, "amzDate"    # Lio/minio/messages/ResponseDate;

    .line 75
    invoke-virtual {p2}, Lio/minio/messages/ResponseDate;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-interface {p1, v0}, Lorg/simpleframework/xml/stream/OutputNode;->setValue(Ljava/lang/String;)V

    .line 76
    return-void
.end method

.method public bridge synthetic write(Lorg/simpleframework/xml/stream/OutputNode;Ljava/lang/Object;)V
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 67
    check-cast p2, Lio/minio/messages/ResponseDate;

    invoke-virtual {p0, p1, p2}, Lio/minio/messages/ResponseDate$ResponseDateConverter;->write(Lorg/simpleframework/xml/stream/OutputNode;Lio/minio/messages/ResponseDate;)V

    return-void
.end method
