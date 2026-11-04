.class public Lio/minio/messages/ErrorResponse;
.super Ljava/lang/Object;
.source "ErrorResponse.java"

# interfaces
.implements Ljava/io/Serializable;


# annotations
.annotation runtime Lorg/simpleframework/xml/Namespace;
    reference = "http://s3.amazonaws.com/doc/2006-03-01/"
.end annotation

.annotation runtime Lorg/simpleframework/xml/Root;
    name = "ErrorResponse"
    strict = false
.end annotation


# static fields
.field private static final serialVersionUID:J = 0x1a707ec87e00a98fL


# instance fields
.field protected bucketName:Ljava/lang/String;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "BucketName"
        required = false
    .end annotation
.end field

.field protected code:Ljava/lang/String;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "Code"
    .end annotation
.end field

.field protected hostId:Ljava/lang/String;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "HostId"
        required = false
    .end annotation
.end field

.field protected message:Ljava/lang/String;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "Message"
        required = false
    .end annotation
.end field

.field protected objectName:Ljava/lang/String;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "Key"
        required = false
    .end annotation
.end field

.field protected requestId:Ljava/lang/String;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "RequestId"
        required = false
    .end annotation
.end field

.field protected resource:Ljava/lang/String;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "Resource"
        required = false
    .end annotation
.end field


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 52
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public constructor <init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 0
    .param p1, "code"    # Ljava/lang/String;
    .param p2, "message"    # Ljava/lang/String;
    .param p3, "bucketName"    # Ljava/lang/String;
    .param p4, "objectName"    # Ljava/lang/String;
    .param p5, "resource"    # Ljava/lang/String;
    .param p6, "requestId"    # Ljava/lang/String;
    .param p7, "hostId"    # Ljava/lang/String;

    .line 65
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 66
    iput-object p1, p0, Lio/minio/messages/ErrorResponse;->code:Ljava/lang/String;

    .line 67
    iput-object p2, p0, Lio/minio/messages/ErrorResponse;->message:Ljava/lang/String;

    .line 68
    iput-object p3, p0, Lio/minio/messages/ErrorResponse;->bucketName:Ljava/lang/String;

    .line 69
    iput-object p4, p0, Lio/minio/messages/ErrorResponse;->objectName:Ljava/lang/String;

    .line 70
    iput-object p5, p0, Lio/minio/messages/ErrorResponse;->resource:Ljava/lang/String;

    .line 71
    iput-object p6, p0, Lio/minio/messages/ErrorResponse;->requestId:Ljava/lang/String;

    .line 72
    iput-object p7, p0, Lio/minio/messages/ErrorResponse;->hostId:Ljava/lang/String;

    .line 73
    return-void
.end method


# virtual methods
.method public bucketName()Ljava/lang/String;
    .locals 1

    .line 87
    iget-object v0, p0, Lio/minio/messages/ErrorResponse;->bucketName:Ljava/lang/String;

    return-object v0
.end method

.method public code()Ljava/lang/String;
    .locals 1

    .line 77
    iget-object v0, p0, Lio/minio/messages/ErrorResponse;->code:Ljava/lang/String;

    return-object v0
.end method

.method public hostId()Ljava/lang/String;
    .locals 1

    .line 97
    iget-object v0, p0, Lio/minio/messages/ErrorResponse;->hostId:Ljava/lang/String;

    return-object v0
.end method

.method public message()Ljava/lang/String;
    .locals 1

    .line 82
    iget-object v0, p0, Lio/minio/messages/ErrorResponse;->message:Ljava/lang/String;

    return-object v0
.end method

.method public objectName()Ljava/lang/String;
    .locals 1

    .line 92
    iget-object v0, p0, Lio/minio/messages/ErrorResponse;->objectName:Ljava/lang/String;

    return-object v0
.end method

.method public requestId()Ljava/lang/String;
    .locals 1

    .line 102
    iget-object v0, p0, Lio/minio/messages/ErrorResponse;->requestId:Ljava/lang/String;

    return-object v0
.end method

.method public resource()Ljava/lang/String;
    .locals 1

    .line 107
    iget-object v0, p0, Lio/minio/messages/ErrorResponse;->resource:Ljava/lang/String;

    return-object v0
.end method

.method public toString()Ljava/lang/String;
    .locals 2

    .line 112
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "ErrorResponse(code = "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lio/minio/messages/ErrorResponse;->code:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", message = "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lio/minio/messages/ErrorResponse;->message:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", bucketName = "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lio/minio/messages/ErrorResponse;->bucketName:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", objectName = "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lio/minio/messages/ErrorResponse;->objectName:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", resource = "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lio/minio/messages/ErrorResponse;->resource:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", requestId = "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lio/minio/messages/ErrorResponse;->requestId:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", hostId = "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lio/minio/messages/ErrorResponse;->hostId:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ")"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
