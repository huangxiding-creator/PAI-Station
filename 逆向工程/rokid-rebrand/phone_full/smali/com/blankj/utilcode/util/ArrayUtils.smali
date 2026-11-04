.class public Lcom/blankj/utilcode/util/ArrayUtils;
.super Ljava/lang/Object;
.source "ArrayUtils.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/blankj/utilcode/util/ArrayUtils$Closure;
    }
.end annotation


# static fields
.field public static final INDEX_NOT_FOUND:I = -0x1


# direct methods
.method private constructor <init>()V
    .locals 2

    .line 26
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 27
    new-instance v0, Ljava/lang/UnsupportedOperationException;

    const-string/jumbo v1, "u can\'t instantiate me..."

    invoke-direct {v0, v1}, Ljava/lang/UnsupportedOperationException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public static add([BB)[B
    .locals 2
    .param p0, "array"    # [B
    .param p1, "element"    # B

    .line 531
    invoke-static {p1}, Ljava/lang/Byte;->valueOf(B)Ljava/lang/Byte;

    move-result-object v0

    sget-object v1, Ljava/lang/Byte;->TYPE:Ljava/lang/Class;

    invoke-static {p0, v0, v1}, Lcom/blankj/utilcode/util/ArrayUtils;->realAddOne(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [B

    check-cast v0, [B

    return-object v0
.end method

.method public static add([BIB)[B
    .locals 2
    .param p0, "array"    # [B
    .param p1, "index"    # I
    .param p2, "element"    # B

    .line 841
    invoke-static {p2}, Ljava/lang/Byte;->valueOf(B)Ljava/lang/Byte;

    move-result-object v0

    sget-object v1, Ljava/lang/Byte;->TYPE:Ljava/lang/Class;

    invoke-static {p0, p1, v0, v1}, Lcom/blankj/utilcode/util/ArrayUtils;->realAdd(Ljava/lang/Object;ILjava/lang/Object;Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [B

    check-cast v0, [B

    return-object v0
.end method

.method public static add([BI[B)[B
    .locals 2
    .param p0, "array1"    # [B
    .param p1, "index"    # I
    .param p2, "array2"    # [B

    .line 716
    sget-object v0, Ljava/lang/Byte;->TYPE:Ljava/lang/Class;

    invoke-static {p0, p1, p2, v0}, Lcom/blankj/utilcode/util/ArrayUtils;->realAddArr(Ljava/lang/Object;ILjava/lang/Object;Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v0

    .line 717
    .local v0, "result":Ljava/lang/Object;
    if-nez v0, :cond_0

    const/4 v1, 0x0

    return-object v1

    .line 718
    :cond_0
    move-object v1, v0

    check-cast v1, [B

    check-cast v1, [B

    return-object v1
.end method

.method public static add([B[B)[B
    .locals 1
    .param p0, "array1"    # [B
    .param p1, "array2"    # [B

    .line 616
    invoke-static {p0, p1}, Lcom/blankj/utilcode/util/ArrayUtils;->realAddArr(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [B

    check-cast v0, [B

    return-object v0
.end method

.method public static add([CC)[C
    .locals 2
    .param p0, "array"    # [C
    .param p1, "element"    # C

    .line 536
    invoke-static {p1}, Ljava/lang/Character;->valueOf(C)Ljava/lang/Character;

    move-result-object v0

    sget-object v1, Ljava/lang/Character;->TYPE:Ljava/lang/Class;

    invoke-static {p0, v0, v1}, Lcom/blankj/utilcode/util/ArrayUtils;->realAddOne(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [C

    check-cast v0, [C

    return-object v0
.end method

.method public static add([CIC)[C
    .locals 2
    .param p0, "array"    # [C
    .param p1, "index"    # I
    .param p2, "element"    # C

    .line 836
    invoke-static {p2}, Ljava/lang/Character;->valueOf(C)Ljava/lang/Character;

    move-result-object v0

    sget-object v1, Ljava/lang/Character;->TYPE:Ljava/lang/Class;

    invoke-static {p0, p1, v0, v1}, Lcom/blankj/utilcode/util/ArrayUtils;->realAdd(Ljava/lang/Object;ILjava/lang/Object;Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [C

    check-cast v0, [C

    return-object v0
.end method

.method public static add([CI[C)[C
    .locals 2
    .param p0, "array1"    # [C
    .param p1, "index"    # I
    .param p2, "array2"    # [C

    .line 709
    sget-object v0, Ljava/lang/Character;->TYPE:Ljava/lang/Class;

    invoke-static {p0, p1, p2, v0}, Lcom/blankj/utilcode/util/ArrayUtils;->realAddArr(Ljava/lang/Object;ILjava/lang/Object;Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v0

    .line 710
    .local v0, "result":Ljava/lang/Object;
    if-nez v0, :cond_0

    const/4 v1, 0x0

    return-object v1

    .line 711
    :cond_0
    move-object v1, v0

    check-cast v1, [C

    check-cast v1, [C

    return-object v1
.end method

.method public static add([C[C)[C
    .locals 1
    .param p0, "array1"    # [C
    .param p1, "array2"    # [C

    .line 611
    invoke-static {p0, p1}, Lcom/blankj/utilcode/util/ArrayUtils;->realAddArr(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [C

    check-cast v0, [C

    return-object v0
.end method

.method public static add([DD)[D
    .locals 2
    .param p0, "array"    # [D
    .param p1, "element"    # D

    .line 541
    invoke-static {p1, p2}, Ljava/lang/Double;->valueOf(D)Ljava/lang/Double;

    move-result-object v0

    sget-object v1, Ljava/lang/Double;->TYPE:Ljava/lang/Class;

    invoke-static {p0, v0, v1}, Lcom/blankj/utilcode/util/ArrayUtils;->realAddOne(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [D

    check-cast v0, [D

    return-object v0
.end method

.method public static add([DID)[D
    .locals 2
    .param p0, "array"    # [D
    .param p1, "index"    # I
    .param p2, "element"    # D

    .line 866
    invoke-static {p2, p3}, Ljava/lang/Double;->valueOf(D)Ljava/lang/Double;

    move-result-object v0

    sget-object v1, Ljava/lang/Double;->TYPE:Ljava/lang/Class;

    invoke-static {p0, p1, v0, v1}, Lcom/blankj/utilcode/util/ArrayUtils;->realAdd(Ljava/lang/Object;ILjava/lang/Object;Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [D

    check-cast v0, [D

    return-object v0
.end method

.method public static add([DI[D)[D
    .locals 2
    .param p0, "array1"    # [D
    .param p1, "index"    # I
    .param p2, "array2"    # [D

    .line 751
    sget-object v0, Ljava/lang/Double;->TYPE:Ljava/lang/Class;

    invoke-static {p0, p1, p2, v0}, Lcom/blankj/utilcode/util/ArrayUtils;->realAddArr(Ljava/lang/Object;ILjava/lang/Object;Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v0

    .line 752
    .local v0, "result":Ljava/lang/Object;
    if-nez v0, :cond_0

    const/4 v1, 0x0

    return-object v1

    .line 753
    :cond_0
    move-object v1, v0

    check-cast v1, [D

    check-cast v1, [D

    return-object v1
.end method

.method public static add([D[D)[D
    .locals 1
    .param p0, "array1"    # [D
    .param p1, "array2"    # [D

    .line 641
    invoke-static {p0, p1}, Lcom/blankj/utilcode/util/ArrayUtils;->realAddArr(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [D

    check-cast v0, [D

    return-object v0
.end method

.method public static add([FF)[F
    .locals 2
    .param p0, "array"    # [F
    .param p1, "element"    # F

    .line 546
    invoke-static {p1}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object v0

    sget-object v1, Ljava/lang/Float;->TYPE:Ljava/lang/Class;

    invoke-static {p0, v0, v1}, Lcom/blankj/utilcode/util/ArrayUtils;->realAddOne(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [F

    check-cast v0, [F

    return-object v0
.end method

.method public static add([FIF)[F
    .locals 2
    .param p0, "array"    # [F
    .param p1, "index"    # I
    .param p2, "element"    # F

    .line 861
    invoke-static {p2}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object v0

    sget-object v1, Ljava/lang/Float;->TYPE:Ljava/lang/Class;

    invoke-static {p0, p1, v0, v1}, Lcom/blankj/utilcode/util/ArrayUtils;->realAdd(Ljava/lang/Object;ILjava/lang/Object;Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [F

    check-cast v0, [F

    return-object v0
.end method

.method public static add([FI[F)[F
    .locals 2
    .param p0, "array1"    # [F
    .param p1, "index"    # I
    .param p2, "array2"    # [F

    .line 744
    sget-object v0, Ljava/lang/Float;->TYPE:Ljava/lang/Class;

    invoke-static {p0, p1, p2, v0}, Lcom/blankj/utilcode/util/ArrayUtils;->realAddArr(Ljava/lang/Object;ILjava/lang/Object;Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v0

    .line 745
    .local v0, "result":Ljava/lang/Object;
    if-nez v0, :cond_0

    const/4 v1, 0x0

    return-object v1

    .line 746
    :cond_0
    move-object v1, v0

    check-cast v1, [F

    check-cast v1, [F

    return-object v1
.end method

.method public static add([F[F)[F
    .locals 1
    .param p0, "array1"    # [F
    .param p1, "array2"    # [F

    .line 636
    invoke-static {p0, p1}, Lcom/blankj/utilcode/util/ArrayUtils;->realAddArr(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [F

    check-cast v0, [F

    return-object v0
.end method

.method public static add([II)[I
    .locals 2
    .param p0, "array"    # [I
    .param p1, "element"    # I

    .line 551
    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    sget-object v1, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    invoke-static {p0, v0, v1}, Lcom/blankj/utilcode/util/ArrayUtils;->realAddOne(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [I

    check-cast v0, [I

    return-object v0
.end method

.method public static add([III)[I
    .locals 2
    .param p0, "array"    # [I
    .param p1, "index"    # I
    .param p2, "element"    # I

    .line 851
    invoke-static {p2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    sget-object v1, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    invoke-static {p0, p1, v0, v1}, Lcom/blankj/utilcode/util/ArrayUtils;->realAdd(Ljava/lang/Object;ILjava/lang/Object;Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [I

    check-cast v0, [I

    return-object v0
.end method

.method public static add([II[I)[I
    .locals 2
    .param p0, "array1"    # [I
    .param p1, "index"    # I
    .param p2, "array2"    # [I

    .line 730
    sget-object v0, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    invoke-static {p0, p1, p2, v0}, Lcom/blankj/utilcode/util/ArrayUtils;->realAddArr(Ljava/lang/Object;ILjava/lang/Object;Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v0

    .line 731
    .local v0, "result":Ljava/lang/Object;
    if-nez v0, :cond_0

    const/4 v1, 0x0

    return-object v1

    .line 732
    :cond_0
    move-object v1, v0

    check-cast v1, [I

    check-cast v1, [I

    return-object v1
.end method

.method public static add([I[I)[I
    .locals 1
    .param p0, "array1"    # [I
    .param p1, "array2"    # [I

    .line 626
    invoke-static {p0, p1}, Lcom/blankj/utilcode/util/ArrayUtils;->realAddArr(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [I

    check-cast v0, [I

    return-object v0
.end method

.method public static add([JIJ)[J
    .locals 2
    .param p0, "array"    # [J
    .param p1, "index"    # I
    .param p2, "element"    # J

    .line 856
    invoke-static {p2, p3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v0

    sget-object v1, Ljava/lang/Long;->TYPE:Ljava/lang/Class;

    invoke-static {p0, p1, v0, v1}, Lcom/blankj/utilcode/util/ArrayUtils;->realAdd(Ljava/lang/Object;ILjava/lang/Object;Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [J

    check-cast v0, [J

    return-object v0
.end method

.method public static add([JI[J)[J
    .locals 2
    .param p0, "array1"    # [J
    .param p1, "index"    # I
    .param p2, "array2"    # [J

    .line 737
    sget-object v0, Ljava/lang/Long;->TYPE:Ljava/lang/Class;

    invoke-static {p0, p1, p2, v0}, Lcom/blankj/utilcode/util/ArrayUtils;->realAddArr(Ljava/lang/Object;ILjava/lang/Object;Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v0

    .line 738
    .local v0, "result":Ljava/lang/Object;
    if-nez v0, :cond_0

    const/4 v1, 0x0

    return-object v1

    .line 739
    :cond_0
    move-object v1, v0

    check-cast v1, [J

    check-cast v1, [J

    return-object v1
.end method

.method public static add([JJ)[J
    .locals 2
    .param p0, "array"    # [J
    .param p1, "element"    # J

    .line 556
    invoke-static {p1, p2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v0

    sget-object v1, Ljava/lang/Long;->TYPE:Ljava/lang/Class;

    invoke-static {p0, v0, v1}, Lcom/blankj/utilcode/util/ArrayUtils;->realAddOne(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [J

    check-cast v0, [J

    return-object v0
.end method

.method public static add([J[J)[J
    .locals 1
    .param p0, "array1"    # [J
    .param p1, "array2"    # [J

    .line 631
    invoke-static {p0, p1}, Lcom/blankj/utilcode/util/ArrayUtils;->realAddArr(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [J

    check-cast v0, [J

    return-object v0
.end method

.method public static add([Ljava/lang/Object;ILjava/lang/Object;)[Ljava/lang/Object;
    .locals 2
    .param p1, "index"    # I
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">([TT;ITT;)[TT;"
        }
    .end annotation

    .line 819
    .local p0, "array":[Ljava/lang/Object;, "[TT;"
    .local p2, "element":Ljava/lang/Object;, "TT;"
    if-eqz p0, :cond_0

    .line 820
    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Class;->getComponentType()Ljava/lang/Class;

    move-result-object v0

    .local v0, "clss":Ljava/lang/Class;
    goto :goto_0

    .line 821
    .end local v0    # "clss":Ljava/lang/Class;
    :cond_0
    if-eqz p2, :cond_1

    .line 822
    invoke-virtual {p2}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v0

    .line 826
    .restart local v0    # "clss":Ljava/lang/Class;
    :goto_0
    invoke-static {p0, p1, p2, v0}, Lcom/blankj/utilcode/util/ArrayUtils;->realAdd(Ljava/lang/Object;ILjava/lang/Object;Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, [Ljava/lang/Object;

    check-cast v1, [Ljava/lang/Object;

    return-object v1

    .line 824
    .end local v0    # "clss":Ljava/lang/Class;
    :cond_1
    const/4 v0, 0x0

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Ljava/lang/Object;

    return-object v0
.end method

.method public static add([Ljava/lang/Object;I[Ljava/lang/Object;)[Ljava/lang/Object;
    .locals 2
    .param p1, "index"    # I
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">([TT;I[TT;)[TT;"
        }
    .end annotation

    .line 691
    .local p0, "array1":[Ljava/lang/Object;, "[TT;"
    .local p2, "array2":[Ljava/lang/Object;, "[TT;"
    if-eqz p0, :cond_0

    .line 692
    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Class;->getComponentType()Ljava/lang/Class;

    move-result-object v0

    .local v0, "clss":Ljava/lang/Class;
    goto :goto_0

    .line 693
    .end local v0    # "clss":Ljava/lang/Class;
    :cond_0
    if-eqz p2, :cond_1

    .line 694
    invoke-virtual {p2}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Class;->getComponentType()Ljava/lang/Class;

    move-result-object v0

    .line 698
    .restart local v0    # "clss":Ljava/lang/Class;
    :goto_0
    invoke-static {p0, p1, p2, v0}, Lcom/blankj/utilcode/util/ArrayUtils;->realAddArr(Ljava/lang/Object;ILjava/lang/Object;Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, [Ljava/lang/Object;

    check-cast v1, [Ljava/lang/Object;

    return-object v1

    .line 696
    .end local v0    # "clss":Ljava/lang/Class;
    :cond_1
    const/4 v0, 0x0

    return-object v0
.end method

.method public static add([Ljava/lang/Object;Ljava/lang/Object;)[Ljava/lang/Object;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">([TT;TT;)[TT;"
        }
    .end annotation

    .line 520
    .local p0, "array":[Ljava/lang/Object;, "[TT;"
    .local p1, "element":Ljava/lang/Object;, "TT;"
    if-eqz p0, :cond_0

    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v0

    goto :goto_0

    :cond_0
    if-eqz p1, :cond_1

    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v0

    goto :goto_0

    :cond_1
    const-class v0, Ljava/lang/Object;

    .line 521
    .local v0, "type":Ljava/lang/Class;
    :goto_0
    invoke-static {p0, p1, v0}, Lcom/blankj/utilcode/util/ArrayUtils;->realAddOne(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, [Ljava/lang/Object;

    check-cast v1, [Ljava/lang/Object;

    return-object v1
.end method

.method public static add([Ljava/lang/Object;[Ljava/lang/Object;)[Ljava/lang/Object;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">([TT;[TT;)[TT;"
        }
    .end annotation

    .line 601
    .local p0, "array1":[Ljava/lang/Object;, "[TT;"
    .local p1, "array2":[Ljava/lang/Object;, "[TT;"
    invoke-static {p0, p1}, Lcom/blankj/utilcode/util/ArrayUtils;->realAddArr(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Ljava/lang/Object;

    check-cast v0, [Ljava/lang/Object;

    return-object v0
.end method

.method public static add([SIS)[S
    .locals 2
    .param p0, "array"    # [S
    .param p1, "index"    # I
    .param p2, "element"    # S

    .line 846
    invoke-static {p2}, Ljava/lang/Short;->valueOf(S)Ljava/lang/Short;

    move-result-object v0

    sget-object v1, Ljava/lang/Short;->TYPE:Ljava/lang/Class;

    invoke-static {p0, p1, v0, v1}, Lcom/blankj/utilcode/util/ArrayUtils;->realAdd(Ljava/lang/Object;ILjava/lang/Object;Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [S

    check-cast v0, [S

    return-object v0
.end method

.method public static add([SI[S)[S
    .locals 2
    .param p0, "array1"    # [S
    .param p1, "index"    # I
    .param p2, "array2"    # [S

    .line 723
    sget-object v0, Ljava/lang/Short;->TYPE:Ljava/lang/Class;

    invoke-static {p0, p1, p2, v0}, Lcom/blankj/utilcode/util/ArrayUtils;->realAddArr(Ljava/lang/Object;ILjava/lang/Object;Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v0

    .line 724
    .local v0, "result":Ljava/lang/Object;
    if-nez v0, :cond_0

    const/4 v1, 0x0

    return-object v1

    .line 725
    :cond_0
    move-object v1, v0

    check-cast v1, [S

    check-cast v1, [S

    return-object v1
.end method

.method public static add([SS)[S
    .locals 2
    .param p0, "array"    # [S
    .param p1, "element"    # S

    .line 561
    invoke-static {p1}, Ljava/lang/Short;->valueOf(S)Ljava/lang/Short;

    move-result-object v0

    sget-object v1, Ljava/lang/Short;->TYPE:Ljava/lang/Class;

    invoke-static {p0, v0, v1}, Lcom/blankj/utilcode/util/ArrayUtils;->realAddOne(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [S

    check-cast v0, [S

    return-object v0
.end method

.method public static add([S[S)[S
    .locals 1
    .param p0, "array1"    # [S
    .param p1, "array2"    # [S

    .line 621
    invoke-static {p0, p1}, Lcom/blankj/utilcode/util/ArrayUtils;->realAddArr(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [S

    check-cast v0, [S

    return-object v0
.end method

.method public static add([ZIZ)[Z
    .locals 2
    .param p0, "array"    # [Z
    .param p1, "index"    # I
    .param p2, "element"    # Z

    .line 831
    invoke-static {p2}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v0

    sget-object v1, Ljava/lang/Boolean;->TYPE:Ljava/lang/Class;

    invoke-static {p0, p1, v0, v1}, Lcom/blankj/utilcode/util/ArrayUtils;->realAdd(Ljava/lang/Object;ILjava/lang/Object;Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Z

    check-cast v0, [Z

    return-object v0
.end method

.method public static add([ZI[Z)[Z
    .locals 2
    .param p0, "array1"    # [Z
    .param p1, "index"    # I
    .param p2, "array2"    # [Z

    .line 703
    sget-object v0, Ljava/lang/Boolean;->TYPE:Ljava/lang/Class;

    invoke-static {p0, p1, p2, v0}, Lcom/blankj/utilcode/util/ArrayUtils;->realAddArr(Ljava/lang/Object;ILjava/lang/Object;Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v0

    .line 704
    .local v0, "result":Ljava/lang/Object;
    if-nez v0, :cond_0

    const/4 v1, 0x0

    return-object v1

    .line 705
    :cond_0
    move-object v1, v0

    check-cast v1, [Z

    check-cast v1, [Z

    return-object v1
.end method

.method public static add([ZZ)[Z
    .locals 2
    .param p0, "array"    # [Z
    .param p1, "element"    # Z

    .line 526
    invoke-static {p1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v0

    sget-object v1, Ljava/lang/Boolean;->TYPE:Ljava/lang/Class;

    invoke-static {p0, v0, v1}, Lcom/blankj/utilcode/util/ArrayUtils;->realAddOne(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Z

    check-cast v0, [Z

    return-object v0
.end method

.method public static add([Z[Z)[Z
    .locals 1
    .param p0, "array1"    # [Z
    .param p1, "array2"    # [Z

    .line 606
    invoke-static {p0, p1}, Lcom/blankj/utilcode/util/ArrayUtils;->realAddArr(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Z

    check-cast v0, [Z

    return-object v0
.end method

.method public static varargs asArrayList([Ljava/lang/Object;)Ljava/util/List;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">([TT;)",
            "Ljava/util/List<",
            "TT;>;"
        }
    .end annotation

    .line 1986
    .local p0, "array":[Ljava/lang/Object;, "[TT;"
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    .line 1987
    .local v0, "list":Ljava/util/List;, "Ljava/util/List<TT;>;"
    if-eqz p0, :cond_1

    array-length v1, p0

    if-nez v1, :cond_0

    goto :goto_0

    .line 1988
    :cond_0
    invoke-static {p0}, Ljava/util/Arrays;->asList([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->addAll(Ljava/util/Collection;)Z

    .line 1989
    return-object v0

    .line 1987
    :cond_1
    :goto_0
    return-object v0
.end method

.method public static varargs asLinkedList([Ljava/lang/Object;)Ljava/util/List;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">([TT;)",
            "Ljava/util/List<",
            "TT;>;"
        }
    .end annotation

    .line 1994
    .local p0, "array":[Ljava/lang/Object;, "[TT;"
    new-instance v0, Ljava/util/LinkedList;

    invoke-direct {v0}, Ljava/util/LinkedList;-><init>()V

    .line 1995
    .local v0, "list":Ljava/util/List;, "Ljava/util/List<TT;>;"
    if-eqz p0, :cond_1

    array-length v1, p0

    if-nez v1, :cond_0

    goto :goto_0

    .line 1996
    :cond_0
    invoke-static {p0}, Ljava/util/Arrays;->asList([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->addAll(Ljava/util/Collection;)Z

    .line 1997
    return-object v0

    .line 1995
    :cond_1
    :goto_0
    return-object v0
.end method

.method public static varargs asList([Ljava/lang/Object;)Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">([TT;)",
            "Ljava/util/List<",
            "TT;>;"
        }
    .end annotation

    .line 1973
    .local p0, "array":[Ljava/lang/Object;, "[TT;"
    if-eqz p0, :cond_1

    array-length v0, p0

    if-nez v0, :cond_0

    goto :goto_0

    .line 1976
    :cond_0
    invoke-static {p0}, Ljava/util/Arrays;->asList([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v0

    return-object v0

    .line 1974
    :cond_1
    :goto_0
    invoke-static {}, Ljava/util/Collections;->emptyList()Ljava/util/List;

    move-result-object v0

    return-object v0
.end method

.method public static varargs asUnmodifiableList([Ljava/lang/Object;)Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">([TT;)",
            "Ljava/util/List<",
            "TT;>;"
        }
    .end annotation

    .line 1981
    .local p0, "array":[Ljava/lang/Object;, "[TT;"
    invoke-static {p0}, Lcom/blankj/utilcode/util/ArrayUtils;->asList([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v0

    invoke-static {v0}, Ljava/util/Collections;->unmodifiableList(Ljava/util/List;)Ljava/util/List;

    move-result-object v0

    return-object v0
.end method

.method public static contains([BB)Z
    .locals 2
    .param p0, "array"    # [B
    .param p1, "valueToFind"    # B

    .line 1400
    invoke-static {p0, p1}, Lcom/blankj/utilcode/util/ArrayUtils;->indexOf([BB)I

    move-result v0

    const/4 v1, -0x1

    if-eq v0, v1, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public static contains([CC)Z
    .locals 2
    .param p0, "array"    # [C
    .param p1, "valueToFind"    # C

    .line 1352
    invoke-static {p0, p1}, Lcom/blankj/utilcode/util/ArrayUtils;->indexOf([CC)I

    move-result v0

    const/4 v1, -0x1

    if-eq v0, v1, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public static contains([DD)Z
    .locals 2
    .param p0, "array"    # [D
    .param p1, "valueToFind"    # D

    .line 1492
    invoke-static {p0, p1, p2}, Lcom/blankj/utilcode/util/ArrayUtils;->indexOf([DD)I

    move-result v0

    const/4 v1, -0x1

    if-eq v0, v1, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public static contains([DDD)Z
    .locals 6
    .param p0, "array"    # [D
    .param p1, "valueToFind"    # D
    .param p3, "tolerance"    # D

    .line 1496
    const/4 v3, 0x0

    move-object v0, p0

    move-wide v1, p1

    move-wide v4, p3

    invoke-static/range {v0 .. v5}, Lcom/blankj/utilcode/util/ArrayUtils;->indexOf([DDID)I

    move-result v0

    const/4 v1, -0x1

    if-eq v0, v1, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public static contains([FF)Z
    .locals 2
    .param p0, "array"    # [F
    .param p1, "valueToFind"    # F

    .line 1544
    invoke-static {p0, p1}, Lcom/blankj/utilcode/util/ArrayUtils;->indexOf([FF)I

    move-result v0

    const/4 v1, -0x1

    if-eq v0, v1, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public static contains([II)Z
    .locals 2
    .param p0, "array"    # [I
    .param p1, "valueToFind"    # I

    .line 1256
    invoke-static {p0, p1}, Lcom/blankj/utilcode/util/ArrayUtils;->indexOf([II)I

    move-result v0

    const/4 v1, -0x1

    if-eq v0, v1, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public static contains([JJ)Z
    .locals 2
    .param p0, "array"    # [J
    .param p1, "valueToFind"    # J

    .line 1208
    invoke-static {p0, p1, p2}, Lcom/blankj/utilcode/util/ArrayUtils;->indexOf([JJ)I

    move-result v0

    const/4 v1, -0x1

    if-eq v0, v1, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public static contains([Ljava/lang/Object;Ljava/lang/Object;)Z
    .locals 2
    .param p0, "array"    # [Ljava/lang/Object;
    .param p1, "objectToFind"    # Ljava/lang/Object;

    .line 1160
    invoke-static {p0, p1}, Lcom/blankj/utilcode/util/ArrayUtils;->indexOf([Ljava/lang/Object;Ljava/lang/Object;)I

    move-result v0

    const/4 v1, -0x1

    if-eq v0, v1, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public static contains([SS)Z
    .locals 2
    .param p0, "array"    # [S
    .param p1, "valueToFind"    # S

    .line 1304
    invoke-static {p0, p1}, Lcom/blankj/utilcode/util/ArrayUtils;->indexOf([SS)I

    move-result v0

    const/4 v1, -0x1

    if-eq v0, v1, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public static contains([ZZ)Z
    .locals 2
    .param p0, "array"    # [Z
    .param p1, "valueToFind"    # Z

    .line 1592
    invoke-static {p0, p1}, Lcom/blankj/utilcode/util/ArrayUtils;->indexOf([ZZ)I

    move-result v0

    const/4 v1, -0x1

    if-eq v0, v1, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public static copy([B)[B
    .locals 2
    .param p0, "array"    # [B

    .line 392
    if-nez p0, :cond_0

    const/4 v0, 0x0

    return-object v0

    .line 393
    :cond_0
    const/4 v0, 0x0

    array-length v1, p0

    invoke-static {p0, v0, v1}, Lcom/blankj/utilcode/util/ArrayUtils;->subArray([BII)[B

    move-result-object v0

    return-object v0
.end method

.method public static copy([C)[C
    .locals 2
    .param p0, "array"    # [C

    .line 386
    if-nez p0, :cond_0

    const/4 v0, 0x0

    return-object v0

    .line 387
    :cond_0
    const/4 v0, 0x0

    array-length v1, p0

    invoke-static {p0, v0, v1}, Lcom/blankj/utilcode/util/ArrayUtils;->subArray([CII)[C

    move-result-object v0

    return-object v0
.end method

.method public static copy([D)[D
    .locals 2
    .param p0, "array"    # [D

    .line 398
    if-nez p0, :cond_0

    const/4 v0, 0x0

    return-object v0

    .line 399
    :cond_0
    const/4 v0, 0x0

    array-length v1, p0

    invoke-static {p0, v0, v1}, Lcom/blankj/utilcode/util/ArrayUtils;->subArray([DII)[D

    move-result-object v0

    return-object v0
.end method

.method public static copy([F)[F
    .locals 2
    .param p0, "array"    # [F

    .line 404
    if-nez p0, :cond_0

    const/4 v0, 0x0

    return-object v0

    .line 405
    :cond_0
    const/4 v0, 0x0

    array-length v1, p0

    invoke-static {p0, v0, v1}, Lcom/blankj/utilcode/util/ArrayUtils;->subArray([FII)[F

    move-result-object v0

    return-object v0
.end method

.method public static copy([I)[I
    .locals 2
    .param p0, "array"    # [I

    .line 374
    if-nez p0, :cond_0

    const/4 v0, 0x0

    return-object v0

    .line 375
    :cond_0
    const/4 v0, 0x0

    array-length v1, p0

    invoke-static {p0, v0, v1}, Lcom/blankj/utilcode/util/ArrayUtils;->subArray([III)[I

    move-result-object v0

    return-object v0
.end method

.method public static copy([J)[J
    .locals 2
    .param p0, "array"    # [J

    .line 368
    if-nez p0, :cond_0

    const/4 v0, 0x0

    return-object v0

    .line 369
    :cond_0
    const/4 v0, 0x0

    array-length v1, p0

    invoke-static {p0, v0, v1}, Lcom/blankj/utilcode/util/ArrayUtils;->subArray([JII)[J

    move-result-object v0

    return-object v0
.end method

.method public static copy([Ljava/lang/Object;)[Ljava/lang/Object;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">([TT;)[TT;"
        }
    .end annotation

    .line 362
    .local p0, "array":[Ljava/lang/Object;, "[TT;"
    if-nez p0, :cond_0

    const/4 v0, 0x0

    return-object v0

    .line 363
    :cond_0
    const/4 v0, 0x0

    array-length v1, p0

    invoke-static {p0, v0, v1}, Lcom/blankj/utilcode/util/ArrayUtils;->subArray([Ljava/lang/Object;II)[Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public static copy([S)[S
    .locals 2
    .param p0, "array"    # [S

    .line 380
    if-nez p0, :cond_0

    const/4 v0, 0x0

    return-object v0

    .line 381
    :cond_0
    const/4 v0, 0x0

    array-length v1, p0

    invoke-static {p0, v0, v1}, Lcom/blankj/utilcode/util/ArrayUtils;->subArray([SII)[S

    move-result-object v0

    return-object v0
.end method

.method public static copy([Z)[Z
    .locals 2
    .param p0, "array"    # [Z

    .line 410
    if-nez p0, :cond_0

    const/4 v0, 0x0

    return-object v0

    .line 411
    :cond_0
    const/4 v0, 0x0

    array-length v1, p0

    invoke-static {p0, v0, v1}, Lcom/blankj/utilcode/util/ArrayUtils;->subArray([ZII)[Z

    move-result-object v0

    return-object v0
.end method

.method public static equals([B[B)Z
    .locals 1
    .param p0, "a"    # [B
    .param p1, "a2"    # [B

    .line 164
    invoke-static {p0, p1}, Ljava/util/Arrays;->equals([B[B)Z

    move-result v0

    return v0
.end method

.method public static equals([C[C)Z
    .locals 1
    .param p0, "a"    # [C
    .param p1, "a2"    # [C

    .line 168
    invoke-static {p0, p1}, Ljava/util/Arrays;->equals([C[C)Z

    move-result v0

    return v0
.end method

.method public static equals([D[D)Z
    .locals 1
    .param p0, "a"    # [D
    .param p1, "a2"    # [D

    .line 172
    invoke-static {p0, p1}, Ljava/util/Arrays;->equals([D[D)Z

    move-result v0

    return v0
.end method

.method public static equals([F[F)Z
    .locals 1
    .param p0, "a"    # [F
    .param p1, "a2"    # [F

    .line 176
    invoke-static {p0, p1}, Ljava/util/Arrays;->equals([F[F)Z

    move-result v0

    return v0
.end method

.method public static equals([I[I)Z
    .locals 1
    .param p0, "a"    # [I
    .param p1, "a2"    # [I

    .line 180
    invoke-static {p0, p1}, Ljava/util/Arrays;->equals([I[I)Z

    move-result v0

    return v0
.end method

.method public static equals([Ljava/lang/Object;[Ljava/lang/Object;)Z
    .locals 1
    .param p0, "a"    # [Ljava/lang/Object;
    .param p1, "a2"    # [Ljava/lang/Object;

    .line 156
    invoke-static {p0, p1}, Ljava/util/Arrays;->deepEquals([Ljava/lang/Object;[Ljava/lang/Object;)Z

    move-result v0

    return v0
.end method

.method public static equals([S[S)Z
    .locals 1
    .param p0, "a"    # [S
    .param p1, "a2"    # [S

    .line 184
    invoke-static {p0, p1}, Ljava/util/Arrays;->equals([S[S)Z

    move-result v0

    return v0
.end method

.method public static equals([Z[Z)Z
    .locals 1
    .param p0, "a"    # [Z
    .param p1, "a2"    # [Z

    .line 160
    invoke-static {p0, p1}, Ljava/util/Arrays;->equals([Z[Z)Z

    move-result v0

    return v0
.end method

.method public static forAllDo(Ljava/lang/Object;Lcom/blankj/utilcode/util/ArrayUtils$Closure;)V
    .locals 6
    .param p0, "array"    # Ljava/lang/Object;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<E:",
            "Ljava/lang/Object;",
            ">(",
            "Ljava/lang/Object;",
            "Lcom/blankj/utilcode/util/ArrayUtils$Closure<",
            "TE;>;)V"
        }
    .end annotation

    .line 2049
    .local p1, "closure":Lcom/blankj/utilcode/util/ArrayUtils$Closure;, "Lcom/blankj/utilcode/util/ArrayUtils$Closure<TE;>;"
    if-eqz p0, :cond_14

    if-nez p1, :cond_0

    goto/16 :goto_b

    .line 2050
    :cond_0
    instance-of v0, p0, [Ljava/lang/Object;

    if-eqz v0, :cond_2

    .line 2051
    move-object v0, p0

    check-cast v0, [Ljava/lang/Object;

    check-cast v0, [Ljava/lang/Object;

    .line 2052
    .local v0, "objects":[Ljava/lang/Object;
    const/4 v1, 0x0

    .local v1, "i":I
    array-length v2, v0

    .local v2, "length":I
    :goto_0
    if-ge v1, v2, :cond_1

    .line 2053
    aget-object v3, v0, v1

    .line 2054
    .local v3, "ele":Ljava/lang/Object;
    invoke-interface {p1, v1, v3}, Lcom/blankj/utilcode/util/ArrayUtils$Closure;->execute(ILjava/lang/Object;)V

    .line 2052
    .end local v3    # "ele":Ljava/lang/Object;
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 2056
    .end local v0    # "objects":[Ljava/lang/Object;
    .end local v1    # "i":I
    .end local v2    # "length":I
    :cond_1
    goto/16 :goto_a

    :cond_2
    instance-of v0, p0, [Z

    if-eqz v0, :cond_5

    .line 2057
    move-object v0, p0

    check-cast v0, [Z

    check-cast v0, [Z

    .line 2058
    .local v0, "booleans":[Z
    const/4 v1, 0x0

    .restart local v1    # "i":I
    array-length v2, v0

    .restart local v2    # "length":I
    :goto_1
    if-ge v1, v2, :cond_4

    .line 2059
    aget-boolean v3, v0, v1

    .line 2060
    .local v3, "ele":Z
    if-eqz v3, :cond_3

    sget-object v4, Ljava/lang/Boolean;->TRUE:Ljava/lang/Boolean;

    goto :goto_2

    :cond_3
    sget-object v4, Ljava/lang/Boolean;->FALSE:Ljava/lang/Boolean;

    :goto_2
    invoke-interface {p1, v1, v4}, Lcom/blankj/utilcode/util/ArrayUtils$Closure;->execute(ILjava/lang/Object;)V

    .line 2058
    .end local v3    # "ele":Z
    add-int/lit8 v1, v1, 0x1

    goto :goto_1

    .line 2062
    .end local v0    # "booleans":[Z
    .end local v1    # "i":I
    .end local v2    # "length":I
    :cond_4
    goto/16 :goto_a

    :cond_5
    instance-of v0, p0, [B

    if-eqz v0, :cond_7

    .line 2063
    move-object v0, p0

    check-cast v0, [B

    check-cast v0, [B

    .line 2064
    .local v0, "bytes":[B
    const/4 v1, 0x0

    .restart local v1    # "i":I
    array-length v2, v0

    .restart local v2    # "length":I
    :goto_3
    if-ge v1, v2, :cond_6

    .line 2065
    aget-byte v3, v0, v1

    .line 2066
    .local v3, "ele":B
    invoke-static {v3}, Ljava/lang/Byte;->valueOf(B)Ljava/lang/Byte;

    move-result-object v4

    invoke-interface {p1, v1, v4}, Lcom/blankj/utilcode/util/ArrayUtils$Closure;->execute(ILjava/lang/Object;)V

    .line 2064
    .end local v3    # "ele":B
    add-int/lit8 v1, v1, 0x1

    goto :goto_3

    .line 2068
    .end local v0    # "bytes":[B
    .end local v1    # "i":I
    .end local v2    # "length":I
    :cond_6
    goto/16 :goto_a

    :cond_7
    instance-of v0, p0, [C

    if-eqz v0, :cond_9

    .line 2069
    move-object v0, p0

    check-cast v0, [C

    check-cast v0, [C

    .line 2070
    .local v0, "chars":[C
    const/4 v1, 0x0

    .restart local v1    # "i":I
    array-length v2, v0

    .restart local v2    # "length":I
    :goto_4
    if-ge v1, v2, :cond_8

    .line 2071
    aget-char v3, v0, v1

    .line 2072
    .local v3, "ele":C
    invoke-static {v3}, Ljava/lang/Character;->valueOf(C)Ljava/lang/Character;

    move-result-object v4

    invoke-interface {p1, v1, v4}, Lcom/blankj/utilcode/util/ArrayUtils$Closure;->execute(ILjava/lang/Object;)V

    .line 2070
    .end local v3    # "ele":C
    add-int/lit8 v1, v1, 0x1

    goto :goto_4

    .line 2074
    .end local v0    # "chars":[C
    .end local v1    # "i":I
    .end local v2    # "length":I
    :cond_8
    goto/16 :goto_a

    :cond_9
    instance-of v0, p0, [S

    if-eqz v0, :cond_b

    .line 2075
    move-object v0, p0

    check-cast v0, [S

    check-cast v0, [S

    .line 2076
    .local v0, "shorts":[S
    const/4 v1, 0x0

    .restart local v1    # "i":I
    array-length v2, v0

    .restart local v2    # "length":I
    :goto_5
    if-ge v1, v2, :cond_a

    .line 2077
    aget-short v3, v0, v1

    .line 2078
    .local v3, "ele":S
    invoke-static {v3}, Ljava/lang/Short;->valueOf(S)Ljava/lang/Short;

    move-result-object v4

    invoke-interface {p1, v1, v4}, Lcom/blankj/utilcode/util/ArrayUtils$Closure;->execute(ILjava/lang/Object;)V

    .line 2076
    .end local v3    # "ele":S
    add-int/lit8 v1, v1, 0x1

    goto :goto_5

    .line 2080
    .end local v0    # "shorts":[S
    .end local v1    # "i":I
    .end local v2    # "length":I
    :cond_a
    goto/16 :goto_a

    :cond_b
    instance-of v0, p0, [I

    if-eqz v0, :cond_d

    .line 2081
    move-object v0, p0

    check-cast v0, [I

    check-cast v0, [I

    .line 2082
    .local v0, "ints":[I
    const/4 v1, 0x0

    .restart local v1    # "i":I
    array-length v2, v0

    .restart local v2    # "length":I
    :goto_6
    if-ge v1, v2, :cond_c

    .line 2083
    aget v3, v0, v1

    .line 2084
    .local v3, "ele":I
    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    invoke-interface {p1, v1, v4}, Lcom/blankj/utilcode/util/ArrayUtils$Closure;->execute(ILjava/lang/Object;)V

    .line 2082
    .end local v3    # "ele":I
    add-int/lit8 v1, v1, 0x1

    goto :goto_6

    .line 2086
    .end local v0    # "ints":[I
    .end local v1    # "i":I
    .end local v2    # "length":I
    :cond_c
    goto :goto_a

    :cond_d
    instance-of v0, p0, [J

    if-eqz v0, :cond_f

    .line 2087
    move-object v0, p0

    check-cast v0, [J

    check-cast v0, [J

    .line 2088
    .local v0, "longs":[J
    const/4 v1, 0x0

    .restart local v1    # "i":I
    array-length v2, v0

    .restart local v2    # "length":I
    :goto_7
    if-ge v1, v2, :cond_e

    .line 2089
    aget-wide v3, v0, v1

    .line 2090
    .local v3, "ele":J
    invoke-static {v3, v4}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v5

    invoke-interface {p1, v1, v5}, Lcom/blankj/utilcode/util/ArrayUtils$Closure;->execute(ILjava/lang/Object;)V

    .line 2088
    .end local v3    # "ele":J
    add-int/lit8 v1, v1, 0x1

    goto :goto_7

    .line 2092
    .end local v0    # "longs":[J
    .end local v1    # "i":I
    .end local v2    # "length":I
    :cond_e
    goto :goto_a

    :cond_f
    instance-of v0, p0, [F

    if-eqz v0, :cond_11

    .line 2093
    move-object v0, p0

    check-cast v0, [F

    check-cast v0, [F

    .line 2094
    .local v0, "floats":[F
    const/4 v1, 0x0

    .restart local v1    # "i":I
    array-length v2, v0

    .restart local v2    # "length":I
    :goto_8
    if-ge v1, v2, :cond_10

    .line 2095
    aget v3, v0, v1

    .line 2096
    .local v3, "ele":F
    invoke-static {v3}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object v4

    invoke-interface {p1, v1, v4}, Lcom/blankj/utilcode/util/ArrayUtils$Closure;->execute(ILjava/lang/Object;)V

    .line 2094
    .end local v3    # "ele":F
    add-int/lit8 v1, v1, 0x1

    goto :goto_8

    .line 2098
    .end local v0    # "floats":[F
    .end local v1    # "i":I
    .end local v2    # "length":I
    :cond_10
    goto :goto_a

    :cond_11
    instance-of v0, p0, [D

    if-eqz v0, :cond_13

    .line 2099
    move-object v0, p0

    check-cast v0, [D

    check-cast v0, [D

    .line 2100
    .local v0, "doubles":[D
    const/4 v1, 0x0

    .restart local v1    # "i":I
    array-length v2, v0

    .restart local v2    # "length":I
    :goto_9
    if-ge v1, v2, :cond_12

    .line 2101
    aget-wide v3, v0, v1

    .line 2102
    .local v3, "ele":D
    invoke-static {v3, v4}, Ljava/lang/Double;->valueOf(D)Ljava/lang/Double;

    move-result-object v5

    invoke-interface {p1, v1, v5}, Lcom/blankj/utilcode/util/ArrayUtils$Closure;->execute(ILjava/lang/Object;)V

    .line 2100
    .end local v3    # "ele":D
    add-int/lit8 v1, v1, 0x1

    goto :goto_9

    .line 2104
    .end local v0    # "doubles":[D
    .end local v1    # "i":I
    .end local v2    # "length":I
    :cond_12
    nop

    .line 2107
    :goto_a
    return-void

    .line 2105
    :cond_13
    new-instance v0, Ljava/lang/IllegalArgumentException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Not an array: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 2049
    :cond_14
    :goto_b
    return-void
.end method

.method public static get(Ljava/lang/Object;I)Ljava/lang/Object;
    .locals 1
    .param p0, "array"    # Ljava/lang/Object;
    .param p1, "index"    # I

    .line 115
    const/4 v0, 0x0

    invoke-static {p0, p1, v0}, Lcom/blankj/utilcode/util/ArrayUtils;->get(Ljava/lang/Object;ILjava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public static get(Ljava/lang/Object;ILjava/lang/Object;)Ljava/lang/Object;
    .locals 1
    .param p0, "array"    # Ljava/lang/Object;
    .param p1, "index"    # I
    .param p2, "defaultValue"    # Ljava/lang/Object;

    .line 128
    if-nez p0, :cond_0

    return-object p2

    .line 130
    :cond_0
    :try_start_0
    invoke-static {p0, p1}, Ljava/lang/reflect/Array;->get(Ljava/lang/Object;I)Ljava/lang/Object;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    .line 131
    :catch_0
    move-exception v0

    .line 132
    .local v0, "ignore":Ljava/lang/Exception;
    return-object p2
.end method

.method public static getLength(Ljava/lang/Object;)I
    .locals 1
    .param p0, "array"    # Ljava/lang/Object;

    .line 98
    if-nez p0, :cond_0

    const/4 v0, 0x0

    return v0

    .line 99
    :cond_0
    invoke-static {p0}, Ljava/lang/reflect/Array;->getLength(Ljava/lang/Object;)I

    move-result v0

    return v0
.end method

.method public static indexOf([BB)I
    .locals 1
    .param p0, "array"    # [B
    .param p1, "valueToFind"    # B

    .line 1360
    const/4 v0, 0x0

    invoke-static {p0, p1, v0}, Lcom/blankj/utilcode/util/ArrayUtils;->indexOf([BBI)I

    move-result v0

    return v0
.end method

.method public static indexOf([BBI)I
    .locals 3
    .param p0, "array"    # [B
    .param p1, "valueToFind"    # B
    .param p2, "startIndex"    # I

    .line 1364
    const/4 v0, -0x1

    if-nez p0, :cond_0

    .line 1365
    return v0

    .line 1367
    :cond_0
    if-gez p2, :cond_1

    .line 1368
    const/4 p2, 0x0

    .line 1370
    :cond_1
    move v1, p2

    .local v1, "i":I
    :goto_0
    array-length v2, p0

    if-ge v1, v2, :cond_3

    .line 1371
    aget-byte v2, p0, v1

    if-ne p1, v2, :cond_2

    .line 1372
    return v1

    .line 1370
    :cond_2
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 1375
    .end local v1    # "i":I
    :cond_3
    return v0
.end method

.method public static indexOf([CC)I
    .locals 1
    .param p0, "array"    # [C
    .param p1, "valueToFind"    # C

    .line 1312
    const/4 v0, 0x0

    invoke-static {p0, p1, v0}, Lcom/blankj/utilcode/util/ArrayUtils;->indexOf([CCI)I

    move-result v0

    return v0
.end method

.method public static indexOf([CCI)I
    .locals 3
    .param p0, "array"    # [C
    .param p1, "valueToFind"    # C
    .param p2, "startIndex"    # I

    .line 1316
    const/4 v0, -0x1

    if-nez p0, :cond_0

    .line 1317
    return v0

    .line 1319
    :cond_0
    if-gez p2, :cond_1

    .line 1320
    const/4 p2, 0x0

    .line 1322
    :cond_1
    move v1, p2

    .local v1, "i":I
    :goto_0
    array-length v2, p0

    if-ge v1, v2, :cond_3

    .line 1323
    aget-char v2, p0, v1

    if-ne p1, v2, :cond_2

    .line 1324
    return v1

    .line 1322
    :cond_2
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 1327
    .end local v1    # "i":I
    :cond_3
    return v0
.end method

.method public static indexOf([DD)I
    .locals 1
    .param p0, "array"    # [D
    .param p1, "valueToFind"    # D

    .line 1408
    const/4 v0, 0x0

    invoke-static {p0, p1, p2, v0}, Lcom/blankj/utilcode/util/ArrayUtils;->indexOf([DDI)I

    move-result v0

    return v0
.end method

.method public static indexOf([DDD)I
    .locals 6
    .param p0, "array"    # [D
    .param p1, "valueToFind"    # D
    .param p3, "tolerance"    # D

    .line 1412
    const/4 v3, 0x0

    move-object v0, p0

    move-wide v1, p1

    move-wide v4, p3

    invoke-static/range {v0 .. v5}, Lcom/blankj/utilcode/util/ArrayUtils;->indexOf([DDID)I

    move-result v0

    return v0
.end method

.method public static indexOf([DDI)I
    .locals 4
    .param p0, "array"    # [D
    .param p1, "valueToFind"    # D
    .param p3, "startIndex"    # I

    .line 1416
    invoke-static {p0}, Lcom/blankj/utilcode/util/ArrayUtils;->isEmpty(Ljava/lang/Object;)Z

    move-result v0

    const/4 v1, -0x1

    if-eqz v0, :cond_0

    .line 1417
    return v1

    .line 1419
    :cond_0
    if-gez p3, :cond_1

    .line 1420
    const/4 p3, 0x0

    .line 1422
    :cond_1
    move v0, p3

    .local v0, "i":I
    :goto_0
    array-length v2, p0

    if-ge v0, v2, :cond_3

    .line 1423
    aget-wide v2, p0, v0

    cmpl-double v2, p1, v2

    if-nez v2, :cond_2

    .line 1424
    return v0

    .line 1422
    :cond_2
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 1427
    .end local v0    # "i":I
    :cond_3
    return v1
.end method

.method public static indexOf([DDID)I
    .locals 8
    .param p0, "array"    # [D
    .param p1, "valueToFind"    # D
    .param p3, "startIndex"    # I
    .param p4, "tolerance"    # D

    .line 1431
    invoke-static {p0}, Lcom/blankj/utilcode/util/ArrayUtils;->isEmpty(Ljava/lang/Object;)Z

    move-result v0

    const/4 v1, -0x1

    if-eqz v0, :cond_0

    .line 1432
    return v1

    .line 1434
    :cond_0
    if-gez p3, :cond_1

    .line 1435
    const/4 p3, 0x0

    .line 1437
    :cond_1
    sub-double v2, p1, p4

    .line 1438
    .local v2, "min":D
    add-double v4, p1, p4

    .line 1439
    .local v4, "max":D
    move v0, p3

    .local v0, "i":I
    :goto_0
    array-length v6, p0

    if-ge v0, v6, :cond_3

    .line 1440
    aget-wide v6, p0, v0

    cmpl-double v6, v6, v2

    if-ltz v6, :cond_2

    aget-wide v6, p0, v0

    cmpg-double v6, v6, v4

    if-gtz v6, :cond_2

    .line 1441
    return v0

    .line 1439
    :cond_2
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 1444
    .end local v0    # "i":I
    :cond_3
    return v1
.end method

.method public static indexOf([FF)I
    .locals 1
    .param p0, "array"    # [F
    .param p1, "valueToFind"    # F

    .line 1504
    const/4 v0, 0x0

    invoke-static {p0, p1, v0}, Lcom/blankj/utilcode/util/ArrayUtils;->indexOf([FFI)I

    move-result v0

    return v0
.end method

.method public static indexOf([FFI)I
    .locals 3
    .param p0, "array"    # [F
    .param p1, "valueToFind"    # F
    .param p2, "startIndex"    # I

    .line 1508
    invoke-static {p0}, Lcom/blankj/utilcode/util/ArrayUtils;->isEmpty(Ljava/lang/Object;)Z

    move-result v0

    const/4 v1, -0x1

    if-eqz v0, :cond_0

    .line 1509
    return v1

    .line 1511
    :cond_0
    if-gez p2, :cond_1

    .line 1512
    const/4 p2, 0x0

    .line 1514
    :cond_1
    move v0, p2

    .local v0, "i":I
    :goto_0
    array-length v2, p0

    if-ge v0, v2, :cond_3

    .line 1515
    aget v2, p0, v0

    cmpl-float v2, p1, v2

    if-nez v2, :cond_2

    .line 1516
    return v0

    .line 1514
    :cond_2
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 1519
    .end local v0    # "i":I
    :cond_3
    return v1
.end method

.method public static indexOf([II)I
    .locals 1
    .param p0, "array"    # [I
    .param p1, "valueToFind"    # I

    .line 1216
    const/4 v0, 0x0

    invoke-static {p0, p1, v0}, Lcom/blankj/utilcode/util/ArrayUtils;->indexOf([III)I

    move-result v0

    return v0
.end method

.method public static indexOf([III)I
    .locals 3
    .param p0, "array"    # [I
    .param p1, "valueToFind"    # I
    .param p2, "startIndex"    # I

    .line 1220
    const/4 v0, -0x1

    if-nez p0, :cond_0

    .line 1221
    return v0

    .line 1223
    :cond_0
    if-gez p2, :cond_1

    .line 1224
    const/4 p2, 0x0

    .line 1226
    :cond_1
    move v1, p2

    .local v1, "i":I
    :goto_0
    array-length v2, p0

    if-ge v1, v2, :cond_3

    .line 1227
    aget v2, p0, v1

    if-ne p1, v2, :cond_2

    .line 1228
    return v1

    .line 1226
    :cond_2
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 1231
    .end local v1    # "i":I
    :cond_3
    return v0
.end method

.method public static indexOf([JJ)I
    .locals 1
    .param p0, "array"    # [J
    .param p1, "valueToFind"    # J

    .line 1168
    const/4 v0, 0x0

    invoke-static {p0, p1, p2, v0}, Lcom/blankj/utilcode/util/ArrayUtils;->indexOf([JJI)I

    move-result v0

    return v0
.end method

.method public static indexOf([JJI)I
    .locals 4
    .param p0, "array"    # [J
    .param p1, "valueToFind"    # J
    .param p3, "startIndex"    # I

    .line 1172
    const/4 v0, -0x1

    if-nez p0, :cond_0

    .line 1173
    return v0

    .line 1175
    :cond_0
    if-gez p3, :cond_1

    .line 1176
    const/4 p3, 0x0

    .line 1178
    :cond_1
    move v1, p3

    .local v1, "i":I
    :goto_0
    array-length v2, p0

    if-ge v1, v2, :cond_3

    .line 1179
    aget-wide v2, p0, v1

    cmp-long v2, p1, v2

    if-nez v2, :cond_2

    .line 1180
    return v1

    .line 1178
    :cond_2
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 1183
    .end local v1    # "i":I
    :cond_3
    return v0
.end method

.method public static indexOf([Ljava/lang/Object;Ljava/lang/Object;)I
    .locals 1
    .param p0, "array"    # [Ljava/lang/Object;
    .param p1, "objectToFind"    # Ljava/lang/Object;

    .line 1104
    const/4 v0, 0x0

    invoke-static {p0, p1, v0}, Lcom/blankj/utilcode/util/ArrayUtils;->indexOf([Ljava/lang/Object;Ljava/lang/Object;I)I

    move-result v0

    return v0
.end method

.method public static indexOf([Ljava/lang/Object;Ljava/lang/Object;I)I
    .locals 3
    .param p0, "array"    # [Ljava/lang/Object;
    .param p1, "objectToFind"    # Ljava/lang/Object;
    .param p2, "startIndex"    # I

    .line 1108
    const/4 v0, -0x1

    if-nez p0, :cond_0

    .line 1109
    return v0

    .line 1111
    :cond_0
    if-gez p2, :cond_1

    .line 1112
    const/4 p2, 0x0

    .line 1114
    :cond_1
    if-nez p1, :cond_4

    .line 1115
    move v1, p2

    .local v1, "i":I
    :goto_0
    array-length v2, p0

    if-ge v1, v2, :cond_3

    .line 1116
    aget-object v2, p0, v1

    if-nez v2, :cond_2

    .line 1117
    return v1

    .line 1115
    :cond_2
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .end local v1    # "i":I
    :cond_3
    goto :goto_2

    .line 1121
    :cond_4
    move v1, p2

    .restart local v1    # "i":I
    :goto_1
    array-length v2, p0

    if-ge v1, v2, :cond_6

    .line 1122
    aget-object v2, p0, v1

    invoke-virtual {p1, v2}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_5

    .line 1123
    return v1

    .line 1121
    :cond_5
    add-int/lit8 v1, v1, 0x1

    goto :goto_1

    .line 1127
    .end local v1    # "i":I
    :cond_6
    :goto_2
    return v0
.end method

.method public static indexOf([SS)I
    .locals 1
    .param p0, "array"    # [S
    .param p1, "valueToFind"    # S

    .line 1264
    const/4 v0, 0x0

    invoke-static {p0, p1, v0}, Lcom/blankj/utilcode/util/ArrayUtils;->indexOf([SSI)I

    move-result v0

    return v0
.end method

.method public static indexOf([SSI)I
    .locals 3
    .param p0, "array"    # [S
    .param p1, "valueToFind"    # S
    .param p2, "startIndex"    # I

    .line 1268
    const/4 v0, -0x1

    if-nez p0, :cond_0

    .line 1269
    return v0

    .line 1271
    :cond_0
    if-gez p2, :cond_1

    .line 1272
    const/4 p2, 0x0

    .line 1274
    :cond_1
    move v1, p2

    .local v1, "i":I
    :goto_0
    array-length v2, p0

    if-ge v1, v2, :cond_3

    .line 1275
    aget-short v2, p0, v1

    if-ne p1, v2, :cond_2

    .line 1276
    return v1

    .line 1274
    :cond_2
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 1279
    .end local v1    # "i":I
    :cond_3
    return v0
.end method

.method public static indexOf([ZZ)I
    .locals 1
    .param p0, "array"    # [Z
    .param p1, "valueToFind"    # Z

    .line 1552
    const/4 v0, 0x0

    invoke-static {p0, p1, v0}, Lcom/blankj/utilcode/util/ArrayUtils;->indexOf([ZZI)I

    move-result v0

    return v0
.end method

.method public static indexOf([ZZI)I
    .locals 3
    .param p0, "array"    # [Z
    .param p1, "valueToFind"    # Z
    .param p2, "startIndex"    # I

    .line 1556
    invoke-static {p0}, Lcom/blankj/utilcode/util/ArrayUtils;->isEmpty(Ljava/lang/Object;)Z

    move-result v0

    const/4 v1, -0x1

    if-eqz v0, :cond_0

    .line 1557
    return v1

    .line 1559
    :cond_0
    if-gez p2, :cond_1

    .line 1560
    const/4 p2, 0x0

    .line 1562
    :cond_1
    move v0, p2

    .local v0, "i":I
    :goto_0
    array-length v2, p0

    if-ge v0, v2, :cond_3

    .line 1563
    aget-boolean v2, p0, v0

    if-ne p1, v2, :cond_2

    .line 1564
    return v0

    .line 1562
    :cond_2
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 1567
    .end local v0    # "i":I
    :cond_3
    return v1
.end method

.method public static isEmpty(Ljava/lang/Object;)Z
    .locals 1
    .param p0, "array"    # Ljava/lang/Object;

    .line 88
    invoke-static {p0}, Lcom/blankj/utilcode/util/ArrayUtils;->getLength(Ljava/lang/Object;)I

    move-result v0

    if-nez v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public static isSameLength(Ljava/lang/Object;Ljava/lang/Object;)Z
    .locals 2
    .param p0, "array1"    # Ljava/lang/Object;
    .param p1, "array2"    # Ljava/lang/Object;

    .line 103
    invoke-static {p0}, Lcom/blankj/utilcode/util/ArrayUtils;->getLength(Ljava/lang/Object;)I

    move-result v0

    invoke-static {p1}, Lcom/blankj/utilcode/util/ArrayUtils;->getLength(Ljava/lang/Object;)I

    move-result v1

    if-ne v0, v1, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public static lastIndexOf([BB)I
    .locals 1
    .param p0, "array"    # [B
    .param p1, "valueToFind"    # B

    .line 1379
    const v0, 0x7fffffff

    invoke-static {p0, p1, v0}, Lcom/blankj/utilcode/util/ArrayUtils;->lastIndexOf([BBI)I

    move-result v0

    return v0
.end method

.method public static lastIndexOf([BBI)I
    .locals 3
    .param p0, "array"    # [B
    .param p1, "valueToFind"    # B
    .param p2, "startIndex"    # I

    .line 1383
    const/4 v0, -0x1

    if-nez p0, :cond_0

    .line 1384
    return v0

    .line 1386
    :cond_0
    if-gez p2, :cond_1

    .line 1387
    return v0

    .line 1388
    :cond_1
    array-length v1, p0

    if-lt p2, v1, :cond_2

    .line 1389
    array-length v1, p0

    add-int/lit8 p2, v1, -0x1

    .line 1391
    :cond_2
    move v1, p2

    .local v1, "i":I
    :goto_0
    if-ltz v1, :cond_4

    .line 1392
    aget-byte v2, p0, v1

    if-ne p1, v2, :cond_3

    .line 1393
    return v1

    .line 1391
    :cond_3
    add-int/lit8 v1, v1, -0x1

    goto :goto_0

    .line 1396
    .end local v1    # "i":I
    :cond_4
    return v0
.end method

.method public static lastIndexOf([CC)I
    .locals 1
    .param p0, "array"    # [C
    .param p1, "valueToFind"    # C

    .line 1331
    const v0, 0x7fffffff

    invoke-static {p0, p1, v0}, Lcom/blankj/utilcode/util/ArrayUtils;->lastIndexOf([CCI)I

    move-result v0

    return v0
.end method

.method public static lastIndexOf([CCI)I
    .locals 3
    .param p0, "array"    # [C
    .param p1, "valueToFind"    # C
    .param p2, "startIndex"    # I

    .line 1335
    const/4 v0, -0x1

    if-nez p0, :cond_0

    .line 1336
    return v0

    .line 1338
    :cond_0
    if-gez p2, :cond_1

    .line 1339
    return v0

    .line 1340
    :cond_1
    array-length v1, p0

    if-lt p2, v1, :cond_2

    .line 1341
    array-length v1, p0

    add-int/lit8 p2, v1, -0x1

    .line 1343
    :cond_2
    move v1, p2

    .local v1, "i":I
    :goto_0
    if-ltz v1, :cond_4

    .line 1344
    aget-char v2, p0, v1

    if-ne p1, v2, :cond_3

    .line 1345
    return v1

    .line 1343
    :cond_3
    add-int/lit8 v1, v1, -0x1

    goto :goto_0

    .line 1348
    .end local v1    # "i":I
    :cond_4
    return v0
.end method

.method public static lastIndexOf([DD)I
    .locals 1
    .param p0, "array"    # [D
    .param p1, "valueToFind"    # D

    .line 1448
    const v0, 0x7fffffff

    invoke-static {p0, p1, p2, v0}, Lcom/blankj/utilcode/util/ArrayUtils;->lastIndexOf([DDI)I

    move-result v0

    return v0
.end method

.method public static lastIndexOf([DDD)I
    .locals 6
    .param p0, "array"    # [D
    .param p1, "valueToFind"    # D
    .param p3, "tolerance"    # D

    .line 1452
    const v3, 0x7fffffff

    move-object v0, p0

    move-wide v1, p1

    move-wide v4, p3

    invoke-static/range {v0 .. v5}, Lcom/blankj/utilcode/util/ArrayUtils;->lastIndexOf([DDID)I

    move-result v0

    return v0
.end method

.method public static lastIndexOf([DDI)I
    .locals 4
    .param p0, "array"    # [D
    .param p1, "valueToFind"    # D
    .param p3, "startIndex"    # I

    .line 1456
    invoke-static {p0}, Lcom/blankj/utilcode/util/ArrayUtils;->isEmpty(Ljava/lang/Object;)Z

    move-result v0

    const/4 v1, -0x1

    if-eqz v0, :cond_0

    .line 1457
    return v1

    .line 1459
    :cond_0
    if-gez p3, :cond_1

    .line 1460
    return v1

    .line 1461
    :cond_1
    array-length v0, p0

    if-lt p3, v0, :cond_2

    .line 1462
    array-length v0, p0

    add-int/lit8 p3, v0, -0x1

    .line 1464
    :cond_2
    move v0, p3

    .local v0, "i":I
    :goto_0
    if-ltz v0, :cond_4

    .line 1465
    aget-wide v2, p0, v0

    cmpl-double v2, p1, v2

    if-nez v2, :cond_3

    .line 1466
    return v0

    .line 1464
    :cond_3
    add-int/lit8 v0, v0, -0x1

    goto :goto_0

    .line 1469
    .end local v0    # "i":I
    :cond_4
    return v1
.end method

.method public static lastIndexOf([DDID)I
    .locals 8
    .param p0, "array"    # [D
    .param p1, "valueToFind"    # D
    .param p3, "startIndex"    # I
    .param p4, "tolerance"    # D

    .line 1473
    invoke-static {p0}, Lcom/blankj/utilcode/util/ArrayUtils;->isEmpty(Ljava/lang/Object;)Z

    move-result v0

    const/4 v1, -0x1

    if-eqz v0, :cond_0

    .line 1474
    return v1

    .line 1476
    :cond_0
    if-gez p3, :cond_1

    .line 1477
    return v1

    .line 1478
    :cond_1
    array-length v0, p0

    if-lt p3, v0, :cond_2

    .line 1479
    array-length v0, p0

    add-int/lit8 p3, v0, -0x1

    .line 1481
    :cond_2
    sub-double v2, p1, p4

    .line 1482
    .local v2, "min":D
    add-double v4, p1, p4

    .line 1483
    .local v4, "max":D
    move v0, p3

    .local v0, "i":I
    :goto_0
    if-ltz v0, :cond_4

    .line 1484
    aget-wide v6, p0, v0

    cmpl-double v6, v6, v2

    if-ltz v6, :cond_3

    aget-wide v6, p0, v0

    cmpg-double v6, v6, v4

    if-gtz v6, :cond_3

    .line 1485
    return v0

    .line 1483
    :cond_3
    add-int/lit8 v0, v0, -0x1

    goto :goto_0

    .line 1488
    .end local v0    # "i":I
    :cond_4
    return v1
.end method

.method public static lastIndexOf([FF)I
    .locals 1
    .param p0, "array"    # [F
    .param p1, "valueToFind"    # F

    .line 1523
    const v0, 0x7fffffff

    invoke-static {p0, p1, v0}, Lcom/blankj/utilcode/util/ArrayUtils;->lastIndexOf([FFI)I

    move-result v0

    return v0
.end method

.method public static lastIndexOf([FFI)I
    .locals 3
    .param p0, "array"    # [F
    .param p1, "valueToFind"    # F
    .param p2, "startIndex"    # I

    .line 1527
    invoke-static {p0}, Lcom/blankj/utilcode/util/ArrayUtils;->isEmpty(Ljava/lang/Object;)Z

    move-result v0

    const/4 v1, -0x1

    if-eqz v0, :cond_0

    .line 1528
    return v1

    .line 1530
    :cond_0
    if-gez p2, :cond_1

    .line 1531
    return v1

    .line 1532
    :cond_1
    array-length v0, p0

    if-lt p2, v0, :cond_2

    .line 1533
    array-length v0, p0

    add-int/lit8 p2, v0, -0x1

    .line 1535
    :cond_2
    move v0, p2

    .local v0, "i":I
    :goto_0
    if-ltz v0, :cond_4

    .line 1536
    aget v2, p0, v0

    cmpl-float v2, p1, v2

    if-nez v2, :cond_3

    .line 1537
    return v0

    .line 1535
    :cond_3
    add-int/lit8 v0, v0, -0x1

    goto :goto_0

    .line 1540
    .end local v0    # "i":I
    :cond_4
    return v1
.end method

.method public static lastIndexOf([II)I
    .locals 1
    .param p0, "array"    # [I
    .param p1, "valueToFind"    # I

    .line 1235
    const v0, 0x7fffffff

    invoke-static {p0, p1, v0}, Lcom/blankj/utilcode/util/ArrayUtils;->lastIndexOf([III)I

    move-result v0

    return v0
.end method

.method public static lastIndexOf([III)I
    .locals 3
    .param p0, "array"    # [I
    .param p1, "valueToFind"    # I
    .param p2, "startIndex"    # I

    .line 1239
    const/4 v0, -0x1

    if-nez p0, :cond_0

    .line 1240
    return v0

    .line 1242
    :cond_0
    if-gez p2, :cond_1

    .line 1243
    return v0

    .line 1244
    :cond_1
    array-length v1, p0

    if-lt p2, v1, :cond_2

    .line 1245
    array-length v1, p0

    add-int/lit8 p2, v1, -0x1

    .line 1247
    :cond_2
    move v1, p2

    .local v1, "i":I
    :goto_0
    if-ltz v1, :cond_4

    .line 1248
    aget v2, p0, v1

    if-ne p1, v2, :cond_3

    .line 1249
    return v1

    .line 1247
    :cond_3
    add-int/lit8 v1, v1, -0x1

    goto :goto_0

    .line 1252
    .end local v1    # "i":I
    :cond_4
    return v0
.end method

.method public static lastIndexOf([JJ)I
    .locals 1
    .param p0, "array"    # [J
    .param p1, "valueToFind"    # J

    .line 1187
    const v0, 0x7fffffff

    invoke-static {p0, p1, p2, v0}, Lcom/blankj/utilcode/util/ArrayUtils;->lastIndexOf([JJI)I

    move-result v0

    return v0
.end method

.method public static lastIndexOf([JJI)I
    .locals 4
    .param p0, "array"    # [J
    .param p1, "valueToFind"    # J
    .param p3, "startIndex"    # I

    .line 1191
    const/4 v0, -0x1

    if-nez p0, :cond_0

    .line 1192
    return v0

    .line 1194
    :cond_0
    if-gez p3, :cond_1

    .line 1195
    return v0

    .line 1196
    :cond_1
    array-length v1, p0

    if-lt p3, v1, :cond_2

    .line 1197
    array-length v1, p0

    add-int/lit8 p3, v1, -0x1

    .line 1199
    :cond_2
    move v1, p3

    .local v1, "i":I
    :goto_0
    if-ltz v1, :cond_4

    .line 1200
    aget-wide v2, p0, v1

    cmp-long v2, p1, v2

    if-nez v2, :cond_3

    .line 1201
    return v1

    .line 1199
    :cond_3
    add-int/lit8 v1, v1, -0x1

    goto :goto_0

    .line 1204
    .end local v1    # "i":I
    :cond_4
    return v0
.end method

.method public static lastIndexOf([Ljava/lang/Object;Ljava/lang/Object;)I
    .locals 1
    .param p0, "array"    # [Ljava/lang/Object;
    .param p1, "objectToFind"    # Ljava/lang/Object;

    .line 1131
    const v0, 0x7fffffff

    invoke-static {p0, p1, v0}, Lcom/blankj/utilcode/util/ArrayUtils;->lastIndexOf([Ljava/lang/Object;Ljava/lang/Object;I)I

    move-result v0

    return v0
.end method

.method public static lastIndexOf([Ljava/lang/Object;Ljava/lang/Object;I)I
    .locals 3
    .param p0, "array"    # [Ljava/lang/Object;
    .param p1, "objectToFind"    # Ljava/lang/Object;
    .param p2, "startIndex"    # I

    .line 1135
    const/4 v0, -0x1

    if-nez p0, :cond_0

    .line 1136
    return v0

    .line 1138
    :cond_0
    if-gez p2, :cond_1

    .line 1139
    return v0

    .line 1140
    :cond_1
    array-length v1, p0

    if-lt p2, v1, :cond_2

    .line 1141
    array-length v1, p0

    add-int/lit8 p2, v1, -0x1

    .line 1143
    :cond_2
    if-nez p1, :cond_5

    .line 1144
    move v1, p2

    .local v1, "i":I
    :goto_0
    if-ltz v1, :cond_4

    .line 1145
    aget-object v2, p0, v1

    if-nez v2, :cond_3

    .line 1146
    return v1

    .line 1144
    :cond_3
    add-int/lit8 v1, v1, -0x1

    goto :goto_0

    .end local v1    # "i":I
    :cond_4
    goto :goto_2

    .line 1150
    :cond_5
    move v1, p2

    .restart local v1    # "i":I
    :goto_1
    if-ltz v1, :cond_7

    .line 1151
    aget-object v2, p0, v1

    invoke-virtual {p1, v2}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_6

    .line 1152
    return v1

    .line 1150
    :cond_6
    add-int/lit8 v1, v1, -0x1

    goto :goto_1

    .line 1156
    .end local v1    # "i":I
    :cond_7
    :goto_2
    return v0
.end method

.method public static lastIndexOf([SS)I
    .locals 1
    .param p0, "array"    # [S
    .param p1, "valueToFind"    # S

    .line 1283
    const v0, 0x7fffffff

    invoke-static {p0, p1, v0}, Lcom/blankj/utilcode/util/ArrayUtils;->lastIndexOf([SSI)I

    move-result v0

    return v0
.end method

.method public static lastIndexOf([SSI)I
    .locals 3
    .param p0, "array"    # [S
    .param p1, "valueToFind"    # S
    .param p2, "startIndex"    # I

    .line 1287
    const/4 v0, -0x1

    if-nez p0, :cond_0

    .line 1288
    return v0

    .line 1290
    :cond_0
    if-gez p2, :cond_1

    .line 1291
    return v0

    .line 1292
    :cond_1
    array-length v1, p0

    if-lt p2, v1, :cond_2

    .line 1293
    array-length v1, p0

    add-int/lit8 p2, v1, -0x1

    .line 1295
    :cond_2
    move v1, p2

    .local v1, "i":I
    :goto_0
    if-ltz v1, :cond_4

    .line 1296
    aget-short v2, p0, v1

    if-ne p1, v2, :cond_3

    .line 1297
    return v1

    .line 1295
    :cond_3
    add-int/lit8 v1, v1, -0x1

    goto :goto_0

    .line 1300
    .end local v1    # "i":I
    :cond_4
    return v0
.end method

.method public static lastIndexOf([ZZ)I
    .locals 1
    .param p0, "array"    # [Z
    .param p1, "valueToFind"    # Z

    .line 1571
    const v0, 0x7fffffff

    invoke-static {p0, p1, v0}, Lcom/blankj/utilcode/util/ArrayUtils;->lastIndexOf([ZZI)I

    move-result v0

    return v0
.end method

.method public static lastIndexOf([ZZI)I
    .locals 3
    .param p0, "array"    # [Z
    .param p1, "valueToFind"    # Z
    .param p2, "startIndex"    # I

    .line 1575
    invoke-static {p0}, Lcom/blankj/utilcode/util/ArrayUtils;->isEmpty(Ljava/lang/Object;)Z

    move-result v0

    const/4 v1, -0x1

    if-eqz v0, :cond_0

    .line 1576
    return v1

    .line 1578
    :cond_0
    if-gez p2, :cond_1

    .line 1579
    return v1

    .line 1580
    :cond_1
    array-length v0, p0

    if-lt p2, v0, :cond_2

    .line 1581
    array-length v0, p0

    add-int/lit8 p2, v0, -0x1

    .line 1583
    :cond_2
    move v0, p2

    .local v0, "i":I
    :goto_0
    if-ltz v0, :cond_4

    .line 1584
    aget-boolean v2, p0, v0

    if-ne p1, v2, :cond_3

    .line 1585
    return v0

    .line 1583
    :cond_3
    add-int/lit8 v0, v0, -0x1

    goto :goto_0

    .line 1588
    .end local v0    # "i":I
    :cond_4
    return v1
.end method

.method public static varargs newArray([Ljava/lang/Object;)[Ljava/lang/Object;
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">([TT;)[TT;"
        }
    .end annotation

    .line 38
    .local p0, "array":[Ljava/lang/Object;, "[TT;"
    return-object p0
.end method

.method public static varargs newBooleanArray([Z)[Z
    .locals 0
    .param p0, "array"    # [Z

    .line 78
    return-object p0
.end method

.method public static varargs newByteArray([B)[B
    .locals 0
    .param p0, "array"    # [B

    .line 63
    return-object p0
.end method

.method public static varargs newCharArray([C)[C
    .locals 0
    .param p0, "array"    # [C

    .line 58
    return-object p0
.end method

.method public static varargs newDoubleArray([D)[D
    .locals 0
    .param p0, "array"    # [D

    .line 68
    return-object p0
.end method

.method public static varargs newFloatArray([F)[F
    .locals 0
    .param p0, "array"    # [F

    .line 73
    return-object p0
.end method

.method public static varargs newIntArray([I)[I
    .locals 0
    .param p0, "array"    # [I

    .line 48
    return-object p0
.end method

.method public static varargs newLongArray([J)[J
    .locals 0
    .param p0, "array"    # [J

    .line 43
    return-object p0
.end method

.method public static varargs newShortArray([S)[S
    .locals 0
    .param p0, "array"    # [S

    .line 53
    return-object p0
.end method

.method private static realAdd(Ljava/lang/Object;ILjava/lang/Object;Ljava/lang/Class;)Ljava/lang/Object;
    .locals 4
    .param p0, "array"    # Ljava/lang/Object;
    .param p1, "index"    # I
    .param p2, "element"    # Ljava/lang/Object;
    .param p3, "clss"    # Ljava/lang/Class;

    .line 871
    const-string v0, "Index: "

    const/4 v1, 0x0

    if-nez p0, :cond_1

    .line 872
    if-nez p1, :cond_0

    .line 875
    const/4 v0, 0x1

    invoke-static {p3, v0}, Ljava/lang/reflect/Array;->newInstance(Ljava/lang/Class;I)Ljava/lang/Object;

    move-result-object v0

    .line 876
    .local v0, "joinedArray":Ljava/lang/Object;
    invoke-static {v0, v1, p2}, Ljava/lang/reflect/Array;->set(Ljava/lang/Object;ILjava/lang/Object;)V

    .line 877
    return-object v0

    .line 873
    .end local v0    # "joinedArray":Ljava/lang/Object;
    :cond_0
    new-instance v1, Ljava/lang/IndexOutOfBoundsException;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v2, ", Length: 0"

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {v1, v0}, Ljava/lang/IndexOutOfBoundsException;-><init>(Ljava/lang/String;)V

    throw v1

    .line 879
    :cond_1
    invoke-static {p0}, Ljava/lang/reflect/Array;->getLength(Ljava/lang/Object;)I

    move-result v2

    .line 880
    .local v2, "length":I
    if-gt p1, v2, :cond_3

    if-ltz p1, :cond_3

    .line 883
    add-int/lit8 v0, v2, 0x1

    invoke-static {p3, v0}, Ljava/lang/reflect/Array;->newInstance(Ljava/lang/Class;I)Ljava/lang/Object;

    move-result-object v0

    .line 884
    .local v0, "result":Ljava/lang/Object;
    invoke-static {p0, v1, v0, v1, p1}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 885
    invoke-static {v0, p1, p2}, Ljava/lang/reflect/Array;->set(Ljava/lang/Object;ILjava/lang/Object;)V

    .line 886
    if-ge p1, v2, :cond_2

    .line 887
    add-int/lit8 v1, p1, 0x1

    sub-int v3, v2, p1

    invoke-static {p0, p1, v0, v1, v3}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 889
    :cond_2
    return-object v0

    .line 881
    .end local v0    # "result":Ljava/lang/Object;
    :cond_3
    new-instance v1, Ljava/lang/IndexOutOfBoundsException;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v3, ", Length: "

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {v1, v0}, Ljava/lang/IndexOutOfBoundsException;-><init>(Ljava/lang/String;)V

    throw v1
.end method

.method private static realAddArr(Ljava/lang/Object;ILjava/lang/Object;Ljava/lang/Class;)Ljava/lang/Object;
    .locals 5
    .param p0, "array1"    # Ljava/lang/Object;
    .param p1, "index"    # I
    .param p2, "array2"    # Ljava/lang/Object;
    .param p3, "clss"    # Ljava/lang/Class;

    .line 758
    if-nez p0, :cond_0

    if-nez p2, :cond_0

    const/4 v0, 0x0

    return-object v0

    .line 759
    :cond_0
    invoke-static {p0}, Lcom/blankj/utilcode/util/ArrayUtils;->getLength(Ljava/lang/Object;)I

    move-result v0

    .line 760
    .local v0, "len1":I
    invoke-static {p2}, Lcom/blankj/utilcode/util/ArrayUtils;->getLength(Ljava/lang/Object;)I

    move-result v1

    .line 761
    .local v1, "len2":I
    const-string v2, "Index: "

    if-nez v0, :cond_2

    .line 762
    if-nez p1, :cond_1

    .line 765
    invoke-static {p2}, Lcom/blankj/utilcode/util/ArrayUtils;->realCopy(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    return-object v2

    .line 763
    :cond_1
    new-instance v3, Ljava/lang/IndexOutOfBoundsException;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v4, ", array1 Length: 0"

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v3, v2}, Ljava/lang/IndexOutOfBoundsException;-><init>(Ljava/lang/String;)V

    throw v3

    .line 767
    :cond_2
    if-nez v1, :cond_3

    .line 768
    invoke-static {p0}, Lcom/blankj/utilcode/util/ArrayUtils;->realCopy(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    return-object v2

    .line 770
    :cond_3
    if-gt p1, v0, :cond_6

    if-ltz p1, :cond_6

    .line 773
    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/Class;->getComponentType()Ljava/lang/Class;

    move-result-object v2

    add-int v3, v0, v1

    invoke-static {v2, v3}, Ljava/lang/reflect/Array;->newInstance(Ljava/lang/Class;I)Ljava/lang/Object;

    move-result-object v2

    .line 774
    .local v2, "joinedArray":Ljava/lang/Object;
    const/4 v3, 0x0

    if-ne p1, v0, :cond_4

    .line 775
    invoke-static {p0, v3, v2, v3, v0}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 776
    invoke-static {p2, v3, v2, v0, v1}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    goto :goto_0

    .line 777
    :cond_4
    if-nez p1, :cond_5

    .line 778
    invoke-static {p2, v3, v2, v3, v1}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 779
    invoke-static {p0, v3, v2, v1, v0}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    goto :goto_0

    .line 781
    :cond_5
    invoke-static {p0, v3, v2, v3, p1}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 782
    invoke-static {p2, v3, v2, p1, v1}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 783
    add-int v3, p1, v1

    sub-int v4, v0, p1

    invoke-static {p0, p1, v2, v3, v4}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 785
    :goto_0
    return-object v2

    .line 771
    .end local v2    # "joinedArray":Ljava/lang/Object;
    :cond_6
    new-instance v3, Ljava/lang/IndexOutOfBoundsException;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v4, ", array1 Length: "

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v3, v2}, Ljava/lang/IndexOutOfBoundsException;-><init>(Ljava/lang/String;)V

    throw v3
.end method

.method private static realAddArr(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 4
    .param p0, "array1"    # Ljava/lang/Object;
    .param p1, "array2"    # Ljava/lang/Object;

    .line 645
    if-nez p0, :cond_0

    if-nez p1, :cond_0

    const/4 v0, 0x0

    return-object v0

    .line 646
    :cond_0
    if-nez p0, :cond_1

    .line 647
    invoke-static {p1}, Lcom/blankj/utilcode/util/ArrayUtils;->realCopy(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    return-object v0

    .line 649
    :cond_1
    if-nez p1, :cond_2

    .line 650
    invoke-static {p0}, Lcom/blankj/utilcode/util/ArrayUtils;->realCopy(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    return-object v0

    .line 652
    :cond_2
    invoke-static {p0}, Lcom/blankj/utilcode/util/ArrayUtils;->getLength(Ljava/lang/Object;)I

    move-result v0

    .line 653
    .local v0, "len1":I
    invoke-static {p1}, Lcom/blankj/utilcode/util/ArrayUtils;->getLength(Ljava/lang/Object;)I

    move-result v1

    .line 654
    .local v1, "len2":I
    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/Class;->getComponentType()Ljava/lang/Class;

    move-result-object v2

    add-int v3, v0, v1

    invoke-static {v2, v3}, Ljava/lang/reflect/Array;->newInstance(Ljava/lang/Class;I)Ljava/lang/Object;

    move-result-object v2

    .line 655
    .local v2, "joinedArray":Ljava/lang/Object;
    const/4 v3, 0x0

    invoke-static {p0, v3, v2, v3, v0}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 656
    invoke-static {p1, v3, v2, v0, v1}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 657
    return-object v2
.end method

.method private static realAddOne(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Class;)Ljava/lang/Object;
    .locals 3
    .param p0, "array"    # Ljava/lang/Object;
    .param p1, "element"    # Ljava/lang/Object;
    .param p2, "newArrayComponentType"    # Ljava/lang/Class;

    .line 567
    const/4 v0, 0x0

    .line 568
    .local v0, "arrayLength":I
    if-eqz p0, :cond_0

    .line 569
    invoke-static {p0}, Lcom/blankj/utilcode/util/ArrayUtils;->getLength(Ljava/lang/Object;)I

    move-result v0

    .line 570
    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Class;->getComponentType()Ljava/lang/Class;

    move-result-object v1

    add-int/lit8 v2, v0, 0x1

    invoke-static {v1, v2}, Ljava/lang/reflect/Array;->newInstance(Ljava/lang/Class;I)Ljava/lang/Object;

    move-result-object v1

    .line 571
    .local v1, "newArray":Ljava/lang/Object;
    const/4 v2, 0x0

    invoke-static {p0, v2, v1, v2, v0}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    goto :goto_0

    .line 573
    .end local v1    # "newArray":Ljava/lang/Object;
    :cond_0
    const/4 v1, 0x1

    invoke-static {p2, v1}, Ljava/lang/reflect/Array;->newInstance(Ljava/lang/Class;I)Ljava/lang/Object;

    move-result-object v1

    .line 575
    .restart local v1    # "newArray":Ljava/lang/Object;
    :goto_0
    invoke-static {v1, v0, p1}, Ljava/lang/reflect/Array;->set(Ljava/lang/Object;ILjava/lang/Object;)V

    .line 576
    return-object v1
.end method

.method private static realCopy(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 2
    .param p0, "array"    # Ljava/lang/Object;

    .line 416
    if-nez p0, :cond_0

    const/4 v0, 0x0

    return-object v0

    .line 417
    :cond_0
    const/4 v0, 0x0

    invoke-static {p0}, Lcom/blankj/utilcode/util/ArrayUtils;->getLength(Ljava/lang/Object;)I

    move-result v1

    invoke-static {p0, v0, v1}, Lcom/blankj/utilcode/util/ArrayUtils;->realSubArray(Ljava/lang/Object;II)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method private static realSubArray(Ljava/lang/Object;II)Ljava/lang/Object;
    .locals 5
    .param p0, "array"    # Ljava/lang/Object;
    .param p1, "startIndexInclusive"    # I
    .param p2, "endIndexExclusive"    # I

    .line 472
    if-nez p0, :cond_0

    .line 473
    const/4 v0, 0x0

    return-object v0

    .line 475
    :cond_0
    if-gez p1, :cond_1

    .line 476
    const/4 p1, 0x0

    .line 478
    :cond_1
    invoke-static {p0}, Lcom/blankj/utilcode/util/ArrayUtils;->getLength(Ljava/lang/Object;)I

    move-result v0

    .line 479
    .local v0, "length":I
    if-le p2, v0, :cond_2

    .line 480
    move p2, v0

    .line 482
    :cond_2
    sub-int v1, p2, p1

    .line 483
    .local v1, "newSize":I
    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/Class;->getComponentType()Ljava/lang/Class;

    move-result-object v2

    .line 484
    .local v2, "type":Ljava/lang/Class;
    const/4 v3, 0x0

    if-gtz v1, :cond_3

    .line 485
    invoke-static {v2, v3}, Ljava/lang/reflect/Array;->newInstance(Ljava/lang/Class;I)Ljava/lang/Object;

    move-result-object v3

    return-object v3

    .line 487
    :cond_3
    invoke-static {v2, v1}, Ljava/lang/reflect/Array;->newInstance(Ljava/lang/Class;I)Ljava/lang/Object;

    move-result-object v4

    .line 488
    .local v4, "subArray":Ljava/lang/Object;
    invoke-static {p0, p1, v4, v3, v1}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 489
    return-object v4
.end method

.method private static remove(Ljava/lang/Object;I)Ljava/lang/Object;
    .locals 4
    .param p0, "array"    # Ljava/lang/Object;
    .param p1, "index"    # I

    .line 1085
    invoke-static {p0}, Lcom/blankj/utilcode/util/ArrayUtils;->getLength(Ljava/lang/Object;)I

    move-result v0

    .line 1086
    .local v0, "length":I
    if-ltz p1, :cond_1

    if-ge p1, v0, :cond_1

    .line 1090
    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Class;->getComponentType()Ljava/lang/Class;

    move-result-object v1

    add-int/lit8 v2, v0, -0x1

    invoke-static {v1, v2}, Ljava/lang/reflect/Array;->newInstance(Ljava/lang/Class;I)Ljava/lang/Object;

    move-result-object v1

    .line 1091
    .local v1, "result":Ljava/lang/Object;
    const/4 v2, 0x0

    invoke-static {p0, v2, v1, v2, p1}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 1092
    add-int/lit8 v2, v0, -0x1

    if-ge p1, v2, :cond_0

    .line 1093
    add-int/lit8 v2, p1, 0x1

    sub-int v3, v0, p1

    add-int/lit8 v3, v3, -0x1

    invoke-static {p0, v2, v1, p1, v3}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 1096
    :cond_0
    return-object v1

    .line 1087
    .end local v1    # "result":Ljava/lang/Object;
    :cond_1
    new-instance v1, Ljava/lang/IndexOutOfBoundsException;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Index: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ", Length: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2}, Ljava/lang/IndexOutOfBoundsException;-><init>(Ljava/lang/String;)V

    throw v1
.end method

.method public static remove([BI)[B
    .locals 1
    .param p0, "array"    # [B
    .param p1, "index"    # I

    .line 979
    if-nez p0, :cond_0

    const/4 v0, 0x0

    return-object v0

    .line 980
    :cond_0
    invoke-static {p0, p1}, Lcom/blankj/utilcode/util/ArrayUtils;->remove(Ljava/lang/Object;I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [B

    check-cast v0, [B

    return-object v0
.end method

.method public static remove([CI)[C
    .locals 1
    .param p0, "array"    # [C
    .param p1, "index"    # I

    .line 994
    if-nez p0, :cond_0

    const/4 v0, 0x0

    return-object v0

    .line 995
    :cond_0
    invoke-static {p0, p1}, Lcom/blankj/utilcode/util/ArrayUtils;->remove(Ljava/lang/Object;I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [C

    check-cast v0, [C

    return-object v0
.end method

.method public static remove([DI)[D
    .locals 1
    .param p0, "array"    # [D
    .param p1, "index"    # I

    .line 1009
    if-nez p0, :cond_0

    const/4 v0, 0x0

    return-object v0

    .line 1010
    :cond_0
    invoke-static {p0, p1}, Lcom/blankj/utilcode/util/ArrayUtils;->remove(Ljava/lang/Object;I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [D

    check-cast v0, [D

    return-object v0
.end method

.method public static remove([FI)[F
    .locals 1
    .param p0, "array"    # [F
    .param p1, "index"    # I

    .line 1025
    if-nez p0, :cond_0

    const/4 v0, 0x0

    return-object v0

    .line 1026
    :cond_0
    invoke-static {p0, p1}, Lcom/blankj/utilcode/util/ArrayUtils;->remove(Ljava/lang/Object;I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [F

    check-cast v0, [F

    return-object v0
.end method

.method public static remove([II)[I
    .locals 1
    .param p0, "array"    # [I
    .param p1, "index"    # I

    .line 1040
    if-nez p0, :cond_0

    const/4 v0, 0x0

    return-object v0

    .line 1041
    :cond_0
    invoke-static {p0, p1}, Lcom/blankj/utilcode/util/ArrayUtils;->remove(Ljava/lang/Object;I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [I

    check-cast v0, [I

    return-object v0
.end method

.method public static remove([JI)[J
    .locals 1
    .param p0, "array"    # [J
    .param p1, "index"    # I

    .line 1055
    if-nez p0, :cond_0

    const/4 v0, 0x0

    return-object v0

    .line 1056
    :cond_0
    invoke-static {p0, p1}, Lcom/blankj/utilcode/util/ArrayUtils;->remove(Ljava/lang/Object;I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [J

    check-cast v0, [J

    return-object v0
.end method

.method public static remove([Ljava/lang/Object;I)[Ljava/lang/Object;
    .locals 1
    .param p0, "array"    # [Ljava/lang/Object;
    .param p1, "index"    # I

    .line 925
    if-nez p0, :cond_0

    const/4 v0, 0x0

    return-object v0

    .line 926
    :cond_0
    invoke-static {p0, p1}, Lcom/blankj/utilcode/util/ArrayUtils;->remove(Ljava/lang/Object;I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Ljava/lang/Object;

    check-cast v0, [Ljava/lang/Object;

    return-object v0
.end method

.method public static remove([SI)[S
    .locals 1
    .param p0, "array"    # [S
    .param p1, "index"    # I

    .line 1070
    if-nez p0, :cond_0

    const/4 v0, 0x0

    return-object v0

    .line 1071
    :cond_0
    invoke-static {p0, p1}, Lcom/blankj/utilcode/util/ArrayUtils;->remove(Ljava/lang/Object;I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [S

    check-cast v0, [S

    return-object v0
.end method

.method public static remove([ZI)[Z
    .locals 1
    .param p0, "array"    # [Z
    .param p1, "index"    # I

    .line 964
    if-nez p0, :cond_0

    const/4 v0, 0x0

    return-object v0

    .line 965
    :cond_0
    invoke-static {p0, p1}, Lcom/blankj/utilcode/util/ArrayUtils;->remove(Ljava/lang/Object;I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Z

    check-cast v0, [Z

    return-object v0
.end method

.method public static removeElement([BB)[B
    .locals 2
    .param p0, "array"    # [B
    .param p1, "element"    # B

    .line 985
    invoke-static {p0, p1}, Lcom/blankj/utilcode/util/ArrayUtils;->indexOf([BB)I

    move-result v0

    .line 986
    .local v0, "index":I
    const/4 v1, -0x1

    if-ne v0, v1, :cond_0

    .line 987
    invoke-static {p0}, Lcom/blankj/utilcode/util/ArrayUtils;->copy([B)[B

    move-result-object v1

    return-object v1

    .line 989
    :cond_0
    invoke-static {p0, v0}, Lcom/blankj/utilcode/util/ArrayUtils;->remove([BI)[B

    move-result-object v1

    return-object v1
.end method

.method public static removeElement([CC)[C
    .locals 2
    .param p0, "array"    # [C
    .param p1, "element"    # C

    .line 1000
    invoke-static {p0, p1}, Lcom/blankj/utilcode/util/ArrayUtils;->indexOf([CC)I

    move-result v0

    .line 1001
    .local v0, "index":I
    const/4 v1, -0x1

    if-ne v0, v1, :cond_0

    .line 1002
    invoke-static {p0}, Lcom/blankj/utilcode/util/ArrayUtils;->copy([C)[C

    move-result-object v1

    return-object v1

    .line 1004
    :cond_0
    invoke-static {p0, v0}, Lcom/blankj/utilcode/util/ArrayUtils;->remove([CI)[C

    move-result-object v1

    return-object v1
.end method

.method public static removeElement([DD)[D
    .locals 2
    .param p0, "array"    # [D
    .param p1, "element"    # D

    .line 1015
    invoke-static {p0, p1, p2}, Lcom/blankj/utilcode/util/ArrayUtils;->indexOf([DD)I

    move-result v0

    .line 1016
    .local v0, "index":I
    const/4 v1, -0x1

    if-ne v0, v1, :cond_0

    .line 1017
    invoke-static {p0}, Lcom/blankj/utilcode/util/ArrayUtils;->copy([D)[D

    move-result-object v1

    return-object v1

    .line 1020
    :cond_0
    invoke-static {p0, v0}, Lcom/blankj/utilcode/util/ArrayUtils;->remove([DI)[D

    move-result-object v1

    return-object v1
.end method

.method public static removeElement([FF)[F
    .locals 2
    .param p0, "array"    # [F
    .param p1, "element"    # F

    .line 1031
    invoke-static {p0, p1}, Lcom/blankj/utilcode/util/ArrayUtils;->indexOf([FF)I

    move-result v0

    .line 1032
    .local v0, "index":I
    const/4 v1, -0x1

    if-ne v0, v1, :cond_0

    .line 1033
    invoke-static {p0}, Lcom/blankj/utilcode/util/ArrayUtils;->copy([F)[F

    move-result-object v1

    return-object v1

    .line 1035
    :cond_0
    invoke-static {p0, v0}, Lcom/blankj/utilcode/util/ArrayUtils;->remove([FI)[F

    move-result-object v1

    return-object v1
.end method

.method public static removeElement([II)[I
    .locals 2
    .param p0, "array"    # [I
    .param p1, "element"    # I

    .line 1046
    invoke-static {p0, p1}, Lcom/blankj/utilcode/util/ArrayUtils;->indexOf([II)I

    move-result v0

    .line 1047
    .local v0, "index":I
    const/4 v1, -0x1

    if-ne v0, v1, :cond_0

    .line 1048
    invoke-static {p0}, Lcom/blankj/utilcode/util/ArrayUtils;->copy([I)[I

    move-result-object v1

    return-object v1

    .line 1050
    :cond_0
    invoke-static {p0, v0}, Lcom/blankj/utilcode/util/ArrayUtils;->remove([II)[I

    move-result-object v1

    return-object v1
.end method

.method public static removeElement([JJ)[J
    .locals 2
    .param p0, "array"    # [J
    .param p1, "element"    # J

    .line 1061
    invoke-static {p0, p1, p2}, Lcom/blankj/utilcode/util/ArrayUtils;->indexOf([JJ)I

    move-result v0

    .line 1062
    .local v0, "index":I
    const/4 v1, -0x1

    if-ne v0, v1, :cond_0

    .line 1063
    invoke-static {p0}, Lcom/blankj/utilcode/util/ArrayUtils;->copy([J)[J

    move-result-object v1

    return-object v1

    .line 1065
    :cond_0
    invoke-static {p0, v0}, Lcom/blankj/utilcode/util/ArrayUtils;->remove([JI)[J

    move-result-object v1

    return-object v1
.end method

.method public static removeElement([Ljava/lang/Object;Ljava/lang/Object;)[Ljava/lang/Object;
    .locals 2
    .param p0, "array"    # [Ljava/lang/Object;
    .param p1, "element"    # Ljava/lang/Object;

    .line 955
    invoke-static {p0, p1}, Lcom/blankj/utilcode/util/ArrayUtils;->indexOf([Ljava/lang/Object;Ljava/lang/Object;)I

    move-result v0

    .line 956
    .local v0, "index":I
    const/4 v1, -0x1

    if-ne v0, v1, :cond_0

    .line 957
    invoke-static {p0}, Lcom/blankj/utilcode/util/ArrayUtils;->copy([Ljava/lang/Object;)[Ljava/lang/Object;

    move-result-object v1

    return-object v1

    .line 959
    :cond_0
    invoke-static {p0, v0}, Lcom/blankj/utilcode/util/ArrayUtils;->remove([Ljava/lang/Object;I)[Ljava/lang/Object;

    move-result-object v1

    return-object v1
.end method

.method public static removeElement([SS)[S
    .locals 2
    .param p0, "array"    # [S
    .param p1, "element"    # S

    .line 1076
    invoke-static {p0, p1}, Lcom/blankj/utilcode/util/ArrayUtils;->indexOf([SS)I

    move-result v0

    .line 1077
    .local v0, "index":I
    const/4 v1, -0x1

    if-ne v0, v1, :cond_0

    .line 1078
    invoke-static {p0}, Lcom/blankj/utilcode/util/ArrayUtils;->copy([S)[S

    move-result-object v1

    return-object v1

    .line 1080
    :cond_0
    invoke-static {p0, v0}, Lcom/blankj/utilcode/util/ArrayUtils;->remove([SI)[S

    move-result-object v1

    return-object v1
.end method

.method public static removeElement([ZZ)[Z
    .locals 2
    .param p0, "array"    # [Z
    .param p1, "element"    # Z

    .line 970
    invoke-static {p0, p1}, Lcom/blankj/utilcode/util/ArrayUtils;->indexOf([ZZ)I

    move-result v0

    .line 971
    .local v0, "index":I
    const/4 v1, -0x1

    if-ne v0, v1, :cond_0

    .line 972
    invoke-static {p0}, Lcom/blankj/utilcode/util/ArrayUtils;->copy([Z)[Z

    move-result-object v1

    return-object v1

    .line 974
    :cond_0
    invoke-static {p0, v0}, Lcom/blankj/utilcode/util/ArrayUtils;->remove([ZI)[Z

    move-result-object v1

    return-object v1
.end method

.method public static reverse([B)V
    .locals 4
    .param p0, "array"    # [B

    .line 281
    if-nez p0, :cond_0

    .line 282
    return-void

    .line 284
    :cond_0
    const/4 v0, 0x0

    .line 285
    .local v0, "i":I
    array-length v1, p0

    add-int/lit8 v1, v1, -0x1

    .line 287
    .local v1, "j":I
    :goto_0
    if-le v1, v0, :cond_1

    .line 288
    aget-byte v2, p0, v1

    .line 289
    .local v2, "tmp":B
    aget-byte v3, p0, v0

    aput-byte v3, p0, v1

    .line 290
    aput-byte v2, p0, v0

    .line 291
    add-int/lit8 v1, v1, -0x1

    .line 292
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 294
    .end local v2    # "tmp":B
    :cond_1
    return-void
.end method

.method public static reverse([C)V
    .locals 4
    .param p0, "array"    # [C

    .line 265
    if-nez p0, :cond_0

    .line 266
    return-void

    .line 268
    :cond_0
    const/4 v0, 0x0

    .line 269
    .local v0, "i":I
    array-length v1, p0

    add-int/lit8 v1, v1, -0x1

    .line 271
    .local v1, "j":I
    :goto_0
    if-le v1, v0, :cond_1

    .line 272
    aget-char v2, p0, v1

    .line 273
    .local v2, "tmp":C
    aget-char v3, p0, v0

    aput-char v3, p0, v1

    .line 274
    aput-char v2, p0, v0

    .line 275
    add-int/lit8 v1, v1, -0x1

    .line 276
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 278
    .end local v2    # "tmp":C
    :cond_1
    return-void
.end method

.method public static reverse([D)V
    .locals 6
    .param p0, "array"    # [D

    .line 297
    if-nez p0, :cond_0

    .line 298
    return-void

    .line 300
    :cond_0
    const/4 v0, 0x0

    .line 301
    .local v0, "i":I
    array-length v1, p0

    add-int/lit8 v1, v1, -0x1

    .line 303
    .local v1, "j":I
    :goto_0
    if-le v1, v0, :cond_1

    .line 304
    aget-wide v2, p0, v1

    .line 305
    .local v2, "tmp":D
    aget-wide v4, p0, v0

    aput-wide v4, p0, v1

    .line 306
    aput-wide v2, p0, v0

    .line 307
    add-int/lit8 v1, v1, -0x1

    .line 308
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 310
    .end local v2    # "tmp":D
    :cond_1
    return-void
.end method

.method public static reverse([F)V
    .locals 4
    .param p0, "array"    # [F

    .line 313
    if-nez p0, :cond_0

    .line 314
    return-void

    .line 316
    :cond_0
    const/4 v0, 0x0

    .line 317
    .local v0, "i":I
    array-length v1, p0

    add-int/lit8 v1, v1, -0x1

    .line 319
    .local v1, "j":I
    :goto_0
    if-le v1, v0, :cond_1

    .line 320
    aget v2, p0, v1

    .line 321
    .local v2, "tmp":F
    aget v3, p0, v0

    aput v3, p0, v1

    .line 322
    aput v2, p0, v0

    .line 323
    add-int/lit8 v1, v1, -0x1

    .line 324
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 326
    .end local v2    # "tmp":F
    :cond_1
    return-void
.end method

.method public static reverse([I)V
    .locals 4
    .param p0, "array"    # [I

    .line 233
    if-nez p0, :cond_0

    .line 234
    return-void

    .line 236
    :cond_0
    const/4 v0, 0x0

    .line 237
    .local v0, "i":I
    array-length v1, p0

    add-int/lit8 v1, v1, -0x1

    .line 239
    .local v1, "j":I
    :goto_0
    if-le v1, v0, :cond_1

    .line 240
    aget v2, p0, v1

    .line 241
    .local v2, "tmp":I
    aget v3, p0, v0

    aput v3, p0, v1

    .line 242
    aput v2, p0, v0

    .line 243
    add-int/lit8 v1, v1, -0x1

    .line 244
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 246
    .end local v2    # "tmp":I
    :cond_1
    return-void
.end method

.method public static reverse([J)V
    .locals 6
    .param p0, "array"    # [J

    .line 217
    if-nez p0, :cond_0

    .line 218
    return-void

    .line 220
    :cond_0
    const/4 v0, 0x0

    .line 221
    .local v0, "i":I
    array-length v1, p0

    add-int/lit8 v1, v1, -0x1

    .line 223
    .local v1, "j":I
    :goto_0
    if-le v1, v0, :cond_1

    .line 224
    aget-wide v2, p0, v1

    .line 225
    .local v2, "tmp":J
    aget-wide v4, p0, v0

    aput-wide v4, p0, v1

    .line 226
    aput-wide v2, p0, v0

    .line 227
    add-int/lit8 v1, v1, -0x1

    .line 228
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 230
    .end local v2    # "tmp":J
    :cond_1
    return-void
.end method

.method public static reverse([Ljava/lang/Object;)V
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">([TT;)V"
        }
    .end annotation

    .line 201
    .local p0, "array":[Ljava/lang/Object;, "[TT;"
    if-nez p0, :cond_0

    .line 202
    return-void

    .line 204
    :cond_0
    const/4 v0, 0x0

    .line 205
    .local v0, "i":I
    array-length v1, p0

    add-int/lit8 v1, v1, -0x1

    .line 207
    .local v1, "j":I
    :goto_0
    if-le v1, v0, :cond_1

    .line 208
    aget-object v2, p0, v1

    .line 209
    .local v2, "tmp":Ljava/lang/Object;, "TT;"
    aget-object v3, p0, v0

    aput-object v3, p0, v1

    .line 210
    aput-object v2, p0, v0

    .line 211
    add-int/lit8 v1, v1, -0x1

    .line 212
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 214
    .end local v2    # "tmp":Ljava/lang/Object;, "TT;"
    :cond_1
    return-void
.end method

.method public static reverse([S)V
    .locals 4
    .param p0, "array"    # [S

    .line 249
    if-nez p0, :cond_0

    .line 250
    return-void

    .line 252
    :cond_0
    const/4 v0, 0x0

    .line 253
    .local v0, "i":I
    array-length v1, p0

    add-int/lit8 v1, v1, -0x1

    .line 255
    .local v1, "j":I
    :goto_0
    if-le v1, v0, :cond_1

    .line 256
    aget-short v2, p0, v1

    .line 257
    .local v2, "tmp":S
    aget-short v3, p0, v0

    aput-short v3, p0, v1

    .line 258
    aput-short v2, p0, v0

    .line 259
    add-int/lit8 v1, v1, -0x1

    .line 260
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 262
    .end local v2    # "tmp":S
    :cond_1
    return-void
.end method

.method public static reverse([Z)V
    .locals 4
    .param p0, "array"    # [Z

    .line 329
    if-nez p0, :cond_0

    .line 330
    return-void

    .line 332
    :cond_0
    const/4 v0, 0x0

    .line 333
    .local v0, "i":I
    array-length v1, p0

    add-int/lit8 v1, v1, -0x1

    .line 335
    .local v1, "j":I
    :goto_0
    if-le v1, v0, :cond_1

    .line 336
    aget-boolean v2, p0, v1

    .line 337
    .local v2, "tmp":Z
    aget-boolean v3, p0, v0

    aput-boolean v3, p0, v1

    .line 338
    aput-boolean v2, p0, v0

    .line 339
    add-int/lit8 v1, v1, -0x1

    .line 340
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 342
    .end local v2    # "tmp":Z
    :cond_1
    return-void
.end method

.method public static set(Ljava/lang/Object;ILjava/lang/Object;)V
    .locals 0
    .param p0, "array"    # Ljava/lang/Object;
    .param p1, "index"    # I
    .param p2, "value"    # Ljava/lang/Object;

    .line 144
    if-nez p0, :cond_0

    return-void

    .line 145
    :cond_0
    invoke-static {p0, p1, p2}, Ljava/lang/reflect/Array;->set(Ljava/lang/Object;ILjava/lang/Object;)V

    .line 146
    return-void
.end method

.method public static sort([B)V
    .locals 2
    .param p0, "array"    # [B

    .line 2006
    if-eqz p0, :cond_1

    array-length v0, p0

    const/4 v1, 0x2

    if-ge v0, v1, :cond_0

    goto :goto_0

    .line 2007
    :cond_0
    invoke-static {p0}, Ljava/util/Arrays;->sort([B)V

    .line 2008
    return-void

    .line 2006
    :cond_1
    :goto_0
    return-void
.end method

.method public static sort([C)V
    .locals 2
    .param p0, "array"    # [C

    .line 2011
    if-eqz p0, :cond_1

    array-length v0, p0

    const/4 v1, 0x2

    if-ge v0, v1, :cond_0

    goto :goto_0

    .line 2012
    :cond_0
    invoke-static {p0}, Ljava/util/Arrays;->sort([C)V

    .line 2013
    return-void

    .line 2011
    :cond_1
    :goto_0
    return-void
.end method

.method public static sort([D)V
    .locals 2
    .param p0, "array"    # [D

    .line 2016
    if-eqz p0, :cond_1

    array-length v0, p0

    const/4 v1, 0x2

    if-ge v0, v1, :cond_0

    goto :goto_0

    .line 2017
    :cond_0
    invoke-static {p0}, Ljava/util/Arrays;->sort([D)V

    .line 2018
    return-void

    .line 2016
    :cond_1
    :goto_0
    return-void
.end method

.method public static sort([F)V
    .locals 2
    .param p0, "array"    # [F

    .line 2021
    if-eqz p0, :cond_1

    array-length v0, p0

    const/4 v1, 0x2

    if-ge v0, v1, :cond_0

    goto :goto_0

    .line 2022
    :cond_0
    invoke-static {p0}, Ljava/util/Arrays;->sort([F)V

    .line 2023
    return-void

    .line 2021
    :cond_1
    :goto_0
    return-void
.end method

.method public static sort([I)V
    .locals 2
    .param p0, "array"    # [I

    .line 2026
    if-eqz p0, :cond_1

    array-length v0, p0

    const/4 v1, 0x2

    if-ge v0, v1, :cond_0

    goto :goto_0

    .line 2027
    :cond_0
    invoke-static {p0}, Ljava/util/Arrays;->sort([I)V

    .line 2028
    return-void

    .line 2026
    :cond_1
    :goto_0
    return-void
.end method

.method public static sort([J)V
    .locals 2
    .param p0, "array"    # [J

    .line 2031
    if-eqz p0, :cond_1

    array-length v0, p0

    const/4 v1, 0x2

    if-ge v0, v1, :cond_0

    goto :goto_0

    .line 2032
    :cond_0
    invoke-static {p0}, Ljava/util/Arrays;->sort([J)V

    .line 2033
    return-void

    .line 2031
    :cond_1
    :goto_0
    return-void
.end method

.method public static sort([Ljava/lang/Object;Ljava/util/Comparator;)V
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">([TT;",
            "Ljava/util/Comparator<",
            "-TT;>;)V"
        }
    .end annotation

    .line 2001
    .local p0, "array":[Ljava/lang/Object;, "[TT;"
    .local p1, "c":Ljava/util/Comparator;, "Ljava/util/Comparator<-TT;>;"
    if-eqz p0, :cond_1

    array-length v0, p0

    const/4 v1, 0x2

    if-ge v0, v1, :cond_0

    goto :goto_0

    .line 2002
    :cond_0
    invoke-static {p0, p1}, Ljava/util/Arrays;->sort([Ljava/lang/Object;Ljava/util/Comparator;)V

    .line 2003
    return-void

    .line 2001
    :cond_1
    :goto_0
    return-void
.end method

.method public static sort([S)V
    .locals 2
    .param p0, "array"    # [S

    .line 2036
    if-eqz p0, :cond_1

    array-length v0, p0

    const/4 v1, 0x2

    if-ge v0, v1, :cond_0

    goto :goto_0

    .line 2037
    :cond_0
    invoke-static {p0}, Ljava/util/Arrays;->sort([S)V

    .line 2038
    return-void

    .line 2036
    :cond_1
    :goto_0
    return-void
.end method

.method public static subArray([BII)[B
    .locals 1
    .param p0, "array"    # [B
    .param p1, "startIndexInclusive"    # I
    .param p2, "endIndexExclusive"    # I

    .line 452
    invoke-static {p0, p1, p2}, Lcom/blankj/utilcode/util/ArrayUtils;->realSubArray(Ljava/lang/Object;II)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [B

    check-cast v0, [B

    return-object v0
.end method

.method public static subArray([CII)[C
    .locals 1
    .param p0, "array"    # [C
    .param p1, "startIndexInclusive"    # I
    .param p2, "endIndexExclusive"    # I

    .line 447
    invoke-static {p0, p1, p2}, Lcom/blankj/utilcode/util/ArrayUtils;->realSubArray(Ljava/lang/Object;II)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [C

    check-cast v0, [C

    return-object v0
.end method

.method public static subArray([DII)[D
    .locals 1
    .param p0, "array"    # [D
    .param p1, "startIndexInclusive"    # I
    .param p2, "endIndexExclusive"    # I

    .line 457
    invoke-static {p0, p1, p2}, Lcom/blankj/utilcode/util/ArrayUtils;->realSubArray(Ljava/lang/Object;II)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [D

    check-cast v0, [D

    return-object v0
.end method

.method public static subArray([FII)[F
    .locals 1
    .param p0, "array"    # [F
    .param p1, "startIndexInclusive"    # I
    .param p2, "endIndexExclusive"    # I

    .line 462
    invoke-static {p0, p1, p2}, Lcom/blankj/utilcode/util/ArrayUtils;->realSubArray(Ljava/lang/Object;II)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [F

    check-cast v0, [F

    return-object v0
.end method

.method public static subArray([III)[I
    .locals 1
    .param p0, "array"    # [I
    .param p1, "startIndexInclusive"    # I
    .param p2, "endIndexExclusive"    # I

    .line 437
    invoke-static {p0, p1, p2}, Lcom/blankj/utilcode/util/ArrayUtils;->realSubArray(Ljava/lang/Object;II)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [I

    check-cast v0, [I

    return-object v0
.end method

.method public static subArray([JII)[J
    .locals 1
    .param p0, "array"    # [J
    .param p1, "startIndexInclusive"    # I
    .param p2, "endIndexExclusive"    # I

    .line 432
    invoke-static {p0, p1, p2}, Lcom/blankj/utilcode/util/ArrayUtils;->realSubArray(Ljava/lang/Object;II)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [J

    check-cast v0, [J

    return-object v0
.end method

.method public static subArray([Ljava/lang/Object;II)[Ljava/lang/Object;
    .locals 1
    .param p1, "startIndexInclusive"    # I
    .param p2, "endIndexExclusive"    # I
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">([TT;II)[TT;"
        }
    .end annotation

    .line 427
    .local p0, "array":[Ljava/lang/Object;, "[TT;"
    invoke-static {p0, p1, p2}, Lcom/blankj/utilcode/util/ArrayUtils;->realSubArray(Ljava/lang/Object;II)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Ljava/lang/Object;

    check-cast v0, [Ljava/lang/Object;

    return-object v0
.end method

.method public static subArray([SII)[S
    .locals 1
    .param p0, "array"    # [S
    .param p1, "startIndexInclusive"    # I
    .param p2, "endIndexExclusive"    # I

    .line 442
    invoke-static {p0, p1, p2}, Lcom/blankj/utilcode/util/ArrayUtils;->realSubArray(Ljava/lang/Object;II)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [S

    check-cast v0, [S

    return-object v0
.end method

.method public static subArray([ZII)[Z
    .locals 1
    .param p0, "array"    # [Z
    .param p1, "startIndexInclusive"    # I
    .param p2, "endIndexExclusive"    # I

    .line 467
    invoke-static {p0, p1, p2}, Lcom/blankj/utilcode/util/ArrayUtils;->realSubArray(Ljava/lang/Object;II)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Z

    check-cast v0, [Z

    return-object v0
.end method

.method public static toObject([Z)[Ljava/lang/Boolean;
    .locals 3
    .param p0, "array"    # [Z

    .line 1959
    if-nez p0, :cond_0

    .line 1960
    const/4 v0, 0x0

    return-object v0

    .line 1961
    :cond_0
    array-length v0, p0

    if-nez v0, :cond_1

    .line 1962
    const/4 v0, 0x0

    new-array v0, v0, [Ljava/lang/Boolean;

    return-object v0

    .line 1964
    :cond_1
    array-length v0, p0

    new-array v0, v0, [Ljava/lang/Boolean;

    .line 1965
    .local v0, "result":[Ljava/lang/Boolean;
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_0
    array-length v2, p0

    if-ge v1, v2, :cond_3

    .line 1966
    aget-boolean v2, p0, v1

    if-eqz v2, :cond_2

    sget-object v2, Ljava/lang/Boolean;->TRUE:Ljava/lang/Boolean;

    goto :goto_1

    :cond_2
    sget-object v2, Ljava/lang/Boolean;->FALSE:Ljava/lang/Boolean;

    :goto_1
    aput-object v2, v0, v1

    .line 1965
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 1968
    .end local v1    # "i":I
    :cond_3
    return-object v0
.end method

.method public static toObject([B)[Ljava/lang/Byte;
    .locals 4
    .param p0, "array"    # [B

    .line 1818
    if-nez p0, :cond_0

    .line 1819
    const/4 v0, 0x0

    return-object v0

    .line 1820
    :cond_0
    array-length v0, p0

    if-nez v0, :cond_1

    .line 1821
    const/4 v0, 0x0

    new-array v0, v0, [Ljava/lang/Byte;

    return-object v0

    .line 1823
    :cond_1
    array-length v0, p0

    new-array v0, v0, [Ljava/lang/Byte;

    .line 1824
    .local v0, "result":[Ljava/lang/Byte;
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_0
    array-length v2, p0

    if-ge v1, v2, :cond_2

    .line 1825
    new-instance v2, Ljava/lang/Byte;

    aget-byte v3, p0, v1

    invoke-direct {v2, v3}, Ljava/lang/Byte;-><init>(B)V

    aput-object v2, v0, v1

    .line 1824
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 1827
    .end local v1    # "i":I
    :cond_2
    return-object v0
.end method

.method public static toObject([C)[Ljava/lang/Character;
    .locals 4
    .param p0, "array"    # [C

    .line 1630
    if-nez p0, :cond_0

    .line 1631
    const/4 v0, 0x0

    return-object v0

    .line 1632
    :cond_0
    array-length v0, p0

    if-nez v0, :cond_1

    .line 1633
    const/4 v0, 0x0

    new-array v0, v0, [Ljava/lang/Character;

    return-object v0

    .line 1635
    :cond_1
    array-length v0, p0

    new-array v0, v0, [Ljava/lang/Character;

    .line 1636
    .local v0, "result":[Ljava/lang/Character;
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_0
    array-length v2, p0

    if-ge v1, v2, :cond_2

    .line 1637
    new-instance v2, Ljava/lang/Character;

    aget-char v3, p0, v1

    invoke-direct {v2, v3}, Ljava/lang/Character;-><init>(C)V

    aput-object v2, v0, v1

    .line 1636
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 1639
    .end local v1    # "i":I
    :cond_2
    return-object v0
.end method

.method public static toObject([D)[Ljava/lang/Double;
    .locals 5
    .param p0, "array"    # [D

    .line 1865
    if-nez p0, :cond_0

    .line 1866
    const/4 v0, 0x0

    return-object v0

    .line 1867
    :cond_0
    array-length v0, p0

    if-nez v0, :cond_1

    .line 1868
    const/4 v0, 0x0

    new-array v0, v0, [Ljava/lang/Double;

    return-object v0

    .line 1870
    :cond_1
    array-length v0, p0

    new-array v0, v0, [Ljava/lang/Double;

    .line 1871
    .local v0, "result":[Ljava/lang/Double;
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_0
    array-length v2, p0

    if-ge v1, v2, :cond_2

    .line 1872
    new-instance v2, Ljava/lang/Double;

    aget-wide v3, p0, v1

    invoke-direct {v2, v3, v4}, Ljava/lang/Double;-><init>(D)V

    aput-object v2, v0, v1

    .line 1871
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 1874
    .end local v1    # "i":I
    :cond_2
    return-object v0
.end method

.method public static toObject([F)[Ljava/lang/Float;
    .locals 4
    .param p0, "array"    # [F

    .line 1912
    if-nez p0, :cond_0

    .line 1913
    const/4 v0, 0x0

    return-object v0

    .line 1914
    :cond_0
    array-length v0, p0

    if-nez v0, :cond_1

    .line 1915
    const/4 v0, 0x0

    new-array v0, v0, [Ljava/lang/Float;

    return-object v0

    .line 1917
    :cond_1
    array-length v0, p0

    new-array v0, v0, [Ljava/lang/Float;

    .line 1918
    .local v0, "result":[Ljava/lang/Float;
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_0
    array-length v2, p0

    if-ge v1, v2, :cond_2

    .line 1919
    new-instance v2, Ljava/lang/Float;

    aget v3, p0, v1

    invoke-direct {v2, v3}, Ljava/lang/Float;-><init>(F)V

    aput-object v2, v0, v1

    .line 1918
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 1921
    .end local v1    # "i":I
    :cond_2
    return-object v0
.end method

.method public static toObject([I)[Ljava/lang/Integer;
    .locals 4
    .param p0, "array"    # [I

    .line 1724
    if-nez p0, :cond_0

    .line 1725
    const/4 v0, 0x0

    return-object v0

    .line 1726
    :cond_0
    array-length v0, p0

    if-nez v0, :cond_1

    .line 1727
    const/4 v0, 0x0

    new-array v0, v0, [Ljava/lang/Integer;

    return-object v0

    .line 1729
    :cond_1
    array-length v0, p0

    new-array v0, v0, [Ljava/lang/Integer;

    .line 1730
    .local v0, "result":[Ljava/lang/Integer;
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_0
    array-length v2, p0

    if-ge v1, v2, :cond_2

    .line 1731
    new-instance v2, Ljava/lang/Integer;

    aget v3, p0, v1

    invoke-direct {v2, v3}, Ljava/lang/Integer;-><init>(I)V

    aput-object v2, v0, v1

    .line 1730
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 1733
    .end local v1    # "i":I
    :cond_2
    return-object v0
.end method

.method public static toObject([J)[Ljava/lang/Long;
    .locals 5
    .param p0, "array"    # [J

    .line 1677
    if-nez p0, :cond_0

    .line 1678
    const/4 v0, 0x0

    return-object v0

    .line 1679
    :cond_0
    array-length v0, p0

    if-nez v0, :cond_1

    .line 1680
    const/4 v0, 0x0

    new-array v0, v0, [Ljava/lang/Long;

    return-object v0

    .line 1682
    :cond_1
    array-length v0, p0

    new-array v0, v0, [Ljava/lang/Long;

    .line 1683
    .local v0, "result":[Ljava/lang/Long;
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_0
    array-length v2, p0

    if-ge v1, v2, :cond_2

    .line 1684
    new-instance v2, Ljava/lang/Long;

    aget-wide v3, p0, v1

    invoke-direct {v2, v3, v4}, Ljava/lang/Long;-><init>(J)V

    aput-object v2, v0, v1

    .line 1683
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 1686
    .end local v1    # "i":I
    :cond_2
    return-object v0
.end method

.method public static toObject([S)[Ljava/lang/Short;
    .locals 4
    .param p0, "array"    # [S

    .line 1771
    if-nez p0, :cond_0

    .line 1772
    const/4 v0, 0x0

    return-object v0

    .line 1773
    :cond_0
    array-length v0, p0

    if-nez v0, :cond_1

    .line 1774
    const/4 v0, 0x0

    new-array v0, v0, [Ljava/lang/Short;

    return-object v0

    .line 1776
    :cond_1
    array-length v0, p0

    new-array v0, v0, [Ljava/lang/Short;

    .line 1777
    .local v0, "result":[Ljava/lang/Short;
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_0
    array-length v2, p0

    if-ge v1, v2, :cond_2

    .line 1778
    new-instance v2, Ljava/lang/Short;

    aget-short v3, p0, v1

    invoke-direct {v2, v3}, Ljava/lang/Short;-><init>(S)V

    aput-object v2, v0, v1

    .line 1777
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 1780
    .end local v1    # "i":I
    :cond_2
    return-object v0
.end method

.method public static toPrimitive([Ljava/lang/Byte;)[B
    .locals 3
    .param p0, "array"    # [Ljava/lang/Byte;

    .line 1789
    if-nez p0, :cond_0

    .line 1790
    const/4 v0, 0x0

    return-object v0

    .line 1791
    :cond_0
    array-length v0, p0

    if-nez v0, :cond_1

    .line 1792
    const/4 v0, 0x0

    new-array v0, v0, [B

    return-object v0

    .line 1794
    :cond_1
    array-length v0, p0

    new-array v0, v0, [B

    .line 1795
    .local v0, "result":[B
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_0
    array-length v2, p0

    if-ge v1, v2, :cond_2

    .line 1796
    aget-object v2, p0, v1

    invoke-virtual {v2}, Ljava/lang/Byte;->byteValue()B

    move-result v2

    aput-byte v2, v0, v1

    .line 1795
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 1798
    .end local v1    # "i":I
    :cond_2
    return-object v0
.end method

.method public static toPrimitive([Ljava/lang/Byte;B)[B
    .locals 4
    .param p0, "array"    # [Ljava/lang/Byte;
    .param p1, "valueForNull"    # B

    .line 1803
    if-nez p0, :cond_0

    .line 1804
    const/4 v0, 0x0

    return-object v0

    .line 1805
    :cond_0
    array-length v0, p0

    if-nez v0, :cond_1

    .line 1806
    const/4 v0, 0x0

    new-array v0, v0, [B

    return-object v0

    .line 1808
    :cond_1
    array-length v0, p0

    new-array v0, v0, [B

    .line 1809
    .local v0, "result":[B
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_0
    array-length v2, p0

    if-ge v1, v2, :cond_3

    .line 1810
    aget-object v2, p0, v1

    .line 1811
    .local v2, "b":Ljava/lang/Byte;
    if-nez v2, :cond_2

    move v3, p1

    goto :goto_1

    :cond_2
    invoke-virtual {v2}, Ljava/lang/Byte;->byteValue()B

    move-result v3

    :goto_1
    aput-byte v3, v0, v1

    .line 1809
    .end local v2    # "b":Ljava/lang/Byte;
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 1813
    .end local v1    # "i":I
    :cond_3
    return-object v0
.end method

.method public static toPrimitive([Ljava/lang/Character;)[C
    .locals 3
    .param p0, "array"    # [Ljava/lang/Character;

    .line 1601
    if-nez p0, :cond_0

    .line 1602
    const/4 v0, 0x0

    return-object v0

    .line 1603
    :cond_0
    array-length v0, p0

    if-nez v0, :cond_1

    .line 1604
    const/4 v0, 0x0

    new-array v0, v0, [C

    return-object v0

    .line 1606
    :cond_1
    array-length v0, p0

    new-array v0, v0, [C

    .line 1607
    .local v0, "result":[C
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_0
    array-length v2, p0

    if-ge v1, v2, :cond_2

    .line 1608
    aget-object v2, p0, v1

    invoke-virtual {v2}, Ljava/lang/Character;->charValue()C

    move-result v2

    aput-char v2, v0, v1

    .line 1607
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 1610
    .end local v1    # "i":I
    :cond_2
    return-object v0
.end method

.method public static toPrimitive([Ljava/lang/Character;C)[C
    .locals 4
    .param p0, "array"    # [Ljava/lang/Character;
    .param p1, "valueForNull"    # C

    .line 1615
    if-nez p0, :cond_0

    .line 1616
    const/4 v0, 0x0

    return-object v0

    .line 1617
    :cond_0
    array-length v0, p0

    if-nez v0, :cond_1

    .line 1618
    const/4 v0, 0x0

    new-array v0, v0, [C

    return-object v0

    .line 1620
    :cond_1
    array-length v0, p0

    new-array v0, v0, [C

    .line 1621
    .local v0, "result":[C
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_0
    array-length v2, p0

    if-ge v1, v2, :cond_3

    .line 1622
    aget-object v2, p0, v1

    .line 1623
    .local v2, "b":Ljava/lang/Character;
    if-nez v2, :cond_2

    move v3, p1

    goto :goto_1

    :cond_2
    invoke-virtual {v2}, Ljava/lang/Character;->charValue()C

    move-result v3

    :goto_1
    aput-char v3, v0, v1

    .line 1621
    .end local v2    # "b":Ljava/lang/Character;
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 1625
    .end local v1    # "i":I
    :cond_3
    return-object v0
.end method

.method public static toPrimitive([Ljava/lang/Double;)[D
    .locals 4
    .param p0, "array"    # [Ljava/lang/Double;

    .line 1836
    if-nez p0, :cond_0

    .line 1837
    const/4 v0, 0x0

    return-object v0

    .line 1838
    :cond_0
    array-length v0, p0

    if-nez v0, :cond_1

    .line 1839
    const/4 v0, 0x0

    new-array v0, v0, [D

    return-object v0

    .line 1841
    :cond_1
    array-length v0, p0

    new-array v0, v0, [D

    .line 1842
    .local v0, "result":[D
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_0
    array-length v2, p0

    if-ge v1, v2, :cond_2

    .line 1843
    aget-object v2, p0, v1

    invoke-virtual {v2}, Ljava/lang/Double;->doubleValue()D

    move-result-wide v2

    aput-wide v2, v0, v1

    .line 1842
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 1845
    .end local v1    # "i":I
    :cond_2
    return-object v0
.end method

.method public static toPrimitive([Ljava/lang/Double;D)[D
    .locals 5
    .param p0, "array"    # [Ljava/lang/Double;
    .param p1, "valueForNull"    # D

    .line 1850
    if-nez p0, :cond_0

    .line 1851
    const/4 v0, 0x0

    return-object v0

    .line 1852
    :cond_0
    array-length v0, p0

    if-nez v0, :cond_1

    .line 1853
    const/4 v0, 0x0

    new-array v0, v0, [D

    return-object v0

    .line 1855
    :cond_1
    array-length v0, p0

    new-array v0, v0, [D

    .line 1856
    .local v0, "result":[D
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_0
    array-length v2, p0

    if-ge v1, v2, :cond_3

    .line 1857
    aget-object v2, p0, v1

    .line 1858
    .local v2, "b":Ljava/lang/Double;
    if-nez v2, :cond_2

    move-wide v3, p1

    goto :goto_1

    :cond_2
    invoke-virtual {v2}, Ljava/lang/Double;->doubleValue()D

    move-result-wide v3

    :goto_1
    aput-wide v3, v0, v1

    .line 1856
    .end local v2    # "b":Ljava/lang/Double;
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 1860
    .end local v1    # "i":I
    :cond_3
    return-object v0
.end method

.method public static toPrimitive([Ljava/lang/Float;)[F
    .locals 3
    .param p0, "array"    # [Ljava/lang/Float;

    .line 1883
    if-nez p0, :cond_0

    .line 1884
    const/4 v0, 0x0

    return-object v0

    .line 1885
    :cond_0
    array-length v0, p0

    if-nez v0, :cond_1

    .line 1886
    const/4 v0, 0x0

    new-array v0, v0, [F

    return-object v0

    .line 1888
    :cond_1
    array-length v0, p0

    new-array v0, v0, [F

    .line 1889
    .local v0, "result":[F
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_0
    array-length v2, p0

    if-ge v1, v2, :cond_2

    .line 1890
    aget-object v2, p0, v1

    invoke-virtual {v2}, Ljava/lang/Float;->floatValue()F

    move-result v2

    aput v2, v0, v1

    .line 1889
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 1892
    .end local v1    # "i":I
    :cond_2
    return-object v0
.end method

.method public static toPrimitive([Ljava/lang/Float;F)[F
    .locals 4
    .param p0, "array"    # [Ljava/lang/Float;
    .param p1, "valueForNull"    # F

    .line 1897
    if-nez p0, :cond_0

    .line 1898
    const/4 v0, 0x0

    return-object v0

    .line 1899
    :cond_0
    array-length v0, p0

    if-nez v0, :cond_1

    .line 1900
    const/4 v0, 0x0

    new-array v0, v0, [F

    return-object v0

    .line 1902
    :cond_1
    array-length v0, p0

    new-array v0, v0, [F

    .line 1903
    .local v0, "result":[F
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_0
    array-length v2, p0

    if-ge v1, v2, :cond_3

    .line 1904
    aget-object v2, p0, v1

    .line 1905
    .local v2, "b":Ljava/lang/Float;
    if-nez v2, :cond_2

    move v3, p1

    goto :goto_1

    :cond_2
    invoke-virtual {v2}, Ljava/lang/Float;->floatValue()F

    move-result v3

    :goto_1
    aput v3, v0, v1

    .line 1903
    .end local v2    # "b":Ljava/lang/Float;
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 1907
    .end local v1    # "i":I
    :cond_3
    return-object v0
.end method

.method public static toPrimitive([Ljava/lang/Integer;)[I
    .locals 3
    .param p0, "array"    # [Ljava/lang/Integer;

    .line 1695
    if-nez p0, :cond_0

    .line 1696
    const/4 v0, 0x0

    return-object v0

    .line 1697
    :cond_0
    array-length v0, p0

    if-nez v0, :cond_1

    .line 1698
    const/4 v0, 0x0

    new-array v0, v0, [I

    return-object v0

    .line 1700
    :cond_1
    array-length v0, p0

    new-array v0, v0, [I

    .line 1701
    .local v0, "result":[I
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_0
    array-length v2, p0

    if-ge v1, v2, :cond_2

    .line 1702
    aget-object v2, p0, v1

    invoke-virtual {v2}, Ljava/lang/Integer;->intValue()I

    move-result v2

    aput v2, v0, v1

    .line 1701
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 1704
    .end local v1    # "i":I
    :cond_2
    return-object v0
.end method

.method public static toPrimitive([Ljava/lang/Integer;I)[I
    .locals 4
    .param p0, "array"    # [Ljava/lang/Integer;
    .param p1, "valueForNull"    # I

    .line 1709
    if-nez p0, :cond_0

    .line 1710
    const/4 v0, 0x0

    return-object v0

    .line 1711
    :cond_0
    array-length v0, p0

    if-nez v0, :cond_1

    .line 1712
    const/4 v0, 0x0

    new-array v0, v0, [I

    return-object v0

    .line 1714
    :cond_1
    array-length v0, p0

    new-array v0, v0, [I

    .line 1715
    .local v0, "result":[I
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_0
    array-length v2, p0

    if-ge v1, v2, :cond_3

    .line 1716
    aget-object v2, p0, v1

    .line 1717
    .local v2, "b":Ljava/lang/Integer;
    if-nez v2, :cond_2

    move v3, p1

    goto :goto_1

    :cond_2
    invoke-virtual {v2}, Ljava/lang/Integer;->intValue()I

    move-result v3

    :goto_1
    aput v3, v0, v1

    .line 1715
    .end local v2    # "b":Ljava/lang/Integer;
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 1719
    .end local v1    # "i":I
    :cond_3
    return-object v0
.end method

.method public static toPrimitive([Ljava/lang/Long;)[J
    .locals 4
    .param p0, "array"    # [Ljava/lang/Long;

    .line 1648
    if-nez p0, :cond_0

    .line 1649
    const/4 v0, 0x0

    return-object v0

    .line 1650
    :cond_0
    array-length v0, p0

    if-nez v0, :cond_1

    .line 1651
    const/4 v0, 0x0

    new-array v0, v0, [J

    return-object v0

    .line 1653
    :cond_1
    array-length v0, p0

    new-array v0, v0, [J

    .line 1654
    .local v0, "result":[J
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_0
    array-length v2, p0

    if-ge v1, v2, :cond_2

    .line 1655
    aget-object v2, p0, v1

    invoke-virtual {v2}, Ljava/lang/Long;->longValue()J

    move-result-wide v2

    aput-wide v2, v0, v1

    .line 1654
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 1657
    .end local v1    # "i":I
    :cond_2
    return-object v0
.end method

.method public static toPrimitive([Ljava/lang/Long;J)[J
    .locals 5
    .param p0, "array"    # [Ljava/lang/Long;
    .param p1, "valueForNull"    # J

    .line 1662
    if-nez p0, :cond_0

    .line 1663
    const/4 v0, 0x0

    return-object v0

    .line 1664
    :cond_0
    array-length v0, p0

    if-nez v0, :cond_1

    .line 1665
    const/4 v0, 0x0

    new-array v0, v0, [J

    return-object v0

    .line 1667
    :cond_1
    array-length v0, p0

    new-array v0, v0, [J

    .line 1668
    .local v0, "result":[J
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_0
    array-length v2, p0

    if-ge v1, v2, :cond_3

    .line 1669
    aget-object v2, p0, v1

    .line 1670
    .local v2, "b":Ljava/lang/Long;
    if-nez v2, :cond_2

    move-wide v3, p1

    goto :goto_1

    :cond_2
    invoke-virtual {v2}, Ljava/lang/Long;->longValue()J

    move-result-wide v3

    :goto_1
    aput-wide v3, v0, v1

    .line 1668
    .end local v2    # "b":Ljava/lang/Long;
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 1672
    .end local v1    # "i":I
    :cond_3
    return-object v0
.end method

.method public static toPrimitive([Ljava/lang/Short;)[S
    .locals 3
    .param p0, "array"    # [Ljava/lang/Short;

    .line 1742
    if-nez p0, :cond_0

    .line 1743
    const/4 v0, 0x0

    return-object v0

    .line 1744
    :cond_0
    array-length v0, p0

    if-nez v0, :cond_1

    .line 1745
    const/4 v0, 0x0

    new-array v0, v0, [S

    return-object v0

    .line 1747
    :cond_1
    array-length v0, p0

    new-array v0, v0, [S

    .line 1748
    .local v0, "result":[S
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_0
    array-length v2, p0

    if-ge v1, v2, :cond_2

    .line 1749
    aget-object v2, p0, v1

    invoke-virtual {v2}, Ljava/lang/Short;->shortValue()S

    move-result v2

    aput-short v2, v0, v1

    .line 1748
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 1751
    .end local v1    # "i":I
    :cond_2
    return-object v0
.end method

.method public static toPrimitive([Ljava/lang/Short;S)[S
    .locals 4
    .param p0, "array"    # [Ljava/lang/Short;
    .param p1, "valueForNull"    # S

    .line 1756
    if-nez p0, :cond_0

    .line 1757
    const/4 v0, 0x0

    return-object v0

    .line 1758
    :cond_0
    array-length v0, p0

    if-nez v0, :cond_1

    .line 1759
    const/4 v0, 0x0

    new-array v0, v0, [S

    return-object v0

    .line 1761
    :cond_1
    array-length v0, p0

    new-array v0, v0, [S

    .line 1762
    .local v0, "result":[S
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_0
    array-length v2, p0

    if-ge v1, v2, :cond_3

    .line 1763
    aget-object v2, p0, v1

    .line 1764
    .local v2, "b":Ljava/lang/Short;
    if-nez v2, :cond_2

    move v3, p1

    goto :goto_1

    :cond_2
    invoke-virtual {v2}, Ljava/lang/Short;->shortValue()S

    move-result v3

    :goto_1
    aput-short v3, v0, v1

    .line 1762
    .end local v2    # "b":Ljava/lang/Short;
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 1766
    .end local v1    # "i":I
    :cond_3
    return-object v0
.end method

.method public static toPrimitive([Ljava/lang/Boolean;)[Z
    .locals 3
    .param p0, "array"    # [Ljava/lang/Boolean;

    .line 1930
    if-nez p0, :cond_0

    .line 1931
    const/4 v0, 0x0

    return-object v0

    .line 1932
    :cond_0
    array-length v0, p0

    if-nez v0, :cond_1

    .line 1933
    const/4 v0, 0x0

    new-array v0, v0, [Z

    return-object v0

    .line 1935
    :cond_1
    array-length v0, p0

    new-array v0, v0, [Z

    .line 1936
    .local v0, "result":[Z
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_0
    array-length v2, p0

    if-ge v1, v2, :cond_2

    .line 1937
    aget-object v2, p0, v1

    invoke-virtual {v2}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v2

    aput-boolean v2, v0, v1

    .line 1936
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 1939
    .end local v1    # "i":I
    :cond_2
    return-object v0
.end method

.method public static toPrimitive([Ljava/lang/Boolean;Z)[Z
    .locals 4
    .param p0, "array"    # [Ljava/lang/Boolean;
    .param p1, "valueForNull"    # Z

    .line 1944
    if-nez p0, :cond_0

    .line 1945
    const/4 v0, 0x0

    return-object v0

    .line 1946
    :cond_0
    array-length v0, p0

    if-nez v0, :cond_1

    .line 1947
    const/4 v0, 0x0

    new-array v0, v0, [Z

    return-object v0

    .line 1949
    :cond_1
    array-length v0, p0

    new-array v0, v0, [Z

    .line 1950
    .local v0, "result":[Z
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_0
    array-length v2, p0

    if-ge v1, v2, :cond_3

    .line 1951
    aget-object v2, p0, v1

    .line 1952
    .local v2, "b":Ljava/lang/Boolean;
    if-nez v2, :cond_2

    move v3, p1

    goto :goto_1

    :cond_2
    invoke-virtual {v2}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v3

    :goto_1
    aput-boolean v3, v0, v1

    .line 1950
    .end local v2    # "b":Ljava/lang/Boolean;
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 1954
    .end local v1    # "i":I
    :cond_3
    return-object v0
.end method

.method public static toString(Ljava/lang/Object;)Ljava/lang/String;
    .locals 3
    .param p0, "array"    # Ljava/lang/Object;

    .line 2117
    if-nez p0, :cond_0

    const-string v0, "null"

    return-object v0

    .line 2118
    :cond_0
    instance-of v0, p0, [Ljava/lang/Object;

    if-eqz v0, :cond_1

    .line 2119
    move-object v0, p0

    check-cast v0, [Ljava/lang/Object;

    check-cast v0, [Ljava/lang/Object;

    invoke-static {v0}, Ljava/util/Arrays;->deepToString([Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    return-object v0

    .line 2120
    :cond_1
    instance-of v0, p0, [Z

    if-eqz v0, :cond_2

    .line 2121
    move-object v0, p0

    check-cast v0, [Z

    check-cast v0, [Z

    invoke-static {v0}, Ljava/util/Arrays;->toString([Z)Ljava/lang/String;

    move-result-object v0

    return-object v0

    .line 2122
    :cond_2
    instance-of v0, p0, [B

    if-eqz v0, :cond_3

    .line 2123
    move-object v0, p0

    check-cast v0, [B

    check-cast v0, [B

    invoke-static {v0}, Ljava/util/Arrays;->toString([B)Ljava/lang/String;

    move-result-object v0

    return-object v0

    .line 2124
    :cond_3
    instance-of v0, p0, [C

    if-eqz v0, :cond_4

    .line 2125
    move-object v0, p0

    check-cast v0, [C

    check-cast v0, [C

    invoke-static {v0}, Ljava/util/Arrays;->toString([C)Ljava/lang/String;

    move-result-object v0

    return-object v0

    .line 2126
    :cond_4
    instance-of v0, p0, [D

    if-eqz v0, :cond_5

    .line 2127
    move-object v0, p0

    check-cast v0, [D

    check-cast v0, [D

    invoke-static {v0}, Ljava/util/Arrays;->toString([D)Ljava/lang/String;

    move-result-object v0

    return-object v0

    .line 2128
    :cond_5
    instance-of v0, p0, [F

    if-eqz v0, :cond_6

    .line 2129
    move-object v0, p0

    check-cast v0, [F

    check-cast v0, [F

    invoke-static {v0}, Ljava/util/Arrays;->toString([F)Ljava/lang/String;

    move-result-object v0

    return-object v0

    .line 2130
    :cond_6
    instance-of v0, p0, [I

    if-eqz v0, :cond_7

    .line 2131
    move-object v0, p0

    check-cast v0, [I

    check-cast v0, [I

    invoke-static {v0}, Ljava/util/Arrays;->toString([I)Ljava/lang/String;

    move-result-object v0

    return-object v0

    .line 2132
    :cond_7
    instance-of v0, p0, [J

    if-eqz v0, :cond_8

    .line 2133
    move-object v0, p0

    check-cast v0, [J

    check-cast v0, [J

    invoke-static {v0}, Ljava/util/Arrays;->toString([J)Ljava/lang/String;

    move-result-object v0

    return-object v0

    .line 2134
    :cond_8
    instance-of v0, p0, [S

    if-eqz v0, :cond_9

    .line 2135
    move-object v0, p0

    check-cast v0, [S

    check-cast v0, [S

    invoke-static {v0}, Ljava/util/Arrays;->toString([S)Ljava/lang/String;

    move-result-object v0

    return-object v0

    .line 2137
    :cond_9
    new-instance v0, Ljava/lang/IllegalArgumentException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Array has incompatible type: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method
