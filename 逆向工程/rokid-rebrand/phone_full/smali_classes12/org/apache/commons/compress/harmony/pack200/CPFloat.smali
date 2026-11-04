.class public Lorg/apache/commons/compress/harmony/pack200/CPFloat;
.super Lorg/apache/commons/compress/harmony/pack200/CPConstant;
.source "CPFloat.java"


# instance fields
.field private final theFloat:F


# direct methods
.method public constructor <init>(F)V
    .locals 0
    .param p1, "theFloat"    # F

    .line 26
    invoke-direct {p0}, Lorg/apache/commons/compress/harmony/pack200/CPConstant;-><init>()V

    .line 27
    iput p1, p0, Lorg/apache/commons/compress/harmony/pack200/CPFloat;->theFloat:F

    .line 28
    return-void
.end method


# virtual methods
.method public compareTo(Ljava/lang/Object;)I
    .locals 2
    .param p1, "obj"    # Ljava/lang/Object;

    .line 32
    iget v0, p0, Lorg/apache/commons/compress/harmony/pack200/CPFloat;->theFloat:F

    move-object v1, p1

    check-cast v1, Lorg/apache/commons/compress/harmony/pack200/CPFloat;

    iget v1, v1, Lorg/apache/commons/compress/harmony/pack200/CPFloat;->theFloat:F

    invoke-static {v0, v1}, Ljava/lang/Float;->compare(FF)I

    move-result v0

    return v0
.end method

.method public getFloat()F
    .locals 1

    .line 36
    iget v0, p0, Lorg/apache/commons/compress/harmony/pack200/CPFloat;->theFloat:F

    return v0
.end method
