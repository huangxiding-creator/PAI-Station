.class public Lio/minio/Xml;
.super Ljava/lang/Object;
.source "Xml.java"


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 32
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static marshal(Ljava/lang/Object;)Ljava/lang/String;
    .locals 4
    .param p0, "source"    # Ljava/lang/Object;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lio/minio/errors/XmlParserException;
        }
    .end annotation

    .line 39
    :try_start_0
    new-instance v0, Lorg/simpleframework/xml/core/Persister;

    new-instance v1, Lorg/simpleframework/xml/convert/AnnotationStrategy;

    invoke-direct {v1}, Lorg/simpleframework/xml/convert/AnnotationStrategy;-><init>()V

    new-instance v2, Lorg/simpleframework/xml/stream/Format;

    const/4 v3, 0x0

    invoke-direct {v2, v3}, Lorg/simpleframework/xml/stream/Format;-><init>(I)V

    invoke-direct {v0, v1, v2}, Lorg/simpleframework/xml/core/Persister;-><init>(Lorg/simpleframework/xml/strategy/Strategy;Lorg/simpleframework/xml/stream/Format;)V

    .line 40
    .local v0, "serializer":Lorg/simpleframework/xml/Serializer;
    new-instance v1, Ljava/io/StringWriter;

    invoke-direct {v1}, Ljava/io/StringWriter;-><init>()V

    .line 41
    .local v1, "writer":Ljava/io/StringWriter;
    invoke-interface {v0, p0, v1}, Lorg/simpleframework/xml/Serializer;->write(Ljava/lang/Object;Ljava/io/Writer;)V

    .line 42
    invoke-virtual {v1}, Ljava/io/StringWriter;->toString()Ljava/lang/String;

    move-result-object v2
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-object v2

    .line 43
    .end local v0    # "serializer":Lorg/simpleframework/xml/Serializer;
    .end local v1    # "writer":Ljava/io/StringWriter;
    :catch_0
    move-exception v0

    .line 44
    .local v0, "e":Ljava/lang/Exception;
    new-instance v1, Lio/minio/errors/XmlParserException;

    invoke-direct {v1, v0}, Lio/minio/errors/XmlParserException;-><init>(Ljava/lang/Exception;)V

    throw v1
.end method

.method public static unmarshal(Ljava/lang/Class;Ljava/io/Reader;)Ljava/lang/Object;
    .locals 2
    .param p1, "source"    # Ljava/io/Reader;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">(",
            "Ljava/lang/Class<",
            "+TT;>;",
            "Ljava/io/Reader;",
            ")TT;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lio/minio/errors/XmlParserException;
        }
    .end annotation

    .line 54
    .local p0, "type":Ljava/lang/Class;, "Ljava/lang/Class<+TT;>;"
    :try_start_0
    new-instance v0, Lorg/simpleframework/xml/core/Persister;

    new-instance v1, Lorg/simpleframework/xml/convert/AnnotationStrategy;

    invoke-direct {v1}, Lorg/simpleframework/xml/convert/AnnotationStrategy;-><init>()V

    invoke-direct {v0, v1}, Lorg/simpleframework/xml/core/Persister;-><init>(Lorg/simpleframework/xml/strategy/Strategy;)V

    .line 55
    .local v0, "serializer":Lorg/simpleframework/xml/Serializer;
    invoke-interface {v0, p0, p1}, Lorg/simpleframework/xml/Serializer;->read(Ljava/lang/Class;Ljava/io/Reader;)Ljava/lang/Object;

    move-result-object v1
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-object v1

    .line 56
    .end local v0    # "serializer":Lorg/simpleframework/xml/Serializer;
    :catch_0
    move-exception v0

    .line 57
    .local v0, "e":Ljava/lang/Exception;
    new-instance v1, Lio/minio/errors/XmlParserException;

    invoke-direct {v1, v0}, Lio/minio/errors/XmlParserException;-><init>(Ljava/lang/Exception;)V

    throw v1
.end method

.method public static unmarshal(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Object;
    .locals 2
    .param p1, "source"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">(",
            "Ljava/lang/Class<",
            "+TT;>;",
            "Ljava/lang/String;",
            ")TT;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lio/minio/errors/XmlParserException;
        }
    .end annotation

    .line 67
    .local p0, "type":Ljava/lang/Class;, "Ljava/lang/Class<+TT;>;"
    :try_start_0
    new-instance v0, Lorg/simpleframework/xml/core/Persister;

    new-instance v1, Lorg/simpleframework/xml/convert/AnnotationStrategy;

    invoke-direct {v1}, Lorg/simpleframework/xml/convert/AnnotationStrategy;-><init>()V

    invoke-direct {v0, v1}, Lorg/simpleframework/xml/core/Persister;-><init>(Lorg/simpleframework/xml/strategy/Strategy;)V

    .line 68
    .local v0, "serializer":Lorg/simpleframework/xml/Serializer;
    new-instance v1, Ljava/io/StringReader;

    invoke-direct {v1, p1}, Ljava/io/StringReader;-><init>(Ljava/lang/String;)V

    invoke-interface {v0, p0, v1}, Lorg/simpleframework/xml/Serializer;->read(Ljava/lang/Class;Ljava/io/Reader;)Ljava/lang/Object;

    move-result-object v1
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-object v1

    .line 69
    .end local v0    # "serializer":Lorg/simpleframework/xml/Serializer;
    :catch_0
    move-exception v0

    .line 70
    .local v0, "e":Ljava/lang/Exception;
    new-instance v1, Lio/minio/errors/XmlParserException;

    invoke-direct {v1, v0}, Lio/minio/errors/XmlParserException;-><init>(Ljava/lang/Exception;)V

    throw v1
.end method

.method public static validate(Ljava/lang/Class;Ljava/lang/String;)Z
    .locals 2
    .param p0, "type"    # Ljava/lang/Class;
    .param p1, "source"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lio/minio/errors/XmlParserException;
        }
    .end annotation

    .line 80
    :try_start_0
    new-instance v0, Lorg/simpleframework/xml/core/Persister;

    new-instance v1, Lorg/simpleframework/xml/convert/AnnotationStrategy;

    invoke-direct {v1}, Lorg/simpleframework/xml/convert/AnnotationStrategy;-><init>()V

    invoke-direct {v0, v1}, Lorg/simpleframework/xml/core/Persister;-><init>(Lorg/simpleframework/xml/strategy/Strategy;)V

    .line 81
    .local v0, "serializer":Lorg/simpleframework/xml/Serializer;
    invoke-interface {v0, p0, p1}, Lorg/simpleframework/xml/Serializer;->validate(Ljava/lang/Class;Ljava/lang/String;)Z

    move-result v1
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return v1

    .line 82
    .end local v0    # "serializer":Lorg/simpleframework/xml/Serializer;
    :catch_0
    move-exception v0

    .line 83
    .local v0, "e":Ljava/lang/Exception;
    new-instance v1, Lio/minio/errors/XmlParserException;

    invoke-direct {v1, v0}, Lio/minio/errors/XmlParserException;-><init>(Ljava/lang/Exception;)V

    throw v1
.end method
