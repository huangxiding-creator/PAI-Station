.class public abstract Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPConstantNumber;
.super Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPConstant;
.source "CPConstantNumber.java"


# direct methods
.method public constructor <init>(BLjava/lang/Object;I)V
    .locals 0
    .param p1, "tag"    # B
    .param p2, "value"    # Ljava/lang/Object;
    .param p3, "globalIndex"    # I

    .line 25
    invoke-direct {p0, p1, p2, p3}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPConstant;-><init>(BLjava/lang/Object;I)V

    .line 26
    return-void
.end method


# virtual methods
.method protected getNumber()Ljava/lang/Number;
    .locals 1

    .line 29
    invoke-virtual {p0}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPConstantNumber;->getValue()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Number;

    return-object v0
.end method
