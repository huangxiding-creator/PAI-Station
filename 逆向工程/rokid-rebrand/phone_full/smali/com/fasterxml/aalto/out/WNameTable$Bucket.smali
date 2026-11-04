.class final Lcom/fasterxml/aalto/out/WNameTable$Bucket;
.super Ljava/lang/Object;
.source "WNameTable.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/fasterxml/aalto/out/WNameTable;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = "Bucket"
.end annotation


# instance fields
.field final mName:Lcom/fasterxml/aalto/out/WName;

.field final mNext:Lcom/fasterxml/aalto/out/WNameTable$Bucket;


# direct methods
.method constructor <init>(Lcom/fasterxml/aalto/out/WName;Lcom/fasterxml/aalto/out/WNameTable$Bucket;)V
    .locals 0
    .param p1, "name"    # Lcom/fasterxml/aalto/out/WName;
    .param p2, "next"    # Lcom/fasterxml/aalto/out/WNameTable$Bucket;

    .line 697
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 698
    iput-object p1, p0, Lcom/fasterxml/aalto/out/WNameTable$Bucket;->mName:Lcom/fasterxml/aalto/out/WName;

    .line 699
    iput-object p2, p0, Lcom/fasterxml/aalto/out/WNameTable$Bucket;->mNext:Lcom/fasterxml/aalto/out/WNameTable$Bucket;

    .line 700
    return-void
.end method


# virtual methods
.method public find(Ljava/lang/String;)Lcom/fasterxml/aalto/out/WName;
    .locals 3
    .param p1, "localName"    # Ljava/lang/String;

    .line 713
    iget-object v0, p0, Lcom/fasterxml/aalto/out/WNameTable$Bucket;->mName:Lcom/fasterxml/aalto/out/WName;

    invoke-virtual {v0, p1}, Lcom/fasterxml/aalto/out/WName;->hasName(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 714
    iget-object v0, p0, Lcom/fasterxml/aalto/out/WNameTable$Bucket;->mName:Lcom/fasterxml/aalto/out/WName;

    return-object v0

    .line 716
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/out/WNameTable$Bucket;->mNext:Lcom/fasterxml/aalto/out/WNameTable$Bucket;

    .local v0, "curr":Lcom/fasterxml/aalto/out/WNameTable$Bucket;
    :goto_0
    if-eqz v0, :cond_2

    .line 717
    iget-object v1, v0, Lcom/fasterxml/aalto/out/WNameTable$Bucket;->mName:Lcom/fasterxml/aalto/out/WName;

    .line 718
    .local v1, "currName":Lcom/fasterxml/aalto/out/WName;
    invoke-virtual {v1, p1}, Lcom/fasterxml/aalto/out/WName;->hasName(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_1

    .line 719
    return-object v1

    .line 716
    .end local v1    # "currName":Lcom/fasterxml/aalto/out/WName;
    :cond_1
    iget-object v0, v0, Lcom/fasterxml/aalto/out/WNameTable$Bucket;->mNext:Lcom/fasterxml/aalto/out/WNameTable$Bucket;

    goto :goto_0

    .line 722
    .end local v0    # "curr":Lcom/fasterxml/aalto/out/WNameTable$Bucket;
    :cond_2
    const/4 v0, 0x0

    return-object v0
.end method

.method public find(Ljava/lang/String;Ljava/lang/String;)Lcom/fasterxml/aalto/out/WName;
    .locals 3
    .param p1, "prefix"    # Ljava/lang/String;
    .param p2, "localName"    # Ljava/lang/String;

    .line 727
    iget-object v0, p0, Lcom/fasterxml/aalto/out/WNameTable$Bucket;->mName:Lcom/fasterxml/aalto/out/WName;

    invoke-virtual {v0, p1, p2}, Lcom/fasterxml/aalto/out/WName;->hasName(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 728
    iget-object v0, p0, Lcom/fasterxml/aalto/out/WNameTable$Bucket;->mName:Lcom/fasterxml/aalto/out/WName;

    return-object v0

    .line 730
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/out/WNameTable$Bucket;->mNext:Lcom/fasterxml/aalto/out/WNameTable$Bucket;

    .local v0, "curr":Lcom/fasterxml/aalto/out/WNameTable$Bucket;
    :goto_0
    if-eqz v0, :cond_2

    .line 731
    iget-object v1, v0, Lcom/fasterxml/aalto/out/WNameTable$Bucket;->mName:Lcom/fasterxml/aalto/out/WName;

    .line 732
    .local v1, "currName":Lcom/fasterxml/aalto/out/WName;
    invoke-virtual {v1, p1, p2}, Lcom/fasterxml/aalto/out/WName;->hasName(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_1

    .line 733
    return-object v1

    .line 730
    .end local v1    # "currName":Lcom/fasterxml/aalto/out/WName;
    :cond_1
    iget-object v0, v0, Lcom/fasterxml/aalto/out/WNameTable$Bucket;->mNext:Lcom/fasterxml/aalto/out/WNameTable$Bucket;

    goto :goto_0

    .line 736
    .end local v0    # "curr":Lcom/fasterxml/aalto/out/WNameTable$Bucket;
    :cond_2
    const/4 v0, 0x0

    return-object v0
.end method

.method public length()I
    .locals 2

    .line 704
    const/4 v0, 0x1

    .line 705
    .local v0, "len":I
    iget-object v1, p0, Lcom/fasterxml/aalto/out/WNameTable$Bucket;->mNext:Lcom/fasterxml/aalto/out/WNameTable$Bucket;

    .local v1, "curr":Lcom/fasterxml/aalto/out/WNameTable$Bucket;
    :goto_0
    if-eqz v1, :cond_0

    .line 706
    add-int/lit8 v0, v0, 0x1

    .line 705
    iget-object v1, v1, Lcom/fasterxml/aalto/out/WNameTable$Bucket;->mNext:Lcom/fasterxml/aalto/out/WNameTable$Bucket;

    goto :goto_0

    .line 708
    .end local v1    # "curr":Lcom/fasterxml/aalto/out/WNameTable$Bucket;
    :cond_0
    return v0
.end method

.method public toDebugString()Ljava/lang/String;
    .locals 3

    .line 741
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 742
    .local v0, "sb":Ljava/lang/StringBuilder;
    const-string v1, "[Bucket("

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 743
    invoke-virtual {p0}, Lcom/fasterxml/aalto/out/WNameTable$Bucket;->length()I

    move-result v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    .line 744
    const-string v1, "): "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 745
    move-object v1, p0

    .local v1, "curr":Lcom/fasterxml/aalto/out/WNameTable$Bucket;
    :goto_0
    if-eqz v1, :cond_0

    .line 746
    const/16 v2, 0x22

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 747
    iget-object v2, v1, Lcom/fasterxml/aalto/out/WNameTable$Bucket;->mName:Lcom/fasterxml/aalto/out/WName;

    invoke-virtual {v2}, Lcom/fasterxml/aalto/out/WName;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 748
    const-string v2, "\" -> "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 745
    iget-object v1, v1, Lcom/fasterxml/aalto/out/WNameTable$Bucket;->mNext:Lcom/fasterxml/aalto/out/WNameTable$Bucket;

    goto :goto_0

    .line 750
    .end local v1    # "curr":Lcom/fasterxml/aalto/out/WNameTable$Bucket;
    :cond_0
    const-string v1, "NULL]"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 751
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    return-object v1
.end method
