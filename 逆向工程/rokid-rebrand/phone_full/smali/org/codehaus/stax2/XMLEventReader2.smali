.class public interface abstract Lorg/codehaus/stax2/XMLEventReader2;
.super Ljava/lang/Object;
.source "XMLEventReader2.java"

# interfaces
.implements Ljavax/xml/stream/XMLEventReader;


# virtual methods
.method public abstract hasNextEvent()Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method public abstract isPropertySupported(Ljava/lang/String;)Z
.end method

.method public abstract setProperty(Ljava/lang/String;Ljava/lang/Object;)Z
.end method
