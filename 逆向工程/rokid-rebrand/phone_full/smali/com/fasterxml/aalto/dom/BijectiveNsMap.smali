.class public final Lcom/fasterxml/aalto/dom/BijectiveNsMap;
.super Ljava/lang/Object;
.source "BijectiveNsMap.java"


# static fields
.field static final DEFAULT_ARRAY_SIZE:I = 0x20


# instance fields
.field _nsStrings:[Ljava/lang/String;

.field _scopeEnd:I

.field final _scopeStart:I


# direct methods
.method private constructor <init>(I[Ljava/lang/String;)V
    .locals 0
    .param p1, "scopeStart"    # I
    .param p2, "strs"    # [Ljava/lang/String;

    .line 56
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 57
    iput p1, p0, Lcom/fasterxml/aalto/dom/BijectiveNsMap;->_scopeEnd:I

    iput p1, p0, Lcom/fasterxml/aalto/dom/BijectiveNsMap;->_scopeStart:I

    .line 58
    iput-object p2, p0, Lcom/fasterxml/aalto/dom/BijectiveNsMap;->_nsStrings:[Ljava/lang/String;

    .line 59
    return-void
.end method

.method public static createEmpty()Lcom/fasterxml/aalto/dom/BijectiveNsMap;
    .locals 3

    .line 63
    const/16 v0, 0x20

    new-array v0, v0, [Ljava/lang/String;

    .line 65
    .local v0, "strs":[Ljava/lang/String;
    const/4 v1, 0x0

    const-string/jumbo v2, "xml"

    aput-object v2, v0, v1

    .line 66
    const/4 v1, 0x1

    const-string v2, "http://www.w3.org/XML/1998/namespace"

    aput-object v2, v0, v1

    .line 67
    const/4 v1, 0x2

    const-string/jumbo v2, "xmlns"

    aput-object v2, v0, v1

    .line 68
    const/4 v1, 0x3

    const-string v2, "http://www.w3.org/2000/xmlns/"

    aput-object v2, v0, v1

    .line 73
    new-instance v1, Lcom/fasterxml/aalto/dom/BijectiveNsMap;

    const/4 v2, 0x4

    invoke-direct {v1, v2, v0}, Lcom/fasterxml/aalto/dom/BijectiveNsMap;-><init>(I[Ljava/lang/String;)V

    return-object v1
.end method


# virtual methods
.method public addGeneratedMapping(Ljava/lang/String;Ljavax/xml/namespace/NamespaceContext;Ljava/lang/String;[I)Ljava/lang/String;
    .locals 8
    .param p1, "prefixBase"    # Ljava/lang/String;
    .param p2, "ctxt"    # Ljavax/xml/namespace/NamespaceContext;
    .param p3, "uri"    # Ljava/lang/String;
    .param p4, "seqArr"    # [I

    .line 242
    iget-object v0, p0, Lcom/fasterxml/aalto/dom/BijectiveNsMap;->_nsStrings:[Ljava/lang/String;

    .line 243
    .local v0, "strs":[Ljava/lang/String;
    const/4 v1, 0x0

    aget v2, p4, v1

    .line 251
    .local v2, "seqNr":I
    :cond_0
    :goto_0
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->intern()Ljava/lang/String;

    move-result-object v3

    .line 252
    .local v3, "prefix":Ljava/lang/String;
    add-int/lit8 v2, v2, 0x1

    .line 259
    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v4

    .line 261
    .local v4, "phash":I
    iget v5, p0, Lcom/fasterxml/aalto/dom/BijectiveNsMap;->_scopeEnd:I

    add-int/lit8 v5, v5, -0x2

    .local v5, "ix":I
    :goto_1
    if-ltz v5, :cond_2

    .line 262
    aget-object v6, v0, v5

    .line 263
    .local v6, "thisP":Ljava/lang/String;
    if-eq v6, v3, :cond_0

    .line 264
    invoke-virtual {v6}, Ljava/lang/String;->hashCode()I

    move-result v7

    if-ne v7, v4, :cond_1

    invoke-virtual {v6, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v7

    if-eqz v7, :cond_1

    .line 265
    goto :goto_0

    .line 261
    .end local v6    # "thisP":Ljava/lang/String;
    :cond_1
    add-int/lit8 v5, v5, -0x2

    goto :goto_1

    .line 272
    .end local v5    # "ix":I
    :cond_2
    if-eqz p2, :cond_3

    invoke-interface {p2, v3}, Ljavax/xml/namespace/NamespaceContext;->getNamespaceURI(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    if-eqz v5, :cond_3

    .line 273
    goto :goto_0

    .line 277
    .end local v4    # "phash":I
    :cond_3
    aput v2, p4, v1

    .line 280
    iget v1, p0, Lcom/fasterxml/aalto/dom/BijectiveNsMap;->_scopeEnd:I

    array-length v4, v0

    if-lt v1, v4, :cond_4

    .line 282
    array-length v1, v0

    shl-int/lit8 v1, v1, 0x1

    invoke-static {v0, v1}, Ljava/util/Arrays;->copyOf([Ljava/lang/Object;I)[Ljava/lang/Object;

    move-result-object v1

    move-object v0, v1

    check-cast v0, [Ljava/lang/String;

    .line 283
    iput-object v0, p0, Lcom/fasterxml/aalto/dom/BijectiveNsMap;->_nsStrings:[Ljava/lang/String;

    .line 285
    :cond_4
    iget v1, p0, Lcom/fasterxml/aalto/dom/BijectiveNsMap;->_scopeEnd:I

    add-int/lit8 v4, v1, 0x1

    iput v4, p0, Lcom/fasterxml/aalto/dom/BijectiveNsMap;->_scopeEnd:I

    aput-object v3, v0, v1

    .line 286
    iget v1, p0, Lcom/fasterxml/aalto/dom/BijectiveNsMap;->_scopeEnd:I

    add-int/lit8 v4, v1, 0x1

    iput v4, p0, Lcom/fasterxml/aalto/dom/BijectiveNsMap;->_scopeEnd:I

    aput-object p3, v0, v1

    .line 288
    return-object v3
.end method

.method public addMapping(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 7
    .param p1, "prefix"    # Ljava/lang/String;
    .param p2, "uri"    # Ljava/lang/String;

    .line 210
    iget-object v0, p0, Lcom/fasterxml/aalto/dom/BijectiveNsMap;->_nsStrings:[Ljava/lang/String;

    .line 211
    .local v0, "strs":[Ljava/lang/String;
    invoke-virtual {p1}, Ljava/lang/String;->hashCode()I

    move-result v1

    .line 213
    .local v1, "phash":I
    iget v2, p0, Lcom/fasterxml/aalto/dom/BijectiveNsMap;->_scopeStart:I

    .local v2, "ix":I
    iget v3, p0, Lcom/fasterxml/aalto/dom/BijectiveNsMap;->_scopeEnd:I

    .local v3, "end":I
    :goto_0
    if-ge v2, v3, :cond_2

    .line 214
    aget-object v4, v0, v2

    .line 215
    .local v4, "thisP":Ljava/lang/String;
    if-eq v4, p1, :cond_1

    .line 216
    invoke-virtual {v4}, Ljava/lang/String;->hashCode()I

    move-result v5

    if-ne v5, v1, :cond_0

    invoke-virtual {v4, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_0

    goto :goto_1

    .line 213
    .end local v4    # "thisP":Ljava/lang/String;
    :cond_0
    add-int/lit8 v2, v2, 0x2

    goto :goto_0

    .line 218
    .restart local v4    # "thisP":Ljava/lang/String;
    :cond_1
    :goto_1
    add-int/lit8 v5, v2, 0x1

    aget-object v5, v0, v5

    .line 219
    .local v5, "old":Ljava/lang/String;
    add-int/lit8 v6, v2, 0x1

    aput-object p2, v0, v6

    .line 220
    return-object v5

    .line 224
    .end local v2    # "ix":I
    .end local v3    # "end":I
    .end local v4    # "thisP":Ljava/lang/String;
    .end local v5    # "old":Ljava/lang/String;
    :cond_2
    iget v2, p0, Lcom/fasterxml/aalto/dom/BijectiveNsMap;->_scopeEnd:I

    array-length v3, v0

    if-lt v2, v3, :cond_3

    .line 226
    array-length v2, v0

    shl-int/lit8 v2, v2, 0x1

    invoke-static {v0, v2}, Ljava/util/Arrays;->copyOf([Ljava/lang/Object;I)[Ljava/lang/Object;

    move-result-object v2

    move-object v0, v2

    check-cast v0, [Ljava/lang/String;

    .line 227
    iput-object v0, p0, Lcom/fasterxml/aalto/dom/BijectiveNsMap;->_nsStrings:[Ljava/lang/String;

    .line 229
    :cond_3
    iget v2, p0, Lcom/fasterxml/aalto/dom/BijectiveNsMap;->_scopeEnd:I

    add-int/lit8 v3, v2, 0x1

    iput v3, p0, Lcom/fasterxml/aalto/dom/BijectiveNsMap;->_scopeEnd:I

    aput-object p1, v0, v2

    .line 230
    iget v2, p0, Lcom/fasterxml/aalto/dom/BijectiveNsMap;->_scopeEnd:I

    add-int/lit8 v3, v2, 0x1

    iput v3, p0, Lcom/fasterxml/aalto/dom/BijectiveNsMap;->_scopeEnd:I

    aput-object p2, v0, v2

    .line 232
    const/4 v2, 0x0

    return-object v2
.end method

.method public createChild()Lcom/fasterxml/aalto/dom/BijectiveNsMap;
    .locals 3

    .line 77
    new-instance v0, Lcom/fasterxml/aalto/dom/BijectiveNsMap;

    iget v1, p0, Lcom/fasterxml/aalto/dom/BijectiveNsMap;->_scopeEnd:I

    iget-object v2, p0, Lcom/fasterxml/aalto/dom/BijectiveNsMap;->_nsStrings:[Ljava/lang/String;

    invoke-direct {v0, v1, v2}, Lcom/fasterxml/aalto/dom/BijectiveNsMap;-><init>(I[Ljava/lang/String;)V

    return-object v0
.end method

.method public findPrefixByUri(Ljava/lang/String;)Ljava/lang/String;
    .locals 10
    .param p1, "uri"    # Ljava/lang/String;

    .line 113
    iget-object v0, p0, Lcom/fasterxml/aalto/dom/BijectiveNsMap;->_nsStrings:[Ljava/lang/String;

    .line 114
    .local v0, "strs":[Ljava/lang/String;
    invoke-virtual {p1}, Ljava/lang/String;->hashCode()I

    move-result v1

    .line 117
    .local v1, "uhash":I
    iget v2, p0, Lcom/fasterxml/aalto/dom/BijectiveNsMap;->_scopeEnd:I

    add-int/lit8 v2, v2, -0x1

    .local v2, "ix":I
    :goto_0
    if-lez v2, :cond_4

    .line 118
    aget-object v3, v0, v2

    .line 119
    .local v3, "thisU":Ljava/lang/String;
    if-eq v3, p1, :cond_0

    .line 120
    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v4

    if-ne v4, v1, :cond_2

    invoke-virtual {v3, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_2

    .line 122
    :cond_0
    add-int/lit8 v4, v2, -0x1

    aget-object v4, v0, v4

    .line 126
    .local v4, "prefix":Ljava/lang/String;
    iget v5, p0, Lcom/fasterxml/aalto/dom/BijectiveNsMap;->_scopeStart:I

    if-ge v2, v5, :cond_3

    .line 127
    invoke-virtual {v4}, Ljava/lang/String;->hashCode()I

    move-result v5

    .line 128
    .local v5, "phash":I
    add-int/lit8 v6, v2, -0x1

    .local v6, "j":I
    iget v7, p0, Lcom/fasterxml/aalto/dom/BijectiveNsMap;->_scopeEnd:I

    .local v7, "end":I
    :goto_1
    if-ge v6, v7, :cond_3

    .line 129
    aget-object v8, v0, v2

    .line 130
    .local v8, "thisP":Ljava/lang/String;
    if-eq v8, v4, :cond_2

    .line 131
    invoke-virtual {v8}, Ljava/lang/String;->hashCode()I

    move-result v9

    if-ne v9, v5, :cond_1

    invoke-virtual {v8, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v9

    if-eqz v9, :cond_1

    .line 133
    goto :goto_2

    .line 128
    .end local v8    # "thisP":Ljava/lang/String;
    :cond_1
    add-int/lit8 v6, v6, 0x2

    goto :goto_1

    .line 117
    .end local v3    # "thisU":Ljava/lang/String;
    .end local v4    # "prefix":Ljava/lang/String;
    .end local v5    # "phash":I
    .end local v6    # "j":I
    .end local v7    # "end":I
    :cond_2
    :goto_2
    add-int/lit8 v2, v2, -0x2

    goto :goto_0

    .line 138
    .restart local v3    # "thisU":Ljava/lang/String;
    .restart local v4    # "prefix":Ljava/lang/String;
    :cond_3
    return-object v4

    .line 141
    .end local v2    # "ix":I
    .end local v3    # "thisU":Ljava/lang/String;
    .end local v4    # "prefix":Ljava/lang/String;
    :cond_4
    const/4 v2, 0x0

    return-object v2
.end method

.method public findUriByPrefix(Ljava/lang/String;)Ljava/lang/String;
    .locals 5
    .param p1, "prefix"    # Ljava/lang/String;

    .line 91
    iget-object v0, p0, Lcom/fasterxml/aalto/dom/BijectiveNsMap;->_nsStrings:[Ljava/lang/String;

    .line 92
    .local v0, "strs":[Ljava/lang/String;
    invoke-virtual {p1}, Ljava/lang/String;->hashCode()I

    move-result v1

    .line 94
    .local v1, "phash":I
    iget v2, p0, Lcom/fasterxml/aalto/dom/BijectiveNsMap;->_scopeEnd:I

    add-int/lit8 v2, v2, -0x2

    .local v2, "ix":I
    :goto_0
    if-ltz v2, :cond_2

    .line 95
    aget-object v3, v0, v2

    .line 96
    .local v3, "thisP":Ljava/lang/String;
    if-eq v3, p1, :cond_1

    .line 97
    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v4

    if-ne v4, v1, :cond_0

    invoke-virtual {v3, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_0

    goto :goto_1

    .line 94
    .end local v3    # "thisP":Ljava/lang/String;
    :cond_0
    add-int/lit8 v2, v2, -0x2

    goto :goto_0

    .line 98
    .restart local v3    # "thisP":Ljava/lang/String;
    :cond_1
    :goto_1
    add-int/lit8 v4, v2, 0x1

    aget-object v4, v0, v4

    return-object v4

    .line 101
    .end local v2    # "ix":I
    .end local v3    # "thisP":Ljava/lang/String;
    :cond_2
    const/4 v2, 0x0

    return-object v2
.end method

.method public getPrefixesBoundToUri(Ljava/lang/String;Ljava/util/List;)Ljava/util/List;
    .locals 10
    .param p1, "uri"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;)",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .line 149
    .local p2, "l":Ljava/util/List;, "Ljava/util/List<Ljava/lang/String;>;"
    iget-object v0, p0, Lcom/fasterxml/aalto/dom/BijectiveNsMap;->_nsStrings:[Ljava/lang/String;

    .line 150
    .local v0, "strs":[Ljava/lang/String;
    invoke-virtual {p1}, Ljava/lang/String;->hashCode()I

    move-result v1

    .line 153
    .local v1, "uhash":I
    iget v2, p0, Lcom/fasterxml/aalto/dom/BijectiveNsMap;->_scopeEnd:I

    add-int/lit8 v2, v2, -0x1

    .local v2, "ix":I
    :goto_0
    if-lez v2, :cond_5

    .line 154
    aget-object v3, v0, v2

    .line 155
    .local v3, "thisU":Ljava/lang/String;
    if-eq v3, p1, :cond_0

    .line 156
    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v4

    if-ne v4, v1, :cond_4

    invoke-virtual {v3, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_4

    .line 158
    :cond_0
    add-int/lit8 v4, v2, -0x1

    aget-object v4, v0, v4

    .line 162
    .local v4, "prefix":Ljava/lang/String;
    iget v5, p0, Lcom/fasterxml/aalto/dom/BijectiveNsMap;->_scopeStart:I

    if-ge v2, v5, :cond_2

    .line 163
    invoke-virtual {v4}, Ljava/lang/String;->hashCode()I

    move-result v5

    .line 164
    .local v5, "phash":I
    add-int/lit8 v6, v2, -0x1

    .local v6, "j":I
    iget v7, p0, Lcom/fasterxml/aalto/dom/BijectiveNsMap;->_scopeEnd:I

    .local v7, "end":I
    :goto_1
    if-ge v6, v7, :cond_2

    .line 165
    aget-object v8, v0, v2

    .line 166
    .local v8, "thisP":Ljava/lang/String;
    if-eq v8, v4, :cond_4

    .line 167
    invoke-virtual {v8}, Ljava/lang/String;->hashCode()I

    move-result v9

    if-ne v9, v5, :cond_1

    invoke-virtual {v8, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v9

    if-eqz v9, :cond_1

    .line 169
    goto :goto_2

    .line 164
    .end local v8    # "thisP":Ljava/lang/String;
    :cond_1
    add-int/lit8 v6, v6, 0x2

    goto :goto_1

    .line 174
    .end local v5    # "phash":I
    .end local v6    # "j":I
    .end local v7    # "end":I
    :cond_2
    if-nez p2, :cond_3

    .line 175
    new-instance v5, Ljava/util/ArrayList;

    invoke-direct {v5}, Ljava/util/ArrayList;-><init>()V

    move-object p2, v5

    .line 177
    :cond_3
    invoke-interface {p2, v4}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 153
    .end local v3    # "thisU":Ljava/lang/String;
    .end local v4    # "prefix":Ljava/lang/String;
    :cond_4
    :goto_2
    add-int/lit8 v2, v2, -0x2

    goto :goto_0

    .line 180
    .end local v2    # "ix":I
    :cond_5
    return-object p2
.end method

.method public localSize()I
    .locals 2

    .line 188
    iget v0, p0, Lcom/fasterxml/aalto/dom/BijectiveNsMap;->_scopeEnd:I

    iget v1, p0, Lcom/fasterxml/aalto/dom/BijectiveNsMap;->_scopeStart:I

    sub-int/2addr v0, v1

    shr-int/lit8 v0, v0, 0x1

    return v0
.end method

.method public size()I
    .locals 1

    .line 184
    iget v0, p0, Lcom/fasterxml/aalto/dom/BijectiveNsMap;->_scopeEnd:I

    shr-int/lit8 v0, v0, 0x1

    return v0
.end method
