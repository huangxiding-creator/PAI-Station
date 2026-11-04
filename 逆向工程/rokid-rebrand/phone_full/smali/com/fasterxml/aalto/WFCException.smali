.class public Lcom/fasterxml/aalto/WFCException;
.super Lcom/fasterxml/aalto/impl/StreamExceptionBase;
.source "WFCException.java"


# direct methods
.method public constructor <init>(Ljava/lang/String;Ljavax/xml/stream/Location;)V
    .locals 0
    .param p1, "msg"    # Ljava/lang/String;
    .param p2, "loc"    # Ljavax/xml/stream/Location;

    .line 32
    invoke-direct {p0, p1, p2}, Lcom/fasterxml/aalto/impl/StreamExceptionBase;-><init>(Ljava/lang/String;Ljavax/xml/stream/Location;)V

    .line 33
    return-void
.end method
