.class public interface abstract Lcom/fasterxml/aalto/AsyncXMLStreamReader;
.super Ljava/lang/Object;
.source "AsyncXMLStreamReader.java"

# interfaces
.implements Lorg/codehaus/stax2/XMLStreamReader2;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "<F::",
        "Lcom/fasterxml/aalto/AsyncInputFeeder;",
        ">",
        "Ljava/lang/Object;",
        "Lorg/codehaus/stax2/XMLStreamReader2;"
    }
.end annotation


# static fields
.field public static final EVENT_INCOMPLETE:I = 0x101


# virtual methods
.method public abstract getConfig()Lcom/fasterxml/aalto/in/ReaderConfig;
.end method

.method public abstract getInputFeeder()Lcom/fasterxml/aalto/AsyncInputFeeder;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()TF;"
        }
    .end annotation
.end method
