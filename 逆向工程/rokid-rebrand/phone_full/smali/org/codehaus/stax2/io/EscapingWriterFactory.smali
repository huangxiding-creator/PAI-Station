.class public interface abstract Lorg/codehaus/stax2/io/EscapingWriterFactory;
.super Ljava/lang/Object;
.source "EscapingWriterFactory.java"


# virtual methods
.method public abstract createEscapingWriterFor(Ljava/io/OutputStream;Ljava/lang/String;)Ljava/io/Writer;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/UnsupportedEncodingException;
        }
    .end annotation
.end method

.method public abstract createEscapingWriterFor(Ljava/io/Writer;Ljava/lang/String;)Ljava/io/Writer;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/UnsupportedEncodingException;
        }
    .end annotation
.end method
