.class public abstract Lorg/apache/commons/compress/harmony/pack200/ConstantPoolEntry;
.super Ljava/lang/Object;
.source "ConstantPoolEntry.java"


# instance fields
.field private index:I


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 22
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 24
    const/4 v0, -0x1

    iput v0, p0, Lorg/apache/commons/compress/harmony/pack200/ConstantPoolEntry;->index:I

    return-void
.end method


# virtual methods
.method public getIndex()I
    .locals 1

    .line 27
    iget v0, p0, Lorg/apache/commons/compress/harmony/pack200/ConstantPoolEntry;->index:I

    return v0
.end method

.method public setIndex(I)V
    .locals 0
    .param p1, "index"    # I

    .line 31
    iput p1, p0, Lorg/apache/commons/compress/harmony/pack200/ConstantPoolEntry;->index:I

    .line 32
    return-void
.end method
