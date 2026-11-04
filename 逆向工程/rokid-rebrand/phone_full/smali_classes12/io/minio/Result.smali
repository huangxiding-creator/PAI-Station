.class public Lio/minio/Result;
.super Ljava/lang/Object;
.source "Result.java"


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "<T:",
        "Ljava/lang/Object;",
        ">",
        "Ljava/lang/Object;"
    }
.end annotation


# instance fields
.field private final ex:Ljava/lang/Exception;

.field private final type:Ljava/lang/Object;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "TT;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>(Ljava/lang/Exception;)V
    .locals 1
    .param p1, "ex"    # Ljava/lang/Exception;

    .line 43
    .local p0, "this":Lio/minio/Result;, "Lio/minio/Result<TT;>;"
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 44
    const/4 v0, 0x0

    iput-object v0, p0, Lio/minio/Result;->type:Ljava/lang/Object;

    .line 45
    iput-object p1, p0, Lio/minio/Result;->ex:Ljava/lang/Exception;

    .line 46
    return-void
.end method

.method public constructor <init>(Ljava/lang/Object;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TT;)V"
        }
    .end annotation

    .line 38
    .local p0, "this":Lio/minio/Result;, "Lio/minio/Result<TT;>;"
    .local p1, "type":Ljava/lang/Object;, "TT;"
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 39
    iput-object p1, p0, Lio/minio/Result;->type:Ljava/lang/Object;

    .line 40
    const/4 v0, 0x0

    iput-object v0, p0, Lio/minio/Result;->ex:Ljava/lang/Exception;

    .line 41
    return-void
.end method


# virtual methods
.method public get()Ljava/lang/Object;
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()TT;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lio/minio/errors/ErrorResponseException;,
            Ljava/lang/IllegalArgumentException;,
            Lio/minio/errors/InsufficientDataException;,
            Lio/minio/errors/InternalException;,
            Ljava/security/InvalidKeyException;,
            Lio/minio/errors/InvalidResponseException;,
            Ljava/io/IOException;,
            Lcom/fasterxml/jackson/databind/JsonMappingException;,
            Lcom/fasterxml/jackson/core/JsonParseException;,
            Ljava/security/NoSuchAlgorithmException;,
            Lio/minio/errors/ServerException;,
            Lio/minio/errors/XmlParserException;
        }
    .end annotation

    .line 54
    .local p0, "this":Lio/minio/Result;, "Lio/minio/Result<TT;>;"
    iget-object v0, p0, Lio/minio/Result;->ex:Ljava/lang/Exception;

    if-nez v0, :cond_0

    .line 55
    iget-object v0, p0, Lio/minio/Result;->type:Ljava/lang/Object;

    return-object v0

    .line 58
    :cond_0
    iget-object v0, p0, Lio/minio/Result;->ex:Ljava/lang/Exception;

    instance-of v0, v0, Lio/minio/errors/ErrorResponseException;

    if-nez v0, :cond_c

    .line 62
    iget-object v0, p0, Lio/minio/Result;->ex:Ljava/lang/Exception;

    instance-of v0, v0, Ljava/lang/IllegalArgumentException;

    if-nez v0, :cond_b

    .line 66
    iget-object v0, p0, Lio/minio/Result;->ex:Ljava/lang/Exception;

    instance-of v0, v0, Lio/minio/errors/InsufficientDataException;

    if-nez v0, :cond_a

    .line 70
    iget-object v0, p0, Lio/minio/Result;->ex:Ljava/lang/Exception;

    instance-of v0, v0, Lio/minio/errors/InternalException;

    if-nez v0, :cond_9

    .line 74
    iget-object v0, p0, Lio/minio/Result;->ex:Ljava/lang/Exception;

    instance-of v0, v0, Ljava/security/InvalidKeyException;

    if-nez v0, :cond_8

    .line 78
    iget-object v0, p0, Lio/minio/Result;->ex:Ljava/lang/Exception;

    instance-of v0, v0, Lio/minio/errors/InvalidResponseException;

    if-nez v0, :cond_7

    .line 82
    iget-object v0, p0, Lio/minio/Result;->ex:Ljava/lang/Exception;

    instance-of v0, v0, Ljava/io/IOException;

    if-nez v0, :cond_6

    .line 86
    iget-object v0, p0, Lio/minio/Result;->ex:Ljava/lang/Exception;

    instance-of v0, v0, Lcom/fasterxml/jackson/databind/JsonMappingException;

    if-nez v0, :cond_5

    .line 90
    iget-object v0, p0, Lio/minio/Result;->ex:Ljava/lang/Exception;

    instance-of v0, v0, Lcom/fasterxml/jackson/core/JsonParseException;

    if-nez v0, :cond_4

    .line 94
    iget-object v0, p0, Lio/minio/Result;->ex:Ljava/lang/Exception;

    instance-of v0, v0, Ljava/security/NoSuchAlgorithmException;

    if-nez v0, :cond_3

    .line 98
    iget-object v0, p0, Lio/minio/Result;->ex:Ljava/lang/Exception;

    instance-of v0, v0, Lio/minio/errors/ServerException;

    if-nez v0, :cond_2

    .line 102
    iget-object v0, p0, Lio/minio/Result;->ex:Ljava/lang/Exception;

    instance-of v0, v0, Lio/minio/errors/XmlParserException;

    if-eqz v0, :cond_1

    .line 103
    iget-object v0, p0, Lio/minio/Result;->ex:Ljava/lang/Exception;

    check-cast v0, Lio/minio/errors/XmlParserException;

    throw v0

    .line 106
    :cond_1
    new-instance v0, Ljava/lang/RuntimeException;

    const-string v1, "Exception not handled"

    iget-object v2, p0, Lio/minio/Result;->ex:Ljava/lang/Exception;

    invoke-direct {v0, v1, v2}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    throw v0

    .line 99
    :cond_2
    iget-object v0, p0, Lio/minio/Result;->ex:Ljava/lang/Exception;

    check-cast v0, Lio/minio/errors/ServerException;

    throw v0

    .line 95
    :cond_3
    iget-object v0, p0, Lio/minio/Result;->ex:Ljava/lang/Exception;

    check-cast v0, Ljava/security/NoSuchAlgorithmException;

    throw v0

    .line 91
    :cond_4
    iget-object v0, p0, Lio/minio/Result;->ex:Ljava/lang/Exception;

    check-cast v0, Lcom/fasterxml/jackson/core/JsonParseException;

    throw v0

    .line 87
    :cond_5
    iget-object v0, p0, Lio/minio/Result;->ex:Ljava/lang/Exception;

    check-cast v0, Lcom/fasterxml/jackson/databind/JsonMappingException;

    throw v0

    .line 83
    :cond_6
    iget-object v0, p0, Lio/minio/Result;->ex:Ljava/lang/Exception;

    check-cast v0, Ljava/io/IOException;

    throw v0

    .line 79
    :cond_7
    iget-object v0, p0, Lio/minio/Result;->ex:Ljava/lang/Exception;

    check-cast v0, Lio/minio/errors/InvalidResponseException;

    throw v0

    .line 75
    :cond_8
    iget-object v0, p0, Lio/minio/Result;->ex:Ljava/lang/Exception;

    check-cast v0, Ljava/security/InvalidKeyException;

    throw v0

    .line 71
    :cond_9
    iget-object v0, p0, Lio/minio/Result;->ex:Ljava/lang/Exception;

    check-cast v0, Lio/minio/errors/InternalException;

    throw v0

    .line 67
    :cond_a
    iget-object v0, p0, Lio/minio/Result;->ex:Ljava/lang/Exception;

    check-cast v0, Lio/minio/errors/InsufficientDataException;

    throw v0

    .line 63
    :cond_b
    iget-object v0, p0, Lio/minio/Result;->ex:Ljava/lang/Exception;

    check-cast v0, Ljava/lang/IllegalArgumentException;

    throw v0

    .line 59
    :cond_c
    iget-object v0, p0, Lio/minio/Result;->ex:Ljava/lang/Exception;

    check-cast v0, Lio/minio/errors/ErrorResponseException;

    throw v0
.end method
