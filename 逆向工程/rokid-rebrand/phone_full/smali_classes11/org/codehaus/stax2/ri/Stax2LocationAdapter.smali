.class public Lorg/codehaus/stax2/ri/Stax2LocationAdapter;
.super Ljava/lang/Object;
.source "Stax2LocationAdapter.java"

# interfaces
.implements Lorg/codehaus/stax2/XMLStreamLocation2;


# instance fields
.field protected final mParentLocation:Ljavax/xml/stream/Location;

.field protected final mWrappedLocation:Ljavax/xml/stream/Location;


# direct methods
.method public constructor <init>(Ljavax/xml/stream/Location;)V
    .locals 1
    .param p1, "loc"    # Ljavax/xml/stream/Location;

    .line 21
    const/4 v0, 0x0

    invoke-direct {p0, p1, v0}, Lorg/codehaus/stax2/ri/Stax2LocationAdapter;-><init>(Ljavax/xml/stream/Location;Ljavax/xml/stream/Location;)V

    .line 22
    return-void
.end method

.method public constructor <init>(Ljavax/xml/stream/Location;Ljavax/xml/stream/Location;)V
    .locals 0
    .param p1, "loc"    # Ljavax/xml/stream/Location;
    .param p2, "parent"    # Ljavax/xml/stream/Location;

    .line 25
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 26
    iput-object p1, p0, Lorg/codehaus/stax2/ri/Stax2LocationAdapter;->mWrappedLocation:Ljavax/xml/stream/Location;

    .line 27
    iput-object p2, p0, Lorg/codehaus/stax2/ri/Stax2LocationAdapter;->mParentLocation:Ljavax/xml/stream/Location;

    .line 28
    return-void
.end method


# virtual methods
.method public getCharacterOffset()I
    .locals 1

    .line 35
    iget-object v0, p0, Lorg/codehaus/stax2/ri/Stax2LocationAdapter;->mWrappedLocation:Ljavax/xml/stream/Location;

    invoke-interface {v0}, Ljavax/xml/stream/Location;->getCharacterOffset()I

    move-result v0

    return v0
.end method

.method public getColumnNumber()I
    .locals 1

    .line 41
    iget-object v0, p0, Lorg/codehaus/stax2/ri/Stax2LocationAdapter;->mWrappedLocation:Ljavax/xml/stream/Location;

    invoke-interface {v0}, Ljavax/xml/stream/Location;->getColumnNumber()I

    move-result v0

    return v0
.end method

.method public getContext()Lorg/codehaus/stax2/XMLStreamLocation2;
    .locals 2

    .line 67
    iget-object v0, p0, Lorg/codehaus/stax2/ri/Stax2LocationAdapter;->mParentLocation:Ljavax/xml/stream/Location;

    if-nez v0, :cond_0

    .line 68
    const/4 v0, 0x0

    return-object v0

    .line 70
    :cond_0
    iget-object v0, p0, Lorg/codehaus/stax2/ri/Stax2LocationAdapter;->mParentLocation:Ljavax/xml/stream/Location;

    instance-of v0, v0, Lorg/codehaus/stax2/XMLStreamLocation2;

    if-eqz v0, :cond_1

    .line 71
    iget-object v0, p0, Lorg/codehaus/stax2/ri/Stax2LocationAdapter;->mParentLocation:Ljavax/xml/stream/Location;

    check-cast v0, Lorg/codehaus/stax2/XMLStreamLocation2;

    return-object v0

    .line 73
    :cond_1
    new-instance v0, Lorg/codehaus/stax2/ri/Stax2LocationAdapter;

    iget-object v1, p0, Lorg/codehaus/stax2/ri/Stax2LocationAdapter;->mParentLocation:Ljavax/xml/stream/Location;

    invoke-direct {v0, v1}, Lorg/codehaus/stax2/ri/Stax2LocationAdapter;-><init>(Ljavax/xml/stream/Location;)V

    return-object v0
.end method

.method public getLineNumber()I
    .locals 1

    .line 47
    iget-object v0, p0, Lorg/codehaus/stax2/ri/Stax2LocationAdapter;->mWrappedLocation:Ljavax/xml/stream/Location;

    invoke-interface {v0}, Ljavax/xml/stream/Location;->getLineNumber()I

    move-result v0

    return v0
.end method

.method public getPublicId()Ljava/lang/String;
    .locals 1

    .line 53
    iget-object v0, p0, Lorg/codehaus/stax2/ri/Stax2LocationAdapter;->mWrappedLocation:Ljavax/xml/stream/Location;

    invoke-interface {v0}, Ljavax/xml/stream/Location;->getPublicId()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getSystemId()Ljava/lang/String;
    .locals 1

    .line 59
    iget-object v0, p0, Lorg/codehaus/stax2/ri/Stax2LocationAdapter;->mWrappedLocation:Ljavax/xml/stream/Location;

    invoke-interface {v0}, Ljavax/xml/stream/Location;->getSystemId()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
