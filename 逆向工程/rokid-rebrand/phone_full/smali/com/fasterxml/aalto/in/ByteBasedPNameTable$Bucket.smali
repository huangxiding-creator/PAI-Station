.class final Lcom/fasterxml/aalto/in/ByteBasedPNameTable$Bucket;
.super Ljava/lang/Object;
.source "ByteBasedPNameTable.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/fasterxml/aalto/in/ByteBasedPNameTable;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = "Bucket"
.end annotation


# instance fields
.field final mName:Lcom/fasterxml/aalto/in/ByteBasedPName;

.field final mNext:Lcom/fasterxml/aalto/in/ByteBasedPNameTable$Bucket;


# direct methods
.method constructor <init>(Lcom/fasterxml/aalto/in/ByteBasedPName;Lcom/fasterxml/aalto/in/ByteBasedPNameTable$Bucket;)V
    .locals 0
    .param p1, "name"    # Lcom/fasterxml/aalto/in/ByteBasedPName;
    .param p2, "next"    # Lcom/fasterxml/aalto/in/ByteBasedPNameTable$Bucket;

    .line 775
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 776
    iput-object p1, p0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable$Bucket;->mName:Lcom/fasterxml/aalto/in/ByteBasedPName;

    .line 777
    iput-object p2, p0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable$Bucket;->mNext:Lcom/fasterxml/aalto/in/ByteBasedPNameTable$Bucket;

    .line 778
    return-void
.end method


# virtual methods
.method public find(III)Lcom/fasterxml/aalto/in/ByteBasedPName;
    .locals 3
    .param p1, "hash"    # I
    .param p2, "firstQuad"    # I
    .param p3, "secondQuad"    # I

    .line 791
    iget-object v0, p0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable$Bucket;->mName:Lcom/fasterxml/aalto/in/ByteBasedPName;

    invoke-virtual {v0, p1, p2, p3}, Lcom/fasterxml/aalto/in/ByteBasedPName;->hashEquals(III)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 792
    iget-object v0, p0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable$Bucket;->mName:Lcom/fasterxml/aalto/in/ByteBasedPName;

    return-object v0

    .line 794
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable$Bucket;->mNext:Lcom/fasterxml/aalto/in/ByteBasedPNameTable$Bucket;

    .local v0, "curr":Lcom/fasterxml/aalto/in/ByteBasedPNameTable$Bucket;
    :goto_0
    if-eqz v0, :cond_2

    .line 795
    iget-object v1, v0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable$Bucket;->mName:Lcom/fasterxml/aalto/in/ByteBasedPName;

    .line 796
    .local v1, "currName":Lcom/fasterxml/aalto/in/ByteBasedPName;
    invoke-virtual {v1, p1, p2, p3}, Lcom/fasterxml/aalto/in/ByteBasedPName;->hashEquals(III)Z

    move-result v2

    if-eqz v2, :cond_1

    .line 797
    return-object v1

    .line 794
    .end local v1    # "currName":Lcom/fasterxml/aalto/in/ByteBasedPName;
    :cond_1
    iget-object v0, v0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable$Bucket;->mNext:Lcom/fasterxml/aalto/in/ByteBasedPNameTable$Bucket;

    goto :goto_0

    .line 800
    .end local v0    # "curr":Lcom/fasterxml/aalto/in/ByteBasedPNameTable$Bucket;
    :cond_2
    const/4 v0, 0x0

    return-object v0
.end method

.method public find(I[II)Lcom/fasterxml/aalto/in/ByteBasedPName;
    .locals 3
    .param p1, "hash"    # I
    .param p2, "quads"    # [I
    .param p3, "qlen"    # I

    .line 805
    iget-object v0, p0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable$Bucket;->mName:Lcom/fasterxml/aalto/in/ByteBasedPName;

    invoke-virtual {v0, p1, p2, p3}, Lcom/fasterxml/aalto/in/ByteBasedPName;->hashEquals(I[II)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 806
    iget-object v0, p0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable$Bucket;->mName:Lcom/fasterxml/aalto/in/ByteBasedPName;

    return-object v0

    .line 808
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable$Bucket;->mNext:Lcom/fasterxml/aalto/in/ByteBasedPNameTable$Bucket;

    .local v0, "curr":Lcom/fasterxml/aalto/in/ByteBasedPNameTable$Bucket;
    :goto_0
    if-eqz v0, :cond_2

    .line 809
    iget-object v1, v0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable$Bucket;->mName:Lcom/fasterxml/aalto/in/ByteBasedPName;

    .line 810
    .local v1, "currName":Lcom/fasterxml/aalto/in/ByteBasedPName;
    invoke-virtual {v1, p1, p2, p3}, Lcom/fasterxml/aalto/in/ByteBasedPName;->hashEquals(I[II)Z

    move-result v2

    if-eqz v2, :cond_1

    .line 811
    return-object v1

    .line 808
    .end local v1    # "currName":Lcom/fasterxml/aalto/in/ByteBasedPName;
    :cond_1
    iget-object v0, v0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable$Bucket;->mNext:Lcom/fasterxml/aalto/in/ByteBasedPNameTable$Bucket;

    goto :goto_0

    .line 814
    .end local v0    # "curr":Lcom/fasterxml/aalto/in/ByteBasedPNameTable$Bucket;
    :cond_2
    const/4 v0, 0x0

    return-object v0
.end method

.method public length()I
    .locals 2

    .line 782
    const/4 v0, 0x1

    .line 783
    .local v0, "len":I
    iget-object v1, p0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable$Bucket;->mNext:Lcom/fasterxml/aalto/in/ByteBasedPNameTable$Bucket;

    .local v1, "curr":Lcom/fasterxml/aalto/in/ByteBasedPNameTable$Bucket;
    :goto_0
    if-eqz v1, :cond_0

    .line 784
    add-int/lit8 v0, v0, 0x1

    .line 783
    iget-object v1, v1, Lcom/fasterxml/aalto/in/ByteBasedPNameTable$Bucket;->mNext:Lcom/fasterxml/aalto/in/ByteBasedPNameTable$Bucket;

    goto :goto_0

    .line 786
    .end local v1    # "curr":Lcom/fasterxml/aalto/in/ByteBasedPNameTable$Bucket;
    :cond_0
    return v0
.end method
