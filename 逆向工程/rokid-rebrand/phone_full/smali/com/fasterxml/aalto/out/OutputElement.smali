.class final Lcom/fasterxml/aalto/out/OutputElement;
.super Ljava/lang/Object;
.source "OutputElement.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/fasterxml/aalto/out/OutputElement$PrefixState;
    }
.end annotation


# static fields
.field static final BYTE_GT:B = 0x3et

.field static final BYTE_LT:B = 0x3ct

.field static final BYTE_SLASH:B = 0x2ft


# instance fields
.field private _defaultNsURI:Ljava/lang/String;

.field private _name:Lcom/fasterxml/aalto/out/WName;

.field private _nsBinder:Lcom/fasterxml/aalto/out/NsBinder;

.field private _parent:Lcom/fasterxml/aalto/out/OutputElement;

.field private _uri:Ljava/lang/String;


# direct methods
.method private constructor <init>()V
    .locals 2

    .line 86
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 75
    const-string v0, ""

    iput-object v0, p0, Lcom/fasterxml/aalto/out/OutputElement;->_defaultNsURI:Ljava/lang/String;

    .line 77
    const/4 v1, 0x0

    iput-object v1, p0, Lcom/fasterxml/aalto/out/OutputElement;->_nsBinder:Lcom/fasterxml/aalto/out/NsBinder;

    .line 87
    iput-object v1, p0, Lcom/fasterxml/aalto/out/OutputElement;->_parent:Lcom/fasterxml/aalto/out/OutputElement;

    .line 88
    iput-object v1, p0, Lcom/fasterxml/aalto/out/OutputElement;->_name:Lcom/fasterxml/aalto/out/WName;

    .line 89
    iput-object v1, p0, Lcom/fasterxml/aalto/out/OutputElement;->_uri:Ljava/lang/String;

    .line 90
    iput-object v1, p0, Lcom/fasterxml/aalto/out/OutputElement;->_nsBinder:Lcom/fasterxml/aalto/out/NsBinder;

    .line 91
    iput-object v0, p0, Lcom/fasterxml/aalto/out/OutputElement;->_defaultNsURI:Ljava/lang/String;

    .line 92
    return-void
.end method

.method private constructor <init>(Lcom/fasterxml/aalto/out/OutputElement;Lcom/fasterxml/aalto/out/WName;Ljava/lang/String;Lcom/fasterxml/aalto/out/NsBinder;)V
    .locals 1
    .param p1, "parent"    # Lcom/fasterxml/aalto/out/OutputElement;
    .param p2, "name"    # Lcom/fasterxml/aalto/out/WName;
    .param p3, "uri"    # Ljava/lang/String;
    .param p4, "binder"    # Lcom/fasterxml/aalto/out/NsBinder;

    .line 97
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 75
    const-string v0, ""

    iput-object v0, p0, Lcom/fasterxml/aalto/out/OutputElement;->_defaultNsURI:Ljava/lang/String;

    .line 77
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/fasterxml/aalto/out/OutputElement;->_nsBinder:Lcom/fasterxml/aalto/out/NsBinder;

    .line 98
    iput-object p1, p0, Lcom/fasterxml/aalto/out/OutputElement;->_parent:Lcom/fasterxml/aalto/out/OutputElement;

    .line 99
    iput-object p2, p0, Lcom/fasterxml/aalto/out/OutputElement;->_name:Lcom/fasterxml/aalto/out/WName;

    .line 100
    iput-object p3, p0, Lcom/fasterxml/aalto/out/OutputElement;->_uri:Ljava/lang/String;

    .line 101
    iput-object p4, p0, Lcom/fasterxml/aalto/out/OutputElement;->_nsBinder:Lcom/fasterxml/aalto/out/NsBinder;

    .line 102
    iget-object v0, p1, Lcom/fasterxml/aalto/out/OutputElement;->_defaultNsURI:Ljava/lang/String;

    iput-object v0, p0, Lcom/fasterxml/aalto/out/OutputElement;->_defaultNsURI:Ljava/lang/String;

    .line 103
    return-void
.end method

.method protected static createRoot()Lcom/fasterxml/aalto/out/OutputElement;
    .locals 1

    .line 107
    new-instance v0, Lcom/fasterxml/aalto/out/OutputElement;

    invoke-direct {v0}, Lcom/fasterxml/aalto/out/OutputElement;-><init>()V

    return-object v0
.end method

.method private relink(Lcom/fasterxml/aalto/out/OutputElement;Lcom/fasterxml/aalto/out/WName;Ljava/lang/String;)V
    .locals 1
    .param p1, "parent"    # Lcom/fasterxml/aalto/out/OutputElement;
    .param p2, "name"    # Lcom/fasterxml/aalto/out/WName;
    .param p3, "uri"    # Ljava/lang/String;

    .line 170
    iput-object p1, p0, Lcom/fasterxml/aalto/out/OutputElement;->_parent:Lcom/fasterxml/aalto/out/OutputElement;

    .line 171
    iput-object p2, p0, Lcom/fasterxml/aalto/out/OutputElement;->_name:Lcom/fasterxml/aalto/out/WName;

    .line 172
    iput-object p3, p0, Lcom/fasterxml/aalto/out/OutputElement;->_uri:Ljava/lang/String;

    .line 173
    iget-object v0, p1, Lcom/fasterxml/aalto/out/OutputElement;->_nsBinder:Lcom/fasterxml/aalto/out/NsBinder;

    iput-object v0, p0, Lcom/fasterxml/aalto/out/OutputElement;->_nsBinder:Lcom/fasterxml/aalto/out/NsBinder;

    .line 174
    iget-object v0, p1, Lcom/fasterxml/aalto/out/OutputElement;->_defaultNsURI:Ljava/lang/String;

    iput-object v0, p0, Lcom/fasterxml/aalto/out/OutputElement;->_defaultNsURI:Ljava/lang/String;

    .line 175
    return-void
.end method


# virtual methods
.method public addPrefix(Ljava/lang/String;Ljava/lang/String;)V
    .locals 2
    .param p1, "prefix"    # Ljava/lang/String;
    .param p2, "uri"    # Ljava/lang/String;

    .line 262
    iget-object v0, p0, Lcom/fasterxml/aalto/out/OutputElement;->_nsBinder:Lcom/fasterxml/aalto/out/NsBinder;

    if-nez v0, :cond_0

    .line 264
    invoke-static {}, Lcom/fasterxml/aalto/out/NsBinder;->createEmpty()Lcom/fasterxml/aalto/out/NsBinder;

    move-result-object v0

    iput-object v0, p0, Lcom/fasterxml/aalto/out/OutputElement;->_nsBinder:Lcom/fasterxml/aalto/out/NsBinder;

    goto :goto_0

    .line 266
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/out/OutputElement;->_parent:Lcom/fasterxml/aalto/out/OutputElement;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/fasterxml/aalto/out/OutputElement;->_parent:Lcom/fasterxml/aalto/out/OutputElement;

    iget-object v0, v0, Lcom/fasterxml/aalto/out/OutputElement;->_nsBinder:Lcom/fasterxml/aalto/out/NsBinder;

    iget-object v1, p0, Lcom/fasterxml/aalto/out/OutputElement;->_nsBinder:Lcom/fasterxml/aalto/out/NsBinder;

    if-ne v0, v1, :cond_1

    .line 268
    iget-object v0, p0, Lcom/fasterxml/aalto/out/OutputElement;->_nsBinder:Lcom/fasterxml/aalto/out/NsBinder;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/out/NsBinder;->createChild()Lcom/fasterxml/aalto/out/NsBinder;

    move-result-object v0

    iput-object v0, p0, Lcom/fasterxml/aalto/out/OutputElement;->_nsBinder:Lcom/fasterxml/aalto/out/NsBinder;

    .line 271
    :cond_1
    :goto_0
    iget-object v0, p0, Lcom/fasterxml/aalto/out/OutputElement;->_nsBinder:Lcom/fasterxml/aalto/out/NsBinder;

    invoke-virtual {v0, p1, p2}, Lcom/fasterxml/aalto/out/NsBinder;->addMapping(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    .line 272
    return-void
.end method

.method protected addToPool(Lcom/fasterxml/aalto/out/OutputElement;)V
    .locals 0
    .param p1, "poolHead"    # Lcom/fasterxml/aalto/out/OutputElement;

    .line 183
    iput-object p1, p0, Lcom/fasterxml/aalto/out/OutputElement;->_parent:Lcom/fasterxml/aalto/out/OutputElement;

    .line 184
    return-void
.end method

.method public checkPrefixValidity(Ljava/lang/String;Ljava/lang/String;Ljavax/xml/namespace/NamespaceContext;)Lcom/fasterxml/aalto/out/OutputElement$PrefixState;
    .locals 2
    .param p1, "prefix"    # Ljava/lang/String;
    .param p2, "nsURI"    # Ljava/lang/String;
    .param p3, "rootNsContext"    # Ljavax/xml/namespace/NamespaceContext;

    .line 391
    const-string/jumbo v0, "xml"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 392
    const-string v0, "http://www.w3.org/XML/1998/namespace"

    invoke-virtual {p2, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    sget-object v0, Lcom/fasterxml/aalto/out/OutputElement$PrefixState;->OK:Lcom/fasterxml/aalto/out/OutputElement$PrefixState;

    goto :goto_0

    :cond_0
    sget-object v0, Lcom/fasterxml/aalto/out/OutputElement$PrefixState;->MISBOUND:Lcom/fasterxml/aalto/out/OutputElement$PrefixState;

    :goto_0
    return-object v0

    .line 397
    :cond_1
    iget-object v0, p0, Lcom/fasterxml/aalto/out/OutputElement;->_nsBinder:Lcom/fasterxml/aalto/out/NsBinder;

    if-nez v0, :cond_2

    const/4 v0, 0x0

    goto :goto_1

    :cond_2
    iget-object v0, p0, Lcom/fasterxml/aalto/out/OutputElement;->_nsBinder:Lcom/fasterxml/aalto/out/NsBinder;

    invoke-virtual {v0, p1}, Lcom/fasterxml/aalto/out/NsBinder;->findUriByPrefix(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 398
    .local v0, "act":Ljava/lang/String;
    :goto_1
    if-nez v0, :cond_3

    if-eqz p3, :cond_3

    .line 399
    invoke-interface {p3, p1}, Ljavax/xml/namespace/NamespaceContext;->getNamespaceURI(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 402
    :cond_3
    if-nez v0, :cond_4

    .line 403
    sget-object v1, Lcom/fasterxml/aalto/out/OutputElement$PrefixState;->UNBOUND:Lcom/fasterxml/aalto/out/OutputElement$PrefixState;

    return-object v1

    .line 405
    :cond_4
    if-eq v0, p2, :cond_6

    invoke-virtual {v0, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_5

    goto :goto_2

    :cond_5
    sget-object v1, Lcom/fasterxml/aalto/out/OutputElement$PrefixState;->MISBOUND:Lcom/fasterxml/aalto/out/OutputElement$PrefixState;

    goto :goto_3

    :cond_6
    :goto_2
    sget-object v1, Lcom/fasterxml/aalto/out/OutputElement$PrefixState;->OK:Lcom/fasterxml/aalto/out/OutputElement$PrefixState;

    :goto_3
    return-object v1
.end method

.method protected createChild(Lcom/fasterxml/aalto/out/WName;)Lcom/fasterxml/aalto/out/OutputElement;
    .locals 3
    .param p1, "name"    # Lcom/fasterxml/aalto/out/WName;

    .line 117
    new-instance v0, Lcom/fasterxml/aalto/out/OutputElement;

    iget-object v1, p0, Lcom/fasterxml/aalto/out/OutputElement;->_defaultNsURI:Ljava/lang/String;

    iget-object v2, p0, Lcom/fasterxml/aalto/out/OutputElement;->_nsBinder:Lcom/fasterxml/aalto/out/NsBinder;

    invoke-direct {v0, p0, p1, v1, v2}, Lcom/fasterxml/aalto/out/OutputElement;-><init>(Lcom/fasterxml/aalto/out/OutputElement;Lcom/fasterxml/aalto/out/WName;Ljava/lang/String;Lcom/fasterxml/aalto/out/NsBinder;)V

    return-object v0
.end method

.method protected createChild(Lcom/fasterxml/aalto/out/WName;Ljava/lang/String;)Lcom/fasterxml/aalto/out/OutputElement;
    .locals 2
    .param p1, "name"    # Lcom/fasterxml/aalto/out/WName;
    .param p2, "uri"    # Ljava/lang/String;

    .line 126
    new-instance v0, Lcom/fasterxml/aalto/out/OutputElement;

    iget-object v1, p0, Lcom/fasterxml/aalto/out/OutputElement;->_nsBinder:Lcom/fasterxml/aalto/out/NsBinder;

    invoke-direct {v0, p0, p1, p2, v1}, Lcom/fasterxml/aalto/out/OutputElement;-><init>(Lcom/fasterxml/aalto/out/OutputElement;Lcom/fasterxml/aalto/out/WName;Ljava/lang/String;Lcom/fasterxml/aalto/out/NsBinder;)V

    return-object v0
.end method

.method public generatePrefix(Ljavax/xml/namespace/NamespaceContext;Ljava/lang/String;[I)Ljava/lang/String;
    .locals 1
    .param p1, "rootNsContext"    # Ljavax/xml/namespace/NamespaceContext;
    .param p2, "prefixBase"    # Ljava/lang/String;
    .param p3, "seqArr"    # [I

    .line 253
    iget-object v0, p0, Lcom/fasterxml/aalto/out/OutputElement;->_nsBinder:Lcom/fasterxml/aalto/out/NsBinder;

    if-nez v0, :cond_0

    .line 254
    invoke-static {}, Lcom/fasterxml/aalto/out/NsBinder;->createEmpty()Lcom/fasterxml/aalto/out/NsBinder;

    move-result-object v0

    iput-object v0, p0, Lcom/fasterxml/aalto/out/OutputElement;->_nsBinder:Lcom/fasterxml/aalto/out/NsBinder;

    .line 257
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/out/OutputElement;->_nsBinder:Lcom/fasterxml/aalto/out/NsBinder;

    invoke-virtual {v0, p2, p1, p3}, Lcom/fasterxml/aalto/out/NsBinder;->generatePrefix(Ljava/lang/String;Ljavax/xml/namespace/NamespaceContext;[I)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getDefaultNsURI()Ljava/lang/String;
    .locals 1

    .line 229
    iget-object v0, p0, Lcom/fasterxml/aalto/out/OutputElement;->_defaultNsURI:Ljava/lang/String;

    return-object v0
.end method

.method public getExplicitPrefix(Ljava/lang/String;Ljavax/xml/namespace/NamespaceContext;)Ljava/lang/String;
    .locals 2
    .param p1, "uri"    # Ljava/lang/String;
    .param p2, "rootNsContext"    # Ljavax/xml/namespace/NamespaceContext;

    .line 354
    iget-object v0, p0, Lcom/fasterxml/aalto/out/OutputElement;->_nsBinder:Lcom/fasterxml/aalto/out/NsBinder;

    if-eqz v0, :cond_0

    .line 355
    iget-object v0, p0, Lcom/fasterxml/aalto/out/OutputElement;->_nsBinder:Lcom/fasterxml/aalto/out/NsBinder;

    invoke-virtual {v0, p1}, Lcom/fasterxml/aalto/out/NsBinder;->findPrefixByUri(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 356
    .local v0, "prefix":Ljava/lang/String;
    if-eqz v0, :cond_0

    .line 357
    return-object v0

    .line 360
    .end local v0    # "prefix":Ljava/lang/String;
    :cond_0
    if-eqz p2, :cond_1

    .line 361
    invoke-interface {p2, p1}, Ljavax/xml/namespace/NamespaceContext;->getPrefix(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 362
    .restart local v0    # "prefix":Ljava/lang/String;
    if-eqz v0, :cond_1

    .line 364
    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v1

    if-lez v1, :cond_1

    .line 365
    return-object v0

    .line 370
    .end local v0    # "prefix":Ljava/lang/String;
    :cond_1
    const/4 v0, 0x0

    return-object v0
.end method

.method public getLocalName()Ljava/lang/String;
    .locals 1

    .line 203
    iget-object v0, p0, Lcom/fasterxml/aalto/out/OutputElement;->_name:Lcom/fasterxml/aalto/out/WName;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/out/WName;->getLocalName()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getName()Lcom/fasterxml/aalto/out/WName;
    .locals 1

    .line 201
    iget-object v0, p0, Lcom/fasterxml/aalto/out/OutputElement;->_name:Lcom/fasterxml/aalto/out/WName;

    return-object v0
.end method

.method public getNameDesc()Ljava/lang/String;
    .locals 1

    .line 217
    iget-object v0, p0, Lcom/fasterxml/aalto/out/OutputElement;->_name:Lcom/fasterxml/aalto/out/WName;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/out/WName;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getNamespaceURI()Ljava/lang/String;
    .locals 1

    .line 221
    iget-object v0, p0, Lcom/fasterxml/aalto/out/OutputElement;->_uri:Ljava/lang/String;

    return-object v0
.end method

.method public getNamespaceURI(Ljava/lang/String;)Ljava/lang/String;
    .locals 1
    .param p1, "prefix"    # Ljava/lang/String;

    .line 282
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    if-nez v0, :cond_0

    .line 283
    iget-object v0, p0, Lcom/fasterxml/aalto/out/OutputElement;->_defaultNsURI:Ljava/lang/String;

    return-object v0

    .line 285
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/out/OutputElement;->_nsBinder:Lcom/fasterxml/aalto/out/NsBinder;

    if-eqz v0, :cond_1

    .line 286
    iget-object v0, p0, Lcom/fasterxml/aalto/out/OutputElement;->_nsBinder:Lcom/fasterxml/aalto/out/NsBinder;

    invoke-virtual {v0, p1}, Lcom/fasterxml/aalto/out/NsBinder;->findUriByPrefix(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 287
    .local v0, "uri":Ljava/lang/String;
    if-eqz v0, :cond_1

    .line 288
    return-object v0

    .line 291
    .end local v0    # "uri":Ljava/lang/String;
    :cond_1
    const/4 v0, 0x0

    return-object v0
.end method

.method public getNonNullNamespaceURI()Ljava/lang/String;
    .locals 1

    .line 225
    iget-object v0, p0, Lcom/fasterxml/aalto/out/OutputElement;->_uri:Ljava/lang/String;

    if-nez v0, :cond_0

    const-string v0, ""

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/out/OutputElement;->_uri:Ljava/lang/String;

    :goto_0
    return-object v0
.end method

.method public getNonNullPrefix()Ljava/lang/String;
    .locals 2

    .line 206
    iget-object v0, p0, Lcom/fasterxml/aalto/out/OutputElement;->_name:Lcom/fasterxml/aalto/out/WName;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/out/WName;->getPrefix()Ljava/lang/String;

    move-result-object v0

    .line 207
    .local v0, "p":Ljava/lang/String;
    if-nez v0, :cond_0

    const-string v1, ""

    goto :goto_0

    :cond_0
    const/4 v1, 0x0

    :goto_0
    return-object v1
.end method

.method public getParent()Lcom/fasterxml/aalto/out/OutputElement;
    .locals 1

    .line 193
    iget-object v0, p0, Lcom/fasterxml/aalto/out/OutputElement;->_parent:Lcom/fasterxml/aalto/out/OutputElement;

    return-object v0
.end method

.method public getPrefix(Ljava/lang/String;)Ljava/lang/String;
    .locals 1
    .param p1, "uri"    # Ljava/lang/String;

    .line 296
    iget-object v0, p0, Lcom/fasterxml/aalto/out/OutputElement;->_defaultNsURI:Ljava/lang/String;

    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 297
    const-string v0, ""

    return-object v0

    .line 299
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/out/OutputElement;->_nsBinder:Lcom/fasterxml/aalto/out/NsBinder;

    if-eqz v0, :cond_1

    .line 300
    iget-object v0, p0, Lcom/fasterxml/aalto/out/OutputElement;->_nsBinder:Lcom/fasterxml/aalto/out/NsBinder;

    invoke-virtual {v0, p1}, Lcom/fasterxml/aalto/out/NsBinder;->findPrefixByUri(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 301
    .local v0, "prefix":Ljava/lang/String;
    if-eqz v0, :cond_1

    .line 302
    return-object v0

    .line 305
    .end local v0    # "prefix":Ljava/lang/String;
    :cond_1
    const/4 v0, 0x0

    return-object v0
.end method

.method public getPrefixes(Ljava/lang/String;Ljavax/xml/namespace/NamespaceContext;)Ljava/util/Iterator;
    .locals 4
    .param p1, "uri"    # Ljava/lang/String;
    .param p2, "rootNsContext"    # Ljavax/xml/namespace/NamespaceContext;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljavax/xml/namespace/NamespaceContext;",
            ")",
            "Ljava/util/Iterator<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .line 311
    const/4 v0, 0x0

    .line 313
    .local v0, "l":Ljava/util/List;, "Ljava/util/List<Ljava/lang/String;>;"
    iget-object v1, p0, Lcom/fasterxml/aalto/out/OutputElement;->_defaultNsURI:Ljava/lang/String;

    invoke-virtual {v1, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 314
    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    move-object v0, v1

    .line 315
    const-string v1, ""

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 317
    :cond_0
    iget-object v1, p0, Lcom/fasterxml/aalto/out/OutputElement;->_nsBinder:Lcom/fasterxml/aalto/out/NsBinder;

    if-eqz v1, :cond_1

    .line 318
    iget-object v1, p0, Lcom/fasterxml/aalto/out/OutputElement;->_nsBinder:Lcom/fasterxml/aalto/out/NsBinder;

    invoke-virtual {v1, p1, v0}, Lcom/fasterxml/aalto/out/NsBinder;->getPrefixesBoundToUri(Ljava/lang/String;Ljava/util/List;)Ljava/util/List;

    move-result-object v0

    .line 324
    :cond_1
    if-eqz p2, :cond_5

    .line 325
    invoke-interface {p2, p1}, Ljavax/xml/namespace/NamespaceContext;->getPrefixes(Ljava/lang/String;)Ljava/util/Iterator;

    move-result-object v1

    .line 326
    .local v1, "it":Ljava/util/Iterator;, "Ljava/util/Iterator<Ljava/lang/String;>;"
    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_5

    .line 327
    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    .line 328
    .local v2, "prefix":Ljava/lang/String;
    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v3

    if-nez v3, :cond_2

    .line 329
    goto :goto_0

    .line 332
    :cond_2
    if-nez v0, :cond_3

    .line 333
    new-instance v3, Ljava/util/ArrayList;

    invoke-direct {v3}, Ljava/util/ArrayList;-><init>()V

    move-object v0, v3

    goto :goto_1

    .line 334
    :cond_3
    invoke-interface {v0, v2}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_4

    .line 335
    goto :goto_0

    .line 337
    :cond_4
    :goto_1
    invoke-interface {v0, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 338
    .end local v2    # "prefix":Ljava/lang/String;
    goto :goto_0

    .line 340
    .end local v1    # "it":Ljava/util/Iterator;, "Ljava/util/Iterator<Ljava/lang/String;>;"
    :cond_5
    if-nez v0, :cond_6

    .line 341
    invoke-static {}, Lcom/fasterxml/aalto/util/EmptyIterator;->getInstance()Lcom/fasterxml/aalto/util/EmptyIterator;

    move-result-object v1

    return-object v1

    .line 343
    :cond_6
    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    return-object v1
.end method

.method public getQName()Ljavax/xml/namespace/QName;
    .locals 4

    .line 237
    new-instance v0, Ljavax/xml/namespace/QName;

    iget-object v1, p0, Lcom/fasterxml/aalto/out/OutputElement;->_uri:Ljava/lang/String;

    iget-object v2, p0, Lcom/fasterxml/aalto/out/OutputElement;->_name:Lcom/fasterxml/aalto/out/WName;

    invoke-virtual {v2}, Lcom/fasterxml/aalto/out/WName;->getLocalName()Ljava/lang/String;

    move-result-object v2

    iget-object v3, p0, Lcom/fasterxml/aalto/out/OutputElement;->_name:Lcom/fasterxml/aalto/out/WName;

    invoke-virtual {v3}, Lcom/fasterxml/aalto/out/WName;->getPrefix()Ljava/lang/String;

    move-result-object v3

    invoke-direct {v0, v1, v2, v3}, Ljavax/xml/namespace/QName;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    return-object v0
.end method

.method public hasEmptyDefaultNs()Z
    .locals 1

    .line 233
    iget-object v0, p0, Lcom/fasterxml/aalto/out/OutputElement;->_defaultNsURI:Ljava/lang/String;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/fasterxml/aalto/out/OutputElement;->_defaultNsURI:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v0

    if-nez v0, :cond_0

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    goto :goto_1

    :cond_1
    :goto_0
    const/4 v0, 0x1

    :goto_1
    return v0
.end method

.method public hasPrefix()Z
    .locals 1

    .line 209
    iget-object v0, p0, Lcom/fasterxml/aalto/out/OutputElement;->_name:Lcom/fasterxml/aalto/out/WName;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/out/WName;->hasPrefix()Z

    move-result v0

    return v0
.end method

.method public hashCode()I
    .locals 1

    .line 461
    iget-object v0, p0, Lcom/fasterxml/aalto/out/OutputElement;->_name:Lcom/fasterxml/aalto/out/WName;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/out/WName;->hashCode()I

    move-result v0

    return v0
.end method

.method public isPrefixBoundTo(Ljava/lang/String;Ljava/lang/String;Ljavax/xml/namespace/NamespaceContext;)Z
    .locals 2
    .param p1, "prefix"    # Ljava/lang/String;
    .param p2, "nsURI"    # Ljava/lang/String;
    .param p3, "rootNsContext"    # Ljavax/xml/namespace/NamespaceContext;

    .line 412
    if-eqz p1, :cond_6

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    if-nez v0, :cond_0

    goto :goto_2

    .line 419
    :cond_0
    const-string/jumbo v0, "xml"

    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 420
    const-string v0, "http://www.w3.org/XML/1998/namespace"

    invoke-virtual {p2, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    return v0

    .line 423
    :cond_1
    iget-object v0, p0, Lcom/fasterxml/aalto/out/OutputElement;->_nsBinder:Lcom/fasterxml/aalto/out/NsBinder;

    if-nez v0, :cond_2

    const/4 v0, 0x0

    goto :goto_0

    :cond_2
    iget-object v0, p0, Lcom/fasterxml/aalto/out/OutputElement;->_nsBinder:Lcom/fasterxml/aalto/out/NsBinder;

    invoke-virtual {v0, p1}, Lcom/fasterxml/aalto/out/NsBinder;->findUriByPrefix(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 424
    .local v0, "act":Ljava/lang/String;
    :goto_0
    if-nez v0, :cond_3

    if-eqz p3, :cond_3

    .line 425
    invoke-interface {p3, p1}, Ljavax/xml/namespace/NamespaceContext;->getNamespaceURI(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 428
    :cond_3
    if-eqz v0, :cond_5

    if-eq v0, p2, :cond_4

    invoke-virtual {v0, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_5

    :cond_4
    const/4 v1, 0x1

    goto :goto_1

    :cond_5
    const/4 v1, 0x0

    :goto_1
    return v1

    .line 413
    .end local v0    # "act":Ljava/lang/String;
    :cond_6
    :goto_2
    iget-object v0, p0, Lcom/fasterxml/aalto/out/OutputElement;->_defaultNsURI:Ljava/lang/String;

    invoke-virtual {v0, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    return v0
.end method

.method public isPrefixUnbound(Ljava/lang/String;Ljavax/xml/namespace/NamespaceContext;)Z
    .locals 3
    .param p1, "prefix"    # Ljava/lang/String;
    .param p2, "rootNsContext"    # Ljavax/xml/namespace/NamespaceContext;

    .line 434
    iget-object v0, p0, Lcom/fasterxml/aalto/out/OutputElement;->_nsBinder:Lcom/fasterxml/aalto/out/NsBinder;

    if-nez v0, :cond_0

    const/4 v0, 0x0

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/out/OutputElement;->_nsBinder:Lcom/fasterxml/aalto/out/NsBinder;

    invoke-virtual {v0, p1}, Lcom/fasterxml/aalto/out/NsBinder;->findUriByPrefix(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 435
    .local v0, "act":Ljava/lang/String;
    :goto_0
    const/4 v1, 0x0

    if-eqz v0, :cond_1

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v2

    if-eqz v2, :cond_1

    .line 436
    return v1

    .line 438
    :cond_1
    const-string/jumbo v2, "xml"

    invoke-virtual {p1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_2

    .line 439
    return v1

    .line 441
    :cond_2
    if-eqz p2, :cond_3

    .line 442
    invoke-interface {p2, p1}, Ljavax/xml/namespace/NamespaceContext;->getNamespaceURI(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 443
    if-eqz v0, :cond_3

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v2

    if-eqz v2, :cond_3

    .line 444
    return v1

    .line 448
    :cond_3
    const/4 v1, 0x1

    return v1
.end method

.method public isRoot()Z
    .locals 1

    .line 198
    iget-object v0, p0, Lcom/fasterxml/aalto/out/OutputElement;->_parent:Lcom/fasterxml/aalto/out/OutputElement;

    if-nez v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public relink(Lcom/fasterxml/aalto/out/OutputElement;)V
    .locals 1
    .param p1, "parent"    # Lcom/fasterxml/aalto/out/OutputElement;

    .line 159
    iput-object p1, p0, Lcom/fasterxml/aalto/out/OutputElement;->_parent:Lcom/fasterxml/aalto/out/OutputElement;

    .line 160
    iget-object v0, p1, Lcom/fasterxml/aalto/out/OutputElement;->_nsBinder:Lcom/fasterxml/aalto/out/NsBinder;

    iput-object v0, p0, Lcom/fasterxml/aalto/out/OutputElement;->_nsBinder:Lcom/fasterxml/aalto/out/NsBinder;

    .line 161
    iget-object v0, p1, Lcom/fasterxml/aalto/out/OutputElement;->_defaultNsURI:Ljava/lang/String;

    iput-object v0, p0, Lcom/fasterxml/aalto/out/OutputElement;->_defaultNsURI:Ljava/lang/String;

    .line 162
    return-void
.end method

.method protected reuseAsChild(Lcom/fasterxml/aalto/out/OutputElement;Lcom/fasterxml/aalto/out/WName;)Lcom/fasterxml/aalto/out/OutputElement;
    .locals 2
    .param p1, "parent"    # Lcom/fasterxml/aalto/out/OutputElement;
    .param p2, "name"    # Lcom/fasterxml/aalto/out/WName;

    .line 140
    iget-object v0, p0, Lcom/fasterxml/aalto/out/OutputElement;->_parent:Lcom/fasterxml/aalto/out/OutputElement;

    .line 141
    .local v0, "poolHead":Lcom/fasterxml/aalto/out/OutputElement;
    iget-object v1, p0, Lcom/fasterxml/aalto/out/OutputElement;->_defaultNsURI:Ljava/lang/String;

    invoke-direct {p0, p1, p2, v1}, Lcom/fasterxml/aalto/out/OutputElement;->relink(Lcom/fasterxml/aalto/out/OutputElement;Lcom/fasterxml/aalto/out/WName;Ljava/lang/String;)V

    .line 142
    return-object v0
.end method

.method protected reuseAsChild(Lcom/fasterxml/aalto/out/OutputElement;Lcom/fasterxml/aalto/out/WName;Ljava/lang/String;)Lcom/fasterxml/aalto/out/OutputElement;
    .locals 1
    .param p1, "parent"    # Lcom/fasterxml/aalto/out/OutputElement;
    .param p2, "name"    # Lcom/fasterxml/aalto/out/WName;
    .param p3, "nsURI"    # Ljava/lang/String;

    .line 147
    iget-object v0, p0, Lcom/fasterxml/aalto/out/OutputElement;->_parent:Lcom/fasterxml/aalto/out/OutputElement;

    .line 148
    .local v0, "poolHead":Lcom/fasterxml/aalto/out/OutputElement;
    invoke-direct {p0, p1, p2, p3}, Lcom/fasterxml/aalto/out/OutputElement;->relink(Lcom/fasterxml/aalto/out/OutputElement;Lcom/fasterxml/aalto/out/WName;Ljava/lang/String;)V

    .line 149
    return-object v0
.end method

.method public setDefaultNsURI(Ljava/lang/String;)V
    .locals 0
    .param p1, "uri"    # Ljava/lang/String;

    .line 247
    iput-object p1, p0, Lcom/fasterxml/aalto/out/OutputElement;->_defaultNsURI:Ljava/lang/String;

    .line 248
    return-void
.end method
