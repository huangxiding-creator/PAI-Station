.class final Lcom/fasterxml/aalto/out/NsBinder;
.super Ljava/lang/Object;
.source "NsBinder.java"


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

    .line 68
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 69
    iput p1, p0, Lcom/fasterxml/aalto/out/NsBinder;->_scopeEnd:I

    iput p1, p0, Lcom/fasterxml/aalto/out/NsBinder;->_scopeStart:I

    .line 70
    iput-object p2, p0, Lcom/fasterxml/aalto/out/NsBinder;->_nsStrings:[Ljava/lang/String;

    .line 71
    return-void
.end method

.method public static createEmpty()Lcom/fasterxml/aalto/out/NsBinder;
    .locals 3

    .line 75
    const/16 v0, 0x20

    new-array v0, v0, [Ljava/lang/String;

    .line 77
    .local v0, "strs":[Ljava/lang/String;
    const/4 v1, 0x0

    const-string/jumbo v2, "xml"

    aput-object v2, v0, v1

    .line 78
    const/4 v1, 0x1

    const-string v2, "http://www.w3.org/XML/1998/namespace"

    aput-object v2, v0, v1

    .line 79
    const/4 v1, 0x2

    const-string/jumbo v2, "xmlns"

    aput-object v2, v0, v1

    .line 80
    const/4 v1, 0x3

    const-string v2, "http://www.w3.org/2000/xmlns/"

    aput-object v2, v0, v1

    .line 85
    new-instance v1, Lcom/fasterxml/aalto/out/NsBinder;

    const/4 v2, 0x4

    invoke-direct {v1, v2, v0}, Lcom/fasterxml/aalto/out/NsBinder;-><init>(I[Ljava/lang/String;)V

    return-object v1
.end method


# virtual methods
.method addMapping(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 7
    .param p1, "prefix"    # Ljava/lang/String;
    .param p2, "uri"    # Ljava/lang/String;

    .line 215
    iget-object v0, p0, Lcom/fasterxml/aalto/out/NsBinder;->_nsStrings:[Ljava/lang/String;

    .line 216
    .local v0, "strs":[Ljava/lang/String;
    invoke-virtual {p1}, Ljava/lang/String;->hashCode()I

    move-result v1

    .line 218
    .local v1, "phash":I
    iget v2, p0, Lcom/fasterxml/aalto/out/NsBinder;->_scopeStart:I

    .local v2, "ix":I
    iget v3, p0, Lcom/fasterxml/aalto/out/NsBinder;->_scopeEnd:I

    .local v3, "end":I
    :goto_0
    if-ge v2, v3, :cond_2

    .line 219
    aget-object v4, v0, v2

    .line 220
    .local v4, "thisP":Ljava/lang/String;
    if-eq v4, p1, :cond_1

    .line 221
    invoke-virtual {v4}, Ljava/lang/String;->hashCode()I

    move-result v5

    if-ne v5, v1, :cond_0

    invoke-virtual {v4, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_0

    goto :goto_1

    .line 218
    .end local v4    # "thisP":Ljava/lang/String;
    :cond_0
    add-int/lit8 v2, v2, 0x2

    goto :goto_0

    .line 223
    .restart local v4    # "thisP":Ljava/lang/String;
    :cond_1
    :goto_1
    add-int/lit8 v5, v2, 0x1

    aget-object v5, v0, v5

    .line 224
    .local v5, "old":Ljava/lang/String;
    add-int/lit8 v6, v2, 0x1

    aput-object p2, v0, v6

    .line 225
    return-object v5

    .line 229
    .end local v2    # "ix":I
    .end local v3    # "end":I
    .end local v4    # "thisP":Ljava/lang/String;
    .end local v5    # "old":Ljava/lang/String;
    :cond_2
    iget v2, p0, Lcom/fasterxml/aalto/out/NsBinder;->_scopeEnd:I

    array-length v3, v0

    if-lt v2, v3, :cond_3

    .line 230
    array-length v2, v0

    shl-int/lit8 v2, v2, 0x1

    invoke-static {v0, v2}, Ljava/util/Arrays;->copyOf([Ljava/lang/Object;I)[Ljava/lang/Object;

    move-result-object v2

    move-object v0, v2

    check-cast v0, [Ljava/lang/String;

    .line 231
    iput-object v0, p0, Lcom/fasterxml/aalto/out/NsBinder;->_nsStrings:[Ljava/lang/String;

    .line 233
    :cond_3
    iget v2, p0, Lcom/fasterxml/aalto/out/NsBinder;->_scopeEnd:I

    add-int/lit8 v3, v2, 0x1

    iput v3, p0, Lcom/fasterxml/aalto/out/NsBinder;->_scopeEnd:I

    aput-object p1, v0, v2

    .line 234
    iget v2, p0, Lcom/fasterxml/aalto/out/NsBinder;->_scopeEnd:I

    add-int/lit8 v3, v2, 0x1

    iput v3, p0, Lcom/fasterxml/aalto/out/NsBinder;->_scopeEnd:I

    aput-object p2, v0, v2

    .line 236
    const/4 v2, 0x0

    return-object v2
.end method

.method public createChild()Lcom/fasterxml/aalto/out/NsBinder;
    .locals 3

    .line 89
    new-instance v0, Lcom/fasterxml/aalto/out/NsBinder;

    iget v1, p0, Lcom/fasterxml/aalto/out/NsBinder;->_scopeEnd:I

    iget-object v2, p0, Lcom/fasterxml/aalto/out/NsBinder;->_nsStrings:[Ljava/lang/String;

    invoke-direct {v0, v1, v2}, Lcom/fasterxml/aalto/out/NsBinder;-><init>(I[Ljava/lang/String;)V

    return-object v0
.end method

.method public findPrefixByUri(Ljava/lang/String;)Ljava/lang/String;
    .locals 10
    .param p1, "uri"    # Ljava/lang/String;

    .line 125
    iget-object v0, p0, Lcom/fasterxml/aalto/out/NsBinder;->_nsStrings:[Ljava/lang/String;

    .line 126
    .local v0, "strs":[Ljava/lang/String;
    invoke-virtual {p1}, Ljava/lang/String;->hashCode()I

    move-result v1

    .line 129
    .local v1, "uhash":I
    iget v2, p0, Lcom/fasterxml/aalto/out/NsBinder;->_scopeEnd:I

    add-int/lit8 v2, v2, -0x1

    .local v2, "ix":I
    :goto_0
    if-lez v2, :cond_4

    .line 130
    aget-object v3, v0, v2

    .line 131
    .local v3, "thisU":Ljava/lang/String;
    if-eq v3, p1, :cond_0

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v4

    if-ne v4, v1, :cond_2

    invoke-virtual {v3, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_2

    .line 133
    :cond_0
    add-int/lit8 v4, v2, -0x1

    aget-object v4, v0, v4

    .line 137
    .local v4, "prefix":Ljava/lang/String;
    iget v5, p0, Lcom/fasterxml/aalto/out/NsBinder;->_scopeStart:I

    if-ge v2, v5, :cond_3

    .line 138
    invoke-virtual {v4}, Ljava/lang/String;->hashCode()I

    move-result v5

    .line 139
    .local v5, "phash":I
    add-int/lit8 v6, v2, -0x1

    .local v6, "j":I
    iget v7, p0, Lcom/fasterxml/aalto/out/NsBinder;->_scopeEnd:I

    .local v7, "end":I
    :goto_1
    if-ge v6, v7, :cond_3

    .line 140
    aget-object v8, v0, v2

    .line 141
    .local v8, "thisP":Ljava/lang/String;
    if-eq v8, v4, :cond_2

    .line 142
    invoke-virtual {v8}, Ljava/lang/String;->hashCode()I

    move-result v9

    if-ne v9, v5, :cond_1

    invoke-virtual {v8, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v9

    if-eqz v9, :cond_1

    .line 144
    goto :goto_2

    .line 139
    .end local v8    # "thisP":Ljava/lang/String;
    :cond_1
    add-int/lit8 v6, v6, 0x2

    goto :goto_1

    .line 129
    .end local v3    # "thisU":Ljava/lang/String;
    .end local v4    # "prefix":Ljava/lang/String;
    .end local v5    # "phash":I
    .end local v6    # "j":I
    .end local v7    # "end":I
    :cond_2
    :goto_2
    add-int/lit8 v2, v2, -0x2

    goto :goto_0

    .line 148
    .restart local v3    # "thisU":Ljava/lang/String;
    .restart local v4    # "prefix":Ljava/lang/String;
    :cond_3
    return-object v4

    .line 151
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

    .line 103
    iget-object v0, p0, Lcom/fasterxml/aalto/out/NsBinder;->_nsStrings:[Ljava/lang/String;

    .line 105
    .local v0, "strs":[Ljava/lang/String;
    invoke-virtual {p1}, Ljava/lang/String;->hashCode()I

    move-result v1

    .line 107
    .local v1, "phash":I
    iget v2, p0, Lcom/fasterxml/aalto/out/NsBinder;->_scopeEnd:I

    add-int/lit8 v2, v2, -0x2

    .local v2, "ix":I
    :goto_0
    if-ltz v2, :cond_2

    .line 108
    aget-object v3, v0, v2

    .line 109
    .local v3, "thisP":Ljava/lang/String;
    if-eq v3, p1, :cond_1

    .line 110
    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v4

    if-ne v4, v1, :cond_0

    invoke-virtual {v3, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_0

    goto :goto_1

    .line 107
    .end local v3    # "thisP":Ljava/lang/String;
    :cond_0
    add-int/lit8 v2, v2, -0x2

    goto :goto_0

    .line 111
    .restart local v3    # "thisP":Ljava/lang/String;
    :cond_1
    :goto_1
    add-int/lit8 v4, v2, 0x1

    aget-object v4, v0, v4

    return-object v4

    .line 114
    .end local v2    # "ix":I
    .end local v3    # "thisP":Ljava/lang/String;
    :cond_2
    const/4 v2, 0x0

    return-object v2
.end method

.method generatePrefix(Ljava/lang/String;Ljavax/xml/namespace/NamespaceContext;[I)Ljava/lang/String;
    .locals 8
    .param p1, "prefixBase"    # Ljava/lang/String;
    .param p2, "ctxt"    # Ljavax/xml/namespace/NamespaceContext;
    .param p3, "seqArr"    # [I

    .line 245
    iget-object v0, p0, Lcom/fasterxml/aalto/out/NsBinder;->_nsStrings:[Ljava/lang/String;

    .line 246
    .local v0, "strs":[Ljava/lang/String;
    const/4 v1, 0x0

    aget v2, p3, v1

    .line 254
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

    .line 255
    .local v3, "prefix":Ljava/lang/String;
    add-int/lit8 v2, v2, 0x1

    .line 262
    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v4

    .line 264
    .local v4, "phash":I
    iget v5, p0, Lcom/fasterxml/aalto/out/NsBinder;->_scopeEnd:I

    add-int/lit8 v5, v5, -0x2

    .local v5, "ix":I
    :goto_1
    if-ltz v5, :cond_2

    .line 265
    aget-object v6, v0, v5

    .line 266
    .local v6, "thisP":Ljava/lang/String;
    if-eq v6, v3, :cond_0

    .line 267
    invoke-virtual {v6}, Ljava/lang/String;->hashCode()I

    move-result v7

    if-ne v7, v4, :cond_1

    invoke-virtual {v6, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v7

    if-eqz v7, :cond_1

    .line 268
    goto :goto_0

    .line 264
    .end local v6    # "thisP":Ljava/lang/String;
    :cond_1
    add-int/lit8 v5, v5, -0x2

    goto :goto_1

    .line 274
    .end local v5    # "ix":I
    :cond_2
    if-eqz p2, :cond_3

    invoke-interface {p2, v3}, Ljavax/xml/namespace/NamespaceContext;->getNamespaceURI(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    if-eqz v5, :cond_3

    .line 275
    goto :goto_0

    .line 277
    :cond_3
    aput v2, p3, v1

    .line 278
    return-object v3
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

    .line 159
    .local p2, "l":Ljava/util/List;, "Ljava/util/List<Ljava/lang/String;>;"
    iget-object v0, p0, Lcom/fasterxml/aalto/out/NsBinder;->_nsStrings:[Ljava/lang/String;

    .line 160
    .local v0, "strs":[Ljava/lang/String;
    invoke-virtual {p1}, Ljava/lang/String;->hashCode()I

    move-result v1

    .line 163
    .local v1, "uhash":I
    iget v2, p0, Lcom/fasterxml/aalto/out/NsBinder;->_scopeEnd:I

    add-int/lit8 v2, v2, -0x1

    .local v2, "ix":I
    :goto_0
    if-lez v2, :cond_5

    .line 164
    aget-object v3, v0, v2

    .line 165
    .local v3, "thisU":Ljava/lang/String;
    if-eq v3, p1, :cond_0

    .line 166
    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v4

    if-ne v4, v1, :cond_4

    invoke-virtual {v3, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_4

    .line 167
    :cond_0
    add-int/lit8 v4, v2, -0x1

    aget-object v4, v0, v4

    .line 168
    .local v4, "prefix":Ljava/lang/String;
    iget v5, p0, Lcom/fasterxml/aalto/out/NsBinder;->_scopeStart:I

    if-ge v2, v5, :cond_2

    .line 169
    invoke-virtual {v4}, Ljava/lang/String;->hashCode()I

    move-result v5

    .line 170
    .local v5, "phash":I
    add-int/lit8 v6, v2, -0x1

    .local v6, "j":I
    iget v7, p0, Lcom/fasterxml/aalto/out/NsBinder;->_scopeEnd:I

    .local v7, "end":I
    :goto_1
    if-ge v6, v7, :cond_2

    .line 171
    aget-object v8, v0, v2

    .line 172
    .local v8, "thisP":Ljava/lang/String;
    if-eq v8, v4, :cond_4

    .line 173
    invoke-virtual {v8}, Ljava/lang/String;->hashCode()I

    move-result v9

    if-ne v9, v5, :cond_1

    invoke-virtual {v8, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v9

    if-eqz v9, :cond_1

    .line 175
    goto :goto_2

    .line 170
    .end local v8    # "thisP":Ljava/lang/String;
    :cond_1
    add-int/lit8 v6, v6, 0x2

    goto :goto_1

    .line 179
    .end local v5    # "phash":I
    .end local v6    # "j":I
    .end local v7    # "end":I
    :cond_2
    if-nez p2, :cond_3

    .line 180
    new-instance v5, Ljava/util/ArrayList;

    invoke-direct {v5}, Ljava/util/ArrayList;-><init>()V

    move-object p2, v5

    .line 182
    :cond_3
    invoke-interface {p2, v4}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 163
    .end local v3    # "thisU":Ljava/lang/String;
    .end local v4    # "prefix":Ljava/lang/String;
    :cond_4
    :goto_2
    add-int/lit8 v2, v2, -0x2

    goto :goto_0

    .line 185
    .end local v2    # "ix":I
    :cond_5
    return-object p2
.end method

.method public localSize()I
    .locals 2

    .line 193
    iget v0, p0, Lcom/fasterxml/aalto/out/NsBinder;->_scopeEnd:I

    iget v1, p0, Lcom/fasterxml/aalto/out/NsBinder;->_scopeStart:I

    sub-int/2addr v0, v1

    shr-int/lit8 v0, v0, 0x1

    return v0
.end method

.method public size()I
    .locals 1

    .line 189
    iget v0, p0, Lcom/fasterxml/aalto/out/NsBinder;->_scopeEnd:I

    shr-int/lit8 v0, v0, 0x1

    return v0
.end method

.method public toString()Ljava/lang/String;
    .locals 2

    .line 290
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "["

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Class;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "; "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {p0}, Lcom/fasterxml/aalto/out/NsBinder;->size()I

    move-result v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " entries; of which "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    .line 291
    invoke-virtual {p0}, Lcom/fasterxml/aalto/out/NsBinder;->localSize()I

    move-result v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " local]"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 290
    return-object v0
.end method
