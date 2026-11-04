.class public Lorg/codehaus/stax2/ri/evt/NamespaceEventImpl;
.super Lorg/codehaus/stax2/ri/evt/AttributeEventImpl;
.source "NamespaceEventImpl.java"

# interfaces
.implements Ljavax/xml/stream/events/Namespace;


# instance fields
.field final mPrefix:Ljava/lang/String;

.field final mURI:Ljava/lang/String;


# direct methods
.method protected constructor <init>(Ljavax/xml/stream/Location;Ljava/lang/String;)V
    .locals 7
    .param p1, "loc"    # Ljavax/xml/stream/Location;
    .param p2, "nsURI"    # Ljava/lang/String;

    .line 26
    const/4 v4, 0x0

    const/4 v6, 0x1

    const-string v2, "xmlns"

    const-string v3, "http://www.w3.org/2000/xmlns/"

    move-object v0, p0

    move-object v1, p1

    move-object v5, p2

    invoke-direct/range {v0 .. v6}, Lorg/codehaus/stax2/ri/evt/AttributeEventImpl;-><init>(Ljavax/xml/stream/Location;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Z)V

    .line 29
    const-string v0, ""

    iput-object v0, p0, Lorg/codehaus/stax2/ri/evt/NamespaceEventImpl;->mPrefix:Ljava/lang/String;

    .line 30
    iput-object p2, p0, Lorg/codehaus/stax2/ri/evt/NamespaceEventImpl;->mURI:Ljava/lang/String;

    .line 31
    return-void
.end method

.method protected constructor <init>(Ljavax/xml/stream/Location;Ljava/lang/String;Ljava/lang/String;)V
    .locals 7
    .param p1, "loc"    # Ljavax/xml/stream/Location;
    .param p2, "nsPrefix"    # Ljava/lang/String;
    .param p3, "nsURI"    # Ljava/lang/String;

    .line 39
    const-string v4, "xmlns"

    const/4 v6, 0x1

    const-string v3, "http://www.w3.org/2000/xmlns/"

    move-object v0, p0

    move-object v1, p1

    move-object v2, p2

    move-object v5, p3

    invoke-direct/range {v0 .. v6}, Lorg/codehaus/stax2/ri/evt/AttributeEventImpl;-><init>(Ljavax/xml/stream/Location;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Z)V

    .line 42
    iput-object p2, p0, Lorg/codehaus/stax2/ri/evt/NamespaceEventImpl;->mPrefix:Ljava/lang/String;

    .line 43
    iput-object p3, p0, Lorg/codehaus/stax2/ri/evt/NamespaceEventImpl;->mURI:Ljava/lang/String;

    .line 44
    return-void
.end method

.method public static constructDefaultNamespace(Ljavax/xml/stream/Location;Ljava/lang/String;)Lorg/codehaus/stax2/ri/evt/NamespaceEventImpl;
    .locals 1
    .param p0, "loc"    # Ljavax/xml/stream/Location;
    .param p1, "nsURI"    # Ljava/lang/String;

    .line 48
    new-instance v0, Lorg/codehaus/stax2/ri/evt/NamespaceEventImpl;

    invoke-direct {v0, p0, p1}, Lorg/codehaus/stax2/ri/evt/NamespaceEventImpl;-><init>(Ljavax/xml/stream/Location;Ljava/lang/String;)V

    return-object v0
.end method

.method public static constructNamespace(Ljavax/xml/stream/Location;Ljava/lang/String;Ljava/lang/String;)Lorg/codehaus/stax2/ri/evt/NamespaceEventImpl;
    .locals 1
    .param p0, "loc"    # Ljavax/xml/stream/Location;
    .param p1, "nsPrefix"    # Ljava/lang/String;
    .param p2, "nsURI"    # Ljava/lang/String;

    .line 53
    if-eqz p1, :cond_1

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    if-nez v0, :cond_0

    goto :goto_0

    .line 56
    :cond_0
    new-instance v0, Lorg/codehaus/stax2/ri/evt/NamespaceEventImpl;

    invoke-direct {v0, p0, p1, p2}, Lorg/codehaus/stax2/ri/evt/NamespaceEventImpl;-><init>(Ljavax/xml/stream/Location;Ljava/lang/String;Ljava/lang/String;)V

    return-object v0

    .line 54
    :cond_1
    :goto_0
    new-instance v0, Lorg/codehaus/stax2/ri/evt/NamespaceEventImpl;

    invoke-direct {v0, p0, p2}, Lorg/codehaus/stax2/ri/evt/NamespaceEventImpl;-><init>(Ljavax/xml/stream/Location;Ljava/lang/String;)V

    return-object v0
.end method


# virtual methods
.method public getEventType()I
    .locals 1

    .line 82
    const/16 v0, 0xd

    return v0
.end method

.method public getNamespaceURI()Ljava/lang/String;
    .locals 1

    .line 61
    iget-object v0, p0, Lorg/codehaus/stax2/ri/evt/NamespaceEventImpl;->mURI:Ljava/lang/String;

    return-object v0
.end method

.method public getPrefix()Ljava/lang/String;
    .locals 1

    .line 66
    iget-object v0, p0, Lorg/codehaus/stax2/ri/evt/NamespaceEventImpl;->mPrefix:Ljava/lang/String;

    return-object v0
.end method

.method public isDefaultNamespaceDeclaration()Z
    .locals 1

    .line 71
    iget-object v0, p0, Lorg/codehaus/stax2/ri/evt/NamespaceEventImpl;->mPrefix:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v0

    if-nez v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public isNamespace()Z
    .locals 1

    .line 87
    const/4 v0, 0x1

    return v0
.end method
