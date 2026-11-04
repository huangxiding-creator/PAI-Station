.class public final Lcom/fasterxml/aalto/in/PNameC;
.super Lcom/fasterxml/aalto/in/PName;
.source "PNameC.java"


# instance fields
.field protected final mHash:I


# direct methods
.method public constructor <init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;I)V
    .locals 0
    .param p1, "pname"    # Ljava/lang/String;
    .param p2, "prefix"    # Ljava/lang/String;
    .param p3, "ln"    # Ljava/lang/String;
    .param p4, "hash"    # I

    .line 40
    invoke-direct {p0, p1, p2, p3}, Lcom/fasterxml/aalto/in/PName;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 41
    iput p4, p0, Lcom/fasterxml/aalto/in/PNameC;->mHash:I

    .line 42
    return-void
.end method

.method public static calcHash(Ljava/lang/String;)I
    .locals 5
    .param p0, "key"    # Ljava/lang/String;

    .line 114
    const/4 v0, 0x0

    invoke-virtual {p0, v0}, Ljava/lang/String;->charAt(I)C

    move-result v0

    .line 115
    .local v0, "hash":I
    const/4 v1, 0x1

    .local v1, "i":I
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v2

    .local v2, "len":I
    :goto_0
    if-ge v1, v2, :cond_0

    .line 116
    mul-int/lit8 v3, v0, 0x1f

    invoke-virtual {p0, v1}, Ljava/lang/String;->charAt(I)C

    move-result v4

    add-int v0, v3, v4

    .line 115
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 119
    .end local v1    # "i":I
    .end local v2    # "len":I
    :cond_0
    return v0
.end method

.method public static calcHash([CII)I
    .locals 4
    .param p0, "buffer"    # [C
    .param p1, "start"    # I
    .param p2, "len"    # I

    .line 106
    const/4 v0, 0x0

    aget-char v0, p0, v0

    .line 107
    .local v0, "hash":I
    const/4 v1, 0x1

    .local v1, "i":I
    :goto_0
    if-ge v1, p2, :cond_0

    .line 108
    mul-int/lit8 v2, v0, 0x1f

    aget-char v3, p0, v1

    add-int v0, v2, v3

    .line 107
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 110
    .end local v1    # "i":I
    :cond_0
    return v0
.end method

.method public static construct(Ljava/lang/String;)Lcom/fasterxml/aalto/in/PNameC;
    .locals 1
    .param p0, "pname"    # Ljava/lang/String;

    .line 54
    invoke-static {p0}, Lcom/fasterxml/aalto/in/PNameC;->calcHash(Ljava/lang/String;)I

    move-result v0

    invoke-static {p0, v0}, Lcom/fasterxml/aalto/in/PNameC;->construct(Ljava/lang/String;I)Lcom/fasterxml/aalto/in/PNameC;

    move-result-object v0

    return-object v0
.end method

.method public static construct(Ljava/lang/String;I)Lcom/fasterxml/aalto/in/PNameC;
    .locals 4
    .param p0, "pname"    # Ljava/lang/String;
    .param p1, "hash"    # I

    .line 59
    const/16 v0, 0x3a

    invoke-virtual {p0, v0}, Ljava/lang/String;->indexOf(I)I

    move-result v0

    .line 60
    .local v0, "colonIx":I
    if-gez v0, :cond_0

    .line 61
    new-instance v1, Lcom/fasterxml/aalto/in/PNameC;

    const/4 v2, 0x0

    invoke-direct {v1, p0, v2, p0, p1}, Lcom/fasterxml/aalto/in/PNameC;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;I)V

    return-object v1

    .line 66
    :cond_0
    new-instance v1, Lcom/fasterxml/aalto/in/PNameC;

    const/4 v2, 0x0

    invoke-virtual {p0, v2, v0}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/String;->intern()Ljava/lang/String;

    move-result-object v2

    add-int/lit8 v3, v0, 0x1

    .line 67
    invoke-virtual {p0, v3}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->intern()Ljava/lang/String;

    move-result-object v3

    invoke-direct {v1, p0, v2, v3, p1}, Lcom/fasterxml/aalto/in/PNameC;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;I)V

    .line 66
    return-object v1
.end method


# virtual methods
.method public createBoundName(Lcom/fasterxml/aalto/in/NsBinding;)Lcom/fasterxml/aalto/in/PName;
    .locals 5
    .param p1, "nsb"    # Lcom/fasterxml/aalto/in/NsBinding;

    .line 47
    new-instance v0, Lcom/fasterxml/aalto/in/PNameC;

    iget-object v1, p0, Lcom/fasterxml/aalto/in/PNameC;->_prefixedName:Ljava/lang/String;

    iget-object v2, p0, Lcom/fasterxml/aalto/in/PNameC;->_prefix:Ljava/lang/String;

    iget-object v3, p0, Lcom/fasterxml/aalto/in/PNameC;->_localName:Ljava/lang/String;

    iget v4, p0, Lcom/fasterxml/aalto/in/PNameC;->mHash:I

    invoke-direct {v0, v1, v2, v3, v4}, Lcom/fasterxml/aalto/in/PNameC;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;I)V

    .line 48
    .local v0, "newName":Lcom/fasterxml/aalto/in/PNameC;
    iput-object p1, v0, Lcom/fasterxml/aalto/in/PNameC;->_namespaceBinding:Lcom/fasterxml/aalto/in/NsBinding;

    .line 49
    return-object v0
.end method

.method public equalsPName([CIII)Z
    .locals 6
    .param p1, "buffer"    # [C
    .param p2, "start"    # I
    .param p3, "len"    # I
    .param p4, "hash"    # I

    .line 78
    iget v0, p0, Lcom/fasterxml/aalto/in/PNameC;->mHash:I

    const/4 v1, 0x0

    if-eq p4, v0, :cond_0

    .line 79
    return v1

    .line 81
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/in/PNameC;->_prefixedName:Ljava/lang/String;

    .line 82
    .local v0, "pname":Ljava/lang/String;
    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v2

    .line 83
    .local v2, "plen":I
    if-eq p3, v2, :cond_1

    .line 84
    return v1

    .line 86
    :cond_1
    const/4 v3, 0x0

    .local v3, "i":I
    :goto_0
    if-ge v3, p3, :cond_3

    .line 87
    add-int v4, p2, v3

    aget-char v4, p1, v4

    invoke-virtual {v0, v3}, Ljava/lang/String;->charAt(I)C

    move-result v5

    if-eq v4, v5, :cond_2

    .line 88
    return v1

    .line 86
    :cond_2
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    .line 91
    .end local v3    # "i":I
    :cond_3
    const/4 v1, 0x1

    return v1
.end method

.method public getCustomHash()I
    .locals 1

    .line 94
    iget v0, p0, Lcom/fasterxml/aalto/in/PNameC;->mHash:I

    return v0
.end method

.method public getFirstQuad()I
    .locals 1

    .line 142
    invoke-static {}, Lcom/fasterxml/aalto/impl/ErrorConsts;->throwInternalError()V

    .line 143
    const/4 v0, 0x0

    return v0
.end method

.method public final getLastQuad()I
    .locals 1

    .line 149
    invoke-static {}, Lcom/fasterxml/aalto/impl/ErrorConsts;->throwInternalError()V

    .line 150
    const/4 v0, 0x0

    return v0
.end method

.method public getQuad(I)I
    .locals 1
    .param p1, "index"    # I

    .line 156
    invoke-static {}, Lcom/fasterxml/aalto/impl/ErrorConsts;->throwInternalError()V

    .line 157
    const/4 v0, 0x0

    return v0
.end method

.method public hashCode()I
    .locals 1

    .line 172
    iget v0, p0, Lcom/fasterxml/aalto/in/PNameC;->mHash:I

    return v0
.end method

.method public sizeInQuads()I
    .locals 1

    .line 135
    invoke-static {}, Lcom/fasterxml/aalto/impl/ErrorConsts;->throwInternalError()V

    .line 136
    const/4 v0, 0x0

    return v0
.end method
