.class public abstract Lcom/fasterxml/aalto/out/WName;
.super Ljava/lang/Object;
.source "WName.java"


# instance fields
.field protected final _localName:Ljava/lang/String;

.field protected final _prefix:Ljava/lang/String;


# direct methods
.method protected constructor <init>(Ljava/lang/String;)V
    .locals 1
    .param p1, "ln"    # Ljava/lang/String;

    .line 42
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 43
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/fasterxml/aalto/out/WName;->_prefix:Ljava/lang/String;

    .line 44
    iput-object p1, p0, Lcom/fasterxml/aalto/out/WName;->_localName:Ljava/lang/String;

    .line 45
    return-void
.end method

.method protected constructor <init>(Ljava/lang/String;Ljava/lang/String;)V
    .locals 0
    .param p1, "prefix"    # Ljava/lang/String;
    .param p2, "ln"    # Ljava/lang/String;

    .line 48
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 49
    iput-object p1, p0, Lcom/fasterxml/aalto/out/WName;->_prefix:Ljava/lang/String;

    .line 50
    iput-object p2, p0, Lcom/fasterxml/aalto/out/WName;->_localName:Ljava/lang/String;

    .line 51
    return-void
.end method


# virtual methods
.method public abstract appendBytes([BI)I
.end method

.method public abstract appendChars([CI)I
.end method

.method public final equals(Ljava/lang/Object;)Z
    .locals 5
    .param p1, "o"    # Ljava/lang/Object;

    .line 109
    const/4 v0, 0x1

    if-ne p1, p0, :cond_0

    .line 110
    return v0

    .line 113
    :cond_0
    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v1

    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v2

    const/4 v3, 0x0

    if-eq v1, v2, :cond_1

    instance-of v1, p1, Lcom/fasterxml/aalto/out/WName;

    if-nez v1, :cond_1

    .line 114
    return v3

    .line 117
    :cond_1
    move-object v1, p1

    check-cast v1, Lcom/fasterxml/aalto/out/WName;

    .line 119
    .local v1, "other":Lcom/fasterxml/aalto/out/WName;
    iget-object v2, v1, Lcom/fasterxml/aalto/out/WName;->_localName:Ljava/lang/String;

    iget-object v4, p0, Lcom/fasterxml/aalto/out/WName;->_localName:Ljava/lang/String;

    invoke-virtual {v2, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_4

    .line 120
    iget-object v2, p0, Lcom/fasterxml/aalto/out/WName;->_prefix:Ljava/lang/String;

    if-nez v2, :cond_3

    .line 121
    iget-object v2, v1, Lcom/fasterxml/aalto/out/WName;->_prefix:Ljava/lang/String;

    if-nez v2, :cond_2

    goto :goto_0

    :cond_2
    move v0, v3

    :goto_0
    return v0

    .line 123
    :cond_3
    iget-object v0, p0, Lcom/fasterxml/aalto/out/WName;->_prefix:Ljava/lang/String;

    iget-object v2, v1, Lcom/fasterxml/aalto/out/WName;->_prefix:Ljava/lang/String;

    invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    return v0

    .line 125
    :cond_4
    return v3
.end method

.method public final getLocalName()Ljava/lang/String;
    .locals 1

    .line 73
    iget-object v0, p0, Lcom/fasterxml/aalto/out/WName;->_localName:Ljava/lang/String;

    return-object v0
.end method

.method public final getPrefix()Ljava/lang/String;
    .locals 1

    .line 65
    iget-object v0, p0, Lcom/fasterxml/aalto/out/WName;->_prefix:Ljava/lang/String;

    return-object v0
.end method

.method public final getPrefixedName()Ljava/lang/String;
    .locals 2

    .line 68
    iget-object v0, p0, Lcom/fasterxml/aalto/out/WName;->_prefix:Ljava/lang/String;

    if-nez v0, :cond_0

    .line 69
    iget-object v0, p0, Lcom/fasterxml/aalto/out/WName;->_localName:Ljava/lang/String;

    return-object v0

    .line 71
    :cond_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v1, p0, Lcom/fasterxml/aalto/out/WName;->_prefix:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ":"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/fasterxml/aalto/out/WName;->_localName:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public final hasName(Ljava/lang/String;)Z
    .locals 1
    .param p1, "localName"    # Ljava/lang/String;

    .line 150
    iget-object v0, p0, Lcom/fasterxml/aalto/out/WName;->_prefix:Ljava/lang/String;

    if-eqz v0, :cond_0

    .line 151
    const/4 v0, 0x0

    return v0

    .line 153
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/out/WName;->_localName:Ljava/lang/String;

    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    return v0
.end method

.method public final hasName(Ljava/lang/String;Ljava/lang/String;)Z
    .locals 3
    .param p1, "prefix"    # Ljava/lang/String;
    .param p2, "localName"    # Ljava/lang/String;

    .line 158
    iget-object v0, p0, Lcom/fasterxml/aalto/out/WName;->_localName:Ljava/lang/String;

    const/4 v1, 0x0

    if-ne v0, p2, :cond_2

    .line 159
    if-nez p1, :cond_1

    .line 160
    iget-object v0, p0, Lcom/fasterxml/aalto/out/WName;->_prefix:Ljava/lang/String;

    if-nez v0, :cond_0

    const/4 v1, 0x1

    :cond_0
    return v1

    .line 162
    :cond_1
    iget-object v0, p0, Lcom/fasterxml/aalto/out/WName;->_prefix:Ljava/lang/String;

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    return v0

    .line 166
    :cond_2
    iget-object v0, p0, Lcom/fasterxml/aalto/out/WName;->_localName:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->hashCode()I

    move-result v0

    invoke-virtual {p2}, Ljava/lang/String;->hashCode()I

    move-result v2

    if-eq v0, v2, :cond_3

    .line 167
    return v1

    .line 169
    :cond_3
    if-nez p1, :cond_4

    .line 170
    iget-object v0, p0, Lcom/fasterxml/aalto/out/WName;->_prefix:Ljava/lang/String;

    if-eqz v0, :cond_5

    .line 171
    return v1

    .line 174
    :cond_4
    iget-object v0, p0, Lcom/fasterxml/aalto/out/WName;->_prefix:Ljava/lang/String;

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_5

    .line 175
    return v1

    .line 178
    :cond_5
    iget-object v0, p0, Lcom/fasterxml/aalto/out/WName;->_localName:Ljava/lang/String;

    invoke-virtual {v0, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    return v0
.end method

.method public final hasPrefix()Z
    .locals 1

    .line 75
    iget-object v0, p0, Lcom/fasterxml/aalto/out/WName;->_prefix:Ljava/lang/String;

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public hashCode()I
    .locals 2

    .line 135
    iget-object v0, p0, Lcom/fasterxml/aalto/out/WName;->_localName:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->hashCode()I

    move-result v0

    .line 136
    .local v0, "hash":I
    iget-object v1, p0, Lcom/fasterxml/aalto/out/WName;->_prefix:Ljava/lang/String;

    if-eqz v1, :cond_0

    .line 137
    iget-object v1, p0, Lcom/fasterxml/aalto/out/WName;->_prefix:Ljava/lang/String;

    invoke-virtual {v1}, Ljava/lang/String;->hashCode()I

    move-result v1

    xor-int/2addr v0, v1

    .line 139
    :cond_0
    return v0
.end method

.method public abstract serializedLength()I
.end method

.method public toString()Ljava/lang/String;
    .locals 2

    .line 100
    iget-object v0, p0, Lcom/fasterxml/aalto/out/WName;->_prefix:Ljava/lang/String;

    if-nez v0, :cond_0

    .line 101
    iget-object v0, p0, Lcom/fasterxml/aalto/out/WName;->_localName:Ljava/lang/String;

    return-object v0

    .line 103
    :cond_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v1, p0, Lcom/fasterxml/aalto/out/WName;->_prefix:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ":"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/fasterxml/aalto/out/WName;->_localName:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public abstract writeBytes(Ljava/io/OutputStream;)V
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation
.end method

.method public abstract writeChars(Ljava/io/Writer;)V
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation
.end method
