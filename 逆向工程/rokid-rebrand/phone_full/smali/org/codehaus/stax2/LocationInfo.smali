.class public interface abstract Lorg/codehaus/stax2/LocationInfo;
.super Ljava/lang/Object;
.source "LocationInfo.java"


# virtual methods
.method public abstract getCurrentLocation()Lorg/codehaus/stax2/XMLStreamLocation2;
.end method

.method public abstract getEndLocation()Lorg/codehaus/stax2/XMLStreamLocation2;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method public abstract getEndingByteOffset()J
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method public abstract getEndingCharOffset()J
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method public abstract getLocation()Ljavax/xml/stream/Location;
.end method

.method public abstract getStartLocation()Lorg/codehaus/stax2/XMLStreamLocation2;
.end method

.method public abstract getStartingByteOffset()J
.end method

.method public abstract getStartingCharOffset()J
.end method
