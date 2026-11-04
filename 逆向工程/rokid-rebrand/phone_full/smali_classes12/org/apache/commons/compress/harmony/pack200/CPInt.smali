.class public Lorg/apache/commons/compress/harmony/pack200/CPInt;
.super Lorg/apache/commons/compress/harmony/pack200/CPConstant;
.source "CPInt.java"


# instance fields
.field private final theInt:I


# direct methods
.method public constructor <init>(I)V
    .locals 0
    .param p1, "theInt"    # I

    .line 26
    invoke-direct {p0}, Lorg/apache/commons/compress/harmony/pack200/CPConstant;-><init>()V

    .line 27
    iput p1, p0, Lorg/apache/commons/compress/harmony/pack200/CPInt;->theInt:I

    .line 28
    return-void
.end method


# virtual methods
.method public compareTo(Ljava/lang/Object;)I
    .locals 2
    .param p1, "obj"    # Ljava/lang/Object;

    .line 32
    iget v0, p0, Lorg/apache/commons/compress/harmony/pack200/CPInt;->theInt:I

    move-object v1, p1

    check-cast v1, Lorg/apache/commons/compress/harmony/pack200/CPInt;

    iget v1, v1, Lorg/apache/commons/compress/harmony/pack200/CPInt;->theInt:I

    if-le v0, v1, :cond_0

    .line 33
    const/4 v0, 0x1

    return v0

    .line 35
    :cond_0
    iget v0, p0, Lorg/apache/commons/compress/harmony/pack200/CPInt;->theInt:I

    move-object v1, p1

    check-cast v1, Lorg/apache/commons/compress/harmony/pack200/CPInt;

    iget v1, v1, Lorg/apache/commons/compress/harmony/pack200/CPInt;->theInt:I

    if-ne v0, v1, :cond_1

    .line 36
    const/4 v0, 0x0

    return v0

    .line 38
    :cond_1
    const/4 v0, -0x1

    return v0
.end method

.method public getInt()I
    .locals 1

    .line 42
    iget v0, p0, Lorg/apache/commons/compress/harmony/pack200/CPInt;->theInt:I

    return v0
.end method
