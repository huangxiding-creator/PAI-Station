.class public final Lcom/fasterxml/aalto/util/TextAccumulator;
.super Ljava/lang/Object;
.source "TextAccumulator.java"


# instance fields
.field private mBuilder:Ljava/lang/StringBuilder;

.field private mText:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 13
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 9
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/fasterxml/aalto/util/TextAccumulator;->mText:Ljava/lang/String;

    .line 11
    iput-object v0, p0, Lcom/fasterxml/aalto/util/TextAccumulator;->mBuilder:Ljava/lang/StringBuilder;

    .line 13
    return-void
.end method


# virtual methods
.method public addText(Ljava/lang/String;)V
    .locals 3
    .param p1, "text"    # Ljava/lang/String;

    .line 21
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    .line 22
    .local v0, "len":I
    if-lez v0, :cond_2

    .line 24
    iget-object v1, p0, Lcom/fasterxml/aalto/util/TextAccumulator;->mText:Ljava/lang/String;

    if-eqz v1, :cond_0

    .line 25
    new-instance v1, Ljava/lang/StringBuilder;

    iget-object v2, p0, Lcom/fasterxml/aalto/util/TextAccumulator;->mText:Ljava/lang/String;

    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v2

    add-int/2addr v2, v0

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(I)V

    iput-object v1, p0, Lcom/fasterxml/aalto/util/TextAccumulator;->mBuilder:Ljava/lang/StringBuilder;

    .line 26
    iget-object v1, p0, Lcom/fasterxml/aalto/util/TextAccumulator;->mBuilder:Ljava/lang/StringBuilder;

    iget-object v2, p0, Lcom/fasterxml/aalto/util/TextAccumulator;->mText:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 27
    const/4 v1, 0x0

    iput-object v1, p0, Lcom/fasterxml/aalto/util/TextAccumulator;->mText:Ljava/lang/String;

    .line 29
    :cond_0
    iget-object v1, p0, Lcom/fasterxml/aalto/util/TextAccumulator;->mBuilder:Ljava/lang/StringBuilder;

    if-eqz v1, :cond_1

    .line 30
    iget-object v1, p0, Lcom/fasterxml/aalto/util/TextAccumulator;->mBuilder:Ljava/lang/StringBuilder;

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto :goto_0

    .line 32
    :cond_1
    iput-object p1, p0, Lcom/fasterxml/aalto/util/TextAccumulator;->mText:Ljava/lang/String;

    .line 35
    :cond_2
    :goto_0
    return-void
.end method

.method public addText([CII)V
    .locals 3
    .param p1, "buf"    # [C
    .param p2, "start"    # I
    .param p3, "end"    # I

    .line 39
    sub-int v0, p3, p2

    .line 40
    .local v0, "len":I
    if-lez v0, :cond_2

    .line 42
    iget-object v1, p0, Lcom/fasterxml/aalto/util/TextAccumulator;->mText:Ljava/lang/String;

    if-eqz v1, :cond_0

    .line 43
    new-instance v1, Ljava/lang/StringBuilder;

    iget-object v2, p0, Lcom/fasterxml/aalto/util/TextAccumulator;->mText:Ljava/lang/String;

    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v2

    add-int/2addr v2, v0

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(I)V

    iput-object v1, p0, Lcom/fasterxml/aalto/util/TextAccumulator;->mBuilder:Ljava/lang/StringBuilder;

    .line 44
    iget-object v1, p0, Lcom/fasterxml/aalto/util/TextAccumulator;->mBuilder:Ljava/lang/StringBuilder;

    iget-object v2, p0, Lcom/fasterxml/aalto/util/TextAccumulator;->mText:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 45
    const/4 v1, 0x0

    iput-object v1, p0, Lcom/fasterxml/aalto/util/TextAccumulator;->mText:Ljava/lang/String;

    goto :goto_0

    .line 46
    :cond_0
    iget-object v1, p0, Lcom/fasterxml/aalto/util/TextAccumulator;->mBuilder:Ljava/lang/StringBuilder;

    if-nez v1, :cond_1

    .line 51
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1, v0}, Ljava/lang/StringBuilder;-><init>(I)V

    iput-object v1, p0, Lcom/fasterxml/aalto/util/TextAccumulator;->mBuilder:Ljava/lang/StringBuilder;

    .line 53
    :cond_1
    :goto_0
    iget-object v1, p0, Lcom/fasterxml/aalto/util/TextAccumulator;->mBuilder:Ljava/lang/StringBuilder;

    sub-int v2, p3, p2

    invoke-virtual {v1, p1, p2, v2}, Ljava/lang/StringBuilder;->append([CII)Ljava/lang/StringBuilder;

    .line 55
    :cond_2
    return-void
.end method

.method public getAndClear()Ljava/lang/String;
    .locals 2

    .line 61
    iget-object v0, p0, Lcom/fasterxml/aalto/util/TextAccumulator;->mText:Ljava/lang/String;

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    .line 62
    iget-object v0, p0, Lcom/fasterxml/aalto/util/TextAccumulator;->mText:Ljava/lang/String;

    .line 63
    .local v0, "result":Ljava/lang/String;
    iput-object v1, p0, Lcom/fasterxml/aalto/util/TextAccumulator;->mText:Ljava/lang/String;

    goto :goto_0

    .line 64
    .end local v0    # "result":Ljava/lang/String;
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/util/TextAccumulator;->mBuilder:Ljava/lang/StringBuilder;

    if-eqz v0, :cond_1

    .line 65
    iget-object v0, p0, Lcom/fasterxml/aalto/util/TextAccumulator;->mBuilder:Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 66
    .restart local v0    # "result":Ljava/lang/String;
    iput-object v1, p0, Lcom/fasterxml/aalto/util/TextAccumulator;->mBuilder:Ljava/lang/StringBuilder;

    goto :goto_0

    .line 68
    .end local v0    # "result":Ljava/lang/String;
    :cond_1
    const-string v0, ""

    .line 70
    .restart local v0    # "result":Ljava/lang/String;
    :goto_0
    return-object v0
.end method

.method public hasText()Z
    .locals 1

    .line 16
    iget-object v0, p0, Lcom/fasterxml/aalto/util/TextAccumulator;->mBuilder:Ljava/lang/StringBuilder;

    if-nez v0, :cond_1

    iget-object v0, p0, Lcom/fasterxml/aalto/util/TextAccumulator;->mText:Ljava/lang/String;

    if-eqz v0, :cond_0

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
