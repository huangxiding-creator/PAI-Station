.class public final Lcom/fasterxml/aalto/in/NsDeclaration;
.super Ljava/lang/Object;
.source "NsDeclaration.java"


# instance fields
.field private final mBinding:Lcom/fasterxml/aalto/in/NsBinding;

.field private final mLevel:I

.field private final mPrevDeclaration:Lcom/fasterxml/aalto/in/NsDeclaration;

.field private final mPreviousURI:Ljava/lang/String;


# direct methods
.method public constructor <init>(Lcom/fasterxml/aalto/in/NsBinding;Ljava/lang/String;Lcom/fasterxml/aalto/in/NsDeclaration;I)V
    .locals 1
    .param p1, "binding"    # Lcom/fasterxml/aalto/in/NsBinding;
    .param p2, "newURI"    # Ljava/lang/String;
    .param p3, "prevDecl"    # Lcom/fasterxml/aalto/in/NsDeclaration;
    .param p4, "level"    # I

    .line 47
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 48
    iput-object p1, p0, Lcom/fasterxml/aalto/in/NsDeclaration;->mBinding:Lcom/fasterxml/aalto/in/NsBinding;

    .line 49
    iput-object p3, p0, Lcom/fasterxml/aalto/in/NsDeclaration;->mPrevDeclaration:Lcom/fasterxml/aalto/in/NsDeclaration;

    .line 50
    iput p4, p0, Lcom/fasterxml/aalto/in/NsDeclaration;->mLevel:I

    .line 53
    iget-object v0, p1, Lcom/fasterxml/aalto/in/NsBinding;->mURI:Ljava/lang/String;

    iput-object v0, p0, Lcom/fasterxml/aalto/in/NsDeclaration;->mPreviousURI:Ljava/lang/String;

    .line 54
    iput-object p2, p1, Lcom/fasterxml/aalto/in/NsBinding;->mURI:Ljava/lang/String;

    .line 55
    return-void
.end method


# virtual methods
.method public alreadyDeclared(Ljava/lang/String;I)Z
    .locals 3
    .param p1, "prefix"    # Ljava/lang/String;
    .param p2, "level"    # I

    .line 84
    iget v0, p0, Lcom/fasterxml/aalto/in/NsDeclaration;->mLevel:I

    if-lt v0, p2, :cond_2

    .line 85
    iget-object v0, p0, Lcom/fasterxml/aalto/in/NsDeclaration;->mBinding:Lcom/fasterxml/aalto/in/NsBinding;

    iget-object v0, v0, Lcom/fasterxml/aalto/in/NsBinding;->mPrefix:Ljava/lang/String;

    const/4 v1, 0x1

    if-ne p1, v0, :cond_0

    .line 86
    return v1

    .line 88
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/in/NsDeclaration;->mPrevDeclaration:Lcom/fasterxml/aalto/in/NsDeclaration;

    .line 89
    .local v0, "prev":Lcom/fasterxml/aalto/in/NsDeclaration;
    :goto_0
    if-eqz v0, :cond_2

    iget v2, v0, Lcom/fasterxml/aalto/in/NsDeclaration;->mLevel:I

    if-lt v2, p2, :cond_2

    .line 90
    iget-object v2, v0, Lcom/fasterxml/aalto/in/NsDeclaration;->mBinding:Lcom/fasterxml/aalto/in/NsBinding;

    iget-object v2, v2, Lcom/fasterxml/aalto/in/NsBinding;->mPrefix:Ljava/lang/String;

    if-ne p1, v2, :cond_1

    .line 91
    return v1

    .line 93
    :cond_1
    iget-object v0, v0, Lcom/fasterxml/aalto/in/NsDeclaration;->mPrevDeclaration:Lcom/fasterxml/aalto/in/NsDeclaration;

    goto :goto_0

    .line 96
    .end local v0    # "prev":Lcom/fasterxml/aalto/in/NsDeclaration;
    :cond_2
    const/4 v0, 0x0

    return v0
.end method

.method public countDeclsOnLevel(I)I
    .locals 3
    .param p1, "level"    # I

    .line 101
    const/4 v0, 0x0

    .line 102
    .local v0, "count":I
    iget v1, p0, Lcom/fasterxml/aalto/in/NsDeclaration;->mLevel:I

    if-ne v1, p1, :cond_0

    .line 103
    add-int/lit8 v0, v0, 0x1

    .line 104
    iget-object v1, p0, Lcom/fasterxml/aalto/in/NsDeclaration;->mPrevDeclaration:Lcom/fasterxml/aalto/in/NsDeclaration;

    .line 105
    .local v1, "prev":Lcom/fasterxml/aalto/in/NsDeclaration;
    :goto_0
    if-eqz v1, :cond_0

    iget v2, v1, Lcom/fasterxml/aalto/in/NsDeclaration;->mLevel:I

    if-ne v2, p1, :cond_0

    .line 106
    add-int/lit8 v0, v0, 0x1

    .line 107
    iget-object v1, v1, Lcom/fasterxml/aalto/in/NsDeclaration;->mPrevDeclaration:Lcom/fasterxml/aalto/in/NsDeclaration;

    goto :goto_0

    .line 110
    .end local v1    # "prev":Lcom/fasterxml/aalto/in/NsDeclaration;
    :cond_0
    return v0
.end method

.method public getBinding()Lcom/fasterxml/aalto/in/NsBinding;
    .locals 1

    .line 59
    iget-object v0, p0, Lcom/fasterxml/aalto/in/NsDeclaration;->mBinding:Lcom/fasterxml/aalto/in/NsBinding;

    return-object v0
.end method

.method public getCurrNsURI()Ljava/lang/String;
    .locals 1

    .line 62
    iget-object v0, p0, Lcom/fasterxml/aalto/in/NsDeclaration;->mBinding:Lcom/fasterxml/aalto/in/NsBinding;

    iget-object v0, v0, Lcom/fasterxml/aalto/in/NsBinding;->mURI:Ljava/lang/String;

    return-object v0
.end method

.method public getLevel()I
    .locals 1

    .line 57
    iget v0, p0, Lcom/fasterxml/aalto/in/NsDeclaration;->mLevel:I

    return v0
.end method

.method public getPrefix()Ljava/lang/String;
    .locals 1

    .line 61
    iget-object v0, p0, Lcom/fasterxml/aalto/in/NsDeclaration;->mBinding:Lcom/fasterxml/aalto/in/NsBinding;

    iget-object v0, v0, Lcom/fasterxml/aalto/in/NsBinding;->mPrefix:Ljava/lang/String;

    return-object v0
.end method

.method public getPrev()Lcom/fasterxml/aalto/in/NsDeclaration;
    .locals 1

    .line 58
    iget-object v0, p0, Lcom/fasterxml/aalto/in/NsDeclaration;->mPrevDeclaration:Lcom/fasterxml/aalto/in/NsDeclaration;

    return-object v0
.end method

.method public hasNsURI(Ljava/lang/String;)Z
    .locals 1
    .param p1, "uri"    # Ljava/lang/String;

    .line 69
    iget-object v0, p0, Lcom/fasterxml/aalto/in/NsDeclaration;->mBinding:Lcom/fasterxml/aalto/in/NsBinding;

    iget-object v0, v0, Lcom/fasterxml/aalto/in/NsBinding;->mURI:Ljava/lang/String;

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    return v0
.end method

.method public hasPrefix(Ljava/lang/String;)Z
    .locals 1
    .param p1, "prefix"    # Ljava/lang/String;

    .line 65
    iget-object v0, p0, Lcom/fasterxml/aalto/in/NsDeclaration;->mBinding:Lcom/fasterxml/aalto/in/NsBinding;

    iget-object v0, v0, Lcom/fasterxml/aalto/in/NsBinding;->mPrefix:Ljava/lang/String;

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    return v0
.end method

.method public toString()Ljava/lang/String;
    .locals 2

    .line 115
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "[NS-DECL, prefix = <"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/fasterxml/aalto/in/NsDeclaration;->mBinding:Lcom/fasterxml/aalto/in/NsBinding;

    iget-object v1, v1, Lcom/fasterxml/aalto/in/NsBinding;->mPrefix:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ">, current URI <"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/fasterxml/aalto/in/NsDeclaration;->mBinding:Lcom/fasterxml/aalto/in/NsBinding;

    iget-object v1, v1, Lcom/fasterxml/aalto/in/NsBinding;->mURI:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ">, level "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/fasterxml/aalto/in/NsDeclaration;->mLevel:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", prev URI <"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/fasterxml/aalto/in/NsDeclaration;->mPreviousURI:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ">]"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public unbind()Lcom/fasterxml/aalto/in/NsDeclaration;
    .locals 2

    .line 78
    iget-object v0, p0, Lcom/fasterxml/aalto/in/NsDeclaration;->mBinding:Lcom/fasterxml/aalto/in/NsBinding;

    iget-object v1, p0, Lcom/fasterxml/aalto/in/NsDeclaration;->mPreviousURI:Ljava/lang/String;

    iput-object v1, v0, Lcom/fasterxml/aalto/in/NsBinding;->mURI:Ljava/lang/String;

    .line 79
    iget-object v0, p0, Lcom/fasterxml/aalto/in/NsDeclaration;->mPrevDeclaration:Lcom/fasterxml/aalto/in/NsDeclaration;

    return-object v0
.end method
