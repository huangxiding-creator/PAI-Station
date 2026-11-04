.class final Lcom/fasterxml/aalto/in/CharBasedPNameTable$Bucket;
.super Ljava/lang/Object;
.source "CharBasedPNameTable.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/fasterxml/aalto/in/CharBasedPNameTable;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = "Bucket"
.end annotation


# instance fields
.field private final mNext:Lcom/fasterxml/aalto/in/CharBasedPNameTable$Bucket;

.field private final mSymbol:Lcom/fasterxml/aalto/in/PNameC;


# direct methods
.method public constructor <init>(Lcom/fasterxml/aalto/in/PNameC;Lcom/fasterxml/aalto/in/CharBasedPNameTable$Bucket;)V
    .locals 0
    .param p1, "symbol"    # Lcom/fasterxml/aalto/in/PNameC;
    .param p2, "next"    # Lcom/fasterxml/aalto/in/CharBasedPNameTable$Bucket;

    .line 354
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 355
    iput-object p1, p0, Lcom/fasterxml/aalto/in/CharBasedPNameTable$Bucket;->mSymbol:Lcom/fasterxml/aalto/in/PNameC;

    .line 356
    iput-object p2, p0, Lcom/fasterxml/aalto/in/CharBasedPNameTable$Bucket;->mNext:Lcom/fasterxml/aalto/in/CharBasedPNameTable$Bucket;

    .line 357
    return-void
.end method


# virtual methods
.method public find([CIII)Lcom/fasterxml/aalto/in/PNameC;
    .locals 3
    .param p1, "buf"    # [C
    .param p2, "start"    # I
    .param p3, "len"    # I
    .param p4, "hash"    # I

    .line 364
    move-object v0, p0

    .line 366
    .local v0, "b":Lcom/fasterxml/aalto/in/CharBasedPNameTable$Bucket;
    :cond_0
    iget-object v1, v0, Lcom/fasterxml/aalto/in/CharBasedPNameTable$Bucket;->mSymbol:Lcom/fasterxml/aalto/in/PNameC;

    .line 367
    .local v1, "sym":Lcom/fasterxml/aalto/in/PNameC;
    invoke-virtual {v1, p1, p2, p3, p4}, Lcom/fasterxml/aalto/in/PNameC;->equalsPName([CIII)Z

    move-result v2

    if-eqz v2, :cond_1

    .line 368
    return-object v1

    .line 370
    :cond_1
    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/CharBasedPNameTable$Bucket;->getNext()Lcom/fasterxml/aalto/in/CharBasedPNameTable$Bucket;

    move-result-object v0

    .line 371
    .end local v1    # "sym":Lcom/fasterxml/aalto/in/PNameC;
    if-nez v0, :cond_0

    .line 372
    const/4 v1, 0x0

    return-object v1
.end method

.method public getNext()Lcom/fasterxml/aalto/in/CharBasedPNameTable$Bucket;
    .locals 1

    .line 360
    iget-object v0, p0, Lcom/fasterxml/aalto/in/CharBasedPNameTable$Bucket;->mNext:Lcom/fasterxml/aalto/in/CharBasedPNameTable$Bucket;

    return-object v0
.end method

.method public getSymbol()Lcom/fasterxml/aalto/in/PNameC;
    .locals 1

    .line 359
    iget-object v0, p0, Lcom/fasterxml/aalto/in/CharBasedPNameTable$Bucket;->mSymbol:Lcom/fasterxml/aalto/in/PNameC;

    return-object v0
.end method
