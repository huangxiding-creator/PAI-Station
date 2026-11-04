.class public abstract Lcom/fasterxml/aalto/dom/OutputElementBase;
.super Ljava/lang/Object;
.source "OutputElementBase.java"

# interfaces
.implements Ljavax/xml/namespace/NamespaceContext;


# static fields
.field public static final PREFIX_MISBOUND:I = 0x2

.field public static final PREFIX_OK:I = 0x1

.field public static final PREFIX_UNBOUND:I


# instance fields
.field protected _defaultNsURI:Ljava/lang/String;

.field protected _nsMapShared:Z

.field protected _nsMapping:Lcom/fasterxml/aalto/dom/BijectiveNsMap;

.field protected _rootNsContext:Ljavax/xml/namespace/NamespaceContext;


# direct methods
.method protected constructor <init>()V
    .locals 2

    .line 67
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 68
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/fasterxml/aalto/dom/OutputElementBase;->_nsMapping:Lcom/fasterxml/aalto/dom/BijectiveNsMap;

    .line 69
    const/4 v1, 0x0

    iput-boolean v1, p0, Lcom/fasterxml/aalto/dom/OutputElementBase;->_nsMapShared:Z

    .line 70
    const-string v1, ""

    iput-object v1, p0, Lcom/fasterxml/aalto/dom/OutputElementBase;->_defaultNsURI:Ljava/lang/String;

    .line 71
    iput-object v0, p0, Lcom/fasterxml/aalto/dom/OutputElementBase;->_rootNsContext:Ljavax/xml/namespace/NamespaceContext;

    .line 72
    return-void
.end method

.method protected constructor <init>(Lcom/fasterxml/aalto/dom/OutputElementBase;Lcom/fasterxml/aalto/dom/BijectiveNsMap;)V
    .locals 1
    .param p1, "parent"    # Lcom/fasterxml/aalto/dom/OutputElementBase;
    .param p2, "ns"    # Lcom/fasterxml/aalto/dom/BijectiveNsMap;

    .line 75
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 76
    iput-object p2, p0, Lcom/fasterxml/aalto/dom/OutputElementBase;->_nsMapping:Lcom/fasterxml/aalto/dom/BijectiveNsMap;

    .line 77
    if-eqz p2, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    iput-boolean v0, p0, Lcom/fasterxml/aalto/dom/OutputElementBase;->_nsMapShared:Z

    .line 78
    iget-object v0, p1, Lcom/fasterxml/aalto/dom/OutputElementBase;->_defaultNsURI:Ljava/lang/String;

    iput-object v0, p0, Lcom/fasterxml/aalto/dom/OutputElementBase;->_defaultNsURI:Ljava/lang/String;

    .line 79
    iget-object v0, p1, Lcom/fasterxml/aalto/dom/OutputElementBase;->_rootNsContext:Ljavax/xml/namespace/NamespaceContext;

    iput-object v0, p0, Lcom/fasterxml/aalto/dom/OutputElementBase;->_rootNsContext:Ljavax/xml/namespace/NamespaceContext;

    .line 80
    return-void
.end method


# virtual methods
.method public final addPrefix(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1
    .param p1, "prefix"    # Ljava/lang/String;
    .param p2, "uri"    # Ljava/lang/String;

    .line 256
    iget-object v0, p0, Lcom/fasterxml/aalto/dom/OutputElementBase;->_nsMapping:Lcom/fasterxml/aalto/dom/BijectiveNsMap;

    if-nez v0, :cond_0

    .line 258
    invoke-static {}, Lcom/fasterxml/aalto/dom/BijectiveNsMap;->createEmpty()Lcom/fasterxml/aalto/dom/BijectiveNsMap;

    move-result-object v0

    iput-object v0, p0, Lcom/fasterxml/aalto/dom/OutputElementBase;->_nsMapping:Lcom/fasterxml/aalto/dom/BijectiveNsMap;

    goto :goto_0

    .line 259
    :cond_0
    iget-boolean v0, p0, Lcom/fasterxml/aalto/dom/OutputElementBase;->_nsMapShared:Z

    if-eqz v0, :cond_1

    .line 263
    iget-object v0, p0, Lcom/fasterxml/aalto/dom/OutputElementBase;->_nsMapping:Lcom/fasterxml/aalto/dom/BijectiveNsMap;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/dom/BijectiveNsMap;->createChild()Lcom/fasterxml/aalto/dom/BijectiveNsMap;

    move-result-object v0

    iput-object v0, p0, Lcom/fasterxml/aalto/dom/OutputElementBase;->_nsMapping:Lcom/fasterxml/aalto/dom/BijectiveNsMap;

    .line 264
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/fasterxml/aalto/dom/OutputElementBase;->_nsMapShared:Z

    .line 266
    :cond_1
    :goto_0
    iget-object v0, p0, Lcom/fasterxml/aalto/dom/OutputElementBase;->_nsMapping:Lcom/fasterxml/aalto/dom/BijectiveNsMap;

    invoke-virtual {v0, p1, p2}, Lcom/fasterxml/aalto/dom/BijectiveNsMap;->addMapping(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    .line 267
    return-void
.end method

.method public final generateMapping(Ljava/lang/String;Ljava/lang/String;[I)Ljava/lang/String;
    .locals 2
    .param p1, "prefixBase"    # Ljava/lang/String;
    .param p2, "uri"    # Ljava/lang/String;
    .param p3, "seqArr"    # [I

    .line 240
    iget-object v0, p0, Lcom/fasterxml/aalto/dom/OutputElementBase;->_nsMapping:Lcom/fasterxml/aalto/dom/BijectiveNsMap;

    if-nez v0, :cond_0

    .line 242
    invoke-static {}, Lcom/fasterxml/aalto/dom/BijectiveNsMap;->createEmpty()Lcom/fasterxml/aalto/dom/BijectiveNsMap;

    move-result-object v0

    iput-object v0, p0, Lcom/fasterxml/aalto/dom/OutputElementBase;->_nsMapping:Lcom/fasterxml/aalto/dom/BijectiveNsMap;

    goto :goto_0

    .line 243
    :cond_0
    iget-boolean v0, p0, Lcom/fasterxml/aalto/dom/OutputElementBase;->_nsMapShared:Z

    if-eqz v0, :cond_1

    .line 247
    iget-object v0, p0, Lcom/fasterxml/aalto/dom/OutputElementBase;->_nsMapping:Lcom/fasterxml/aalto/dom/BijectiveNsMap;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/dom/BijectiveNsMap;->createChild()Lcom/fasterxml/aalto/dom/BijectiveNsMap;

    move-result-object v0

    iput-object v0, p0, Lcom/fasterxml/aalto/dom/OutputElementBase;->_nsMapping:Lcom/fasterxml/aalto/dom/BijectiveNsMap;

    .line 248
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/fasterxml/aalto/dom/OutputElementBase;->_nsMapShared:Z

    .line 250
    :cond_1
    :goto_0
    iget-object v0, p0, Lcom/fasterxml/aalto/dom/OutputElementBase;->_nsMapping:Lcom/fasterxml/aalto/dom/BijectiveNsMap;

    iget-object v1, p0, Lcom/fasterxml/aalto/dom/OutputElementBase;->_rootNsContext:Ljavax/xml/namespace/NamespaceContext;

    invoke-virtual {v0, p1, v1, p2, p3}, Lcom/fasterxml/aalto/dom/BijectiveNsMap;->addGeneratedMapping(Ljava/lang/String;Ljavax/xml/namespace/NamespaceContext;Ljava/lang/String;[I)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public final getDefaultNsUri()Ljava/lang/String;
    .locals 1

    .line 111
    iget-object v0, p0, Lcom/fasterxml/aalto/dom/OutputElementBase;->_defaultNsURI:Ljava/lang/String;

    return-object v0
.end method

.method public final getExplicitPrefix(Ljava/lang/String;)Ljava/lang/String;
    .locals 2
    .param p1, "uri"    # Ljava/lang/String;

    .line 127
    iget-object v0, p0, Lcom/fasterxml/aalto/dom/OutputElementBase;->_nsMapping:Lcom/fasterxml/aalto/dom/BijectiveNsMap;

    if-eqz v0, :cond_0

    .line 128
    iget-object v0, p0, Lcom/fasterxml/aalto/dom/OutputElementBase;->_nsMapping:Lcom/fasterxml/aalto/dom/BijectiveNsMap;

    invoke-virtual {v0, p1}, Lcom/fasterxml/aalto/dom/BijectiveNsMap;->findPrefixByUri(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 129
    .local v0, "prefix":Ljava/lang/String;
    if-eqz v0, :cond_0

    .line 130
    return-object v0

    .line 133
    .end local v0    # "prefix":Ljava/lang/String;
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/dom/OutputElementBase;->_rootNsContext:Ljavax/xml/namespace/NamespaceContext;

    if-eqz v0, :cond_1

    .line 134
    iget-object v0, p0, Lcom/fasterxml/aalto/dom/OutputElementBase;->_rootNsContext:Ljavax/xml/namespace/NamespaceContext;

    invoke-interface {v0, p1}, Ljavax/xml/namespace/NamespaceContext;->getPrefix(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 135
    .restart local v0    # "prefix":Ljava/lang/String;
    if-eqz v0, :cond_1

    .line 137
    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v1

    if-lez v1, :cond_1

    .line 138
    return-object v0

    .line 143
    .end local v0    # "prefix":Ljava/lang/String;
    :cond_1
    const/4 v0, 0x0

    return-object v0
.end method

.method public abstract getNameDesc()Ljava/lang/String;
.end method

.method public final getNamespaceURI(Ljava/lang/String;)Ljava/lang/String;
    .locals 1
    .param p1, "prefix"    # Ljava/lang/String;

    .line 278
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    if-nez v0, :cond_0

    .line 279
    iget-object v0, p0, Lcom/fasterxml/aalto/dom/OutputElementBase;->_defaultNsURI:Ljava/lang/String;

    return-object v0

    .line 281
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/dom/OutputElementBase;->_nsMapping:Lcom/fasterxml/aalto/dom/BijectiveNsMap;

    if-eqz v0, :cond_1

    .line 282
    iget-object v0, p0, Lcom/fasterxml/aalto/dom/OutputElementBase;->_nsMapping:Lcom/fasterxml/aalto/dom/BijectiveNsMap;

    invoke-virtual {v0, p1}, Lcom/fasterxml/aalto/dom/BijectiveNsMap;->findUriByPrefix(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 283
    .local v0, "uri":Ljava/lang/String;
    if-eqz v0, :cond_1

    .line 284
    return-object v0

    .line 287
    .end local v0    # "uri":Ljava/lang/String;
    :cond_1
    iget-object v0, p0, Lcom/fasterxml/aalto/dom/OutputElementBase;->_rootNsContext:Ljavax/xml/namespace/NamespaceContext;

    if-eqz v0, :cond_2

    iget-object v0, p0, Lcom/fasterxml/aalto/dom/OutputElementBase;->_rootNsContext:Ljavax/xml/namespace/NamespaceContext;

    .line 288
    invoke-interface {v0, p1}, Ljavax/xml/namespace/NamespaceContext;->getNamespaceURI(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    :cond_2
    const/4 v0, 0x0

    .line 287
    :goto_0
    return-object v0
.end method

.method public final getPrefix(Ljava/lang/String;)Ljava/lang/String;
    .locals 1
    .param p1, "uri"    # Ljava/lang/String;

    .line 294
    iget-object v0, p0, Lcom/fasterxml/aalto/dom/OutputElementBase;->_defaultNsURI:Ljava/lang/String;

    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 295
    const-string v0, ""

    return-object v0

    .line 297
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/dom/OutputElementBase;->_nsMapping:Lcom/fasterxml/aalto/dom/BijectiveNsMap;

    if-eqz v0, :cond_1

    .line 298
    iget-object v0, p0, Lcom/fasterxml/aalto/dom/OutputElementBase;->_nsMapping:Lcom/fasterxml/aalto/dom/BijectiveNsMap;

    invoke-virtual {v0, p1}, Lcom/fasterxml/aalto/dom/BijectiveNsMap;->findPrefixByUri(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 299
    .local v0, "prefix":Ljava/lang/String;
    if-eqz v0, :cond_1

    .line 300
    return-object v0

    .line 303
    .end local v0    # "prefix":Ljava/lang/String;
    :cond_1
    iget-object v0, p0, Lcom/fasterxml/aalto/dom/OutputElementBase;->_rootNsContext:Ljavax/xml/namespace/NamespaceContext;

    if-eqz v0, :cond_2

    iget-object v0, p0, Lcom/fasterxml/aalto/dom/OutputElementBase;->_rootNsContext:Ljavax/xml/namespace/NamespaceContext;

    .line 304
    invoke-interface {v0, p1}, Ljavax/xml/namespace/NamespaceContext;->getPrefix(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    :cond_2
    const/4 v0, 0x0

    .line 303
    :goto_0
    return-object v0
.end method

.method public final getPrefixes(Ljava/lang/String;)Ljava/util/Iterator;
    .locals 4
    .param p1, "uri"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
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
    iget-object v1, p0, Lcom/fasterxml/aalto/dom/OutputElementBase;->_defaultNsURI:Ljava/lang/String;

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
    iget-object v1, p0, Lcom/fasterxml/aalto/dom/OutputElementBase;->_nsMapping:Lcom/fasterxml/aalto/dom/BijectiveNsMap;

    if-eqz v1, :cond_1

    .line 318
    iget-object v1, p0, Lcom/fasterxml/aalto/dom/OutputElementBase;->_nsMapping:Lcom/fasterxml/aalto/dom/BijectiveNsMap;

    invoke-virtual {v1, p1, v0}, Lcom/fasterxml/aalto/dom/BijectiveNsMap;->getPrefixesBoundToUri(Ljava/lang/String;Ljava/util/List;)Ljava/util/List;

    move-result-object v0

    .line 325
    :cond_1
    iget-object v1, p0, Lcom/fasterxml/aalto/dom/OutputElementBase;->_rootNsContext:Ljavax/xml/namespace/NamespaceContext;

    if-eqz v1, :cond_5

    .line 326
    iget-object v1, p0, Lcom/fasterxml/aalto/dom/OutputElementBase;->_rootNsContext:Ljavax/xml/namespace/NamespaceContext;

    invoke-interface {v1, p1}, Ljavax/xml/namespace/NamespaceContext;->getPrefixes(Ljava/lang/String;)Ljava/util/Iterator;

    move-result-object v1

    .line 327
    .local v1, "it":Ljava/util/Iterator;, "Ljava/util/Iterator<Ljava/lang/String;>;"
    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_5

    .line 328
    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    .line 329
    .local v2, "prefix":Ljava/lang/String;
    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v3

    if-nez v3, :cond_2

    .line 330
    goto :goto_0

    .line 333
    :cond_2
    if-nez v0, :cond_3

    .line 334
    new-instance v3, Ljava/util/ArrayList;

    invoke-direct {v3}, Ljava/util/ArrayList;-><init>()V

    move-object v0, v3

    goto :goto_1

    .line 335
    :cond_3
    invoke-interface {v0, v2}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_4

    .line 336
    goto :goto_0

    .line 338
    :cond_4
    :goto_1
    invoke-interface {v0, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 339
    .end local v2    # "prefix":Ljava/lang/String;
    goto :goto_0

    .line 341
    .end local v1    # "it":Ljava/util/Iterator;, "Ljava/util/Iterator<Ljava/lang/String;>;"
    :cond_5
    if-nez v0, :cond_6

    .line 342
    invoke-static {}, Lorg/codehaus/stax2/ri/EmptyIterator;->getInstance()Ljava/util/Iterator;

    move-result-object v1

    return-object v1

    .line 344
    :cond_6
    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    return-object v1
.end method

.method public final isPrefixValid(Ljava/lang/String;Ljava/lang/String;Z)I
    .locals 4
    .param p1, "prefix"    # Ljava/lang/String;
    .param p2, "nsURI"    # Ljava/lang/String;
    .param p3, "isElement"    # Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 168
    if-nez p2, :cond_0

    .line 169
    const-string p2, ""

    .line 177
    :cond_0
    const/4 v0, 0x2

    const/4 v1, 0x1

    if-eqz p1, :cond_9

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v2

    if-nez v2, :cond_1

    goto :goto_1

    .line 197
    :cond_1
    const-string/jumbo v2, "xml"

    invoke-virtual {v2, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_3

    .line 200
    const-string v0, "http://www.w3.org/XML/1998/namespace"

    invoke-virtual {p2, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_2

    .line 201
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Namespace prefix \'xml\' can not be bound to non-default namespace (\'"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "\'); has to be the default \'"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v2, "\'"

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/dom/OutputElementBase;->throwOutputError(Ljava/lang/String;)V

    .line 204
    :cond_2
    return v1

    .line 210
    :cond_3
    iget-object v2, p0, Lcom/fasterxml/aalto/dom/OutputElementBase;->_nsMapping:Lcom/fasterxml/aalto/dom/BijectiveNsMap;

    if-eqz v2, :cond_4

    .line 211
    iget-object v2, p0, Lcom/fasterxml/aalto/dom/OutputElementBase;->_nsMapping:Lcom/fasterxml/aalto/dom/BijectiveNsMap;

    invoke-virtual {v2, p1}, Lcom/fasterxml/aalto/dom/BijectiveNsMap;->findUriByPrefix(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .local v2, "act":Ljava/lang/String;
    goto :goto_0

    .line 213
    .end local v2    # "act":Ljava/lang/String;
    :cond_4
    const/4 v2, 0x0

    .line 216
    .restart local v2    # "act":Ljava/lang/String;
    :goto_0
    if-nez v2, :cond_5

    iget-object v3, p0, Lcom/fasterxml/aalto/dom/OutputElementBase;->_rootNsContext:Ljavax/xml/namespace/NamespaceContext;

    if-eqz v3, :cond_5

    .line 217
    iget-object v3, p0, Lcom/fasterxml/aalto/dom/OutputElementBase;->_rootNsContext:Ljavax/xml/namespace/NamespaceContext;

    invoke-interface {v3, p1}, Ljavax/xml/namespace/NamespaceContext;->getNamespaceURI(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 221
    :cond_5
    if-nez v2, :cond_6

    .line 222
    const/4 v0, 0x0

    return v0

    .line 225
    :cond_6
    if-eq v2, p2, :cond_7

    invoke-virtual {v2, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_8

    :cond_7
    move v0, v1

    :cond_8
    return v0

    .line 178
    .end local v2    # "act":Ljava/lang/String;
    :cond_9
    :goto_1
    if-eqz p3, :cond_b

    .line 180
    iget-object v2, p0, Lcom/fasterxml/aalto/dom/OutputElementBase;->_defaultNsURI:Ljava/lang/String;

    if-eq p2, v2, :cond_a

    iget-object v2, p0, Lcom/fasterxml/aalto/dom/OutputElementBase;->_defaultNsURI:Ljava/lang/String;

    invoke-virtual {p2, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_c

    .line 181
    :cond_a
    return v1

    .line 187
    :cond_b
    invoke-virtual {p2}, Ljava/lang/String;->length()I

    move-result v2

    if-nez v2, :cond_c

    .line 188
    return v1

    .line 191
    :cond_c
    return v0
.end method

.method public abstract isRoot()Z
.end method

.method protected relink(Lcom/fasterxml/aalto/dom/OutputElementBase;)V
    .locals 1
    .param p1, "parent"    # Lcom/fasterxml/aalto/dom/OutputElementBase;

    .line 87
    iget-object v0, p1, Lcom/fasterxml/aalto/dom/OutputElementBase;->_nsMapping:Lcom/fasterxml/aalto/dom/BijectiveNsMap;

    iput-object v0, p0, Lcom/fasterxml/aalto/dom/OutputElementBase;->_nsMapping:Lcom/fasterxml/aalto/dom/BijectiveNsMap;

    .line 88
    iget-object v0, p0, Lcom/fasterxml/aalto/dom/OutputElementBase;->_nsMapping:Lcom/fasterxml/aalto/dom/BijectiveNsMap;

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    iput-boolean v0, p0, Lcom/fasterxml/aalto/dom/OutputElementBase;->_nsMapShared:Z

    .line 89
    iget-object v0, p1, Lcom/fasterxml/aalto/dom/OutputElementBase;->_defaultNsURI:Ljava/lang/String;

    iput-object v0, p0, Lcom/fasterxml/aalto/dom/OutputElementBase;->_defaultNsURI:Ljava/lang/String;

    .line 90
    iget-object v0, p1, Lcom/fasterxml/aalto/dom/OutputElementBase;->_rootNsContext:Ljavax/xml/namespace/NamespaceContext;

    iput-object v0, p0, Lcom/fasterxml/aalto/dom/OutputElementBase;->_rootNsContext:Ljavax/xml/namespace/NamespaceContext;

    .line 91
    return-void
.end method

.method public abstract setDefaultNsUri(Ljava/lang/String;)V
.end method

.method protected abstract setRootNsContext(Ljavax/xml/namespace/NamespaceContext;)V
.end method

.method protected final throwOutputError(Ljava/lang/String;)V
    .locals 1
    .param p1, "msg"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 356
    new-instance v0, Ljavax/xml/stream/XMLStreamException;

    invoke-direct {v0, p1}, Ljavax/xml/stream/XMLStreamException;-><init>(Ljava/lang/String;)V

    throw v0
.end method
